# Interactive Niche Keyword Opportunity Finder (PowerShell Version)
# Run this script to find low-competition keywords (<5 pages of results) for any niche.

$niche = Read-Host "Enter your niche or seed topic (e.g., 'electrician let prep', 'ca real estate math')"
if ([string]::IsNullOrWhiteSpace($niche)) {
    Write-Host "Niche cannot be empty. Exiting." -ForegroundColor Red
    exit 1
}

# Clean niche name for filename
$safeNicheName = $niche -replace '[^a-zA-Z0-9]', '_'
$outputFile = "keywords_$safeNicheName.csv"

# Modifiers to expand the niche query
$modifiers = @(
    "", "best", "premium", "practice test", "exam cheat sheet", 
    "study guide pdf", "course", "bootcamp", "solutions manual", 
    "prep book", "exam questions", "formula sheet"
)

$uniqueKeywords = [System.Collections.Generic.HashSet[string]]::new()

Write-Host "`n[1/3] Generating Google Autocomplete suggestions for: '$niche'..." -ForegroundColor Cyan

foreach ($mod in $modifiers) {
    if ($mod -eq "") {
        $query = $niche
    } else {
        $query = "$mod $niche"
    }
    
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
        # Autocomplete fails occasionally, ignore and proceed
    }
}

Write-Host " Generated $($uniqueKeywords.Count) unique long-tail keywords from Autocomplete." -ForegroundColor Green
Write-Host "Note: Autocomplete suggestions indicate that real search volume exists." -ForegroundColor Yellow

if ($uniqueKeywords.Count -eq 0) {
    Write-Host "No keywords generated. Try a broader seed niche." -ForegroundColor Red
    exit 1
}

# Prioritize/filter keywords that contain educational/digital product terms
$productKeywords = @("course", "prep", "exam", "book", "pdf", "test", "guide", "cheat", "study", "bootcamp", "premium", "sheet")
$prioritizedList = @()

foreach ($kw in $uniqueKeywords) {
    $score = 0
    foreach ($prodWord in $productKeywords) {
        if ($kw -like "*$prodWord*") { $score++ }
    }
    $prioritizedList += [PSCustomObject]@{
        Keyword = $kw
        Score = $score
    }
}

# Sort by score and take the top 15 to check broad SERP count
$keywordsToCheck = $prioritizedList | Sort-Object Score -Descending | Select-Object -First 15

Write-Host "`n[2/3] Checking broad search results count (no quotes, no allintitle) on Bing..." -ForegroundColor Cyan
Write-Host "This finds queries where the entire web has very few pages of matching content." -ForegroundColor Yellow

$results = @()
$counter = 1

foreach ($item in $keywordsToCheck) {
    $kw = $item.Keyword
    Write-Host "[$counter/15] Checking: '$kw'..." -ForegroundColor Gray
    
    # Wait to avoid rate limit/blocks
    $delay = Get-Random -Minimum 4 -Maximum 7
    Start-Sleep -Seconds $delay
    
    $encodedKW = [uri]::EscapeDataString($kw)
    $url = "https://www.bing.com/search?q=$encodedKW"
    
    try {
        $webResponse = Invoke-WebRequest -Uri $url -Method Get -UserAgent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" -TimeoutSec 15
        $content = $webResponse.Content
        $resultCount = -1
        
        # Parse result count from sb_count
        if ($content -match 'class="sb_count">About\s+([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } elseif ($content -match 'class="sb_count">([\d,]+)\s+results') {
            $resultCount = [int]($Matches[1] -replace ',', '')
        } else {
            # Count elements containing class="b_algo" (individual search results)
            $matchesG = [regex]::Matches($content, 'class="b_algo"')
            $resultCount = $matchesG.Count
        }
        
        $status = "High Competition"
        if ($resultCount -eq 0) {
            $status = "Ultra Low Competition (Goldmine - Under 1 Page)"
        } elseif ($resultCount -le 50) {
            $status = "Low Competition (Only 1-5 Pages)"
        } elseif ($resultCount -le 500) {
            $status = "Medium-Low Competition (Under 50 Pages)"
        }
        
        $results += [PSCustomObject]@{
            Keyword = $kw
            BroadResultsCount = $resultCount
            CompetitionStatus = $status
            SearchVolumeSource = "Google Autocomplete (Verify in Planner)"
        }
        
        Write-Host "   -> Count: $resultCount | Status: $status" -ForegroundColor Gray
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
Write-Host "`n[3/3] Saving results to CSV..." -ForegroundColor Cyan
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding utf8
Write-Host " Done! Report saved to: $outputFile" -ForegroundColor Green
Write-Host "You can open this file in Excel or upload it to Google Sheets." -ForegroundColor Green







