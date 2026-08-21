// Global state
let qrInstance = null;
let uploadedLogo = null;
let currentMode = 'url'; // text, url, wifi, vcard, whatsapp

// Site pages index for search discovery
const sitePages = [
    { title: "QR Code Generator Homepage", path: "" },
    { title: "WiFi QR Code Generator & Setup Guide", path: "wifi/" },
    { title: "WiFi Connection Setup Guide", path: "wifi/setup/" },
    { title: "Android WiFi QR Code Connection Guide", path: "wifi/setup/android/" },
    { title: "Free Android Home WiFi QR Code Generator Tool", path: "wifi/setup/android/home-network/free-tool/" },
    { title: "Create Android Home WiFi Network QR Code", path: "wifi/setup/android/home-network/qr-generator/" },
    { title: "Scan and Share Android WiFi QR Codes", path: "wifi/setup/android/home-network/share-scanner/" },
    { title: "Connect to Android WiFi QR Codes Step-by-Step", path: "wifi/setup/android/home-network/connect-guide/" },
    { title: "Link to QR Code Generator Online", path: "link/" },
    { title: "URL to QR Code Generator Guide", path: "link/url-generator/" },
    { title: "Free Link to QR Code Generator Tool", path: "link/url-generator/free/" },
    { title: "Free QR Code Generator from Link No Signup", path: "link/url-generator/free/no-signup/" },
    { title: "Free Unlimited Link QR Code Generator", path: "link/url-generator/free/unlimited/" },
    { title: "Create Free Dynamic QR Codes for Links", path: "link/url-generator/free/dynamic/" },
    { title: "Custom Link QR Code Generator with Logo", path: "link/url-generator/free/custom-logo/" },
    { title: "vCard QR Code Generator & Business Card Maker", path: "vcard/" },
    { title: "QR Code Business Card Creator", path: "vcard/business-card/" },
    { title: "Free QR Code Business Card Maker", path: "vcard/business-card/free/" },
    { title: "Free Digital Business Card QR Code with Logo", path: "vcard/business-card/free/digital-profile/" },
    { title: "Create Free Contact Info QR Codes", path: "vcard/business-card/free/contact-qr/" },
    { title: "Free VCF / vCard Link QR Code Generator", path: "vcard/business-card/free/vcf-generator/" },
    { title: "Mobile vCard Business Card QR Code Generator", path: "vcard/business-card/free/mobile-vcard/" },
    { title: "PDF to QR Code Converter & Document Generator", path: "pdf/" },
    { title: "Document to QR Code Generator Guide", path: "pdf/document-generator/" },
    { title: "Free PDF to QR Code Generator Online", path: "pdf/document-generator/free/" },
    { title: "Free PDF QR Code Generator for Google Drive Documents", path: "pdf/document-generator/free/google-drive/" },
    { title: "Convert Dropbox PDF Links to QR Code Free", path: "pdf/document-generator/free/dropbox-link/" },
    { title: "Create Permanent PDF QR Codes No Expiration", path: "pdf/document-generator/free/no-expiration/" },
    { title: "Online File Converter to QR Code Tool", path: "pdf/document-generator/free/file-converter/" },
    { title: "Social Media QR Code Generator & App Guides", path: "social/" },
    { title: "Messaging App QR Code Generator", path: "social/messaging/" },
    { title: "WhatsApp QR Code Generator & Link Maker", path: "social/messaging/whatsapp/" },
    { title: "WhatsApp Chat Link QR Code Generator with Custom Logo", path: "social/messaging/whatsapp/chat-link/" },
    { title: "Create Free WhatsApp QR Codes Online", path: "social/messaging/whatsapp/qr-generator/" },
    { title: "WhatsApp Phone Number QR Code Generator", path: "social/messaging/whatsapp/contact-number/" },
    { title: "WhatsApp Business API QR Code Generator Tool", path: "social/messaging/whatsapp/business-api/" },
    { title: "Plain Text & SMS QR Code Generator", path: "text/" },
    { title: "Email Mailto QR Code Generator with Subject & Body", path: "email/" }
];

