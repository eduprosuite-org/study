$htmlFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.FullName -notmatch "\\scratch\\" }
$ps1Files = Get-ChildItem -Path $PSScriptRoot -Filter *.ps1 | Where-Object { $_.Name -notmatch "fix_all.ps1" -and $_.Name -notmatch "update_navigation.ps1" -and $_.Name -notmatch "fix_emojis.ps1" }

$allFiles = $htmlFiles + $ps1Files

foreach ($file in $allFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Blindly remove all non-ascii characters EXCEPT copyright (169 / A9) and standard symbols
    # But that might break stuff. Let's just use regex to remove the mangled prefix.
    # The prefix is always hex C3 B0 C2 9F ... which renders as 
    $content = $content -replace '.{1,3}', ''
    $content = $content -replace 'dY"\s+', ''
    
    # Just to be 100% sure we remove the leftover garbage in index.html line 31:
    $content = $content -replace ' ', ''
    $content = $content -replace ' ', ''
    
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}
Write-Host "Encoding fixed!"






