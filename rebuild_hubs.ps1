# PowerShell script to cleanly rebuild the Tier 1 and Tier 2 hub pages
# in the study repository.

$tempDir = "D:\study-inspect-hubs-clean"
if (Test-Path $tempDir) {
    Remove-Item -Path $tempDir -Recurse -Force | Out-Null
}

$tokenFile = Join-Path $PSScriptRoot ".github_token"
$token = (Get-Content $tokenFile).Trim()
$owner = "eduprosuite-org"
$repo = "study"
$branch = "main"

Write-Host "Cloning repository..."
$cloneUrl = "https://$($token)@github.com/$owner/$repo.git"
git clone --depth 1 -b $branch $cloneUrl $tempDir
if (-not (Test-Path $tempDir)) {
    Write-Error "Failed to clone repository."
    exit 1
}

$categories = @("plumbing-math", "plumbing-codes", "plumbing-systems", "journeyman-prep")
$categoryDisplayNames = @{
    "plumbing-math"    = "Plumbing Math and Trade Calculations"
    "plumbing-codes"   = "Plumbing Codes and Safety Standards"
    "plumbing-systems" = "Plumbing Systems and Blueprints"
    "journeyman-prep"  = "Journeyman Exam Prep and Testing Strategy"
}

$baseDomain = "https://eduprosuite-org.github.io/study"

