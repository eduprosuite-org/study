$htmlFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.FullName -notmatch "\\scratch\\" -and $_.FullName -notmatch "exams\\plumbing-license-prep" }
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
    $isNiche = $false
    $nicheFolders = @(
        "ca-real-estate-math",
        "vic-lea-electrician-prep",
        "plumbing-aptitude-test",
        "sarasota-adu-permit-checklist",
        "gwinnett-home-occupation-checklist",
        "douglas-co-residential-building-checklist"
    )
    foreach ($folder in $nicheFolders) {
        if ($file.FullName -match [regex]::Escape($folder)) {
            $isNiche = $true
            break
        }
    }

    if ($isNiche) {
        $newSidebar = @"
            <aside class="sidebar-left glass-card">
                <h3>Specialized &amp; Niche Exams</h3>
                <ul>
                    <li><a href="$($relPath)exams/ca-real-estate-math/index.html">California Real Estate Math</a></li>
                    <li><a href="$($relPath)exams/vic-lea-electrician-prep/index.html">Victoria LEA Electrician</a></li>
                    <li><a href="$($relPath)exams/plumbing-aptitude-test/index.html">Plumbing Aptitude Test</a></li>
                </ul>
                <h3>Local Permit Checklists</h3>
                <ul>
                    <li><a href="$($relPath)exams/sarasota-adu-permit-checklist/index.html">Sarasota ADU Permits</a></li>
                    <li><a href="$($relPath)exams/gwinnett-home-occupation-checklist/index.html">Gwinnett Home Occupation</a></li>
                    <li><a href="$($relPath)exams/douglas-co-residential-building-checklist/index.html">Douglas County CO Building</a></li>
                </ul>
                <h3>Resources</h3>
                <ul>
                    <li><a href="$($relPath)index.html">Home</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/index.html">Plumbing License Hub</a></li>
                    <li><a href="$($relPath)wiki/index.html">Blog</a></li>
                </ul>
            </aside>
"@
    } else {
        $newSidebar = @"
            <aside class="sidebar-left glass-card">
                <h3>Exam Categories</h3>
                <ul>
                    <li><a href="$($relPath)exams/plumbing-license-prep/journeyman/index.html">Journeyman Exams</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/master-contractor/index.html">Master Exams</a></li>
                    <li><a href="$($relPath)exams/plumbing-license-prep/tradesman-other/index.html">Tradesman Exams</a></li>
                    <li><a href="$($relPath)exams/plumbing-aptitude-test/index.html">Plumbing Aptitude Prep</a></li>
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
    }
    $content = $content -replace '(?s)<aside class="sidebar-left glass-card">.*?</aside>', $newSidebar

    # 3. Update Footer
    $newFooter = @"
    <footer>
        <div class="footer-content" style="flex-direction: column; gap: 1.5rem;">
            <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap;">
                <a href="$($relPath)index.html" style="color: var(--text-secondary); text-decoration: none;">Home</a>
                <a href="$($relPath)exams/plumbing-license-prep/journeyman/index.html" style="color: var(--text-secondary); text-decoration: none;">Journeyman Exams</a>
                <a href="$($relPath)exams/plumbing-license-prep/master-contractor/index.html" style="color: var(--text-secondary); text-decoration: none;">Master Exams</a>
                <a href="$($relPath)exams/plumbing-license-prep/tradesman-other/index.html" style="color: var(--text-secondary); text-decoration: none;">Tradesman Exams</a>
                <a href="$($relPath)wiki/index.html" style="color: var(--text-secondary); text-decoration: none;">Blog</a>
            </div>
            <div style="display: flex; gap: 1.5rem; justify-content: center; flex-wrap: wrap; font-size: 0.9rem; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 0.75rem;">
                <a href="$($relPath)exams/ca-real-estate-math/index.html" style="color: var(--text-secondary); text-decoration: none;">CA Real Estate Math</a>
                <a href="$($relPath)exams/vic-lea-electrician-prep/index.html" style="color: var(--text-secondary); text-decoration: none;">Vic LEA Electrician</a>
                <a href="$($relPath)exams/plumbing-aptitude-test/index.html" style="color: var(--text-secondary); text-decoration: none;">Plumbing Aptitude</a>
                <a href="$($relPath)exams/sarasota-adu-permit-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Sarasota ADU Permits</a>
                <a href="$($relPath)exams/gwinnett-home-occupation-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Gwinnett Home Occupation</a>
                <a href="$($relPath)exams/douglas-co-residential-building-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Douglas County Building</a>
            </div>
            <div>© 2026 ExamPrep Portal. All rights reserved.</div>
        </div>
    </footer>
"@
    $content = $content -replace '(?s)<footer>.*?</footer>', $newFooter

    # 4. Strip and Add Niche Tags before footer if it's a niche page
    $content = $content -replace '(?s)<div class="page-layout" style="margin-top: 2rem; margin-bottom: 2rem;">\s*<section class="niche-tags-container".*?</section>\s*</div>', ''
    
    if ($isNiche) {
        $tagsHtml = @"
    <div class="page-layout" style="margin-top: 2rem; margin-bottom: 2rem;">
        <section class="niche-tags-container" style="width: 100%;">
            <h3 style="font-size: 1.25rem; color: white; font-weight: 700; margin: 0;">Explore Licensing &amp; Compliance Resources</h3>
            <div class="niche-tags-list">
                <a href="$($relPath)exams/ca-real-estate-math/index.html" class="niche-tag-link">CA Real Estate Math Prep</a>
                <a href="$($relPath)exams/vic-lea-electrician-prep/index.html" class="niche-tag-link">Victoria LEA Electrician Prep</a>
                <a href="$($relPath)exams/plumbing-aptitude-test/index.html" class="niche-tag-link">Plumbing Aptitude Prep</a>
                <a href="$($relPath)exams/sarasota-adu-permit-checklist/index.html" class="niche-tag-link">Sarasota ADU Permit Guide</a>
                <a href="$($relPath)exams/gwinnett-home-occupation-checklist/index.html" class="niche-tag-link">Gwinnett Home Occupation Checklist</a>
                <a href="$($relPath)exams/douglas-co-residential-building-checklist/index.html" class="niche-tag-link">Douglas County Building Checklist</a>
            </div>
        </section>
    </div>
"@
        if ($content -match "<!-- Semantic Footer -->") {
            $content = $content -replace '<!-- Semantic Footer -->', ($tagsHtml + "`r`n    <!-- Semantic Footer -->")
        } else {
            $content = $content -replace '<footer>', ($tagsHtml + "`r`n    <footer>")
        }
    }

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Navigation layouts upgraded successfully!" -ForegroundColor Green
