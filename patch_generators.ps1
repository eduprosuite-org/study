$generators = @("generate_plumbing_silo.ps1", "generate_wiki.ps1")

foreach ($gen in $generators) {
    $path = Join-Path $PSScriptRoot $gen
    $content = Get-Content $path -Raw
    
    # 1. Update Header Navigation
    # We replace the closing </ul> in <nav> with the blog link
    $content = $content -replace '</ul>\s*</nav>\s*</div>\s*</header>', "    <li><a href=`"`$`$(if (`$relPath) {`$relPath} else {`"../../`"})wiki/index.html`" style=`"color: var(--text-secondary); text-decoration: none; font-weight: 500;`">Blog</a></li>`n                </ul></nav></div></header>"
    
    # 2. Add Left Sidebar Menu
    # We find <main ...> and replace it with <main ...><div class="page-layout"><aside...><div class="main-content">
    $sidebarStr = @"
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
"@
    $content = $content -replace '(<main[^>]*>)', "`$1`n$sidebarStr"
    
    # Close the page-layout divs before </main>
    $content = $content -replace '(</main>)', "            </div>`n        </div>`n`$1"
    
    # 3. Update Footer
    $content = $content -replace '</div>\s*</footer>', "    <div><a href=`"`$`$(if (`$relPath) {`$relPath} else {`"../../`"})wiki/index.html`" style=`"color: var(--text-secondary); text-decoration: none;`">Blog / Wiki</a></div>`n        </div>`n    </footer>"

    Set-Content -Path $path -Value $content -Encoding UTF8
}

Write-Host "Generators patched successfully!" -ForegroundColor Cyan