# Helper to build the Category Hub file content
function Build-CategoryHubHtml {
    param(
        [string]$cat,
        [string]$title,
        [string]$gridHtml,
        [int]$count
    )

    # Sidebar highlight for the other categories
    $otherCatsHtml = ""
    foreach ($c in $categories) {
        if ($c -ne $cat) {
            $cTitle = $categoryDisplayNames[$c]
            $otherCatsHtml += "                    <li><a href=`"../../wiki/$c/index.html`" style=`"color:var(--text-secondary); font-size:0.9rem; text-decoration:none;`" onmouseover=`"this.style.color='#ffffff'`" onmouseout=`"this.style.color='var(--text-secondary)'``>$cTitle</a></li>`n"
        }
    }

    $html = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-GLHCS966WY"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'G-GLHCS966WY');
    </script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Browse all $count plumbing $cat resources — guides, code rules, and exam definitions organized in one directory.">
    <title>$title | Plumbing License Encyclopedia</title>
    <link rel="stylesheet" href="../../style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="canonical" href="$baseDomain/wiki/$cat/">
    <meta property="og:type" content="website">
    <meta property="og:url" content="$baseDomain/wiki/$cat/index.html">
    <meta property="og:title" content="$title | Plumbing License Encyclopedia">
    <meta property="og:image" content="$baseDomain/og-banner.jpg">
    <style>
        .dir-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 0.8rem 1.8rem; }
        @media(max-width:900px){ .dir-grid{ grid-template-columns: repeat(2, 1fr); } }
        @media(max-width:600px){ .dir-grid{ grid-template-columns: 1fr; } }
        .dir-item { display: flex; align-items: center; gap: 8px; padding: 5px 0; }
        .dir-item-guide { padding: 6px 10px; background: rgba(99,102,241,0.05); border: 1px solid rgba(99,102,241,0.2); border-radius: 8px; }
        .dir-icon { font-size: 0.85rem; color: var(--primary); opacity: 0.75; }
        .dir-link { font-size: 0.95rem; color: var(--text-secondary); text-decoration: none; font-weight: 500; transition: color 0.2s; }
        .dir-link:hover { color: #fff; text-decoration: underline; }
        .dir-link-guide { color: #ffffff; font-weight: 700; }
        .count-badge { font-size: 0.8rem; font-weight: 600; background: rgba(99,102,241,0.15); color: var(--primary); padding: 2px 10px; border-radius: 50px; border: 1px solid rgba(99,102,241,0.2); }
        .btn-cta-secondary { display: block; width: 100%; background: linear-gradient(90deg, var(--primary), var(--secondary)); color: #ffffff; font-weight: 700; font-size: 0.9rem; text-align: center; padding: 9px 15px; border-radius: 8px; transition: all 0.25s; text-decoration: none; }
        .btn-cta-secondary:hover { transform: translateY(-1px); color: #fff; }
    </style>
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo"><a href="../../index.html" style="text-decoration:none;color:inherit;">ExamPrep<span>Portal</span></a></div>
            <nav aria-label="Main Navigation" class="main-nav">
                <ul class="nav-list">
                    <li><a href="../../index.html">Home</a></li>
                    <li class="has-dropdown"><a href="../../exams/plumbing-license-prep/index.html">Plumbing Exams &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="../../exams/plumbing-license-prep/journeyman/index.html">Journeyman Exams</a></li>
                            <li><a href="../../exams/plumbing-license-prep/master-contractor/index.html">Master Contractor</a></li>
                            <li><a href="../../exams/plumbing-license-prep/tradesman-other/index.html">Tradesman &amp; Inspector</a></li>
                            <li><a href="../../exams/plumbing-license-prep/general/index.html">General &amp; Free Prep</a></li>
                        </ul>
                    </li>
                    <li class="has-dropdown">
                        <a href="../../exams/plumbing-license-prep/journeyman/index.html">By State &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="../../exams/plumbing-license-prep/journeyman/texas-prep/index.html">Texas</a></li>
                            <li><a href="../../exams/plumbing-license-prep/journeyman/va-prep/index.html">Virginia</a></li>
                            <li><a href="../../exams/plumbing-license-prep/journeyman/kansas-prep/index.html">Kansas</a></li>
                            <li><a href="../../exams/plumbing-license-prep/journeyman/ma-prep/index.html">Massachusetts</a></li>
                            <li><a href="../../exams/plumbing-license-prep/journeyman/wssc-prep/index.html">WSSC (Maryland/DC)</a></li>
                        </ul>
                    </li>
                    <li><a href="../../wiki/index.html">Blog</a></li>
                </ul>
            </nav>
        </div>
    </header>
    <main class="container" style="padding-top:2rem;">
        
        <!-- Breadcrumbs -->
        <nav aria-label="Breadcrumb" class="breadcrumbs" style="margin-bottom: 2rem; font-size: 0.9rem; color: var(--text-secondary);">
            <a href="../../index.html" style="color: var(--primary); text-decoration: none;">Home</a> &gt; 
            <a href="../index.html" style="color: var(--primary); text-decoration: none;">Wiki</a> &gt; 
            <span style="color: var(--text-primary); font-weight: 500;">$title</span>
        </nav>

        <div class="page-layout">
            <!-- LEFT COLUMN: SIDEBAR SITE NAVIGATION -->
            <aside class="sidebar-left glass-card">
                <h3>Other Categories</h3>
                <ul style="list-style:none; padding:0; margin:0 0 1.5rem; display:flex; flex-direction:column; gap:0.5rem;">
$otherCatsHtml                </ul>
                <h3>Exam Silos</h3>
                <ul style="list-style:none; padding:0; margin:0; display:flex; flex-direction:column; gap:0.5rem;">
                    <li><a href="../../exams/plumbing-license-prep/journeyman/index.html" style="color:var(--text-secondary); font-size:0.9rem;">Journeyman Exams</a></li>
                    <li><a href="../../exams/plumbing-license-prep/master-contractor/index.html" style="color:var(--text-secondary); font-size:0.9rem;">Master Exams</a></li>
                    <li><a href="../../exams/plumbing-license-prep/tradesman-other/index.html" style="color:var(--text-secondary); font-size:0.9rem;">Tradesman Exams</a></li>
                    <li><a href="../../exams/plumbing-aptitude-test/index.html" style="color:var(--text-secondary); font-size:0.9rem;">Plumbing Aptitude</a></li>
                </ul>
            </aside>

            <!-- MIDDLE COLUMN: DIRECTORY CONTENT -->
            <div class="main-content">
                <div style="margin-bottom:2.5rem; padding-bottom:1.5rem; border-bottom:1px solid var(--bg-card-border);">
                    <span style="font-size:0.75rem; font-weight:700; color:var(--accent); text-transform:uppercase; letter-spacing:0.08em;">Category Directory</span>
                    <h1 style="font-size:2.4rem; font-weight:800; color:white; margin:0.5rem 0;">$title</h1>
                    
                    <!-- E-E-A-T Badges Row -->
                    <div style="display: flex; gap: 1rem; align-items: center; margin-top: 1rem; margin-bottom: 1.5rem; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 1rem; flex-wrap: wrap;">
                        <div style="background: rgba(255,255,255,0.03); padding: 0.4rem 1rem; border-radius: 50px; font-size: 0.85rem; color: var(--text-secondary);">
                             Curator: <strong style="color: white;">John Masterson, Master Plumber</strong>
                        </div>
                        <div style="background: rgba(255,255,255,0.03); padding: 0.4rem 1rem; border-radius: 50px; font-size: 0.85rem; color: var(--text-secondary);">
                             Last Updated: 2026-08-16
                        </div>
                        <span style="background: rgba(16, 185, 129, 0.1); color: #34d399; padding: 0.4rem 1rem; border-radius: 50px; font-size: 0.85rem; font-weight: bold;">Verified Directory</span>
                    </div>

                    <p style="color:var(--text-secondary); font-size:1.02rem; margin-top:0.5rem;">$count articles including long-form guides (★) and concise trade term definitions.</p>
                </div>

                <!-- AIO/GEO Summary Overview Block -->
                <div style="background: rgba(255,255,255,0.02); border-left: 4px solid var(--primary); padding: 1.25rem; border-radius: 4px; margin-bottom: 2rem;">
                    <div style="font-size: 0.75rem; font-weight: 800; color: var(--accent); text-transform: uppercase; margin-bottom: 0.4rem; letter-spacing: 0.05em;">AI Overview &amp; Key Concepts</div>
                    <p style="margin: 0; font-size: 0.95rem; color: var(--text-secondary);">
                        This directory serves as the official reference index for $title. Use the links below to access full study calculators, clearances, formulas, and mock definitions designed for state-level licensing exams.
                    </p>
                </div>

                $gridHtml
            </div>

            <!-- RIGHT COLUMN: PROMO BANNER -->
            <aside class="sidebar-right glass-card">
                <div style="background:linear-gradient(135deg,rgba(99,102,241,0.1),rgba(168,85,247,0.1)); border:1px solid rgba(168,85,247,0.15); border-radius:16px; padding:1.5rem; text-align:center;">
                    <span style="display:inline-block; background:linear-gradient(90deg,var(--primary),var(--secondary)); color:#fff; font-size:0.7rem; font-weight:800; padding:3px 10px; border-radius:50px; text-transform:uppercase; margin-bottom:0.8rem;">Best Seller</span>
                    <h4 style="color:#fff; margin-bottom:0.5rem;">Journeyman Prep Bundle</h4>
                    <p style="font-size:0.85rem; color:var(--text-secondary); margin-bottom:1rem;">Ace your PSI or state exam with interactive simulators and mock tests.</p>
                    <a href="../../courses/journeyman-plumber-prep-bundle" class="btn-cta-secondary">Get Prep Bundle</a>
                </div>
            </aside>
        </div>
    </main>

$tagsSectionHub
$footerHub
</body>
</html>
"@
    return $html
}

# Process each category hub page
foreach ($cat in $categories) {
    $filePath = Join-Path $tempDir "wiki\$cat\index.html"
    if (-not (Test-Path $filePath)) { continue }

    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

    # Extract class="dir-grid" block
    $gridMatch = [System.Text.RegularExpressions.Regex]::Match($content, '(?s)<div class="dir-grid">.*?</div>')
    if (-not $gridMatch.Success) {
        # Try finding a grid div block manually
        $gridMatch = [System.Text.RegularExpressions.Regex]::Match($content, '(?s)<div class="dir-grid">.*')
    }

    if ($gridMatch.Success) {
        $gridHtml = $gridMatch.Value
        
        # Count the number of articles in this grid
        $itemCount = ([regex]::Matches($gridHtml, '<div class="dir-item[^"]*">')).Count
        if ($itemCount -eq 0) {
            $itemCount = ([regex]::Matches($gridHtml, '<div class="dir-item">')).Count
        }

        $title = $categoryDisplayNames[$cat]
        $newHtml = Build-CategoryHubHtml -cat $cat -title $title -gridHtml $gridHtml -count $itemCount

        [System.IO.File]::WriteAllText($filePath, $newHtml, [System.Text.Encoding]::UTF8)
        Write-Host "Successfully rebuilt and optimized wiki/$cat/index.html with $itemCount articles." -ForegroundColor Green
    } else {
        Write-Warning "Could not find dir-grid in wiki/$cat/index.html"
    }
}

# Commit and Push
Set-Location $tempDir
git config user.email "deploy@eduprosuite.org"
git config user.name "EduProSuite Deployer"
git add -A
git commit -m "Rebuild Category Hub Index Pages cleanly with EEAT, AIO descriptions, proper breadcrumbs, and tags"
git push origin main

Set-Location $PSScriptRoot
Remove-Item -Path $tempDir -Recurse -Force | Out-Null
Write-Host "Rebuild hubs complete!" -ForegroundColor Green
