# Silo and Technical SEO Validation Script for QR Code Web Application
# Performs strict validation of canonicals, styles, scripts, sidebars, schemas, sitemaps, and protections.

$SiteBaseUrl = "https://eduprosuite-org.github.io/qrcode/"
$RootDir = "d:\1 hour in clg\"
$TargetCategories = @("wifi", "link", "vcard", "pdf", "social")

$AllPassed = $true

function Write-ValidationResult {
    param(
        [string]$TestName,
        [bool]$Success,
        [string]$Message
    )
    if ($Success) {
        Write-Host " [PASS] $TestName - $Message" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] $TestName - $Message" -ForegroundColor Red
        $global:AllPassed = $false
    }
}

Write-Host "Starting Programmatic SEO Silo Validation...`n"

# 1. Protection Check (Git diff for plumbing-license-prep)
$gitDiff = git diff --name-only exams/plumbing-license-prep/
if ($gitDiff) {
    Write-ValidationResult -TestName "Plumbing Protection" -Success $false -Message "Protected plumbing license files were modified! Modified files: $gitDiff"
} else {
    Write-ValidationResult -TestName "Plumbing Protection" -Success $true -Message "No plumbing license files were touched under exams/plumbing-license-prep/."
}

# 2. Get list of all index.html pages
$HtmlFiles = @()
$HtmlFiles += Join-Path $RootDir "index.html"
foreach ($cat in $TargetCategories) {
    $catDir = Join-Path $RootDir $cat
    if (Test-Path -Path $catDir) {
        $files = Get-ChildItem -Path $catDir -Filter "index.html" -Recurse
        foreach ($file in $files) {
            $HtmlFiles += $file.FullName
        }
    }
}

Write-ValidationResult -TestName "Page Count Check" -Success ($HtmlFiles.Count -eq 41) -Message "Found $($HtmlFiles.Count) pages (expected: 41)."

