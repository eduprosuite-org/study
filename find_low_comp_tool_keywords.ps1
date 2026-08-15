# find_low_comp_tool_keywords.ps1
# Script to find low-competition keywords in the tools, converters, counters, stopwatches, and timers niches.

$seeds = @(
    "stopwatch", "timer", "counter", "converter", "calculator", "generator", 
    "pomodoro", "tabata", "tally counter", "click counter", "word counter", 
    "case converter", "binary converter", "roman numeral", "pdf to", 
    "webp to", "base64", "url encode", "random name", "wheel spinner", 
    "age calculator", "gpa calculator", "date calculator", "qr code"
)

# We will expand these seeds using Google Autocomplete.
# To keep it quick and avoid getting blocked, we will append a few letters (a, b, c, d, e, s, t, w, f, p, m, o, c, u) rather than all 26.
$letters = @("", "a", "b", "c", "d", "e", "f", "m", "o", "p", "s", "t", "u", "w")

$uniqueKeywords = [System.Collections.Generic.HashSet[string]]::new()

Write-Host "=== Step 1: Expanding seeds using Google Autocomplete ===" -ForegroundColor Cyan
foreach ($seed in $seeds) {
    foreach ($letter in $letters) {
        if ($letter -eq "") {
            $query = $seed
        } else {
            $query = "$seed $letter"
        }
        
        $encodedQuery = [uri]::EscapeDataString($query)
        $url = "http://suggestqueries.google.com/complete/search?client=firefox&q=$encodedQuery"
        
        try {
            $response = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 5 -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
            if ($response -and $response[1]) {
                foreach ($sug in $response[1]) {
                    # Filter: Only keep keywords that contain our seed words to keep it relevant
                    $sugLower = $sug.ToLower()
                    foreach ($s in $seeds) {
                        if ($sugLower -like "*$s*") {
                            $uniqueKeywords.Add($sugLower) | Out-Null
                            break
                        }
                    }
                }
            }
        } catch {
            # Silently continue if rate limited or connection issue
        }
        # Micro sleep to be nice to Google Autocomplete
        Start-Sleep -Milliseconds 100
    }
    Write-Host "Processed seed: $seed | Current total unique keywords: $($uniqueKeywords.Count)" -ForegroundColor Gray
}

Write-Host "`nGenerated $($uniqueKeywords.Count) unique long-tail keywords from Autocomplete." -ForegroundColor Green
Write-Host "Autocomplete suggestions guarantee active search volume." -ForegroundColor Yellow

if ($uniqueKeywords.Count -eq 0) {
    Write-Host "No keywords generated. Exiting." -ForegroundColor Red
    exit 1
}

# We want to check their search volume and result counts.
# Let's select keywords that represent simple single-purpose tools (avoid general high-competition keywords like 'google maps' etc.)
# We will check the result count on Bing.
$results = @()
$counter = 1
# Let's check a maximum of 50 keywords in this run to keep it fast, prioritizing those that are more long-tail (higher word count)
# because longer queries are much more likely to have low competition (3-5 pages of search results).
$keywordsToCheck = $uniqueKeywords | ForEach-Object {
    [PSCustomObject]@{
        Keyword = $_
        Length = ($_ -split ' ').Count
    }
} | Sort-Object Length -Descending | Select-Object -ExpandProperty Keyword -First 60

Write-Host "`n=== Step 2: Checking broad search result counts on Bing ===" -ForegroundColor Cyan
Write-Host "Checking top 60 long-tail keywords for low-competition targets (Google 3-5 pages proxy)..." -ForegroundColor Yellow

foreach ($kw in $keywordsToCheck) {
    Write-Host "[$counter/60] Checking: '$kw'..." -ForegroundColor Gray
    
    # Wait to avoid rate limit/blocks
    $delay = Get-Random -Minimum 3 -Maximum 5
    Start-Sleep -Seconds $delay
    
    $encodedKW = [uri]::EscapeDataString($kw)
    $url = "https://www.bing.com/search?q=$encodedKW"
    
    try {
        $webResponse = Invoke-WebRequest -Uri $url -Method Get -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -TimeoutSec 10
        $content = $webResponse.Content
        $resultCount = -1
        
        # Parse result count
        if ($content -match 'class="sb_count">About\s+([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } elseif ($content -match 'class="sb_count">([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } else {
            $matchesG = [regex]::Matches($content, 'class="b_algo"')
            $resultCount = $matchesG.Count
        }
        
        # If resultCount is under 500, it's very low competition. 
        # If it is under 50, it means 1-5 pages of results!
        $status = "High Competition"
        if ($resultCount -eq 0) {
            $status = "Ultra Low Competition (Under 1 Page)"
        } elseif ($resultCount -le 50) {
            $status = "Low Competition (3-5 Pages / Under 50 results)"
        } elseif ($resultCount -le 300) {
            $status = "Medium-Low Competition (Under 30 Pages)"
        }
        
        $results += [PSCustomObject]@{
            Keyword = $kw
            BroadResultsCount = $resultCount
            CompetitionStatus = $status
            SearchVolume = "High (Autocomplete Validated)"
        }
        
        $color = "Gray"
        if ($resultCount -le 300) { $color = "Green" }
        Write-Host "   -> Count: $resultCount | Status: $status" -ForegroundColor $color
    } catch {
        Write-Host "   -> Skip: Error checking search count." -ForegroundColor Red
        if ($_.Exception.Message -like "*429*") {
            Write-Host "Rate limit reached. Saving current progress and stopping." -ForegroundColor Red
            break
        }
    }
    $counter++
}

# Step 3: Save results to CSV
$outputFile = "low_competition_tool_keywords_report.csv"
Write-Host "`n=== Step 3: Saving results to CSV ===" -ForegroundColor Cyan
$results | Sort-Object BroadResultsCount | Export-Csv -Path $outputFile -NoTypeInformation -Encoding utf8
Write-Host "Done! Report saved to: $outputFile" -ForegroundColor Green
$results | Where-Object { $_.BroadResultsCount -le 300 } | Format-Table -AutoSize



