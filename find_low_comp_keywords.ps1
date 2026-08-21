$niches = @(
    "wiskunde examen voorbereiding online",
    "matematica esame online preparazione",
    "matem online sinav hazirlik",
    "matematicas examen practico online gratis",
    "maths dsst practice test online free",
    "mathe fernstudium pruefung vorbereitung",
    "matematika ujian online latihan soal",
    "matematica prova online simulado gratis",
    "maths tet state board exam study material",
    "maths neco waec practice questions pdf"
)

$results = @()

Write-Host "=== Niche Exam Prep Keyword Low Competition Finder ===" -ForegroundColor Cyan
Write-Host "Checking niche keywords for broad result count..." -ForegroundColor Yellow

foreach ($niche in $niches) {
    $encodedQuery = [uri]::EscapeDataString($niche)
    $autocompleteUrl = "http://suggestqueries.google.com/complete/search?client=firefox&q=$encodedQuery"
    $suggestions = @($niche)
    
    try {
        $acResponse = Invoke-RestMethod -Uri $autocompleteUrl -TimeoutSec 8 -UserAgent "Mozilla/5.0"
        if ($acResponse -and $acResponse[1]) {
            foreach ($sug in $acResponse[1]) {
                $suggestions += $sug
            }
        }
    } catch {}

    foreach ($kw in $suggestions) {
        Start-Sleep -Seconds (Get-Random -Minimum 3 -Maximum 6)

        $encodedKW = [uri]::EscapeDataString($kw)
        $bingUrl = "https://www.bing.com/search?q=$encodedKW"
        
        try {
            $resp = Invoke-WebRequest -Uri $bingUrl -Method Get -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -TimeoutSec 15
            $content = $resp.Content
            $count = -1
            
            if ($content -match 'class="sb_count">About\s+([\d,]+)\s+results') {
                $count = [int]($Matches[1] -replace ',', '')
            } elseif ($content -match 'class="sb_count">([\d,]+)\s+results') {
                $count = [int]($Matches[1] -replace ',', '')
            } else {
                $algos = [regex]::Matches($content, 'class="b_algo"')
                $count = $algos.Count
            }
            
            if ($count -ge 0 -and $count -lt 300000) {
                if ($count -lt 50) {
                    $status = "Ultra Low GOLDMINE Under 5 pages"
                } elseif ($count -lt 50000) {
                    $status = "Very Low 5-10 pages estimated"
                } else {
                    $status = "Low Under 30000 pages"
                }
                
                $results += [PSCustomObject]@{
                    Keyword = $kw
                    BroadResultCount = $count
                    Status = $status
                    SearchVolumeNote = "Verify in Google Keyword Planner"
                }
                Write-Host "FOUND: $kw -> $count results [$status]" -ForegroundColor Green
            } else {
                Write-Host "  Skip: $kw -> $count results (too many)" -ForegroundColor Gray
            }
        } catch {
            Write-Host "  Error for: $kw" -ForegroundColor Red
        }
    }
}

$sortedResults = $results | Sort-Object BroadResultCount
$sortedResults | Export-Csv -Path "low_competition_exam_keywords.csv" -NoTypeInformation -Encoding utf8

$cnt = $results.Count
Write-Host "DONE! Saved $cnt low-competition keywords to low_competition_exam_keywords.csv" -ForegroundColor Cyan
$sortedResults | Format-Table -AutoSize