document.addEventListener('DOMContentLoaded', () => {
    // Determine relative prefix
    const prefix = typeof relPrefix !== 'undefined' ? relPrefix : '';
    
    // Initialize QR Code generator if elements exist
    const canvasElement = document.getElementById('qr-canvas');
    if (canvasElement) {
        initQRGenerator();
    }

    // Set up FAQ Accordion
    const faqQuestions = document.querySelectorAll('.faq-question');
    faqQuestions.forEach(q => {
        q.addEventListener('click', () => {
            const parent = q.parentElement;
            parent.classList.toggle('active');
        });
    });

    // Set up Header Search
    const searchInput = document.getElementById('header-search');
    const searchDropdown = document.getElementById('search-dropdown');
    
    if (searchInput && searchDropdown) {
        searchInput.addEventListener('input', () => {
            const query = searchInput.value.toLowerCase().trim();
            if (!query) {
                searchDropdown.style.display = 'none';
                return;
            }

            const matches = sitePages.filter(p => p.title.toLowerCase().includes(query));
            searchDropdown.innerHTML = '';
            
            if (matches.length === 0) {
                searchDropdown.innerHTML = '<div class="no-results">No pages found</div>';
            } else {
                matches.forEach(m => {
                    const link = document.createElement('a');
                    link.href = prefix + m.path;
                    link.textContent = m.title;
                    searchDropdown.appendChild(link);
                });
            }
            searchDropdown.style.display = 'block';
        });

        // Close dropdown when clicking outside
        document.addEventListener('click', (e) => {
            if (!searchInput.contains(e.target) && !searchDropdown.contains(e.target)) {
                searchDropdown.style.display = 'none';
            }
        });
    }
});

// Initialize the QR Generator controls
function initQRGenerator() {
    // Mode Switch tabs
    const tabButtons = document.querySelectorAll('.qr-tab-btn');
    tabButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            tabButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            
            currentMode = btn.dataset.mode;
            
            // Toggle form views
            document.querySelectorAll('.form-group-fields').forEach(f => f.style.display = 'none');
            const targetForm = document.getElementById(`fields-${currentMode}`);
            if (targetForm) {
                targetForm.style.display = 'block';
            }
            
            generateQRCode();
        });
    });

    // Form inputs change trigger regeneration
    const inputs = document.querySelectorAll('.form-input, .color-input, .range-input');
    inputs.forEach(input => {
        input.addEventListener('input', generateQRCode);
    });

    // Logo upload drag & drop
    const dropzone = document.getElementById('logo-dropzone');
    const logoFile = document.getElementById('logo-file');
    
    if (dropzone && logoFile) {
        dropzone.addEventListener('click', () => logoFile.click());
        
        dropzone.addEventListener('dragover', (e) => {
            e.preventDefault();
            dropzone.classList.add('dragover');
        });
        
        dropzone.addEventListener('dragleave', () => {
            dropzone.classList.remove('dragover');
        });
        
        dropzone.addEventListener('drop', (e) => {
            e.preventDefault();
            dropzone.classList.remove('dragover');
            if (e.dataTransfer.files.length > 0) {
                handleLogoFile(e.dataTransfer.files[0]);
            }
        });
        
        logoFile.addEventListener('change', () => {
            if (logoFile.files.length > 0) {
                handleLogoFile(logoFile.files[0]);
            }
        });
    }

    // Remove logo button
    const removeLogoBtn = document.getElementById('remove-logo-btn');
    if (removeLogoBtn) {
        removeLogoBtn.addEventListener('click', () => {
            uploadedLogo = null;
            document.getElementById('logo-preview-container').style.display = 'none';
            document.getElementById('logo-file').value = '';
            generateQRCode();
        });
    }

    // Download handlers
    const downloadPngBtn = document.getElementById('download-png');
    if (downloadPngBtn) {
        downloadPngBtn.addEventListener('click', downloadPNG);
    }
    
    const downloadSvgBtn = document.getElementById('download-svg');
    if (downloadSvgBtn) {
        downloadSvgBtn.addEventListener('click', downloadSVG);
    }

    // Initial draw
    generateQRCode();
}

// Handle Logo image loading
function handleLogoFile(file) {
    if (!file.type.match('image.*')) {
        alert('Please select an image file (PNG, JPG, SVG).');
        return;
    }
    
    const reader = new FileReader();
    reader.onload = (e) => {
        const img = new Image();
        img.src = e.target.result;
        img.onload = () => {
            uploadedLogo = img;
            // Update preview
            const previewImg = document.getElementById('logo-preview-img');
            const previewContainer = document.getElementById('logo-preview-container');
            if (previewImg && previewContainer) {
                previewImg.src = img.src;
                previewContainer.style.display = 'flex';
            }
            generateQRCode();
        };
    };
    reader.readAsDataURL(file);
}

