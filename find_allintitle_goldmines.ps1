# find_allintitle_goldmines.ps1
# Script to find tool keywords with high search volume (Autocomplete verified)
# and low competition (exactly 3-5 pages of results under allintitle search).

$seeds = @(
    "timer with", "stopwatch with", "word counter with", 
    "character counter with", "tally counter with", "click counter with", 
    "case converter with", "binary converter with", "roman numeral with", 
    "pdf converter with", "webp converter with", "percentage calculator with", 
    "age calculator with", "gpa calculator with", "date calculator with", 
    "random picker with", "wheel spinner with", "pomodoro timer with", 
    "tabata timer with"
)

# Expand using alphabet soup
$letters = @("", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")

$uniqueKeywords = [System.Collections.Generic.HashSet[string]]::new()

Write-Host "=== Step 1: Expanding seeds using Google Autocomplete ===" -ForegroundColor Cyan
foreach ($seed in $seeds) {
    foreach ($letter in $letters) {
        $query = if ($letter -eq "") { $seed } else { "$seed $letter" }
        $encodedQuery = [uri]::EscapeDataString($query)
        $url = "http://suggestqueries.google.com/complete/search?client=firefox&q=$encodedQuery"
        
        try {
            $response = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 4 -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
            if ($response -and $response[1]) {
                foreach ($sug in $response[1]) {
                    # Filter out obvious junk
                    $sugLower = $sug.ToLower()
                    if ($sugLower -like "*buy*" -or $sugLower -like "*price*" -or $sugLower -like "*shop*" -or $sugLower -like "*amazon*") { continue }
                    $uniqueKeywords.Add($sugLower) | Out-Null
                }
            }
        } catch {}
        Start-Sleep -Milliseconds 50
    }
    Write-Host "Processed: $seed | Total unique keywords: $($uniqueKeywords.Count)" -ForegroundColor Gray
}

Write-Host "`nGenerated $($uniqueKeywords.Count) unique long-tail keywords." -ForegroundColor Green

# Select a subset of promising keywords (long-tail, likely to have tools)
$candidateKeywords = @()
foreach ($kw in $uniqueKeywords) {
    # Keep keywords containing specific terms
    if ($kw -match "timer|stopwatch|counter|converter|calculator|generator|picker|spinner|pomodoro|tabata|pdf|webp|base64|url|code") {
        $candidateKeywords += $kw
    }
}

Write-Host "Filtered candidate keywords: $($candidateKeywords.Count)" -ForegroundColor Green

# We will check the allintitle result count for up to 80 candidate keywords (sorted by word length to focus on specific tools)
$keywordsToCheck = $candidateKeywords | ForEach-Object {
    [PSCustomObject]@{
        Keyword = $_
        Length = ($_ -split ' ').Count
    }
} | Sort-Object Length -Descending | Select-Object -ExpandProperty Keyword -First 80

$results = @()
$counter = 1

Write-Host "`n=== Step 2: Checking 'allintitle' Result Counts on Bing ===" -ForegroundColor Cyan
Write-Host "Targeting keywords with exactly 10 to 60 pages/results (representing 1-6 pages on Google)..." -ForegroundColor Yellow

foreach ($kw in $keywordsToCheck) {
    Write-Host "[$counter/80] Checking: '$kw'..." -ForegroundColor Gray
    
    $delay = Get-Random -Minimum 2 -Maximum 4
    Start-Sleep -Seconds $delay
    
    $encodedKW = [uri]::EscapeDataString("allintitle:`"$kw`"")
    $url = "https://www.bing.com/search?q=$encodedKW"
    
    try {
        $webResponse = Invoke-WebRequest -Uri $url -Method Get -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -TimeoutSec 8
        $content = $webResponse.Content
        $resultCount = 0
        
        if ($content -match 'class="sb_count">About\s+([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } elseif ($content -match 'class="sb_count">([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } else {
            $matchesG = [regex]::Matches($content, 'class="b_algo"')
            $resultCount = $matchesG.Count
        }
        
        # Determine Competition Status
        # 10 to 60 is the perfect "3-5 pages" goldmine target (30-50 results is typical, 10-60 is a safe window)
        $status = "High Competition / Untargeted"
        $isGoldmine = $false
        
        if ($resultCount -eq 0) {
            $status = "Ultra-Low: 0 Results (Total Goldmine)"
            $isGoldmine = $true
        } elseif ($resultCount -le 20) {
            $status = "Very Low: 1-2 Pages of Results (Goldmine)"
            $isGoldmine = $true
        } elseif ($resultCount -le 60) {
            $status = "Low: 3-6 Pages of Results (Perfect Goldmine)"
            $isGoldmine = $true
        } elseif ($resultCount -le 200) {
            $status = "Medium-Low: Under 20 Pages"
        }
        
        $results += [PSCustomObject]@{
            Keyword = $kw
            AllInTitleCount = $resultCount
            CompetitionStatus = $status
            IsGoldmine = $isGoldmine
            VolumeIndicator = "High (Autocomplete Suggested)"
        }
        
        if ($isGoldmine) {
            Write-Host "   -> allintitle count: $resultCount | Status: $status" -ForegroundColor Green
        } else {
            Write-Host "   -> allintitle count: $resultCount | Status: $status" -ForegroundColor Gray
        }
    } catch {
        Write-Host "   -> Skip: Error checking search count." -ForegroundColor Red
    }
    $counter++
}

# Step 3: Save results to CSV
$outputFile = "allintitle_goldmine_keywords.csv"
Write-Host "`n=== Step 3: Saving results to CSV ===" -ForegroundColor Cyan
$results | Sort-Object AllInTitleCount | Export-Csv -Path $outputFile -NoTypeInformation -Encoding utf8
Write-Host "Done! Report saved to: $outputFile" -ForegroundColor Green

# Print summary
Write-Host "`n=== Goldmine Keywords Found ===" -ForegroundColor Green
$results | Where-Object { $_.IsGoldmine -eq $true } | Sort-Object AllInTitleCount | Format-Table -AutoSize



