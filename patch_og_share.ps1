# ============================================================
# patch_og_share.ps1
# Adds Open Graph meta tags + Social Share Buttons to ALL
# existing HTML files in the EduProSuite website.
# ============================================================

$baseDir   = "d:\1 hour in clg"
$siteUrl   = "https://eduprosuite-org.github.io/study"
$ogImage   = "https://eduprosuite-org.github.io/study/og-banner.jpg"
$siteName  = "ExamPrep Portal"

# ---- Social Share Bar HTML (pure CSS, no external JS needed) ----
$shareBarCSS = @'
<style>
/* ===== Social Share Floating Bar ===== */
.share-bar {
    position: fixed;
    right: 18px;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
    flex-direction: column;
    gap: 10px;
    z-index: 9999;
}
.share-btn {
    width: 44px;
    height: 44px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    font-size: 18px;
    transition: transform 0.25s, box-shadow 0.25s;
    border: 1px solid rgba(255,255,255,0.12);
    backdrop-filter: blur(10px);
    cursor: pointer;
}
.share-btn:hover { transform: scale(1.18); box-shadow: 0 6px 24px rgba(0,0,0,0.4); }
.share-btn.twitter  { background: rgba(29,161,242,0.18);  color: #1da1f2; }
.share-btn.linkedin { background: rgba(10,102,194,0.18);  color: #0a66c2; }
.share-btn.whatsapp { background: rgba(37,211,102,0.18);  color: #25d366; }
.share-btn.facebook { background: rgba(66,103,178,0.18);  color: #4267B2; }
.share-btn.copylink { background: rgba(99,102,241,0.18);  color: #818cf8; }
.share-label {
    position: absolute;
    right: 54px;
    background: rgba(17,24,39,0.95);
    color: #f3f4f6;
    font-size: 0.75rem;
    padding: 4px 10px;
    border-radius: 6px;
    white-space: nowrap;
    opacity: 0;
    pointer-events: none;
    transition: opacity 0.2s;
    border: 1px solid rgba(255,255,255,0.08);
}
.share-btn:hover .share-label { opacity: 1; }
.share-btn { position: relative; }
@media (max-width: 768px) {
    .share-bar {
        position: fixed;
        right: unset;
        bottom: 0;
        top: unset;
        left: 0;
        width: 100%;
        transform: none;
        flex-direction: row;
        justify-content: center;
        padding: 10px 0;
        background: rgba(9,13,22,0.92);
        backdrop-filter: blur(12px);
        border-top: 1px solid rgba(255,255,255,0.08);
        gap: 16px;
    }
    .share-label { display: none; }
}
</style>
'@

# ---- Share Bar HTML (JS reads current page URL dynamically) ----
$shareBarHTML = @'
<!-- ===== Social Share Floating Bar ===== -->
<div class="share-bar" aria-label="Share this page">
    <a class="share-btn twitter"
       id="share-twitter"
       href="#" target="_blank" rel="noopener"
       title="Share on Twitter/X"
       onclick="this.href='https://twitter.com/intent/tweet?url='+encodeURIComponent(window.location.href)+'&text='+encodeURIComponent(document.title);return true;">
        <span class="share-label">Twitter / X</span>
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
    </a>
    <a class="share-btn linkedin"
       id="share-linkedin"
       href="#" target="_blank" rel="noopener"
       title="Share on LinkedIn"
       onclick="this.href='https://www.linkedin.com/sharing/share-offsite/?url='+encodeURIComponent(window.location.href);return true;">
        <span class="share-label">LinkedIn</span>
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433a2.062 2.062 0 01-2.063-2.065 2.064 2.064 0 112.063 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/></svg>
    </a>
    <a class="share-btn whatsapp"
       id="share-whatsapp"
       href="#" target="_blank" rel="noopener"
       title="Share on WhatsApp"
       onclick="this.href='https://wa.me/?text='+encodeURIComponent(document.title+' - '+window.location.href);return true;">
        <span class="share-label">WhatsApp</span>
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413Z"/></svg>
    </a>
    <a class="share-btn facebook"
       id="share-facebook"
       href="#" target="_blank" rel="noopener"
       title="Share on Facebook"
       onclick="this.href='https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(window.location.href);return true;">
        <span class="share-label">Facebook</span>
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
    </a>
    <button class="share-btn copylink"
       id="share-copy"
       title="Copy Link"
       onclick="navigator.clipboard.writeText(window.location.href).then(function(){var b=document.getElementById('share-copy');b.style.color='#10b981';setTimeout(function(){b.style.color='#818cf8';},2000);})">
        <span class="share-label">Copy Link</span>
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
    </button>
</div>
'@

# ---- Collect all HTML files ----
$htmlFiles = Get-ChildItem -Path $baseDir -Filter "*.html" -Recurse |
    Where-Object { $_.FullName -notlike "*\.git\*" -and $_.FullName -notlike "*\.agents\*" }

Write-Host "Found $($htmlFiles.Count) HTML files to patch." -ForegroundColor Cyan

$patched = 0
$skipped = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding utf8

    # --- Skip if already patched ---
    if ($content -like "*og:title*" -and $content -like "*share-bar*") {
        $skipped++
        continue
    }

    # --- Derive relative URL path for this file ---
    $relPath = $file.FullName.Replace($baseDir, "").Replace("\", "/").TrimStart("/")
    # Convert .html path to URL (remove index.html for clean URLs if needed)
    $pageUrl  = "$siteUrl/$relPath"

    # --- Extract existing title ---
    $titleMatch = [regex]::Match($content, '<title>([^<]+)</title>')
    $pageTitle  = if ($titleMatch.Success) { $titleMatch.Groups[1].Value.Trim() } else { $siteName }

    # --- Extract existing description ---
    $descMatch = [regex]::Match($content, '<meta\s+name=["\x27]description["\x27]\s+content=["\x27]([^"\']+)["\x27]')
    $pageDesc  = if ($descMatch.Success) { $descMatch.Groups[1].Value.Trim() } else { "Premium exam prep courses, interactive practice tests, flashcards, and calculators for licensing exams." }

    # --- Build OG block ---
    $ogBlock = @"

    <!-- Open Graph / Social Preview -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="$pageUrl">
    <meta property="og:title" content="$pageTitle">
    <meta property="og:description" content="$pageDesc">
    <meta property="og:image" content="$ogImage">
    <meta property="og:site_name" content="$siteName">
    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="$pageTitle">
    <meta name="twitter:description" content="$pageDesc">
    <meta name="twitter:image" content="$ogImage">
"@

    # --- Inject OG tags just before </head> ---
    if ($content -notlike "*og:title*") {
        $content = $content -replace '(</head>)', "$ogBlock`$1"
    }

    # --- Inject Share Bar CSS just before </head> (if not already) ---
    if ($content -notlike "*share-bar*") {
        $content = $content -replace '(</head>)', "$shareBarCSS`$1"
        # Inject Share Bar HTML just before </body>
        $content = $content -replace '(</body>)', "$shareBarHTML`$1"
    }

    # --- Write back ---
    Set-Content -Path $file.FullName -Value $content -Encoding utf8
    $patched++
    Write-Host "  Patched: $($file.Name)" -ForegroundColor Green
}

Write-Host ""
Write-Host "============================" -ForegroundColor Yellow
Write-Host "Patched : $patched files" -ForegroundColor Green
Write-Host "Skipped : $skipped files (already patched)" -ForegroundColor Gray
Write-Host "============================" -ForegroundColor Yellow
Write-Host "Done! OG tags + Social Share Buttons added to all HTML files." -ForegroundColor Cyan
