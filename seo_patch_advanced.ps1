$basePath = "d:\1 hour in clg"
$baseUrl = "https://eduprosuite-org.github.io/study/"

# 1. Update robots.txt
$robotsPath = Join-Path $basePath "robots.txt"
$robotsContent = @"
User-agent: *
Allow: /

Sitemap: $($baseUrl)sitemap.xml
"@
Set-Content -Path $robotsPath -Value $robotsContent -Encoding UTF8
Write-Host "Updated robots.txt with correct Sitemap URL." -ForegroundColor Green

# 2. Add canonical tags to all HTML files
$htmlFiles = Get-ChildItem -Path $basePath -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.FullName -notmatch "\\scratch\\" }

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw

    # Calculate canonical URL
    $relativePath = $file.FullName.Substring($basePath.Length).Trim('\').Replace('\', '/')
    # If the file is index.html, we can just use the directory path
    if ($relativePath.EndsWith("index.html")) {
        $relativePath = $relativePath.Substring(0, $relativePath.Length - 10)
    }
    
    $canonicalUrl = $baseUrl + $relativePath
    
    # Check if canonical already exists
    if ($content -notmatch '<link rel="canonical"') {
        $canonicalTag = "`n    <link rel=`"canonical`" href=`"$canonicalUrl`">"
        
        # Insert canonical tag before </head>
        $content = $content -replace '(?i)</head>', "$canonicalTag`n</head>"
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    }
}

Write-Host "Injected canonical URLs into all HTML pages." -ForegroundColor Green

# 3. Push to GitHub
Write-Host "Pushing to GitHub..."
& "d:\1 hour in clg\push_all_to_github.ps1"





