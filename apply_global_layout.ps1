$htmlFiles = Get-ChildItem -Path $PSScriptRoot -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.FullName -notmatch "\\scratch\\" }

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw

    # 1. Update Header Navigation (Add Wiki/Blog)
    # Find the closing </ul> in the <nav> inside <header>
    if ($content -notmatch 'Blog</a></li>') {
        # Determine relative path to root based on file depth
        $relPath = ""
        $depth = ($file.FullName.Substring($PSScriptRoot.Length).Split('\')).Count - 2
        if ($depth -lt 0) { $depth = 0 }
        for ($i = 0; $i -lt $depth; $i++) { $relPath += "../" }
        
        $wikiLink = "<li><a href=`"$($relPath)wiki/index.html`" style=`"color: var(--text-secondary); text-decoration: none; font-weight: 500;`">Blog</a></li>`n                </ul>"
        
        $content = $content -replace '</ul>\s*</nav>\s*</div>\s*</header>', "$wikiLink</nav></div></header>"
    }

    # 2. Add Left Sidebar Menu
    if ($content -notmatch 'sidebar-left') {
        # Determine relative paths
        $relPath = ""
        $depth = ($file.FullName.Substring($PSScriptRoot.Length).Split('\')).Count - 2
        if ($depth -lt 0) { $depth = 0 }
        for ($i = 0; $i -lt $depth; $i++) { $relPath += "../" }

        $sidebarHtml = @"
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
        
        # Replace the opening <main> tag to inject the sidebar
        $content = $content -replace '(<main[^>]*>)', "`$1`n$sidebarHtml"
        
        # Close the page-layout divs before </main>
        $content = $content -replace '(</main>)', "            </div>`n        </div>`n`$1"
    }
    
    # 3. Update Footer
    if ($content -notmatch 'Blog / Wiki</a></div>') {
        $relPath = ""
        $depth = ($file.FullName.Substring($PSScriptRoot.Length).Split('\')).Count - 2
        if ($depth -lt 0) { $depth = 0 }
        for ($i = 0; $i -lt $depth; $i++) { $relPath += "../" }
        
        $footerLink = "<div><a href=`"$($relPath)wiki/index.html`" style=`"color: var(--text-secondary); text-decoration: none;`">Blog / Wiki</a></div>`n        </div>`n    </footer>"
        $content = $content -replace '</div>\s*</footer>', "$footerLink"
    }

    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
}

Write-Host "Global layout applied to all HTML files successfully!" -ForegroundColor Green







