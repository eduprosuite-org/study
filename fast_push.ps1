# Fast Git Push Script
# Ensure Git cmd is in the PATH
$env:PATH += ";C:\Program Files\Git\cmd"
$repoUrl = "https://github.com/eduprosuite-org/study.git"
$token = Get-Content ".github_token" -Raw | ForEach-Object { $_.Trim() }

# Check if Git is initialized
if (!(Test-Path ".git")) {
    Write-Host "Initializing Git for the first time..." -ForegroundColor Yellow
    git init
    git branch -M main
    
    # Configure dummy local identity so commits succeed
    git config user.name "EduProSuite Deployer"
    git config user.email "deploy@eduprosuite.org"
    
    # Add remote with token for authentication
    $authUrl = "https://x-access-token:$token@github.com/eduprosuite-org/study.git"
    git remote add origin $authUrl
}

Write-Host "Adding files to Git..." -ForegroundColor Cyan
git add .

Write-Host "Committing changes..." -ForegroundColor Cyan
# Ensure config exists even if git was already initialized without config
git config user.name "EduProSuite Deployer"
git config user.email "deploy@eduprosuite.org"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
git commit -m "Auto-update: $date"

Write-Host "Pushing to GitHub..." -ForegroundColor Green
git push origin main --force

Write-Host "Done! Deployment finished in seconds." -ForegroundColor Green




