# Victoria LEA Exam Prep & Walkthrough Pack - GitHub Upload Script
# This script uploads index.html, sitemap.xml, and the new exams/vic-lea-electrician-prep/index.html to GitHub.

$tokenFile = Join-Path $PSScriptRoot ".github_token"
if (-not (Test-Path $tokenFile)) {
    Write-Error "Error: .github_token file not found in the root directory."
    exit 1
}

$token = (Get-Content $tokenFile).Trim()
$owner = "onlinemathstutor4u-glitch"
$repo = "real-estate-math-practice-tool"
$branch = "main"

function Upload-FileToGitHub {
    param(
        [string]$localPath,
        [string]$gitPath
    )
    
    $fullLocalPath = Join-Path $PSScriptRoot $localPath
    if (-not (Test-Path $fullLocalPath)) {
        Write-Warning "Warning: Local file $localPath not found. Skipping."
        return
    }
    
    Write-Host "Uploading $localPath to repository path $gitPath..."
    
    $bytes = [System.IO.File]::ReadAllBytes($fullLocalPath)
    $base64Content = [Convert]::ToBase64String($bytes)
    
    $sha = $null
    $headers = @{
        "Authorization" = "Bearer $token"
        "Accept"        = "application/vnd.github.v3+json"
        "User-Agent"    = "Powershell-App"
    }
    
    try {
        $getUri = "https://api.github.com/repos/$owner/$repo/contents/$gitPath?ref=$branch"
        $fileInfo = Invoke-RestMethod -Uri $getUri -Headers $headers -Method Get
        $sha = $fileInfo.sha
    }
    catch {
        # 404 is expected for new files
    }
    
    $body = @{
        message = "Update $gitPath for Victoria LEA Exam Prep"
        content = $base64Content
        branch  = $branch
    }
    if ($sha -ne $null) {
        $body.sha = $sha
    }
    
    $bodyJson = $body | ConvertTo-Json
    
    try {
        $putUri = "https://api.github.com/repos/$owner/$repo/contents/$gitPath"
        $response = Invoke-RestMethod -Uri $putUri -Headers $headers -Method Put -Body $bodyJson -ContentType "application/json"
        Write-Host " Successfully uploaded $gitPath!" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to upload $gitPath. Error: $_"
        if ($_.Exception -and $_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $responseBody = $reader.ReadToEnd()
            Write-Host "Response details: $responseBo-ForegroundColor Red
        }
    }
}

# Run upload for the 3 files
Upload-FileToGitHub -localPath "index.html" -gitPath "index.html"
Upload-FileToGitHub -localPath "sitemap.xml" -gitPath "sitemap.xml"
Upload-FileToGitHub -localPath "exams/vic-lea-electrician-prep/index.html" -gitPath "exams/vic-lea-electrician-prep/index.html"

Write-Host "All uploads processed. Check your GitHub repository!" -ForegroundColor Cyan






