$file = "generate_plumbing_silo.ps1"
$content = Get-Content $file -Raw -Encoding UTF8

# Define the new resources list HTML to inject into the product page template
$resourcesHtml = @"
            <div style="background: rgba(16, 185, 129, 0.05); border: 1px solid rgba(16, 185, 129, 0.2); border-radius: 12px; padding: 2rem; margin-bottom: 2rem;">
                <h3 style="color: white; font-size: 1.3rem; margin-bottom: 1rem; font-weight: 700;">Premium Resources Included (Value: `$750+)</h3>
                <ul style="color: var(--text-secondary); font-size: 0.95rem; line-height: 1.8; list-style: none; padding-left: 0;">
                    <li style="margin-bottom: 0.5rem;"><span style="color: #34d399; margin-right: 0.5rem;">✔️</span> <strong>Downloadable PDF Study Guide</strong> - Comprehensive breakdown of all topics</li>
                    <li style="margin-bottom: 0.5rem;"><span style="color: #34d399; margin-right: 0.5rem;">✔️</span> <strong>Quick Review Cheat Sheet</strong> - Perfect for last-minute cramming</li>
                    <li style="margin-bottom: 0.5rem;"><span style="color: #34d399; margin-right: 0.5rem;">✔️</span> <strong>500+ Interactive Mock Test Questions</strong> - Real exam simulator</li>
                    <li style="margin-bottom: 0.5rem;"><span style="color: #34d399; margin-right: 0.5rem;">✔️</span> <strong>Full Code Book Breakdown</strong> - IPC / UPC / Local Amendments</li>
                    <li style="margin-bottom: 0.5rem;"><span style="color: #34d399; margin-right: 0.5rem;">✔️</span> <strong>3D Isometric Drawing Guides</strong> - Step-by-step sizing tutorials</li>
                    <li style="margin-bottom: 0.5rem;"><span style="color: #34d399; margin-right: 0.5rem;">✔️</span> <strong>1-Year Full Access & Updates</strong> - Study at your own pace</li>
                </ul>
            </div>
"@

# Inject resources HTML before the FAQs section
$content = $content -replace '(<section[^>]*id="faqs".*?>)', ($resourcesHtml + "`n`n        `$1")

# Fix prices in the script
$content = $content -replace 'id = "texas-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$399.00').Replace('$49.99', '$399.00')
$content = $content -replace 'id = "va-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$399.00').Replace('$49.99', '$399.00')
$content = $content -replace 'id = "kansas-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$399.00').Replace('$49.99', '$399.00')
$content = $content -replace 'id = "ma-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$399.00').Replace('$49.99', '$399.00')
$content = $content -replace 'id = "wssc-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$399.00').Replace('$49.99', '$399.00')
$content = $content -replace 'id = "general-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$349.00').Replace('$39.99', '$349.00')
$content = $content -replace 'id = "master-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$549.00').Replace('$59.99', '$549.00')
$content = $content -replace 'id = "contractor-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$549.00').Replace('$59.99', '$549.00')
$content = $content -replace 'id = "tradesman-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$299.00').Replace('$44.99', '$299.00')
$content = $content -replace 'id = "inspector-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$299.00').Replace('$44.99', '$299.00')
$content = $content -replace 'id = "residential-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$199.00').Replace('$39.99', '$199.00')
$content = $content -replace 'id = "code-cert-prep"[\s\S]{0,300}?price = ".*?"', '$0'.Replace('.99', '$199.00').Replace('$39.99', '$199.00')

# Ensure the PayPal link extracts the price value correctly.
# Find where $priceTag is extracted and create a sanitized $priceVal
$content = $content -replace '\$priceVal = "19\.99"', '$priceVal = $priceTag.Replace("$", "")'

# Write back
$utf8NoBOM = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText((Join-Path $PSScriptRoot $file), $content, $utf8NoBOM)

Write-Host "Generator updated with premium pricing and resources!"

