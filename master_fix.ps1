# ============================================================
# master_fix.ps1
# 1. Strip UTF-8 BOM from every .html and .ps1 file
# 2. Replace all non-ASCII chars with nothing (kills leftover emojis)
# 3. Inject category-wise dropdown navigation in header and footer
# ============================================================

$rootDir = $PSScriptRoot

# ---- Helper: relative path from a file to root ----
function Get-RelPath($filePath) {
    $depth = ($filePath.Substring($rootDir.Length).TrimStart('\').Split('\')).Count - 1
    if ($depth -le 0) { return "./" }
    return ("../" * $depth)
}

# ---- Build the header dropdown nav HTML ----
function Get-HeaderNav($rel) {
    return @"
        <div class="nav-container">
            <div class="logo">
                <a href="${rel}index.html" style="text-decoration:none;color:inherit;">ExamPrep<span>Portal</span></a>
            </div>
            <nav aria-label="Main Navigation" class="main-nav">
                <ul class="nav-list">
                    <li><a href="${rel}index.html">Home</a></li>
                    <li class="has-dropdown">
                        <a href="${rel}exams/plumbing-license-prep/index.html">Plumbing Exams &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="${rel}exams/plumbing-license-prep/journeyman/index.html">Journeyman Exams</a></li>
                            <li><a href="${rel}exams/plumbing-license-prep/master-contractor/index.html">Master Contractor</a></li>
                            <li><a href="${rel}exams/plumbing-license-prep/tradesman-other/index.html">Tradesman &amp; Inspector</a></li>
                            <li><a href="${rel}exams/plumbing-license-prep/general/index.html">General &amp; Free Prep</a></li>
                        </ul>
                    </li>
                    <li class="has-dropdown">
                        <a href="${rel}exams/plumbing-license-prep/journeyman/index.html">By State &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="${rel}exams/plumbing-license-prep/journeyman/texas-prep/index.html">Texas</a></li>
                            <li><a href="${rel}exams/plumbing-license-prep/journeyman/va-prep/index.html">Virginia</a></li>
                            <li><a href="${rel}exams/plumbing-license-prep/journeyman/kansas-prep/index.html">Kansas</a></li>
                            <li><a href="${rel}exams/plumbing-license-prep/journeyman/ma-prep/index.html">Massachusetts</a></li>
                            <li><a href="${rel}exams/plumbing-license-prep/journeyman/wssc-prep/index.html">WSSC (Maryland/DC)</a></li>
                        </ul>
                    </li>
                    <li><a href="${rel}wiki/index.html">Blog</a></li>
                </ul>
            </nav>
        </div>
"@
}

# ---- Build the footer nav HTML ----
function Get-Footer($rel) {
    return @"
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
"@
}

# ---- Process every HTML file ----
$htmlFiles = Get-ChildItem -Path $rootDir -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" }

foreach ($file in $htmlFiles) {
    # Read as raw bytes to handle BOM
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    
    # Strip UTF-8 BOM (EF BB BF)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $bytes = $bytes[3..($bytes.Length-1)]
    }
    
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    # Strip ALL remaining non-ASCII characters (mangled emojis, BOM remnants, etc.)
    $text = [regex]::Replace($text, '[^\x09\x0A\x0D\x20-\x7E]', '')
    
    # Calculate relative path
    $rel = Get-RelPath $file.FullName
    
    # Replace the entire <header>...</header> block
    $newHeader = "<header>`n" + (Get-HeaderNav $rel) + "`n    </header>"
    $text = [regex]::Replace($text, '(?s)<header>.*?</header>', $newHeader)
    
    # Replace the entire         <footer>
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
    </footer> block
    $newFooter = Get-Footer $rel
    $text = [regex]::Replace($text, '(?s)        <footer>
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
    </footer>', $newFooter)
    
    # Write back as UTF-8 WITHOUT BOM
    $utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($file.FullName, $text, $utf8NoBOM)
    
    Write-Host "Fixed: $($file.Name)"
}

Write-Host "`nAll files cleaned and navigation updated!" -ForegroundColor Green


