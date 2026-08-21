# ============================================================
# MASTER RESTORE SCRIPT — EduProSuite Org
# ============================================================
# Run this script on a NEW computer or after reinstall.
# It clones ALL your GitHub repositories to the correct local paths.
#
# Usage:
#   powershell -ExecutionPolicy Bypass -File restore_all.ps1
#
# Add new sites to the $sites array below as you create them.
# ============================================================

$org = "eduprosuite-org"

# ============================================================
# SITE LIST — Add new repos here as you create them
# ============================================================
$sites = @(
    @{
        Repo      = "qrcode"
        LocalPath = "D:\1 hour in clg"
        Desc      = "QR Code / Main SEO Site"
    },
    @{
        Repo      = "study"
        LocalPath = "D:\sites\study"
        Desc      = "Study / Exam Prep Site"
    }
    # Add future sites below this line, e.g.:
    # @{
    #     Repo      = "likexnumber"
    #     LocalPath = "D:\sites\likexnumber"
    #     Desc      = "LikeXNumber Site"
    # },
)

# ============================================================
# CLONE LOGIC — Do not modify below this line
# ============================================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  EduProSuite — Master Restore Script" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$success = 0
$skipped = 0
$failed  = 0

foreach ($site in $sites) {
    $repoUrl   = "https://github.com/$org/$($site.Repo).git"
    $localPath = $site.LocalPath
    $desc      = $site.Desc

    Write-Host ">>> $desc ($($site.Repo))" -ForegroundColor Yellow
    Write-Host "    Remote : $repoUrl"
    Write-Host "    Local  : $localPath"

    if (Test-Path "$localPath\.git") {
        Write-Host "    [SKIP] Already cloned. Running git pull instead..." -ForegroundColor DarkYellow
        git -C $localPath pull
        $skipped++
    } else {
        # Create parent directory if it doesn't exist
        $parent = Split-Path $localPath -Parent
        if (!(Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }

        git clone $repoUrl $localPath
        if ($LASTEXITCODE -eq 0) {
            Write-Host "    [OK] Cloned successfully!" -ForegroundColor Green
            $success++
        } else {
            Write-Host "    [ERROR] Clone failed! Check your internet or repo name." -ForegroundColor Red
            $failed++
        }
    }
    Write-Host ""
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Restore Complete!"
Write-Host "  Cloned  : $success"
Write-Host "  Updated : $skipped (already existed)"
Write-Host "  Failed  : $failed"
Write-Host "============================================" -ForegroundColor Cyan

if ($failed -gt 0) {
    Write-Host ""
    Write-Host "WARNING: $failed repo(s) failed. Check the error messages above." -ForegroundColor Red
}
