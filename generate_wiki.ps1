$csvPath = Join-Path $PSScriptRoot "wiki_articles.csv"
if (-Not (Test-Path $csvPath)) {
    Write-Error "wiki_articles.csv not found!"
    exit
}

$articles = Import-Csv $csvPath

foreach ($article in $articles) {
    $wikiDir = Join-Path $PSScriptRoot "wiki\$($article.sub_category)"
    if (-Not (Test-Path $wikiDir)) {
        New-Item -ItemType Directory -Path $wikiDir -Force | Out-Null
    }
    
    $filePath = Join-Path $wikiDir "$($article.id).html"
    
    $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="$($article.meta_desc)">
    <title>$($article.title)</title>
    <link rel="stylesheet" href="../../style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- E-E-A-T Author Schema -->
    <script type="application/ld-json">
    {
      "@context": "https://schema.org",
      "@type": "Article",
      "headline": "$($article.title)",
      "author": {
        "@type": "Person",
        "name": "$($article.author)"
      },
      "datePublished": "$($article.publish_date)"
    }
    </script>
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo">
                 PlumbingLicense <span>Encyclopedia</span>
            </div>
            <nav>
                                                                                <ul style="display: flex; gap: 1.5rem; list-style: none;">
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Home</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Journeyman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Master</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/tradesman-other/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Tradesman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})wiki/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Blog</a></li>
                </ul></nav></div></header>

    <main class="container" style="padding-top: 2rem;">
        <div class="page-layout">
                                                            <aside class="sidebar-left glass-card">
                <h3>Exam Categories</h3>
                <ul>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/index.html">Journeyman Exams</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/index.html">Master Exams</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/tradesman-other/index.html">Tradesman Exams</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-aptitude-test/index.html">Plumbing Aptitude Prep</a></li>
                </ul>
                <h3>Popular Products</h3>
                <ul>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/texas-prep/index.html">Texas Journeyman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/va-prep/index.html">Virginia Journeyman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/master-prep/index.html">Master Plumber</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/general/code-cert-prep/index.html">Code Certification</a></li>
                </ul>
                <h3>Resources</h3>
                <ul>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})wiki/index.html">Blog</a></li>
                </ul>
            </aside>
            <div class="main-content">
        <nav style="font-size: 0.9rem; margin-bottom: 2rem; color: var(--text-secondary);">
            <a href="../../index.html" style="color: var(--primary); text-decoration: none;">Home</a> &gt; 
            <span style="text-transform: capitalize;">Wiki</span> &gt; 
            <span style="text-transform: capitalize; color: var(--primary);">$($article.sub_category)</span> &gt; 
            <span style="color: var(--text-primary);">$($article.title)</span>
        </nav>

        <div class="dashboard-grid">
            <div style="grid-column: span 2;">
                <article class="glass-card" style="line-height: 1.8;">
                    <h1 style="font-size: 2.5rem; font-weight: 800; color: white; margin-bottom: 0.5rem;">$($article.h1_title)</h1>
                    
                    <div style="display: flex; gap: 1rem; align-items: center; margin-bottom: 2rem; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 1rem;">
                        <div style="background: var(--bg-card-hover); padding: 0.5rem 1rem; border-radius: 50px; font-size: 0.85rem; color: var(--text-secondary);">
                             Written by <strong style="color: white;">$($article.author)</strong>
                        </div>
                        <div style="background: var(--bg-card-hover); padding: 0.5rem 1rem; border-radius: 50px; font-size: 0.85rem; color: var(--text-secondary);">
                             Published: $($article.publish_date)
                        </div>
                        <div style="background: rgba(16, 185, 129, 0.1); color: #34d399; padding: 0.5rem 1rem; border-radius: 50px; font-size: 0.85rem; font-weight: bold;">
                             Fact Checked
                        </div>
                    </div>

                    <p style="font-size: 1.2rem; color: var(--text-primary); margin-bottom: 2rem;">$($article.intro)</p>
                    
                    <!-- Contextual Internal Link Promo (Wikipedia Style) -->
                    <div style="float: right; margin: 0 0 1.5rem 1.5rem; background: var(--bg-card); border: 1px solid var(--primary); border-radius: 12px; padding: 1.5rem; width: 300px; text-align: center; box-shadow: 0 10px 30px rgba(0, 240, 255, 0.1);">
                        <h3 style="color: white; font-size: 1.1rem; margin-bottom: 1rem;">Prepare for the Exam</h3>
                        <p style="font-size: 0.9rem; color: var(--text-secondary); margin-bottom: 1rem;">Boost your score with our premium simulator.</p>
                        <a href="$($article.linked_product_url)" class="btn-primary" style="display: block; text-decoration: none; padding: 0.8rem; font-size: 0.95rem;">$($article.linked_product_anchor)</a>
                    </div>

                    <h2 style="font-size: 1.8rem; color: var(--secondary); margin-top: 2rem; margin-bottom: 1rem;">History and Background</h2>
                    <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">$($article.history)</p>

                    <h2 style="font-size: 1.8rem; color: var(--secondary); margin-top: 2rem; margin-bottom: 1rem;">What is it?</h2>
                    <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">$($article.what_is_it)</p>
                    
                    <!-- Alt text image placeholder for SEO -->
                    <div style="background: var(--bg-card-hover); border-radius: 12px; height: 200px; display: flex; align-items: center; justify-content: center; margin: 2rem 0; border: 1px dashed var(--bg-card-border);">
                        <span style="color: var(--text-secondary); font-size: 0.9rem;">[Image Placeholder: alt="$($article.image_alt)"]</span>
                    </div>

                    <h2 style="font-size: 1.8rem; color: var(--secondary); margin-top: 2rem; margin-bottom: 1rem;">Requirements</h2>
                    <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">$($article.requirements)</p>
                    
                    <div style="margin-top: 3rem; padding: 1.5rem; background: var(--bg-card-hover); border-radius: 8px;">
                        <h3 style="color: white; margin-bottom: 0.5rem;">Ready to take the next step?</h3>
                        <p style="color: var(--text-secondary);">Don't leave your career to chance. Explore our <a href="$($article.linked_product_url)" style="color: var(--primary); font-weight: bold;">$($article.linked_product_anchor)</a> today.</p>
                    </div>
                </article>
            </div>
            
            <div class="stats-panel">
                <div class="glass-card" style="position: sticky; top: 120px;">
                    <h3 style="color: white; margin-bottom: 1rem; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.5rem;">Related Articles</h3>
                    <ul style="list-style: none; padding: 0; display: flex; flex-direction: column; gap: 1rem;">
                        <li><a href="wiki-001.html" style="color: var(--primary); text-decoration: none; font-size: 0.95rem;">What is the Journeyman Plumbing Exam?</a></li>
                        <li><a href="wiki-002.html" style="color: var(--primary); text-decoration: none; font-size: 0.95rem;">Master vs Journeyman Plumber</a></li>
                        <li><a href="wiki-003.html" style="color: var(--primary); text-decoration: none; font-size: 0.95rem;">History of Plumbing Codes</a></li>
                    </ul>
                </div>
            </div>
        </div>
                </div>
        </div>
