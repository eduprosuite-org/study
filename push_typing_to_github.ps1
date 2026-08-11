# PowerShell script to recursively upload the typing silo files to GitHub.
# Repository: eduprosuite-org/typing
# Branch: main

$tokenFile = Join-Path $PSScriptRoot ".github_token"
if (-not (Test-Path $tokenFile)) {
    Write-Error "Error: .github_token file not found in the root directory."
    exit 1
}

$token = (Get-Content $tokenFile).Trim()
$owner = "eduprosuite-org"
$repo = "typing"
$branch = "main"

$headers = @{
    "Authorization" = "Bearer $token"
    "Accept"        = "application/vnd.github.v3+json"
    "User-Agent"    = "Powershell-App"
}

# ----------------------------------------------------
# 1. CHECK OR CREATE REPOSITORY
# ----------------------------------------------------
try {
    Write-Host "Checking if repository $owner/$repo exists..." -ForegroundColor Cyan
    $repoUri = "https://api.github.com/repos/$owner/$repo"
    $repoInfo = Invoke-RestMethod -Uri $repoUri -Headers $headers -Method Get
    Write-Host "Repository $owner/$repo found." -ForegroundColor Green
}
catch {
    $err = $_.Exception.Response
    if ($null -ne $err -and $err.StatusCode -eq 'NotFound') {
        Write-Host "Repository $owner/$repo not found. Creating it..." -ForegroundColor Yellow
        $createUri = "https://api.github.com/orgs/$owner/repos"
        $body = @{
            name = $repo
            description = "Static client-side typing speed test utility and SEO content silo."
            private = $false
            has_issues = $true
            has_projects = $true
            has_wiki = $true
            has_downloads = $true
        } | ConvertTo-Json
        
        try {
            $response = Invoke-RestMethod -Uri $createUri -Headers $headers -Method Post -Body $body -ContentType "application/json"
            Write-Host "Created repository $owner/$repo under organization successfully!" -ForegroundColor Green
        }
        catch {
            Write-Host "Failed to create repository under organization. Trying user repository creation..." -ForegroundColor Yellow
            $userCreateUri = "https://api.github.com/user/repos"
            try {
                $response = Invoke-RestMethod -Uri $userCreateUri -Headers $headers -Method Post -Body $body -ContentType "application/json"
                Write-Host "Created repository $repo under user account successfully!" -ForegroundColor Green
            }
            catch {
                Write-Error "Failed to create repository: $_"
                exit 1
            }
        }
    } else {
        Write-Error "Failed to check repository status: $_"
        exit 1
    }
}

# ----------------------------------------------------
# 2. DEFINE FILE UPLOAD FUNCTION
# ----------------------------------------------------
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
    
    $bytes = [System.IO.File]::ReadAllBytes($fullLocalPath)
    $base64Content = [Convert]::ToBase64String($bytes)
    
    $sha = $null
    $gitPathNormalized = $gitPath.Replace('\', '/')
    
    try {
        $tick = [System.DateTime]::Now.Ticks
        $getUri = "https://api.github.com/repos/$owner/$repo/contents/$gitPathNormalized?ref=$branch&t=$tick"
        $fileInfo = Invoke-RestMethod -Uri $getUri -Headers $headers -Method Get
        $sha = $fileInfo.sha
    }
    catch {
        # 404 is expected for new files
    }
    
    $body = @{
        message = "Add/Update $gitPathNormalized (Auto-Deployment)"
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
        Write-Host " Successfully uploaded: $gitPathNormalized" -ForegroundColor Green
    }
    catch {
        $errResp = $_.Exception.Response
        if ($errResp -ne $null -and $errResp.StatusCode -eq 422) {
            Start-Sleep -Seconds 2
            try {
                $getUriRetry = "https://api.github.com/repos/$owner/$repo/contents/$gitPathNormalized?ref=$branch&nocache=$([guid]::NewGuid().ToString())"
                $retryHeaders = $headers.Clone()
                $retryHeaders["Cache-Control"] = "no-cache"
                $fileInfoRetry = Invoke-RestMethod -Uri $getUriRetry -Headers $retryHeaders -Method Get
                $body.sha = $fileInfoRetry.sha
                $bodyJsonRetry = $body | ConvertTo-Json
                $responseRetry = Invoke-RestMethod -Uri $putUri -Headers $headers -Method Put -Body $bodyJsonRetry -ContentType "application/json"
                Write-Host " Successfully uploaded after retry: $gitPathNormalized" -ForegroundColor Green
            } catch {
                Write-Error "Failed to upload $gitPathNormalized after retry. Error: $_"
            }
        } else {
            Write-Error "Failed to upload $gitPathNormalized. Error: $_"
        }
    }
    Start-Sleep -Milliseconds 250
}

# ----------------------------------------------------
# 3. RECURSIVELY FIND AND UPLOAD ALL SILO FILES
# ----------------------------------------------------
$typingPath = Join-Path $PSScriptRoot "typing"
$files = Get-ChildItem -Path $typingPath -Recurse -File

Write-Host "Found $($files.Count) files to upload to GitHub..." -ForegroundColor Cyan

foreach ($file in $files) {
    # Calculate the relative path from the typing folder to the file
    $relative = Resolve-Path $file.FullName -Relative
    
    # Resolve-Path -Relative returns paths like ".\typing\govt-exams\index.html"
    # We want to extract "govt-exams/index.html" or "index.html" relative to the repository root
    $gitPath = $relative.Substring(9) # Strip ".\typing\" or similar
    if ($gitPath.StartsWith("\") -or $gitPath.StartsWith("/")) {
        $gitPath = $gitPath.Substring(1)
    }
    
    $localPath = "typing\" + $gitPath
    Upload-FileToGitHub -localPath $localPath -gitPath $gitPath
}

Write-Host "Deployment to eduprosuite-org/typing complete!" -ForegroundColor Cyan

