# Sitemap and Robots.txt Generator for QR Code Web Application
# Scans index.html pages under wifi, link, vcard, pdf, social, and the root homepage.
# Ignores exams/ and wiki/ to keep study portal separated.

$SiteBaseUrl = "https://eduprosuite-org.github.io/qrcode/"
$RootDir = "d:\1 hour in clg\"

# Get all index.html files under target folders
$TargetCategories = @("wifi", "link", "vcard", "pdf", "social")

# Store URLs grouped by category
$SitemapUrls = @{}
foreach ($cat in $TargetCategories) {
    $SitemapUrls[$cat] = @()
}
$SitemapUrls["pages"] = @() # For root homepage

# Add Root Homepage
$SitemapUrls["pages"] += $SiteBaseUrl

# Scan the folders
foreach ($cat in $TargetCategories) {
    $catDir = Join-Path $RootDir $cat
    if (Test-Path -Path $catDir) {
        $files = Get-ChildItem -Path $catDir -Filter "index.html" -Recurse
        foreach ($file in $files) {
            # Calculate path relative to RootDir
            $relPath = Resolve-Path $file.FullName -Relative
            # Clean up the relative path format (remove .\ and convert \ to /)
            $relPath = $relPath.Replace(".\", "").Replace("\", "/")
            
            # Formulate URL
            $urlPath = $relPath.Replace("index.html", "")
            $fullUrl = $SiteBaseUrl + $urlPath
            
            $SitemapUrls[$cat] += $fullUrl
        }
    }
}

# Helper function to write a sitemap XML
function Write-SitemapXml {
    param(
        [string]$Filename,
        [string[]]$Urls
    )
    
    $xml = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
"@
    
    foreach ($url in $Urls) {
        $xml += "`n  <url>`n    <loc>$url</loc>`n    <lastmod>2026-08-09</lastmod>`n    <changefreq>daily</changefreq>`n    <priority>0.80</priority>`n  </url>"
    }
    
    $xml += "`n</urlset>"
    
    $filePath = Join-Path $RootDir $Filename
    [System.IO.File]::WriteAllText($filePath, $xml, [System.Text.Encoding]::UTF8)
    Write-Host "Generated Sitemap: $filePath with $($Urls.Count) URLs"
}

# Write individual sitemaps
Write-SitemapXml -Filename "sitemap-pages.xml" -Urls $SitemapUrls["pages"]
foreach ($cat in $TargetCategories) {
    Write-SitemapXml -Filename "sitemap-$cat.xml" -Urls $SitemapUrls[$cat]
}

# Generate Sitemap Index
$sitemapsList = @("sitemap-pages.xml", "sitemap-wifi.xml", "sitemap-link.xml", "sitemap-vcard.xml", "sitemap-pdf.xml", "sitemap-social.xml")
$indexXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
"@

foreach ($sm in $sitemapsList) {
    $indexXml += "`n  <sitemap>`n    <loc>$($SiteBaseUrl)$sm</loc>`n    <lastmod>2026-08-09T21:40:00+00:00</lastmod>`n  </sitemap>"
}
$indexXml += "`n</sitemapindex>"

$indexPath = Join-Path $RootDir "sitemap_index.xml"
[System.IO.File]::WriteAllText($indexPath, $indexXml, [System.Text.Encoding]::UTF8)
Write-Host "Generated Sitemap Index: $indexPath"

# Generate Robots.txt
$robotsTxt = @"
User-agent: *
Allow: /
Disallow: /app.js
Disallow: /style.css
Disallow: /backups-study/
Disallow: /scratch/
Disallow: /Google Dev Search Central Official SEO MD files/

Sitemap: https://eduprosuite-org.github.io/qrcode/sitemap_index.xml
"@

$robotsPath = Join-Path $RootDir "robots.txt"
[System.IO.File]::WriteAllText($robotsPath, $robotsTxt, [System.Text.Encoding]::UTF8)
Write-Host "Generated Robots.txt: $robotsPath"



