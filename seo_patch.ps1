$htmlFiles = Get-ChildItem -Path "d:\1 hour in clg\exams" -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw

    # Extract title and description
    $title = ""
    if ($content -match '(?i)<title>(.*?)</title>') {
        $title = $Matches[1].Trim()
    }
    
    $desc = ""
    if ($content -match '(?i)<meta\s+name="description"\s+content="(.*?)">') {
        $desc = $Matches[1].Trim()
    }
    
    # Add Course JSON-LD if not present and if it looks like a course/exam page
    if ($title -ne "" -and $content -notmatch '"@type"\s*:\s*"(Course|Product)"') {
        $jsonLd = @"
    <!-- Schema Structured Data: Course (SEO) -->
    <script type="application/ld-json">
    {
      "@context": "https://schema.org",
      "@type": "Course",
      "name": "$($title -replace '"', '\"')",
      "description": "$($desc -replace '"', '\"')",
      "provider": {
        "@type": "Organization",
        "name": "Exam Prep Portal",
        "sameAs": "https://eduprosuite-org.github.io/study/"
      }
    }
    </script>
"@
        # Insert before </head>
        $content = $content -replace '(?i)</head>', "$jsonLd`n</head>"
    }

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "SEO Patch applied successfully!" -ForegroundColor Green

Write-Host "Updating sitemap..."
& "d:\1 hour in clg\update_sitemap.ps1"

Write-Host "Pushing to GitHub..."
& "d:\1 hour in clg\push_all_to_github.ps1"



