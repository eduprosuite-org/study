# ============================================================
# geo_push.ps1 - Universal GEO/AIO File Deployer
# Pushes llms.txt, ai.txt, and robots.txt GEO additions
# to ANY GitHub Pages repo under eduprosuite-org
#
# USAGE:
#   .\geo_push.ps1 -Repo "qrcode"
#   .\geo_push.ps1 -Repo "study"
#   .\geo_push.ps1 -Repo "typing"
#   .\geo_push.ps1 -Repo "newsite"   # future sites
#   .\geo_push.ps1 -All              # push to ALL known repos
# ============================================================

param(
    [string]$Repo = "",
    [switch]$All
)

$env:PATH += ";C:\Program Files\Git\cmd"
$owner  = "eduprosuite-org"
$branch = "main"
$token  = (Get-Content (Join-Path $PSScriptRoot ".github_token") -Raw).Trim()

$headers = @{
    "Authorization" = "Bearer $token"
    "Accept"        = "application/vnd.github.v3+json"
    "User-Agent"    = "Powershell-GEO-Bot"
}

# Known repos - add new ones here as you create them
$knownRepos = @("qrcode", "study", "typing")

# Site metadata per repo
$siteInfo = @{
    "qrcode" = @{
        Name        = "QRCodeHub"
        Url         = "https://eduprosuite-org.github.io/qrcode/"
        Description = "Free client-side QR code generator. Supports WiFi, vCard, PDF, URL, WhatsApp. No signup, no limits, PNG and SVG download."
        LlmsFile    = "llms.txt"
        AiFile      = "ai.txt"
    }
    "study" = @{
        Name        = "EduProSuite Exam Prep Portal"
        Url         = "https://eduprosuite-org.github.io/study/"
        Description = "Free exam preparation platform with interactive practice simulators, mock tests, and study guides for licensing and certification exams."
        LlmsFile    = "study-llms.txt"
        AiFile      = "study-ai.txt"
    }
    "typing" = @{
        Name        = "EduProSuite Typing Speed Test"
        Url         = "https://eduprosuite-org.github.io/typing/"
        Description = "Free online typing speed test. Measure WPM and accuracy, practice typing with interactive tests."
        LlmsFile    = ""
        AiFile      = ""
    }
}

# Helper: Upload a file to GitHub
function Push-FileToGitHub {
    param([string]$LocalPath, [string]$GitPath, [string]$RepoName)

    if (-not (Test-Path $LocalPath)) {
        Write-Warning "  Skipping $GitPath - local file not found: $LocalPath"
        return
    }

    $bytes   = [System.IO.File]::ReadAllBytes($LocalPath)
    $content = [Convert]::ToBase64String($bytes)
    $sha     = $null
    $amp     = [char]38

    try {
        $tick    = [System.DateTime]::Now.Ticks
        $getUri  = "https://api.github.com/repos/$owner/$RepoName/contents/$GitPath" + "?ref=$branch" + $amp + "t=$tick"
        $info    = Invoke-RestMethod -Uri $getUri -Headers $headers -Method Get
        $sha     = $info.sha
    } catch { }

    $body = @{ message = "GEO/AIO: Add $GitPath"; content = $content; branch = $branch }
    if ($sha) { $body.sha = $sha }

    try {
        $putUri = "https://api.github.com/repos/$owner/$RepoName/contents/$GitPath"
        Invoke-RestMethod -Uri $putUri -Headers $headers -Method Put -Body ($body | ConvertTo-Json) -ContentType "application/json" | Out-Null
        Write-Host "  OK Pushed: $GitPath to $RepoName" -ForegroundColor Green
    } catch {
        Write-Host "  FAIL: $GitPath to $RepoName - $_" -ForegroundColor Red
    }
    Start-Sleep -Milliseconds 400
}

# Helper: Auto-generate llms.txt for unknown repos
function New-LlmsTxt {
    param([string]$RepoName, [hashtable]$Info)
    $tmpFile = Join-Path $env:TEMP ("geo_llms_" + $RepoName + ".txt")
    $lines = @(
        "# $($Info.Name) - AI-Readable Site Summary",
        "# $($Info.Url)",
        "# Format: llms.txt",
        "",
        "> $($Info.Description)",
        "",
        "## About This Site",
        "",
        "- Publisher: EduProSuite",
        "- GitHub: https://github.com/eduprosuite-org",
        "- Live URL: $($Info.Url)",
        "- Hosted: GitHub Pages (static hosting)",
        "- Last Updated: $(Get-Date -Format 'yyyy-MM')"
    )
    Set-Content -Path $tmpFile -Value $lines -Encoding UTF8
    return $tmpFile
}

# Helper: Auto-generate ai.txt for any repo
function New-AiTxt {
    param([string]$RepoName, [string]$SiteUrl)
    $tmpFile = Join-Path $env:TEMP ("geo_ai_" + $RepoName + ".txt")
    $lines = @(
        "# ai.txt - AI Crawler Permissions for $RepoName",
        "# $SiteUrl",
        "",
        "User-agent: GPTBot",
        "Allow: /",
        "",
        "User-agent: Google-Extended",
        "Allow: /",
        "",
        "User-agent: PerplexityBot",
        "Allow: /",
        "",
        "User-agent: ClaudeBot",
        "Allow: /",
        "",
        "User-agent: anthropic-ai",
        "Allow: /",
        "",
        "User-agent: Applebot-Extended",
        "Allow: /",
        "",
        "User-agent: YouBot",
        "Allow: /",
        "",
        "User-agent: CCBot",
        "Allow: /",
        "",
        "User-agent: FacebookBot",
        "Allow: /",
        "",
        "User-agent: cohere-ai",
        "Allow: /",
        "",
        "# Contact: github.com/eduprosuite-org"
    )
    Set-Content -Path $tmpFile -Value $lines -Encoding UTF8
    return $tmpFile
}