// Get the formatted payload string for QR Code
function getQRValue() {
    switch (currentMode) {
        case 'text':
            return document.getElementById('input-text').value || "Hello World";
        case 'url':
            let url = document.getElementById('input-url').value || "https://eduprosuite-org.github.io/qrcode/";
            if (url && !/^https?:\/\//i.test(url)) {
                url = "https://" + url;
            }
            return url;
        case 'wifi':
            const ssid = document.getElementById('wifi-ssid').value || "WiFi-Network";
            const pass = document.getElementById('wifi-pass').value || "";
            const enc = document.getElementById('wifi-enc').value || "WPA";
            const hidden = document.getElementById('wifi-hidden').checked ? 'H:true;' : '';
            return `WIFI:S:${ssid};T:${enc};P:${pass};${hidden};`;
        case 'vcard':
            const first = document.getElementById('vcard-first').value || "John";
            const last = document.getElementById('vcard-last').value || "Doe";
            const phone = document.getElementById('vcard-phone').value || "";
            const email = document.getElementById('vcard-email').value || "";
            const org = document.getElementById('vcard-org').value || "";
            const title = document.getElementById('vcard-title').value || "";
            const web = document.getElementById('vcard-web').value || "";
            const addr = document.getElementById('vcard-addr').value || "";
            
            return [
                "BEGIN:VCARD",
                "VERSION:3.0",
                `N:${last};${first};;;`,
                `FN:${first} ${last}`,
                org ? `ORG:${org}` : '',
                title ? `TITLE:${title}` : '',
                phone ? `TEL;TYPE=CELL:${phone}` : '',
                email ? `EMAIL:${email}` : '',
                web ? `URL:${web}` : '',
                addr ? `ADR:;;${addr};;;;` : '',
                "END:VCARD"
            ].filter(Boolean).join("\n");
        case 'whatsapp':
            const phoneNum = document.getElementById('wa-phone').value.replace(/[^0-9]/g, '') || "1234567890";
            const message = document.getElementById('wa-message').value || "";
            return `https://wa.me/${phoneNum}?text=${encodeURIComponent(message)}`;
        case 'email':
            const emailTo = document.getElementById('email-to') ? document.getElementById('email-to').value : "";
            const emailSub = document.getElementById('email-sub') ? document.getElementById('email-sub').value : "";
            const emailBody = document.getElementById('email-body') ? document.getElementById('email-body').value : "";
            return `mailto:${emailTo}?subject=${encodeURIComponent(emailSub)}&body=${encodeURIComponent(emailBody)}`;
        case 'sms':
            const smsPhone = document.getElementById('sms-phone') ? document.getElementById('sms-phone').value.replace(/[^0-9+]/g, '') : "";
            const smsMsg = document.getElementById('sms-msg') ? document.getElementById('sms-msg').value : "";
            return `SMSTO:${smsPhone}:${smsMsg}`;
        default:
            return "https://eduprosuite-org.github.io/qrcode/";
    }
}

// Generate the QR Code and render to canvas
function generateQRCode() {
    const value = getQRValue();
    const size = parseInt(document.getElementById('qr-size').value) || 300;
    const fgColor = document.getElementById('qr-fg').value || "#000000";
    const bgColor = document.getElementById('qr-bg').value || "#ffffff";
    const canvas = document.getElementById('qr-canvas');
    
    if (!canvas) return;
    
    // Instantiate or update QRious
    if (!qrInstance) {
        qrInstance = new QRious({
            element: canvas,
            value: value,
            size: size,
            level: 'H', // Always use High error correction to allow center logo placement
            foreground: fgColor,
            background: bgColor
        });
    } else {
        qrInstance.set({
            value: value,
            size: size,
            foreground: fgColor,
            background: bgColor
        });
    }

    // Draw custom logo in the center if uploaded
    if (uploadedLogo) {
        const ctx = canvas.getContext('2d');
        const logoSize = size * 0.22; // Scale logo to 22% of QR code size
        const x = (size - logoSize) / 2;
        const y = (size - logoSize) / 2;
        
        // Draw white card background for the logo
        ctx.fillStyle = bgColor;
        ctx.beginPath();
        ctx.roundRect(x - 4, y - 4, logoSize + 8, logoSize + 8, 6);
        ctx.fill();
        
        // Draw logo image
        ctx.drawImage(uploadedLogo, x, y, logoSize, logoSize);
    }
}

