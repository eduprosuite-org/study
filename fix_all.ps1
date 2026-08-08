$htmlFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.FullName -notmatch "\\scratch\\" }
$ps1Files = Get-ChildItem -Path $PSScriptRoot -Filter *.ps1 | Where-Object { $_.Name -notmatch "fix_all.ps1" }

$allFiles = $htmlFiles + $ps1Files

foreach ($file in $allFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8

    # 1. Remove Mangled Emojis (e.g. ðŸš€, ðŸ’¼)
    $content = $content -replace 'ðŸ.{1,2}', ''
    $content = $content -replace 'dY" ', ''

    # 2. SEO Jargon Cleanup
    $content = $content -replace 'Wiki / Blog', 'Blog'
    $content = $content -replace 'Plumbing License Wiki', 'Plumbing Reference'
    $content = $content -replace 'Explore Wiki Hub', 'Explore Articles'
    $content = $content -replace 'Fact Checked \(E-E-A-T\)', 'Fact Checked'
    
    # Remove image placeholders
    $content = $content -replace '<div[^>]*>\[Image Placeholder: alt="[^"]*"\]</div>', ''

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Cleanup completed successfully!" -ForegroundColor Green
