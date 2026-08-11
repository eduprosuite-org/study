# PowerShell script to enable GitHub Pages for eduprosuite-org/study via GitHub API
$tokenFile = Join-Path $PSScriptRoot ".github_token"
if (-not (Test-Path $tokenFile)) {
    Write-Error "Error: .github_token file not found."
    exit 1
}

$token = (Get-Content $tokenFile).Trim()
$owner = "eduprosuite-org"
$repo = "study"
$branch = "main"

$headers = @{
    "Authorization" = "Bearer $token"
    "Accept"        = "application/vnd.github.v3+json"
    "User-Agent"    = "Powershell-App"
}

$body = @{
    source = @{
        branch = $branch
        path = "/"
    }
} | ConvertTo-Json

Write-Host "Enabling GitHub Pages for $owner/$repo..."

try {
    $uri = "https://api.github.com/repos/$owner/$repo/pages"
    $response = Invoke-RestMethod -Uri $uri -Headers $headers -Method Post -Body $body -ContentType "application/json"
    Write-Host "[OK] GitHub Pages enabled successfully!" -ForegroundColor Green
    Write-Host "Site URL: $($response.html_url)" -ForegroundColor Green
}
catch {
    Write-Error "Failed to enable GitHub Pages. Error: $_"
    if ($_.Exception -and $_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response details: $responseBo-ForegroundColor Red
    }
}






