$baseUrl = "https://eduprosuite-org.github.io/study/"
$date = Get-Date -Format "yyyy-MM-dd"

# 1. Pages (Root)
$urlsPages = @("")

# 2. Exams
$urlsExams = @(
    "exams/ca-real-estate-math/"
    "exams/ca-real-estate-math/practice.html"
    "exams/sarasota-adu-permit-checklist/"
    "exams/gwinnett-home-occupation-checklist/"
    "exams/douglas-co-residential-building-checklist/"
    "exams/vic-lea-electrician-prep/"
    "exams/plumbing-license-prep/"
    "exams/plumbing-license-prep/journeyman/"
    "exams/plumbing-license-prep/master-contractor/"
    "exams/plumbing-license-prep/tradesman-other/"
    "exams/plumbing-license-prep/general/"
    "exams/plumbing-license-prep/journeyman/general-prep/"
    "exams/plumbing-license-prep/journeyman/general-prep/practice.html"
    "exams/plumbing-license-prep/journeyman/texas-prep/"
    "exams/plumbing-license-prep/journeyman/texas-prep/practice.html"
    "exams/plumbing-license-prep/journeyman/va-prep/"
    "exams/plumbing-license-prep/journeyman/va-prep/practice.html"
    "exams/plumbing-license-prep/journeyman/kansas-prep/"
    "exams/plumbing-license-prep/journeyman/kansas-prep/practice.html"
    "exams/plumbing-license-prep/journeyman/ma-prep/"
    "exams/plumbing-license-prep/journeyman/ma-prep/practice.html"
    "exams/plumbing-license-prep/journeyman/wssc-prep/"
    "exams/plumbing-license-prep/journeyman/wssc-prep/practice.html"
    "exams/plumbing-license-prep/master-contractor/master-prep/"
    "exams/plumbing-license-prep/master-contractor/master-prep/practice.html"
    "exams/plumbing-license-prep/master-contractor/contractor-prep/"
    "exams/plumbing-license-prep/master-contractor/contractor-prep/practice.html"
    "exams/plumbing-license-prep/tradesman-other/tradesman-prep/"
    "exams/plumbing-license-prep/tradesman-other/tradesman-prep/practice.html"
    "exams/plumbing-license-prep/tradesman-other/inspector-prep/"
    "exams/plumbing-license-prep/tradesman-other/inspector-prep/practice.html"
    "exams/plumbing-license-prep/general/residential-prep/"
    "exams/plumbing-license-prep/general/residential-prep/practice.html"
    "exams/plumbing-license-prep/general/code-cert-prep/"
    "exams/plumbing-license-prep/general/code-cert-prep/practice.html"
    "exams/plumbing-license-prep/general/free-prep/"
    "exams/plumbing-license-prep/general/free-prep/practice.html"
)

# 3. Wiki
$urlsWiki = @(
    "wiki/"
    "wiki/plumbing/wiki-001.html"
    "wiki/plumbing/wiki-002.html"
    "wiki/plumbing/wiki-003.html"
)

function Generate-Sitemap($urls, $filename) {
    $xml = '<?xml version="1.0" encoding="UTF-8"?>' + "`n"
    $xml += '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' + "`n"
    
    foreach ($url in $urls) {
        $loc = $baseUrl + $url
        $priority = "0.8"
        if ($url -eq "") { $priority = "1.0" }
        elseif ($url.EndsWith("/")) { $priority = "0.9" }
        
        $xml += "    <url>`n"
        $xml += "        <loc>$loc</loc>`n"
        $xml += "        <lastmod>$date</lastmod>`n"
        $xml += "        <changefreq>weekly</changefreq>`n"
        $xml += "        <priority>$priority</priority>`n"
        $xml += "    </url>`n"
    }
    
    $xml += '</urlset>'
    
    $path = Join-Path $PSScriptRoot $filename
    [System.IO.File]::WriteAllText($path, $xml)
    Write-Host "$filename generated successfully!" -ForegroundColor Green
}

# Generate individual sitemaps
Generate-Sitemap -urls $urlsPages -filename "sitemap-pages.xml"
Generate-Sitemap -urls $urlsExams -filename "sitemap-exams.xml"
Generate-Sitemap -urls $urlsWiki -filename "sitemap-wiki.xml"

# Generate Sitemap Index
$sitemapIndexXml = '<?xml version="1.0" encoding="UTF-8"?>' + "`n"
$sitemapIndexXml += '<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' + "`n"

$sitemaps = @("sitemap-pages.xml", "sitemap-exams.xml", "sitemap-wiki.xml")
foreach ($sm in $sitemaps) {
    $loc = $baseUrl + $sm
    $sitemapIndexXml += "    <sitemap>`n"
    $sitemapIndexXml += "        <loc>$loc</loc>`n"
    $sitemapIndexXml += "        <lastmod>$date</lastmod>`n"
    $sitemapIndexXml += "    </sitemap>`n"
}
$sitemapIndexXml += '</sitemapindex>'

$indexPath = Join-Path $PSScriptRoot "sitemap.xml"
[System.IO.File]::WriteAllText($indexPath, $sitemapIndexXml)
Write-Host "sitemap.xml (Index) generated successfully!" -ForegroundColor Green