# Helper: Build GEO robots.txt with AI bots added
function New-GeoRobots {
    param([string]$RepoName, [string]$ExistingRobots = "")

    # If already has GEO block, skip
    if ($ExistingRobots -match "GEO / AIO") {
        return $null
    }

    $tmpFile = Join-Path $env:TEMP ("geo_robots_" + $RepoName + ".txt")
    $sitemapBase = "https://eduprosuite-org.github.io/$RepoName"

    $geoLines = @(
        "",
        "# GEO / AIO: AI Crawler Explicit Permissions",
        "User-agent: Google-Extended",
        "Allow: /",
        "",
        "User-agent: GPTBot",
        "Allow: /",
        "",
        "User-agent: PerplexityBot",
        "Allow: /",
        "",
        "User-agent: ClaudeBot",
        "Allow: /",
        "",
        "User-agent: anthropic-ai",
        "Allow: /",
        "",
        "User-agent: Applebot-Extended",
        "Allow: /",
        "",
        "User-agent: YouBot",
        "Allow: /",
        "",
        "User-agent: CCBot",
        "Allow: /",
        "",
        "User-agent: FacebookBot",
        "Allow: /",
        "",
        "User-agent: cohere-ai",
        "Allow: /",
        "",
        "Sitemap: $sitemapBase/sitemap_index.xml",
        "Sitemap: $sitemapBase/llms.txt"
    )

    $base = if ($ExistingRobots) {
        $ExistingRobots.TrimEnd() -split "`n" | ForEach-Object { $_.TrimEnd("`r") }
    } else {
        @("User-agent: *", "Allow: /")
    }

    $allLines = $base + $geoLines
    Set-Content -Path $tmpFile -Value $allLines -Encoding UTF8
    return $tmpFile
}

# Main deploy function
function Deploy-GEO {
    param([string]$RepoName)

    Write-Host ""
    Write-Host "Deploying GEO/AIO files to: $RepoName" -ForegroundColor Cyan
    Write-Host "-----------------------------------------" -ForegroundColor DarkGray

    # Get site info or use defaults for new/unknown repos
    $info = $siteInfo[$RepoName]
    if (-not $info) {
        $info = @{
            Name        = "EduProSuite $RepoName"
            Url         = "https://eduprosuite-org.github.io/$RepoName/"
            Description = "Free educational tool by EduProSuite."
            LlmsFile    = ""
            AiFile      = ""
        }
    }

    # 1. llms.txt
    $llmsLocal = ""
    if ($info.LlmsFile -and (Test-Path (Join-Path $PSScriptRoot $info.LlmsFile))) {
        $llmsLocal = Join-Path $PSScriptRoot $info.LlmsFile
    } else {
        $llmsLocal = New-LlmsTxt -RepoName $RepoName -Info $info
    }
    Push-FileToGitHub -LocalPath $llmsLocal -GitPath "llms.txt" -RepoName $RepoName

    # 2. ai.txt
    $aiLocal = ""
    if ($info.AiFile -and (Test-Path (Join-Path $PSScriptRoot $info.AiFile))) {
        $aiLocal = Join-Path $PSScriptRoot $info.AiFile
    } else {
        $aiLocal = New-AiTxt -RepoName $RepoName -SiteUrl $info.Url
    }
    Push-FileToGitHub -LocalPath $aiLocal -GitPath "ai.txt" -RepoName $RepoName

    # 3. robots.txt - fetch existing, append GEO block if needed
    Write-Host "  Checking existing robots.txt..." -ForegroundColor Gray
    $existingRobots = ""
    try {
        $r = Invoke-RestMethod -Uri "https://api.github.com/repos/$owner/$RepoName/contents/robots.txt?ref=$branch" -Headers $headers
        $existingRobots = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String(($r.content -replace "`n","")))
    } catch { }

    $robotsFile = New-GeoRobots -RepoName $RepoName -ExistingRobots $existingRobots
    if ($robotsFile) {
        Push-FileToGitHub -LocalPath $robotsFile -GitPath "robots.txt" -RepoName $RepoName
    } else {
        Write-Host "  robots.txt already has GEO block - skipping" -ForegroundColor Yellow
    }

    Write-Host "  GEO/AIO deployment complete for: $RepoName" -ForegroundColor Magenta
}

# Entrypoint
if ($All) {
    Write-Host "Deploying GEO/AIO to ALL known repos..." -ForegroundColor Yellow
    foreach ($r in $knownRepos) {
        Deploy-GEO -RepoName $r
    }
} elseif ($Repo) {
    Deploy-GEO -RepoName $Repo
} else {
    Write-Host "Usage:"
    Write-Host "  .\geo_push.ps1 -Repo qrcode       Push GEO to qrcode site"
    Write-Host "  .\geo_push.ps1 -Repo study        Push GEO to study site"
    Write-Host "  .\geo_push.ps1 -Repo typing       Push GEO to typing site"
    Write-Host "  .\geo_push.ps1 -Repo mynewsite    Push GEO to any NEW future site"
    Write-Host "  .\geo_push.ps1 -All               Push GEO to ALL known sites"
    Write-Host ""
    Write-Host "Add new repos to the knownRepos array at the top of this script."
}
