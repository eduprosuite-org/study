# PowerShell script to recursively upload ALL files to GitHub.
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

    
    $bytes = [System.IO.File]::ReadAllBytes($fullLocalPath)
    $base64Content = [Convert]::ToBase64String($bytes)
    
    $sha = $null
    $headers = @{
        "Authorization" = "Bearer $token"
        "Accept"        = "application/vnd.github.v3+json"
        "User-Agent"    = "Powershell-App"
    }
    
    $gitPathNormalized = $gitPath.Replace('\', '/')
    
    try {
        # Cache buster to prevent stale API responses
        $tick = [System.DateTime]::Now.Ticks
        $getUri = "https://api.github.com/repos/$owner/$repo/contents/$gitPathNormalized?ref=$branch&t=$tick"
        $fileInfo = Invoke-RestMethod -Uri $getUri -Headers $headers -Method Get
        $sha = $fileInfo.sha
    }
    catch {
        $errResp = $_.Exception.Response
        if ($null -ne $errResp -and $errResp.StatusCode -eq 'NotFound') {
            # 404 is expected for new files
        } else {
            Write-Warning "Failed to fetch SHA for ${gitPathNormalized}: $_"
        }
    }
    
    $body = @{
        message = "Add/Update $gitPathNormalized (Full Deployment)"
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

            } catch {
                Write-Error "Failed to upload $gitPathNormalized even after retry. Error: $_"
            }
        } else {
            Write-Error "Failed to upload $gitPathNormalized. Error: $_"
            if ($errResp) {
                $reader = New-Object System.IO.StreamReader($errResp.GetResponseStream())
                Write-Host "Response details: $($reader.ReadToEnd())" -ForegroundColor Red
            }
        }
    }
    Start-Sleep -Milliseconds 300
}

$workspaceDir = $PSScriptRoot
$files = Get-ChildItem -Path $workspaceDir -File -Recurse | Where-Object { 
    $_.FullName -notmatch "\\\.git\\" -and 
    $_.FullName -notmatch "\\\.github_token$" -and 
    $_.FullName -notmatch "\\\.agents\\" -and
    $_.FullName -notmatch "\\push_" -and
    $_.FullName -notmatch "\\generate_" -and
    $_.FullName -notmatch "\\update_sitemap.ps1" -and
    $_.FullName -notmatch "\\enable_pages.ps1" -and
    $_.FullName -notmatch "\\\.gitattributes"
}

foreach ($file in $files) {
    $relativePath = Resolve-Path $file.FullName -Relative
    $cleanPath = $relativePath -replace '^\.\\', '' -replace '^\./', ''
    Upload-FileToGitHub -localPath $cleanPath -gitPath $cleanPath
}

Write-Host "Complete Workspace Deployment Finished!" -ForegroundColor Cyan








