$token = (Get-Content .\.github_token).Trim()
$headers = @{
    Authorization = "Bearer $token"
    Accept        = "application/vnd.github.v3+json"
    "User-Agent"  = "Antigravity"
}
$user = Invoke-RestMethod -Uri "https://api.github.com/user" -Headers $headers
Write-Host "Authenticated as: $($user.login)"

$orgs = Invoke-RestMethod -Uri "https://api.github.com/user/orgs" -Headers $headers
Write-Host "Orgs: $(($orgs | Select-Object -ExpandProperty login) -join ', ')"

$repos = Invoke-RestMethod -Uri "https://api.github.com/user/repos?per_page=100" -Headers $headers
foreach ($r in $repos) {
    Write-Host "Repo: $($r.full_name) | Default branch: $($r.default_branch) | Pages: $($r.has_pages)"
}
