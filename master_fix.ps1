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
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-col">
                    <strong>Exam Categories</strong>
                    <ul>
                        <li><a href="${rel}exams/plumbing-license-prep/journeyman/index.html">Journeyman Exams</a></li>
                        <li><a href="${rel}exams/plumbing-license-prep/master-contractor/index.html">Master Contractor</a></li>
                        <li><a href="${rel}exams/plumbing-license-prep/tradesman-other/index.html">Tradesman &amp; Inspector</a></li>
                        <li><a href="${rel}exams/plumbing-license-prep/general/index.html">General &amp; Free Prep</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <strong>By State</strong>
                    <ul>
                        <li><a href="${rel}exams/plumbing-license-prep/journeyman/texas-prep/index.html">Texas Journeyman</a></li>
                        <li><a href="${rel}exams/plumbing-license-prep/journeyman/va-prep/index.html">Virginia Journeyman</a></li>
                        <li><a href="${rel}exams/plumbing-license-prep/journeyman/kansas-prep/index.html">Kansas Journeyman</a></li>
                        <li><a href="${rel}exams/plumbing-license-prep/journeyman/ma-prep/index.html">Massachusetts Journeyman</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <strong>Resources</strong>
                    <ul>
                        <li><a href="${rel}wiki/index.html">Blog &amp; Articles</a></li>
                        <li><a href="${rel}exams/plumbing-license-prep/general/free-prep/index.html">Free Practice Test</a></li>
                        <li><a href="${rel}sitemap.xml">Sitemap</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <strong>Other Exams</strong>
                    <ul>
                        <li><a href="${rel}exams/ca-real-estate-math/index.html">CA Real Estate Math</a></li>
                        <li><a href="${rel}exams/vic-lea-electrician-prep/index.html">Vic LEA Electrician</a></li>
                        <li><a href="${rel}exams/sarasota-adu-permit-checklist/index.html">Sarasota ADU Permits</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">&copy; 2026 ExamPrep Portal. All rights reserved.</div>
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
    
    # Replace the entire <footer>...</footer> block
    $newFooter = Get-Footer $rel
    $text = [regex]::Replace($text, '(?s)<footer>.*?</footer>', $newFooter)
    
    # Write back as UTF-8 WITHOUT BOM
    $utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($file.FullName, $text, $utf8NoBOM)
    
    Write-Host "Fixed: $($file.Name)"
}

Write-Host "`nAll files cleaned and navigation updated!" -ForegroundColor Green
