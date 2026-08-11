$basePath = "d:\1 hour in clg"

Write-Host "1. Fixing Site Names JSON-LD (site-names.md.md)..."
$indexPath = Join-Path $basePath "index.html"
if (Test-Path $indexPath) {
    $content = Get-Content $indexPath -Raw
    
    # Fix the WebSite URL and add alternateName for Site Names SEO
    $content = $content -replace '"url":\s*"https://onlinemathstutor4u-glitch\.github\.io/real-estate-math-practice-tool/"', '"url": "https://eduprosuite-org.github.io/study/","alternateName": "EduProSuite Exams"'
    
    Set-Content -Path $indexPath -Value $content -Encoding UTF8
    Write-Host "Updated index.html WebSite Schema." -ForegroundColor Green
}

Write-Host "2. Applying AI Optimization (ai-optimization-guide.md.md)..."
# AI guide requires semantic lists for features rather than divs
$htmlFiles = Get-ChildItem -Path $basePath -Filter *.html -Recurse | Where-Object { $_.FullName -notmatch "\\\.git\\" -and $_.FullName -notmatch "\\scratch\\" }

$oldDivs = @"
<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 2rem;">
                        <div> 10 Custom Mock Tests</div>
                        <div> Multi-choice Simulator</div>
                        <div> Step-by-step Explanations</div>
                        <div> Built-in Exam Calculator</div>
                    </div>
"@

$newList = @"
<ul style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 2rem; padding-left: 20px; list-style-position: inside;">
                        <li>10 Custom Mock Tests</li>
                        <li>Multi-choice Simulator</li>
                        <li>Step-by-step Explanations</li>
                        <li>Built-in Exam Calculator</li>
                    </ul>
"@

$count = 0
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match '<div> 10 Custom Mock Tests</div>') {
        # Simple regex replace for the block
        $content = $content -replace '(?s)<div style="display: grid;[^>]*>.*?10 Custom Mock Tests.*?Multi-choice Simulator.*?Step-by-step Explanations.*?Built-in Exam Calculator.*?</div>\s*</div>', $newList
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8
        $count++
    }
}
Write-Host "Updated $count pages with semantic <ul> lists for AI Optimization." -ForegroundColor Green

Write-Host "3. Pushing changes to GitHub..."
& "d:\1 hour in clg\push_all_to_github.ps1"



