$tokenFile = Join-Path $PSScriptRoot ".github_token"
$token = (Get-Content $tokenFile).Trim()
$owner = "onlinemathstutor4u-glitch"
$repo = "real-estate-math-practice-tool"
$branch = "main"
$localPath = "low_competition_exam_keywords.csv"
$gitPath = "low_competition_exam_keywords.csv"

$bytes = [System.IO.File]::ReadAllBytes((Join-Path $PSScriptRoot $localPath))
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
} catch {}

$body = @{ message = "Add low competition exam keywords CSV"; content = $base64Content; branch = $branch }
if ($sha -ne $null) { $body.sha = $sha }
$bodyJson = $body | ConvertTo-Json
$putUri = "https://api.github.com/repos/$owner/$repo/contents/$gitPath"
$response = Invoke-RestMethod -Uri $putUri -Headers $headers -Method Put -Body $bodyJson -ContentType "application/json"
Write-Host "Upload successful!"








