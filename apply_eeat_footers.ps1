# PowerShell script to apply high-trust E-E-A-T footers across all workspace HTML files.
# CRITICAL RULE: NEVER touch exams/plumbing-license-prep/

$root = $PSScriptRoot

function Get-RelativeRoot {
    param([string]$filePath)
    $dir = Split-Path $filePath -Parent
    $normalizedDir = $dir.Replace('\', '/').TrimEnd('/')
    $normalizedRoot = $root.Replace('\', '/').TrimEnd('/')
    
    if ($normalizedDir -eq $normalizedRoot) {
        return ""
    }
    
    $relativeDir = $normalizedDir.Substring($normalizedRoot.Length).TrimStart('/')
    $segments = $relativeDir.Split('/', [System.StringSplitOptions]::RemoveEmptyEntries)
    $depth = $segments.Count
    if ($depth -le 0) {
        return ""
    }
    $prefix = ""
    for ($i = 0; $i -lt $depth; $i++) {
        $prefix += "../"
    }
    return $prefix
}

function Build-QR-Footer($toRoot) {
    return @"
    <!-- Footer Area -->
    <footer>
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-col" style="grid-column: span 1;">
                    <h4>QRCodeHub</h4>
                    <p style="font-size:0.85rem; color:var(--text-secondary);">Interactive client-side QR code generator providing customized, print-ready vector SVG and PNG downloads with zero limits and 100% privacy.</p>
                    <a href="${toRoot}index.html" style="font-weight:700; color:var(--primary);">Go back to Homepage</a>
                    <div style="margin-top: 1rem; font-size:0.85rem; color:var(--text-muted);">
                        <strong>Direct Contact:</strong><br>
                        <a href="mailto:support@eduprosuite.org" style="color:var(--accent);">support@eduprosuite.org</a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>QR Code Creators</h4>
                    <ul>
                        <li><a href="${toRoot}link/index.html">Link / Website URL</a></li>
                        <li><a href="${toRoot}wifi/index.html">WiFi Network</a></li>
                        <li><a href="${toRoot}vcard/index.html">vCard Business Card</a></li>
                        <li><a href="${toRoot}pdf/index.html">PDF Document</a></li>
                        <li><a href="${toRoot}social/index.html">WhatsApp &amp; Social</a></li>
                        <li><a href="${toRoot}text/index.html">Plain Text &amp; SMS</a></li>
                        <li><a href="${toRoot}email/index.html">Email Mailto QR</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Trust &amp; Editorial</h4>
                    <ul>
                        <li><a href="${toRoot}legal/about/index.html">About Us</a></li>
                        <li><a href="${toRoot}legal/editorial-policy/index.html">Editorial Policy</a></li>
                        <li><a href="${toRoot}legal/fact-checking/index.html">Fact-Checking Policy</a></li>
                        <li><a href="${toRoot}legal/contact/index.html">Contact Us</a></li>
                        <li><a href="${toRoot}sitemap_index.xml">Sitemap Index</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Legal &amp; Policy</h4>
                    <ul>
                        <li><a href="${toRoot}legal/privacy-policy/index.html">Privacy Policy</a></li>
                        <li><a href="${toRoot}legal/terms-of-service/index.html">Terms &amp; Conditions</a></li>
                        <li><a href="${toRoot}legal/disclaimer/index.html">Disclaimer</a></li>
                        <li><a href="${toRoot}legal/affiliate-disclosure/index.html">Affiliate Disclosure</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <div>&copy; 2026 QRCodeHub &bull; EduProSuite Digital Knowledge Network. All rights reserved. | Contact: <a href="mailto:support@eduprosuite.org" style="color:var(--accent);">support@eduprosuite.org</a></div>
                <div>Client-side privacy guaranteed &bull; Open source on <a href="https://github.com/eduprosuite-org" target="_blank" rel="noopener noreferrer" style="color:var(--primary);">GitHub</a> &bull; <a href="https://linkedin.com" target="_blank" rel="noopener noreferrer" style="color:var(--primary);">LinkedIn</a></div>
            </div>
        </div>
    </footer>
"@
}

function Build-Exam-Footer($toRoot) {
    return @"
    <!-- Semantic E-E-A-T Footer -->
    <footer>
        <div class="footer-content" style="flex-direction: column; gap: 1.5rem; max-width: 1200px; margin: 0 auto; padding: 2rem 1.5rem;">
            <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap; font-size: 0.95rem;">
                <a href="${toRoot}index.html" style="color: var(--text-secondary); text-decoration: none;">Home</a>
                <a href="${toRoot}exams/ca-real-estate-math/index.html" style="color: var(--text-secondary); text-decoration: none;">CA Real Estate Math</a>
                <a href="${toRoot}exams/vic-lea-electrician-prep/index.html" style="color: var(--text-secondary); text-decoration: none;">Vic LEA Electrician</a>
                <a href="${toRoot}exams/plumbing-aptitude-test/index.html" style="color: var(--text-secondary); text-decoration: none;">Plumbing Aptitude</a>
                <a href="${toRoot}exams/sarasota-adu-permit-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Sarasota ADU Permits</a>
                <a href="${toRoot}exams/gwinnett-home-occupation-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Gwinnett Home Occupation</a>
                <a href="${toRoot}exams/douglas-co-residential-building-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Douglas County Building</a>
                <a href="${toRoot}wiki/index.html" style="color: var(--text-secondary); text-decoration: none;">Articles</a>
            </div>
            <div style="display: flex; gap: 1.5rem; justify-content: center; flex-wrap: wrap; font-size: 0.9rem; border-top: 1px solid rgba(255,255,255,0.06); padding-top: 0.85rem;">
                <a href="${toRoot}legal/about/index.html" style="color: var(--text-secondary);">About Us</a>
                <a href="${toRoot}legal/editorial-policy/index.html" style="color: var(--text-secondary);">Editorial Policy</a>
                <a href="${toRoot}legal/fact-checking/index.html" style="color: var(--text-secondary);">Fact-Checking Policy</a>
                <a href="${toRoot}legal/disclaimer/index.html" style="color: var(--text-secondary);">Educational Disclaimer</a>
                <a href="${toRoot}legal/terms-of-service/index.html" style="color: var(--text-secondary);">Terms &amp; Conditions</a>
                <a href="${toRoot}legal/privacy-policy/index.html" style="color: var(--text-secondary);">Privacy Policy</a>
                <a href="${toRoot}legal/affiliate-disclosure/index.html" style="color: var(--text-secondary);">Affiliate Disclosure</a>
                <a href="${toRoot}legal/contact/index.html" style="color: var(--text-secondary);">Contact Us</a>
            </div>
            <div style="text-align: center; color: var(--text-muted); font-size: 0.85rem; border-top: 1px solid rgba(255,255,255,0.04); padding-top: 0.85rem; line-height: 1.6;">
                <div>Direct Contact: <a href="mailto:support@eduprosuite.org" style="color: var(--accent);">support@eduprosuite.org</a> &bull; EduProSuite Digital Knowledge &amp; Exam Prep Network</div>
                <div>Social Proof: <a href="https://github.com/eduprosuite-org" target="_blank" rel="noopener noreferrer" style="color:var(--primary);">GitHub</a> &bull; <a href="https://linkedin.com" target="_blank" rel="noopener noreferrer" style="color:var(--primary);">LinkedIn</a> &bull; <a href="https://twitter.com" target="_blank" rel="noopener noreferrer" style="color:var(--primary);">Twitter/X</a></div>
                <div style="margin-top: 0.35rem;">&copy; 2026 EduProSuite ExamPrep Portal. All rights reserved. Practice simulators are independent educational resources and not affiliated with government testing boards.</div>
            </div>
        </div>
    </footer>
"@
}

function Build-Generic-Footer($toRoot) {
    return @"
    <!-- Semantic E-E-A-T Footer -->
    <footer>
        <div class="footer-content" style="flex-direction: column; gap: 1.5rem; max-width: 1200px; margin: 0 auto; padding: 2rem 1.5rem;">
            <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap; font-size: 0.95rem;">
                <a href="${toRoot}index.html" style="color: var(--text-secondary);">Home</a>
                <a href="${toRoot}legal/about/index.html" style="color: var(--text-secondary);">About Us</a>
                <a href="${toRoot}legal/editorial-policy/index.html" style="color: var(--text-secondary);">Editorial Policy</a>
                <a href="${toRoot}legal/fact-checking/index.html" style="color: var(--text-secondary);">Fact-Checking Policy</a>
                <a href="${toRoot}legal/disclaimer/index.html" style="color: var(--text-secondary);">Disclaimer</a>
                <a href="${toRoot}legal/terms-of-service/index.html" style="color: var(--text-secondary);">Terms &amp; Conditions</a>
                <a href="${toRoot}legal/privacy-policy/index.html" style="color: var(--text-secondary);">Privacy Policy</a>
                <a href="${toRoot}legal/affiliate-disclosure/index.html" style="color: var(--text-secondary);">Affiliate Disclosure</a>
                <a href="${toRoot}legal/contact/index.html" style="color: var(--text-secondary);">Contact</a>
            </div>
            <div style="text-align: center; color: var(--text-muted); font-size: 0.85rem; border-top: 1px solid rgba(255,255,255,0.06); padding-top: 0.85rem; line-height: 1.6;">
                <div>Direct Contact: <a href="mailto:support@eduprosuite.org" style="color: var(--accent);">support@eduprosuite.org</a> &bull; EduProSuite Knowledge Network</div>
                <div>Social Proof: <a href="https://github.com/eduprosuite-org" target="_blank" rel="noopener noreferrer" style="color:var(--primary);">GitHub</a> &bull; <a href="https://linkedin.com" target="_blank" rel="noopener noreferrer" style="color:var(--primary);">LinkedIn</a></div>
                <div style="margin-top: 0.35rem;">&copy; 2026 EduProSuite. All rights reserved. Built for educational clarity, speed, and privacy.</div>
            </div>
        </div>
    </footer>
"@
}

$htmlFiles = Get-ChildItem -Path $root -Filter "*.html" -Recurse | Where-Object {
    $_.FullName -notmatch "\\\.git\\" -and
    $_.FullName -notmatch "\\\.agents\\" -and
    $_.FullName -notmatch "\\exams\\plumbing-license-prep\\" -and
    $_.FullName -notmatch "\\legal\\"
}

Write-Host "Found $($htmlFiles.Count) HTML files to update." -ForegroundColor Cyan

$updatedCount = 0
$normalizedRoot = $root.Replace('\', '/').TrimEnd('/')

foreach ($file in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $toRoot = Get-RelativeRoot -filePath $file.FullName
    
    $normalizedFile = $file.FullName.Replace('\', '/')
    $cleanRel = $normalizedFile.Substring($normalizedRoot.Length).TrimStart('/')
    
    $newFooter = ""
    if ($cleanRel -match '^(link|wifi|vcard|pdf|social|text|email)/' -or $cleanRel -eq "index.html") {
        $newFooter = Build-QR-Footer -toRoot $toRoot
    }
    elseif ($cleanRel -match '^exams/' -or $cleanRel -eq "index-study.html") {
        $newFooter = Build-Exam-Footer -toRoot $toRoot
    }
    else {
        $newFooter = Build-Generic-Footer -toRoot $toRoot
    }
    
    # Clean regex to replace any existing footer and preceding duplicate comments cleanly
    if ($content -match '(?s)(<!--\s*(Footer Area|Semantic E-E-A-T Footer)\s*-->\s*)*<footer.*?>.*?</footer>') {
        $updatedContent = [regex]::Replace($content, '(?s)(<!--\s*(Footer Area|Semantic E-E-A-T Footer)\s*-->\s*)*<footer.*?>.*?</footer>', $newFooter.Trim())
        [System.IO.File]::WriteAllText($file.FullName, $updatedContent, [System.Text.Encoding]::UTF8)
        $updatedCount++
    } else {
        Write-Warning "No <footer> found in $cleanRel"
    }
}

Write-Host "Cleaned & updated $updatedCount HTML files with all 5 E-E-A-T Trustworthiness pillars!" -ForegroundColor Green
