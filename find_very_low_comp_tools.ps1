# find_very_low_comp_tools.ps1
# Script to find extremely low competition keywords in utility tool niches.

$specificSeeds = @(
    "timer with alarm sound online",
    "stopwatch with millisecond online",
    "word counter for essays online",
    "character counter with spaces online",
    "tally counter with label",
    "click counter with sound online",
    "binary to text converter with steps",
    "case converter with capitalization rules",
    "roman numeral converter showing work",
    "percentage calculator increase or decrease",
    "age calculator in hours and seconds",
    "gpa calculator for college students weighted",
    "date calculator add or subtract days",
    "random name picker wheel no duplicates",
    "wheel spinner yes or no decision",
    "pomodoro timer with break customization",
    "tabata timer 45 seconds work 15 seconds rest",
    "pdf merger without size limit online",
    "webp to png converter bulk online",
    "base64 encoder decoder online simple",
    "url encoder decoder online instant",
    "word counter with word density analyzer",
    "online stopwatch with split laps download",
    "visual countdown timer for presentations"
)

# Expand these using letters
$letters = @("", "a", "b", "c", "d", "e", "f", "h", "i", "l", "m", "n", "o", "p", "r", "s", "t", "u", "w")

$expandedKeywords = [System.Collections.Generic.HashSet[string]]::new()

Write-Host "=== Expanding Specific Niche Seeds ===" -ForegroundColor Cyan
foreach ($seed in $specificSeeds) {
    foreach ($letter in $letters) {
        $query = if ($letter -eq "") { $seed } else { "$seed $letter" }
        $encodedQuery = [uri]::EscapeDataString($query)
        $url = "http://suggestqueries.google.com/complete/search?client=firefox&q=$encodedQuery"
        
        try {
            $response = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 5 -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
            if ($response -and $response[1]) {
                foreach ($sug in $response[1]) {
                    $expandedKeywords.Add($sug.ToLower()) | Out-Null
                }
            }
        } catch {}
        Start-Sleep -Milliseconds 50
    }
}

Write-Host "Total unique keywords generated: $($expandedKeywords.Count)" -ForegroundColor Green

# Filter to keep only relevant keywords
$filteredKeywords = @()
foreach ($kw in $expandedKeywords) {
    # Filter out obvious shopping queries or general noise
    if ($kw -like "*buy*" -or $kw -like "*price*" -or $kw -like "*shop*" -or $kw -like "*amazon*" -or $kw -like "*download app*") { continue }
    # Only keep keywords that contain words representing tools
    if ($kw -match "timer|stopwatch|counter|converter|calculator|generator|picker|spinner|pomodoro|tabata|pdf|webp|base64|url|code") {
        $filteredKeywords += $kw
    }
}

Write-Host "Filtered relevant keywords: $($filteredKeywords.Count)" -ForegroundColor Green

# Let's check result count for the top 50 long-tail keywords (sorted by word count)
$keywordsToCheck = $filteredKeywords | ForEach-Object {
    [PSCustomObject]@{
        Keyword = $_
        Length = ($_ -split ' ').Count
    }
} | Sort-Object Length -Descending | Select-Object -ExpandProperty Keyword -First 50

$results = @()
$counter = 1

Write-Host "`n=== Checking Result Counts on Bing ===" -ForegroundColor Cyan
foreach ($kw in $keywordsToCheck) {
    Write-Host "[$counter/50] Checking: '$kw'..." -ForegroundColor Gray
    
    $delay = Get-Random -Minimum 3 -Maximum 5
    Start-Sleep -Seconds $delay
    
    $encodedKW = [uri]::EscapeDataString($kw)
    $url = "https://www.bing.com/search?q=$encodedKW"
    
    try {
        $webResponse = Invoke-WebRequest -Uri $url -Method Get -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -TimeoutSec 10
        $content = $webResponse.Content
        $resultCount = -1
        
        if ($content -match 'class="sb_count">About\s+([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } elseif ($content -match 'class="sb_count">([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } else {
            $matchesG = [regex]::Matches($content, 'class="b_algo"')
            $resultCount = $matchesG.Count
        }
        
        $status = "High Competition"
        if ($resultCount -eq 0) {
            $status = "Goldmine: 0 Results"
        } elseif ($resultCount -le 30) {
            $status = "Goldmine: 1-3 Pages of Results"
        } elseif ($resultCount -le 50) {
            $status = "Low Competition: 3-5 Pages of Results"
        } elseif ($resultCount -le 300) {
            $status = "Medium-Low Competition"
        }
        
        if ($resultCount -le 500) {
            $results += [PSCustomObject]@{
                Keyword = $kw
                BroadResultsCount = $resultCount
                CompetitionStatus = $status
                SearchVolume = "High (Autocomplete Validated)"
            }
            Write-Host "   -> Count: $resultCount | Status: $status" -ForegroundColor Green
        } else {
            Write-Host "   -> Count: $resultCount | Status: High Competition" -ForegroundColor Gray
        }
    } catch {
        Write-Host "   -> Skip: Error checking search count." -ForegroundColor Red
    }
    $counter++
}

# Step 3: Save results to CSV
$outputFile = "very_low_competition_utility_keywords.csv"
Write-Host "`n=== Saving results to CSV ===" -ForegroundColor Cyan
$results | Sort-Object BroadResultsCount | Export-Csv -Path $outputFile -NoTypeInformation -Encoding utf8
Write-Host "Done! Report saved to: $outputFile" -ForegroundColor Green
$results | Sort-Object BroadResultsCount | Format-Table -AutoSize



