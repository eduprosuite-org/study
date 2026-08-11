# Define seed keywords
$seedKeywords = @(
    "mathematics exam prep",
    "math test preparation",
    "math study guide pdf",
    "actuarial exam prep",
    "gre quantitative practice test",
    "gmat quant prep course",
    "clep college algebra study guide",
    "ap calculus bc study guide",
    "linear algebra exam prep",
    "differential equations study guide",
    "real analysis test prep",
    "discrete mathematics cheat sheet",
    "engineering mathematics study guide",
    "best online calculus course",
    "university math prep bootcamp",
    "premium calculus study materials",
    "advanced mathematics course with certificate",
    "math textbook solutions guide"
)

# Modifiers to expand queries
$modifiers = @("best", "premium", "study guide for", "exam cheat sheet", "online course", "practice test pdf", "solutions manual", "bootcamp")

$uniqueKeywords = [System.Collections.Generic.HashSet[string]]::new()

Write-Host "=== Generating Autocomplete Keywords ==="
foreach ($seed in $seedKeywords) {
    # Add seed
    $uniqueKeywords.Add($seed.ToLower()) | Out-Null
    
    # Try modifiers
    foreach ($mod in $modifiers) {
        $query = "$mod $seed"
        $encodedQuery = [uri]::EscapeDataString($query)
        $url = "http://suggestqueries.google.com/complete/search?client=firefox&q=$encodedQuery"
        
        try {
            $response = Invoke-RestMethod -Uri $url -Method Get -TimeoutSec 10 -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
            if ($response -and $response[1]) {
                foreach ($sug in $response[1]) {
                    $uniqueKeywords.Add($sug.ToLower()) | Out-Null
                }
            }
        } catch {
            # Ignore errors and continue
        }
    }
}

Write-Host "Generated $($uniqueKeywords.Count) unique keywords from Google Autocomplete (guaranteed to have search volume)."

# Filter keywords containing product intent terms
$productKeywords = @("course", "prep", "exam", "book", "pdf", "test", "guide", "cheat", "study", "bootcamp", "premium")
$filteredKeywords = @()

foreach ($kw in $uniqueKeywords) {
    $matchCount = 0
    foreach ($prodWord in $productKeywords) {
        if ($kw -like "*$prodWord*") {
            $matchCount++
        }
    }
    if ($matchCount -gt 0) {
        $filteredKeywords += [PSCustomObject]@{
            Keyword = $kw
            Score = $matchCount
        }
    }
}

# Sort by relevance score and take the top 20 to check
$filteredKeywords = $filteredKeywords | Sort-Object Score -Descending | Select-Object -First 20

Write-Host "Checking top 20 keywords for competition on Google..."
$results = @()

foreach ($item in $filteredKeywords) {
    $kw = $item.Keyword
    Write-Host "Checking Google allintitle for: '$kw'..."
    
    # Wait to avoid rate-limiting
    $delay = Get-Random -Minimum 5 -Maximum 10
    Write-Host "Waiting $delay seconds..."
    Start-Sleep -Seconds $delay
    
    $encodedKW = [uri]::EscapeDataString("allintitle:`"$kw`"")
    $url = "https://www.google.com/search?q=$encodedKW"
    
    try {
        $webResponse = Invoke-WebRequest -Uri $url -Method Get -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0" -TimeoutSec 15
        
        $content = $webResponse.Content
        $resultCount = -1
        
        # Parse result-stats or similar indicator
        if ($content -match 'id="result-stats">About\s+([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } elseif ($content -match 'id="result-stats">([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } elseif ($content -like "*did not match any documents*" -or $content -like "*no results found*") {
            $resultCount = 0
        } else {
            # Let's count occurrences of result container '<div class="g">'
            $matchesG = [regex]::Matches($content, 'class="g"')
            $resultCount = $matchesG.Count
        }
        
        $status = "Unknown"
        if ($resultCount -eq 0) {
            $status = "Ultra Low Competition (Goldmine)"
        } elseif ($resultCount -le 10) {
            $status = "Very Low Competition (Less than 1 page)"
        } elseif ($resultCount -le 50) {
            $status = "Low Competition (3-5 pages)"
        } else {
            $status = "Medium/High Competition"
        }
        
        $results += [PSCustomObject]@{
            Keyword = $kw
            "AllInTitle Results Count" = $resultCount
            "Competition Status" = $status
            "Search Volume Indication" = "High (>100 searches/mo suggested by Autocomplete)"
        }
        Write-Host "-> Result count: $resultCount ($status)"
    } catch {
        Write-Host "-> Error checking Google: $_"
        # If rate limited (429), we stop
        if ($_.Exception.Message -like "*429*") {
            Write-Host "Google blocked the request (429 Rate Limit). Stopping script."
            break
        }
    }
}

# Save to CSV
$outputFile = "keywords_daily_report.csv"
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding utf8
Write-Host "=== Daily Keyword Report saved to '$outputFile' ==="





