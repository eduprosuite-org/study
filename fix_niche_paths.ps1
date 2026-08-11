# Correctly fix all niche pages with exact relative paths based on depth
# Hub pages (exams/FOLDER/index.html) = depth 2, relPath = "../"
# Sub pages (exams/FOLDER/SUB/index.html) = depth 3, relPath = "../../"

$root = $PSScriptRoot

$nicheFolders = @(
    "ca-real-estate-math",
    "vic-lea-electrician-prep",
    "sarasota-adu-permit-checklist",
    "gwinnett-home-occupation-checklist",
    "douglas-co-residential-building-checklist"
)

function Build-NicheSidebar($toExams, $toRoot) {
    return "<aside class=`"sidebar-left glass-card`">
                <h3>Specialized &amp; Niche Exams</h3>
                <ul>
                    <li><a href=`"${toExams}ca-real-estate-math/index.html`">California Real Estate Math</a></li>
                    <li><a href=`"${toExams}vic-lea-electrician-prep/index.html`">Victoria LEA Electrician</a></li>
                </ul>
                <h3>Local Permit Checklists</h3>
                <ul>
                    <li><a href=`"${toExams}sarasota-adu-permit-checklist/index.html`">Sarasota ADU Permits</a></li>
                    <li><a href=`"${toExams}gwinnett-home-occupation-checklist/index.html`">Gwinnett Home Occupation</a></li>
                    <li><a href=`"${toExams}douglas-co-residential-building-checklist/index.html`">Douglas County CO Building</a></li>
                </ul>
                <h3>Resources</h3>
                <ul>
                    <li><a href=`"${toRoot}index.html`">Home</a></li>
                    <li><a href=`"${toRoot}wiki/index.html`">Blog</a></li>
                </ul>
            </aside>"
}

function Build-NicheFooter($rr) {
    return "        <footer>
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
    </footer>"
}

function Build-TagsSection($r, $rr) {
    return @"
    <section class="niche-tags-container" style="max-width: 1200px; margin: 2rem auto; padding: 0 1.5rem;">
        <div style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08); border-radius: 16px; padding: 2rem;">
            <h3 style="font-size: 1.15rem; color: white; font-weight: 700; margin: 0 0 1.2rem 0;">Explore Licensing &amp; Compliance Resources</h3>
            <div class="niche-tags-list">
                <a href="${rr}exams/ca-real-estate-math/index.html" class="niche-tag-link">CA Real Estate Math Prep</a>
                <a href="${rr}exams/ca-real-estate-math/practice-test/index.html" class="niche-tag-link">Real Estate Practice Simulator</a>
                <a href="${rr}exams/ca-real-estate-math/study-guide/index.html" class="niche-tag-link">Real Estate Formulas Study Guide</a>
                <a href="${rr}exams/vic-lea-electrician-prep/index.html" class="niche-tag-link">Victoria LEA Electrician Prep</a>
                <a href="${rr}exams/vic-lea-electrician-prep/practice-test/index.html" class="niche-tag-link">LEA Practice Quiz LET/LEP</a>
                <a href="${rr}exams/vic-lea-electrician-prep/study-guide/index.html" class="niche-tag-link">AS NZS 3000 Study Guide</a>
                <a href="${rr}exams/sarasota-adu-permit-checklist/index.html" class="niche-tag-link">Sarasota ADU Permit Guide</a>
                <a href="${rr}exams/sarasota-adu-permit-checklist/zoning-guide/index.html" class="niche-tag-link">Sarasota Zoning Requirements</a>
                <a href="${rr}exams/gwinnett-home-occupation-checklist/index.html" class="niche-tag-link">Gwinnett Home Occupation</a>
                <a href="${rr}exams/gwinnett-home-occupation-checklist/zoning-requirements/index.html" class="niche-tag-link">Gwinnett UDO Zoning Rules</a>
                <a href="${rr}exams/douglas-co-residential-building-checklist/index.html" class="niche-tag-link">Douglas County Building Checklist</a>
                <a href="${rr}exams/douglas-co-residential-building-checklist/building-codes/index.html" class="niche-tag-link">Douglas County Building Codes</a>
            </div>
        </div>
    </section>
"@
}

$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $isNiche = $false
    foreach ($f in $nicheFolders) { if ($_.FullName -match [regex]::Escape($f)) { $isNiche = $true; break } }
    $isNiche
}

foreach ($file in $htmlFiles) {
    $relToRoot = $file.FullName.Substring($root.Length).TrimStart('\')
    $parts = $relToRoot -split '\\'
    $depth = $parts.Count - 1  # number of directories above the file

    # For hub pages (exams/FOLDER/index.html), depth = 2
    # For sub pages (exams/FOLDER/SUB/index.html), depth = 3

    # relExams = path from this file back to the exams/ folder
    # For depth=2: "../" goes to exams/
    # For depth=3: "../../" goes to exams/
    $stepsToExams = $depth - 1  # steps to get back to exams/
    $toExams = ""
    for ($i = 0; $i -lt $stepsToExams; $i++) { $toExams += "../" }

    # relRoot = path from this file back to site root
    $toRoot = ""
    for ($i = 0; $i -lt $depth; $i++) { $toRoot += "../" }

    $content = Get-Content $file.FullName -Raw -Encoding UTF8

    # Build and replace sidebar
    $sidebar = Build-NicheSidebar $toExams $toRoot
    $content = $content -replace '(?s)                        <aside class="sidebar-left glass-card">
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
            </aside>', $sidebar

    # Remove old tags sections
    $content = $content -replace '(?s)<section class="niche-tags-container".*?</section>\s*', ''

    # Build tags
    $tags = Build-TagsSection $toExams $toRoot

    # Build and replace footer
    $footer = Build-NicheFooter $toRoot
    $content = $content -replace '(?s)        <footer>
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
    </footer>', ($tags + $footer)

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Fixed [$depth depth]: $relToRoot" -ForegroundColor Cyan
}

Write-Host "`nAll niche pages fixed!" -ForegroundColor Green


