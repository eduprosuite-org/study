# PowerShell script to recursively upload all generated plumbing license pages to GitHub.
# Repository: eduprosuite-org/study
# Branch: main

$tokenFile = Join-Path $PSScriptRoot ".github_token"
if (-not (Test-Path $tokenFile)) {
    Write-Error "Error: .github_token file not found in the root directory."
    exit 1
}

$token = (Get-Content $tokenFile).Trim()
$owner = "eduprosuite-org"
$repo = "study"
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
    
    # Normalize path separators for Git API (always use forward slashes)
    $gitPathNormalized = $gitPath.Replace('\', '/')
    
    try {
        $getUri = "https://api.github.com/repos/$owner/$repo/contents/$gitPathNormalized?ref=$branch"
        $fileInfo = Invoke-RestMethod -Uri $getUri -Headers $headers -Method Get
        $sha = $fileInfo.sha
    }
    catch {
        # 404 is expected for new files, do nothing
    }
    
    $body = @{
        message = "Add/Update $gitPathNormalized for Plumbing license exam silo"
        content = $base64Content
        branch  = $branch
    }
    if ($sha -ne $null) {
        $body.sha = $sha
    }
    
    $bodyJson = $body | ConvertTo-Json
    
    try {
        $putUri = "https://api.github.com/repos/$owner/$repo/contents/$gitPathNormalized"
        $response = Invoke-RestMethod -Uri $putUri -Headers $headers -Method Put -Body $bodyJson -ContentType "application/json"
        Write-Host "[OK] Successfully uploaded $gitPathNormalized!" -ForegroundColor Green
    }
    catch {
        Write-Error "Failed to upload $gitPathNormalized. Error: $_"
        if ($_.Exception -and $_.Exception.Response) {
            $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
            $responseBody = $reader.ReadToEnd()
            Write-Host "Response details: $responseBo-ForegroundColor Red
        }
    }
}

# 1. Upload root index.html and sitemap.xml
Upload-FileToGitHub -localPath "index.html" -gitPath "index.html"
Upload-FileToGitHub -localPath "sitemap.xml" -gitPath "sitemap.xml"

# 2. Find all files in exams/plumbing-license-prep recursively and upload them
$plumbingDir = Join-Path $PSScriptRoot "exams/plumbing-license-prep"
if (Test-Path $plumbingDir) {
    # Get all files recursively
    $files = Get-ChildItem -Path $plumbingDir -File -Recurse
    
    foreach ($file in $files) {
        # Calculate relative path from workspace root
        $relativePath = Resolve-Path $file.FullName -Relative
        # Remove the leading .\ or ./ if present
        $cleanPath = $relativePath -replace '^\.\\', '' -replace '^\./', ''
        
        # Upload
        Upload-FileToGitHub -localPath $cleanPath -gitPath $cleanPath
    }
}

Write-Host "All plumbing silo uploads completed. Go to https://github.com/$owner/$repo to check your files!" -ForegroundColor Cyan