</main>

                <footer>
        <div class="footer-content" style="flex-direction: column; gap: 1.5rem;">
            <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap;">
                <a href="$(if ($relPath) {$relPath} else {"../../"})index.html" style="color: var(--text-secondary); text-decoration: none;">Home</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/index.html" style="color: var(--text-secondary); text-decoration: none;">Journeyman Exams</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/index.html" style="color: var(--text-secondary); text-decoration: none;">Master Exams</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/tradesman-other/index.html" style="color: var(--text-secondary); text-decoration: none;">Tradesman Exams</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})wiki/index.html" style="color: var(--text-secondary); text-decoration: none;">Blog</a>
            </div>
            <div style="display: flex; gap: 1.5rem; justify-content: center; flex-wrap: wrap; font-size: 0.9rem; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 0.75rem;">
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/ca-real-estate-math/index.html" style="color: var(--text-secondary); text-decoration: none;">CA Real Estate Math</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/vic-lea-electrician-prep/index.html" style="color: var(--text-secondary); text-decoration: none;">Vic LEA Electrician</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-aptitude-test/index.html" style="color: var(--text-secondary); text-decoration: none;">Plumbing Aptitude</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/sarasota-adu-permit-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Sarasota ADU Permits</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/gwinnett-home-occupation-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Gwinnett Home Occupation</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/douglas-co-residential-building-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Douglas County Building</a>
            </div>
            <div>Â© 2026 ExamPrep Portal. All rights reserved.</div>
        </div>
    </footer>
