$htmlFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.FullName -notmatch "\\scratch\\" }
$ps1Files = Get-ChildItem -Path $PSScriptRoot -Filter *.ps1 | Where-Object { $_.Name -notmatch "fix_all.ps1" -and $_.Name -notmatch "update_navigation.ps1" }

$allFiles = $htmlFiles + $ps1Files

foreach ($file in $allFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Calculate depth for relative paths if it's an HTML file
    $relPath = ""
    if ($file.Extension -eq ".html") {
        $depth = ($file.FullName.Substring($PSScriptRoot.Length).Split('\')).Count - 2
        if ($depth -lt 0) { $depth = 0 }
        for ($i = 0; $i -lt $depth; $i++) { $relPath += "../" }
    } else {
        $relPath = "`$`$(if (`$relPath) {`$relPath} else {`"../../`"})"
    }

    # 1. Update Header Navigation (Category Wise)
    $newHeaderNav = @"
                <ul style="display: flex; gap: 1.5rem; list-style: none;">
                    <li><a href="$($relPath)index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Home</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/journeyman/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Journeyman</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/master-contractor/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Master</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/tradesman-other/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Tradesman</a></li>
                    <li><a href="$($relPath)wiki/index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Blog</a></li>
                </ul>
"@
    # Regex replace the header ul block
    $content = $content -replace '(?s)<ul style="display: flex; gap: 1\.5rem; list-style: none;">.*?</ul>', $newHeaderNav

    # 2. Update Left Sidebar (Add Widgets)
    $newSidebar = @"
            <aside class="sidebar-left glass-card">
                <h3>Exam Categories</h3>
                <ul>
                    <li><a href="$($relPath)exams/plumbing-license-prep/journeyman/index.html">Journeyman Exams</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/master-contractor/index.html">Master Exams</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/tradesman-other/index.html">Tradesman Exams</a></li>
                </ul>
                <h3>Popular Products</h3>
                <ul>
                    <li><a href="$($relPath)exams/plumbing-license-prep/journeyman/texas-prep/index.html">Texas Journeyman</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/journeyman/va-prep/index.html">Virginia Journeyman</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/master-contractor/master-prep/index.html">Master Plumber</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/general/code-cert-prep/index.html">Code Certification</a></li>
                </ul>
                <h3>Resources</h3>
                <ul>
                    <li><a href="$($relPath)wiki/index.html">Blog</a></li>
                </ul>
            </aside>
"@
    $content = $content -replace '(?s)<aside class="sidebar-left glass-card">.*?</aside>', $newSidebar

    # 3. Update Footer
    $newFooterContent = @"
        <div class="footer-content" style="flex-direction: column; gap: 1.5rem;">
            <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap;">
                <a href="$($relPath)index.html" style="color: var(--text-secondary); text-decoration: none;">Home</a>
                <a href="$($relPath)exams/plumbing-license-prep/journeyman/index.html" style="color: var(--text-secondary); text-decoration: none;">Journeyman Exams</a>
                <a href="$($relPath)exams/plumbing-license-prep/master-contractor/index.html" style="color: var(--text-secondary); text-decoration: none;">Master Exams</a>
                <a href="$($relPath)exams/plumbing-license-prep/tradesman-other/index.html" style="color: var(--text-secondary); text-decoration: none;">Tradesman Exams</a>
                <a href="$($relPath)wiki/index.html" style="color: var(--text-secondary); text-decoration: none;">Blog</a>
            </div>
            <div>© 2026 ExamPrep Portal.</div>
        </div>
"@
    $content = $content -replace '(?s)<div class="footer-content">.*?</div>\s*</div>', $newFooterContent

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Navigation layouts upgraded successfully!" -ForegroundColor Green