# 3. Individual Page Audits
foreach ($filePath in $HtmlFiles) {
    $relPath = Resolve-Path $filePath -Relative
    $relPath = $relPath.Replace(".\", "").Replace("\", "/")
    
    $content = Get-Content -Path $filePath -Raw
    
    # Audit Heading structure (Single H1)
    $h1Matches = [regex]::Matches($content, "<h1[^>]*>([\s\S]*?)</h1>")
    if ($h1Matches.Count -ne 1) {
        Write-ValidationResult -TestName "H1 Heading Check ($relPath)" -Success $false -Message "Expected exactly 1 H1 tag, found $($h1Matches.Count)"
    }
    
    # Audit Canonical tag
    $canonicalMatch = [regex]::Match($content, '<link rel="canonical" href="([^"]+)"')
    if ($canonicalMatch.Success) {
        $canonVal = $canonicalMatch.Groups[1].Value
        
        # Calculate expected canonical URL
        $urlPath = $relPath.Replace("index.html", "")
        $expectedCanon = $SiteBaseUrl + $urlPath
        if ($urlPath -ne "" -and !$expectedCanon.EndsWith("/")) {
            $expectedCanon += "/"
        }
        
        if ($canonVal -eq $expectedCanon) {
            # Check trailing slash for non-homepage
            if ($urlPath -ne "" -and !$canonVal.EndsWith("/")) {
                Write-ValidationResult -TestName "Canonical Trailing Slash ($relPath)" -Success $false -Message "Canonical lacks trailing slash: $canonVal"
            }
        } else {
            Write-ValidationResult -TestName "Canonical Correctness ($relPath)" -Success $false -Message "Canonical mismatch: found $canonVal, expected $expectedCanon"
        }
    } else {
        Write-ValidationResult -TestName "Canonical Presence ($relPath)" -Success $false -Message "No canonical tag found."
    }
    
    # Audit CSS & JS Relative paths
    $cssMatch = [regex]::Match($content, '<link rel="stylesheet" href="([^"]+)"')
    if ($cssMatch.Success) {
        $cssVal = $cssMatch.Groups[1].Value
        # Resolve path relative to current page directory
        $pageDir = Split-Path -Path $filePath
        $resolvedCssPath = Join-Path $pageDir $cssVal
        if (!(Test-Path -Path $resolvedCssPath)) {
            Write-ValidationResult -TestName "CSS Asset Resolve ($relPath)" -Success $false -Message "CSS path $cssVal is broken, resolves to non-existent $resolvedCssPath"
        }
    } else {
        Write-ValidationResult -TestName "CSS Asset Presence ($relPath)" -Success $false -Message "No stylesheet link found."
    }
    
    $jsMatch = [regex]::Match($content, '<script src="([^"]+)"')
    if ($jsMatch.Success) {
        $jsVal = $jsMatch.Groups[1].Value
        # We need the last script tag since first might be qrious.js CDN
        $jsMatches = [regex]::Matches($content, '<script src="([^"]+)"')
        $jsVal = $jsMatches[$jsMatches.Count - 1].Groups[1].Value
        
        $pageDir = Split-Path -Path $filePath
        $resolvedJsPath = Join-Path $pageDir $jsVal
        if (!(Test-Path -Path $resolvedJsPath)) {
            Write-ValidationResult -TestName "JS Asset Resolve ($relPath)" -Success $false -Message "JS path $jsVal is broken, resolves to non-existent $resolvedJsPath"
        }
    } else {
        Write-ValidationResult -TestName "JS Asset Presence ($relPath)" -Success $false -Message "No script tag found."
    }
    
    # Audit Sidebar Exclusivity
    $leftSidebarMatch = [regex]::Match($content, '<aside class="sidebar-left">([\s\S]*?)</aside>')
    $rightSidebarMatch = [regex]::Match($content, '<aside class="sidebar-right">([\s\S]*?)</aside>')
    
    if ($leftSidebarMatch.Success -and $rightSidebarMatch.Success) {
        # Extract all URLs in left sidebar
        $leftUrls = [regex]::Matches($leftSidebarMatch.Groups[1].Value, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
        # Extract all URLs in right sidebar
        $rightUrls = [regex]::Matches($rightSidebarMatch.Groups[1].Value, 'href="([^"]+)"') | ForEach-Object { $_.Groups[1].Value }
        
        $overlap = @()
        foreach ($lUrl in $leftUrls) {
            if ($rightUrls -contains $lUrl) {
                $overlap += $lUrl
            }
        }
        
        if ($overlap.Count -gt 0) {
            Write-ValidationResult -TestName "Sidebar Exclusivity ($relPath)" -Success $false -Message "Exclusivity violation! Overlapping URLs: $($overlap -join ', ')"
        }
    }
    
    # Audit JSON-LD Schema Presence
    $schemas = @("WebApplication", "BreadcrumbList", "FAQPage", "HowTo")
    foreach ($schema in $schemas) {
        if ($content -notlike "*`"@type`":*`"$schema`"*") {
            Write-ValidationResult -TestName "Schema Presence ($relPath)" -Success $false -Message "Missing JSON-LD schema: $schema"
        }
    }
}

# 4. Sitemap Validation
$sitemaps = @("sitemap-pages.xml", "sitemap-wifi.xml", "sitemap-link.xml", "sitemap-vcard.xml", "sitemap-pdf.xml", "sitemap-social.xml")
$sitemapUrlsCount = 0
foreach ($sm in $sitemaps) {
    $smPath = Join-Path $RootDir $sm
    if (Test-Path -Path $smPath) {
        $smContent = Get-Content -Path $smPath -Raw
        $locs = [regex]::Matches($smContent, "<loc>([^<]+)</loc>") | ForEach-Object { $_.Groups[1].Value }
        $sitemapUrlsCount += $locs.Count
        
        # Verify each location ends with trailing slash (except homepage)
        foreach ($loc in $locs) {
            if ($loc -ne $SiteBaseUrl -and !$loc.EndsWith("/")) {
                Write-ValidationResult -TestName "Sitemap URL Slash ($sm)" -Success $false -Message "URL lacks trailing slash in sitemap: $loc"
            }
        }
    } else {
        Write-ValidationResult -TestName "Sitemap Existence" -Success $false -Message "Missing sitemap: $sm"
    }
}

Write-ValidationResult -TestName "Sitemap Total URL Check" -Success ($sitemapUrlsCount -eq 41) -Message "Total URLs in sitemaps: $sitemapUrlsCount (expected: 41)."

# 5. Robots.txt Validation
$robotsPath = Join-Path $RootDir "robots.txt"
if (Test-Path -Path $robotsPath) {
    $robotsContent = Get-Content -Path $robotsPath -Raw
    $sitemapLineMatch = [regex]::Match($robotsContent, "Sitemap:\s*(https?://[^\s]+)")
    if ($sitemapLineMatch.Success) {
        $robotsSitemap = $sitemapLineMatch.Groups[1].Value
        $expectedIndex = "https://eduprosuite-org.github.io/qrcode/sitemap_index.xml"
        if ($robotsSitemap -eq $expectedIndex) {
            Write-ValidationResult -TestName "Robots.txt Sitemap Link" -Success $true -Message "Robots.txt correctly points to $expectedIndex."
        } else {
            Write-ValidationResult -TestName "Robots.txt Sitemap Link" -Success $false -Message "Robots.txt points to wrong sitemap: $robotsSitemap, expected $expectedIndex."
        }
    } else {
        Write-ValidationResult -TestName "Robots.txt Sitemap Link" -Success $false -Message "Missing Sitemap line in robots.txt."
    }
} else {
    Write-ValidationResult -TestName "Robots.txt Existence" -Success $false -Message "Robots.txt file is missing."
}

Write-Host "`n=========================================="
if ($global:AllPassed) {
    Write-Host " ALL Programmatic SEO Audits Passed Successfully! " -BackgroundColor Green -ForegroundColor White
} else {
    Write-Host " Programmatic SEO Audits Failed. Review details above. " -BackgroundColor Red -ForegroundColor White
}
Write-Host "=========================================="