</body>
</html>
"@

    Set-Content -Path $filePath -Value $html -Encoding UTF8
    Write-Host "Generated Wiki Article: $filePath" -ForegroundColor Green
}

# Generate the Wiki Hub Index
$wikiHubDir = Join-Path $PSScriptRoot "wiki"
$hubPath = Join-Path $wikiHubDir "index.html"
$hubHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Plumbing License Encyclopedia - Educational Resources and Definitions">
    <title>Plumbing Reference Hub</title>
    <link rel="stylesheet" href="../style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo"> PlumbingLicense <span>Wiki</span></div>
            <nav>
                                                                                <ul style="display: flex; gap: 1.5rem; list-style: none;">
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Home</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Journeyman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Master</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/tradesman-other/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Tradesman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})wiki/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Blog</a></li>
                </ul></nav></div></header>
    <main class="container" style="padding-top: 4rem;">
        <div class="page-layout">
                                                            <aside class="sidebar-left glass-card">
                <h3>Exam Categories</h3>
                <ul>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/index.html">Journeyman Exams</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/index.html">Master Exams</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/tradesman-other/index.html">Tradesman Exams</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-aptitude-test/index.html">Plumbing Aptitude Prep</a></li>
                </ul>
                <h3>Popular Products</h3>
                <ul>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/texas-prep/index.html">Texas Journeyman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/va-prep/index.html">Virginia Journeyman</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/master-prep/index.html">Master Plumber</a></li>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/general/code-cert-prep/index.html">Code Certification</a></li>
                </ul>
                <h3>Resources</h3>
                <ul>
                    <li><a href="$(if ($relPath) {$relPath} else {"../../"})wiki/index.html">Blog</a></li>
                </ul>
            </aside>
            <div class="main-content">
        <h1 style="font-size: 3rem; font-weight: 800; color: white; margin-bottom: 1rem; text-align: center;">Encyclopedia & Resources</h1>
        <p style="text-align: center; color: var(--text-secondary); font-size: 1.2rem; margin-bottom: 4rem;">Educational articles to help you understand plumbing exams.</p>
        
        <div class="dashboard-grid">
"@

foreach ($article in $articles) {
    $hubHtml += @"
            <a href="$($article.sub_category)/$($article.id).html" class="glass-card" style="display: block; text-decoration: none; transition: all 0.3s ease;">
                <h2 style="color: white; font-size: 1.4rem; margin-bottom: 0.5rem;">$($article.title)</h2>
                <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 1rem;">$($article.meta_desc)</p>
                <div style="color: var(--primary); font-size: 0.85rem; font-weight: bold;">Read Article </div>
            </a>
"@
}

$hubHtml += @"
        </div>
                </div>
        </div>
</main>
</body>
</html>
"@

Set-Content -Path $hubPath -Value $hubHtml -Encoding UTF8
Write-Host "Generated Wiki Hub: $hubPath" -ForegroundColor Cyan
Write-Host "Wiki Generation Complete!" -ForegroundColor Yellow







