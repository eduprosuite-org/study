# update_prices.ps1 - Updates all exam prices in generated HTML files
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
$base = "D:\1 hour in clg"

$updates = @(
    @("exams\plumbing-license-prep\journeyman\general-prep\index.html", "19.99", "39.99"),
    @("exams\plumbing-license-prep\journeyman\texas-prep\index.html", "19.99", "49.99"),
    @("exams\plumbing-license-prep\journeyman\va-prep\index.html", "19.99", "49.99"),
    @("exams\plumbing-license-prep\journeyman\kansas-prep\index.html", "19.99", "49.99"),
    @("exams\plumbing-license-prep\journeyman\ma-prep\index.html", "19.99", "49.99"),
    @("exams\plumbing-license-prep\journeyman\wssc-prep\index.html", "19.99", "49.99"),
    @("exams\plumbing-license-prep\master-contractor\master-prep\index.html", "19.99", "59.99"),
    @("exams\plumbing-license-prep\master-contractor\contractor-prep\index.html", "19.99", "59.99"),
    @("exams\plumbing-license-prep\tradesman-other\tradesman-prep\index.html", "19.99", "44.99"),
    @("exams\plumbing-license-prep\tradesman-other\inspector-prep\index.html", "19.99", "44.99"),
    @("exams\plumbing-license-prep\general\residential-prep\index.html", "19.99", "39.99"),
    @("exams\plumbing-license-prep\general\code-cert-prep\index.html", "19.99", "39.99")
)

foreach ($u in $updates) {
    $fp = Join-Path $base $u[0]
    if (Test-Path $fp) {
        $c = [System.IO.File]::ReadAllText($fp)
        $c = $c.Replace($u[1], $u[2])
        [System.IO.File]::WriteAllText($fp, $c, $utf8NoBOM)
        Write-Host "Updated: $($u[0]) -> $($u[2])" -ForegroundColor Green
    } else {
        Write-Host "NOT FOUND: $fp" -ForegroundColor Red
    }
}
Write-Host "`nAll prices updated!"




