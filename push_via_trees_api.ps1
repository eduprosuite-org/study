# PowerShell script to upload files using GitHub Git Database API
$tokenFile = Join-Path $PSScriptRoot ".github_token"
$token = (Get-Content $tokenFile).Trim()
$owner = "eduprosuite-org"
$repo = "study"
$branch = "main"

$headers = @{
    "Authorization" = "Bearer $token"
    "Accept"        = "application/vnd.github.v3+json"
    "User-Agent"    = "Powershell-App"
}

# 1. Get current commit SHA
Write-Host "Getting current commit for branch $branch..."
$refUri = "https://api.github.com/repos/$owner/$repo/git/refs/heads/$branch"
$ref = Invoke-RestMethod -Uri $refUri -Headers $headers
$commitSha = $ref.object.sha

# 2. Get the commit tree SHA
$commitUri = "https://api.github.com/repos/$owner/$repo/git/commits/$commitSha"
$commit = Invoke-RestMethod -Uri $commitUri -Headers $headers
$baseTreeSha = $commit.tree.sha
Write-Host "Base Tree SHA: $baseTreeSha"

# 3. Create blobs for all files
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

$treeNodes = @()

foreach ($file in $files) {
    $relativePath = Resolve-Path $file.FullName -Relative
    $cleanPath = ($relativePath -replace '^\.\\', '' -replace '^\./', '').Replace('\', '/')
    
    Write-Host "Creating blob for $cleanPath..."
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $base64Content = [Convert]::ToBase64String($bytes)
    
    $blobBody = @{
        content = $base64Content
        encoding = "base64"
    } | ConvertTo-Json
    
    $blobUri = "https://api.github.com/repos/$owner/$repo/git/blobs"
    $blobRes = Invoke-RestMethod -Uri $blobUri -Headers $headers -Method Post -Body $blobBody -ContentType "application/json"
    
    $treeNodes += @{
        path = $cleanPath
        mode = "100644"
        type = "blob"
        sha = $blobRes.sha
    }
}

# 4. Create new tree
Write-Host "Creating new tree..."
$treeBody = @{
    base_tree = $baseTreeSha
    tree = $treeNodes
} | ConvertTo-Json -Depth 5

$treeUri = "https://api.github.com/repos/$owner/$repo/git/trees"
$newTree = Invoke-RestMethod -Uri $treeUri -Headers $headers -Method Post -Body $treeBody -ContentType "application/json"

# 5. Create new commit
Write-Host "Creating new commit..."
$commitBody = @{
    message = "Full bulk deployment via Trees API (CSS, JS, Exams, and Pricing Fixes)"
    tree = $newTree.sha
    parents = @($commitSha)
} | ConvertTo-Json

$postCommitUri = "https://api.github.com/repos/$owner/$repo/git/commits"
$newCommit = Invoke-RestMethod -Uri $postCommitUri -Headers $headers -Method Post -Body $commitBody -ContentType "application/json"

# 6. Update reference
Write-Host "Updating branch reference..."
$updateRefBody = @{
    sha = $newCommit.sha
} | ConvertTo-Json

Invoke-RestMethod -Uri $refUri -Headers $headers -Method Patch -Body $updateRefBody -ContentType "application/json"

Write-Host "Bulk Deployment SUCCESSFUL!" -ForegroundColor Green