// Helper: Download Canvas as PNG image
function downloadPNG() {
    const canvas = document.getElementById('qr-canvas');
    if (!canvas) return;
    
    const link = document.createElement('a');
    link.download = 'qrcode.png';
    link.href = canvas.toDataURL('image/png');
    link.click();
}

// Helper: Convert Canvas to Vector SVG and download
function downloadSVG() {
    const canvas = document.getElementById('qr-canvas');
    if (!canvas) return;
    
    const fgColor = document.getElementById('qr-fg').value || "#000000";
    const bgColor = document.getElementById('qr-bg').value || "#ffffff";
    
    // Sample canvas to build native vector grid
    const ctx = canvas.getContext('2d');
    const width = canvas.width;
    const height = canvas.height;
    
    // Read pixel data
    const imgData = ctx.getImageData(0, 0, width, height).data;
    
    // Helper function to check if pixel is dark
    const isPixelDark = (x, y) => {
        const idx = (y * width + x) * 4;
        const r = imgData[idx];
        const g = imgData[idx + 1];
        const b = imgData[idx + 2];
        const a = imgData[idx + 3];
        if (a < 128) return false; // transparent
        return (r + g + b) / 3 < 128; // dark average
    };

    // Scan for margin and finder pattern to find module size
    let startX = -1;
    let startY = -1;
    
    // Scan diagonally to find the first dark pixel (top-left of finder pattern)
    for (let i = 0; i < Math.min(width, height); i++) {
        if (isPixelDark(i, i)) {
            startX = i;
            startY = i;
            break;
        }
    }
    
    if (startX === -1) {
        // Fallback to basic search if diagonal fails
        outer: for (let y = 0; y < height; y++) {
            for (let x = 0; x < width; x++) {
                if (isPixelDark(x, y)) {
                    startX = x;
                    startY = y;
                    break outer;
                }
            }
        }
    }
    
    let moduleSize = 1;
    if (startX !== -1) {
        // Measure top-left finder pattern width (7 modules wide)
        let endX = startX;
        while (endX < width && isPixelDark(endX, startY)) {
            endX++;
        }
        const borderWidth = endX - startX;
        moduleSize = borderWidth / 7;
    }
    
    const modulesCount = Math.round((width - 2 * startX) / moduleSize);
    
    // Construct SVG string
    let svgContent = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${height}" width="${width}" height="${height}">`;
    // Background rect
    svgContent += `<rect width="100%" height="100%" fill="${bgColor}" />`;
    
    // Draw cells
    for (let row = 0; row < modulesCount; row++) {
        for (let col = 0; col < modulesCount; col++) {
            const px = Math.round(startX + col * moduleSize + moduleSize / 2);
            const py = Math.round(startY + row * moduleSize + moduleSize / 2);
            
            if (isPixelDark(px, py)) {
                const rx = startX + col * moduleSize;
                const ry = startY + row * moduleSize;
                // Add cell rect, overlapping slightly to prevent seams
                svgContent += `<rect x="${rx.toFixed(2)}" y="${ry.toFixed(2)}" width="${(moduleSize + 0.1).toFixed(2)}" height="${(moduleSize + 0.1).toFixed(2)}" fill="${fgColor}" />`;
            }
        }
    }
    
    // Draw logo overlay if present
    if (uploadedLogo) {
        const logoSize = width * 0.22;
        const lx = (width - logoSize) / 2;
        const ly = (height - logoSize) / 2;
        
        // Draw background white card in SVG
        svgContent += `<rect x="${(lx - 4).toFixed(2)}" y="${(ly - 4).toFixed(2)}" width="${(logoSize + 8).toFixed(2)}" height="${(logoSize + 8).toFixed(2)}" fill="${bgColor}" rx="6" ry="6" />`;
        
        // Embed logo in SVG as base64 image data
        svgContent += `<image x="${lx.toFixed(2)}" y="${ly.toFixed(2)}" width="${logoSize.toFixed(2)}" height="${logoSize.toFixed(2)}" href="${uploadedLogo.src}" />`;
    }
    
    svgContent += `</svg>`;
    
    // Download SVG
    const blob = new Blob([svgContent], { type: 'image/svg+xml' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.download = 'qrcode.svg';
    link.href = url;
    link.click();
    URL.revokeObjectURL(url);
}
