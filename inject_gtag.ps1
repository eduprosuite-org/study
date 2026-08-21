# ============================================================
# inject_gtag.ps1 - Multi-Site Automated Google Analytics Tag Injector
# Injects appropriate Google Tag based on site directory:
#   - QRCode Site (index.html, link/, pdf/, social/, vcard/, wifi/): G-CJDNH392VX
#   - Study Site  (index-study.html, exams/, wiki/): G-GLHCS966WY
# Safe: Idempotent (updates/replaces outdated IDs), preserves UTF-8,
# and skips protected directories (e.g., plumbing-license-prep).
# ============================================================

param(
    [string]$TargetDir = $PSScriptRoot
)

$siteTags = @{
    "qrcode" = "G-CJDNH392VX"
    "study"  = "G-GLHCS966WY"
}

function Get-GtagSnippet([string]$tagId) {
    return @"
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=$tagId"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', '$tagId');
    </script>
"@
}

function Get-ExpectedTagId([string]$relativePath) {
    $norm = $relativePath.Replace('\', '/')
    if ($norm -eq "index-study.html" -or $norm -like "exams/*" -or $norm -like "wiki/*") {
        return "G-GLHCS966WY" # Study Site
    }
    return "G-CJDNH392VX"     # QRCode / Main Site Default
}

Write-Host " Scanning for HTML files in: $TargetDir" -ForegroundColor Cyan

$htmlFiles = Get-ChildItem -Path $TargetDir -Filter "*.html" -Recurse -File | Where-Object {
    $relativePath = $_.FullName.Substring($TargetDir.Length).TrimStart('\', '/')
    $normalized = $relativePath.Replace('\', '/')

    # Skip .git, node_modules, google verification files
    if ($normalized -like ".git/*" -or $normalized -like "node_modules/*") { return $false }
    if ($_.Name -like "google*.html") { return $false }

    # Respect protected silo rule
    if ($normalized -like "exams/plumbing-license-prep/*" -or $normalized -eq "exams/plumbing-license-prep/index.html") {
        Write-Host " Skipping protected silo: $normalized" -ForegroundColor DarkGray
        return $false
    }

    return $true
}

$updatedCount = 0
$alreadyHasCount = 0
$skippedCount = 0

foreach ($file in $htmlFiles) {
    $relativePath = $file.FullName.Substring($TargetDir.Length).TrimStart('\', '/')
    $expectedTag = Get-ExpectedTagId -relativePath $relativePath
    $expectedSnippet = Get-GtagSnippet -tagId $expectedTag

    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)

    # Check if correct Google Tag is already installed
    if ($content -match "gtag\('config',\s*'$expectedTag'\)") {
        $alreadyHasCount++
        continue
    }

    $newContent = $null

    # If an old/different Google Tag is already in the file, replace it cleanly
    $oldTagRegex = [regex]'(?s)<!-- Google tag \(gtag\.js\) -->\s*<script async src="https://www\.googletagmanager\.com/gtag/js\?id=[^"]+"></script>\s*<script>\s*window\.dataLayer = window\.dataLayer \|\| \[\];\s*function gtag\(\)\{dataLayer\.push\(arguments\);\}\s*gtag\(''js'', new Date\(\)\);\s*gtag\(''config'', ''[^'']+''\);\s*</script>'
    
    if ($oldTagRegex.IsMatch($content)) {
        $newContent = $oldTagRegex.Replace($content, $expectedSnippet.Trim(), 1)
        $rel = $relativePath
        Write-Host " Updated Google Tag to $expectedTag in: $rel" -ForegroundColor Green
    }
    elseif ($content -match "(<head[^>]*>)") {
        $headMatch = $matches[1]
        $replacement = "$headMatch`n$expectedSnippet"
        
        $regex = [regex]::new([regex]::Escape($headMatch))
        $newContent = $regex.Replace($content, $replacement, 1)

        $rel = $relativePath
        Write-Host " Injected Google Tag ($expectedTag) into: $rel" -ForegroundColor Green
    } else {
        $rel = $relativePath
        Write-Host " No <head> tag found in: $rel (Skipped)" -ForegroundColor Yellow
        $skippedCount++
        continue
    }

    if ($null -ne $newContent) {
        $utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($file.FullName, $newContent, $utf8WithoutBom)
        $updatedCount++
    }
}

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host " Summary: Google Tag Multi-Site Injection" -ForegroundColor Cyan
Write-Host " Updated/Injected: $updatedCount file(s)" -ForegroundColor Green
Write-Host " Already Up-to-date: $alreadyHasCount file(s)" -ForegroundColor DarkCyan
Write-Host " Skipped/No Head:    $skippedCount file(s)" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
