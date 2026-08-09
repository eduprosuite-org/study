# Silo Generator Script for QR Code Web Application
# Generates a 5-level directory silo structure with optimized meta, sidebars, sitemaps, and schemas.
# Avoids editing any files in exams/plumbing-license-prep.

$SiteBaseUrl = "https://eduprosuite-org.github.io/qrcode/"

# Define the taxonomy database
$Pages = @()

# 1. ROOT HOMEPAGE (Level 1)
$Pages += @{
    Path = ""
    Level = 1
    Category = "root"
    Title = "Free QR Code Generator Online - Custom QR Codes with Logo"
    MetaDesc = "Create custom QR codes with logos, custom colors, and frames. Generate free QR codes for URL, Text, WiFi, WhatsApp, vCard, and PDF. No signup required."
    H1 = "Premium Client-Side QR Code Generator"
    Keywords = "qr code generator, free qr code generator, create qr code, qrcode generator, custom qr code with logo"
    Niche = "root"
    ActiveTab = "url"
    Takeaway = @(
        "Generate fully custom QR codes with logos and colors completely client-side in seconds.",
        "100% free and unlimited scans with high-error-correction templates.",
        "Download vector SVG or high-resolution PNG formats instantly with no registration."
    )
    FAQs = @(
        @{ Q = "Is this QR code generator completely free?"; A = "Yes, our generator runs entirely in your browser and is free forever. There are no scan limits, hidden costs, or subscriptions." },
        @{ Q = "Do these QR codes expire?"; A = "No, the QR codes generated are static and will never expire. They will work as long as the underlying destination URL or text remains active." },
        @{ Q = "How do I add a logo to my QR code?"; A = "Upload your logo in PNG or JPG format using our logo upload box. We automatically set high error correction (level 'H') to ensure the QR code remains scannable." },
        @{ Q = "Can I generate vector QR codes?"; A = "Yes! You can download your custom QR code as a vector SVG file, which is perfect for high-quality print designs." }
    )
    HowTo = @(
        "Select the tab for the type of QR code you want to generate (URL, WiFi, vCard, text, etc.).",
        "Enter your input details in the form fields.",
        "Customize the foreground and background colors to fit your brand guidelines.",
        "Upload a logo to embed in the center of the QR code (optional).",
        "Click the download buttons to save your QR code as a PNG or vector SVG."
    )
}

# 2. WIFI SILO (Category 1)
# Level 2 Category Hub
$Pages += @{
    Path = "wifi/"
    Level = 2
    Category = "wifi"
    Title = "WiFi QR Code Generator - Share WiFi Password Online"
    MetaDesc = "Generate a secure WiFi QR code to share your network name and password. Let guests scan to connect to your home or office WiFi instantly."
    H1 = "WiFi QR Code Generator"
    Keywords = "wifi qr code generator, share wifi qr code, generate wifi qr, scan wifi code"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Share your WiFi network name (SSID) and password without revealing your actual credentials.",
        "Compatible with standard iOS and Android camera apps for instant guest connections.",
        "Supports secure WPA/WPA2, WEP, and hidden network configurations."
    )
    FAQs = @(
        @{ Q = "How do guests connect to my WiFi using a QR code?"; A = "Guests simply open their phone's camera app and point it at the QR code. A notification will appear prompting them to join the network automatically." },
        @{ Q = "Is my WiFi password safe on this website?"; A = "Yes, our tool runs 100% client-side. Your network credentials are never sent to a server. They are processed entirely inside your browser." },
        @{ Q = "What encryption type should I choose?"; A = "Most modern routers use WPA/WPA2. If your router does not require a password, choose 'None'." }
    )
    HowTo = @(
        "Type your WiFi Network Name (SSID) into the SSID field.",
        "Select your network security protocol (usually WPA/WPA2).",
        "Enter your WiFi password in the security field.",
        "If your network is hidden, check the hidden option.",
        "Download your customized WiFi QR code and print it for your guests."
    )
}

# Level 3 Sub-Category
$Pages += @{
    Path = "wifi/setup/"
    Level = 3
    Category = "wifi"
    Title = "WiFi QR Code Setup and Sharing Guide"
    MetaDesc = "Complete guide to setting up, printing, and sharing WiFi connection QR codes. Learn connection requirements and configuration tips."
    H1 = "WiFi QR Code Connection Setup"
    Keywords = "wifi qr code setup, sharing wifi password, create guest wifi qr"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Understand the mechanics of WIFI connection strings and guest network setups.",
        "Learn best practices for printing and placing QR codes in home and business locations.",
        "Troubleshoot common scanning problems on older mobile operating systems."
    )
    FAQs = @(
        @{ Q = "Can I customize the look of my guest network QR code?"; A = "Yes! You can change colors and place a logo in the center of the code while maintaining scannability." },
        @{ Q = "Does this work for both Android and iPhone?"; A = "Yes, all modern mobile devices support direct camera scanning of WiFi QR codes." }
    )
    HowTo = @(
        "Ensure your router security protocol matches the selected value (WPA/WEP).",
        "Input your SSID exactly, matching uppercase and lowercase letters.",
        "Generate and verify the code using your own mobile phone before print."
    )
}

# Level 4 Sub-Sub-Category
$Pages += @{
    Path = "wifi/setup/android/"
    Level = 4
    Category = "wifi"
    Title = "Android WiFi QR Code Generator & Setup Guide"
    MetaDesc = "Learn how to generate and connect to WiFi QR codes on Android devices. Step-by-step instructions for Samsung, Google Pixel, and other Android phones."
    H1 = "Android WiFi QR Code Setup"
    Keywords = "android wifi qr code, generate wifi qr android, samsung share wifi qr"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Generate WiFi sharing codes directly from your Android settings menu.",
        "Scan guest networks using the built-in Android Quick Settings scanner.",
        "Format network credentials safely for all Android OS versions."
    )
    FAQs = @(
        @{ Q = "Where is the WiFi QR code scanner on Android?"; A = "Swipe down to open Quick Settings and look for the 'Scan QR code' tile, or use the camera app." },
        @{ Q = "How do I share my network from a Samsung phone?"; A = "Go to Connections > Wi-Fi, tap the gear icon next to your active network, and tap the 'QR code' button at the bottom." }
    )
    HowTo = @(
        "Go to WiFi settings on your Android device.",
        "Tap the active network gear icon and select QR code to display it.",
        "Use another device to scan the code or save the image to share with guests."
    )
}

# Level 4.5 Niche Hub (segment 4)
$Pages += @{
    Path = "wifi/setup/android/home-network/"
    Level = 4.5
    Category = "wifi"
    Title = "Android Home WiFi Network QR Code Hub"
    MetaDesc = "Explore tools and articles for setting up, generating, scanning, and connecting to home WiFi network QR codes on Android devices."
    H1 = "Android Home WiFi QR Code Hub"
    Keywords = "android home wifi qr, guest network qr android"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Access specialized tools for creating guest networks and smart home configurations.",
        "Read articles on home network security and credential sharing.",
        "Learn integration tips for IoT devices and smart appliances."
    )
    FAQs = @(
        @{ Q = "Should I set up a separate guest network?"; A = "Yes, guest networks keep your main home network secure from external vulnerabilities." }
    )
    HowTo = @(
        "Select one of our specialized guides below.",
        "Generate a separate WiFi QR code for your guest subnet.",
        "Print and display the guest QR code in your living room or entrance."
    )
}

# Level 5 Silo Sibling 1
$Pages += @{
    Path = "wifi/setup/android/home-network/free-tool/"
    Level = 5
    Category = "wifi"
    Title = "Free Android Home WiFi QR Code Generator Tool"
    MetaDesc = "Generate a free custom QR code for your Android home WiFi network. Instantly share secure passwords with guests using this client-side generator."
    H1 = "Free Android Home WiFi QR Code Generator"
    Keywords = "free android home wifi qr, create guest network qr android"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Create custom WiFi connection codes for Android devices instantly.",
        "Embed home network security protocols without leaking passwords.",
        "100% free with unlimited scans and zero data server transfers."
    )
    FAQs = @(
        @{ Q = "Is this generator safe to use for home networks?"; A = "Absolutely. All processing occurs locally in your browser. Your home WiFi SSID and password are never sent to our servers." },
        @{ Q = "Does this work on newer Android versions?"; A = "Yes, it is fully compatible with Android 10, 11, 12, 13, 14, and above." }
    )
    HowTo = @(
        "Enter your home network SSID name.",
        "Choose WPA as the security protocol.",
        "Enter your password and hit generate to render the code.",
        "Verify scannability with your Android camera."
    )
}

# Level 5 Silo Sibling 2
$Pages += @{
    Path = "wifi/setup/android/home-network/qr-generator/"
    Level = 5
    Category = "wifi"
    Title = "Create Android Home WiFi Network QR Codes"
    MetaDesc = "Learn the technical standards for Android home WiFi QR codes. Standard WiFi strings, hidden network protocols, and generation tips."
    H1 = "Create Android Home WiFi Network QR Code"
    Keywords = "create android home wifi qr, wifi connection string android"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Master the standardized 'WIFI:S:SSID;T:WPA;P:PASSWORD;;' connection string format.",
        "Incorporate hidden SSID tags into guest networks correctly.",
        "Optimize module size and contrast for rapid camera capture."
    )
    FAQs = @(
        @{ Q = "How does Android parse WiFi QR codes?"; A = "Android reads the barcode content. If it matches the 'WIFI:' protocol prefix, it routes it to the OS network manager." },
        @{ Q = "What happens if my SSID contains special characters?"; A = "Special characters like semicolons or colons must be escaped with backslashes in the raw connection string." }
    )
    HowTo = @(
        "Construct your WiFi string with the proper syntax.",
        "Generate a high-contrast QR code using our tool.",
        "Test on multiple devices to ensure successful parsing."
    )
}

# Level 5 Silo Sibling 3
$Pages += @{
    Path = "wifi/setup/android/home-network/share-scanner/"
    Level = 5
    Category = "wifi"
    Title = "Scan and Share Android WiFi QR Codes"
    MetaDesc = "Step-by-step guide to scanning and sharing WiFi network connections using QR codes on Android. How to use Google Lens and settings sharing."
    H1 = "Scan & Share Android WiFi QR Codes"
    Keywords = "scan android wifi qr, share wifi qr google lens"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Share credentials without printing using screen-to-screen QR codes.",
        "Scan codes using the Android camera, Google Lens, or settings menu.",
        "Troubleshoot camera focus and scanner permissions on Android."
    )
    FAQs = @(
        @{ Q = "Can I scan a WiFi QR code from a saved screenshot?"; A = "Yes, you can open Google Lens, load the screenshot from your gallery, and tap 'Join Network'." },
        @{ Q = "What if my Android camera does not scan QR codes?"; A = "Check your camera settings and ensure 'Scan QR codes' is enabled, or download a secure scanner app." }
    )
    HowTo = @(
        "Open your active network settings and display the share QR code.",
        "Ask your friend to scan it from their Android Quick Settings menu.",
        "Tap the pop-up notification to immediately connect."
    )
}

# Level 5 Silo Sibling 4
$Pages += @{
    Path = "wifi/setup/android/home-network/connect-guide/"
    Level = 5
    Category = "wifi"
    Title = "Connect to Android WiFi QR Codes Step-by-Step"
    MetaDesc = "Complete troubleshooting guide for connecting to WiFi QR codes on Android. Solve scanning errors, wrong password errors, and network range issues."
    H1 = "Connect to Android WiFi QR Codes Guide"
    Keywords = "connect android wifi qr, troubleshoot wifi qr android"
    Niche = "wifi"
    ActiveTab = "wifi"
    Takeaway = @(
        "Understand the causes behind 'Incorrect Password' or 'Could not connect' errors.",
        "Solve contrast, glare, and resolution scanning issues.",
        "Ensure device settings allow automated network connections."
    )
    FAQs = @(
        @{ Q = "Why does my Android phone say 'Connection Failed' after scanning?"; A = "This usually means the password in the QR code is incorrect or the network security type doesn't match." },
        @{ Q = "Does my phone need to be rooted to scan WiFi QR codes?"; A = "No, QR code scanning and network connection is a native feature on Android 10 and above." }
    )
    HowTo = @(
        "Clean your camera lens and ensure high screen brightness on the host device.",
        "Hold the phone steady and frame the QR code in the scanner viewfinder.",
        "Wait for the prompt and accept the connection request."
    )
}

# 3. LINK SILO (Category 2)
# Level 2 Category Hub
$Pages += @{
    Path = "link/"
    Level = 2
    Category = "link"
    Title = "Link to QR Code Generator - Convert URL to QR Code"
    MetaDesc = "Convert any link, website URL, or social media page into a custom QR code. Download free vector SVG or high-resolution PNG files instantly."
    H1 = "Link to QR Code Generator"
    Keywords = "link to qr code, convert url to qr code, website link to qr"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Convert URLs, domains, and landing pages into scannable QR codes.",
        "Add custom logos and brand color schemes to your website link codes.",
        "Fully client-side rendering ensures your links remain secure and private."
    )
    FAQs = @(
        @{ Q = "Can I generate QR codes for any website URL?"; A = "Yes, you can generate QR codes for any valid URL, including landing pages, articles, and subdomains." },
        @{ Q = "Do my links need to use HTTPS?"; A = "It is highly recommended to use secure HTTPS links as modern browsers might block access to non-secure HTTP destinations." }
    )
    HowTo = @(
        "Paste your destination link into the URL field.",
        "Customize the brand colors to match your website design.",
        "Verify formatting and download as vector SVG or PNG."
    )
}

# Level 3 Sub-Category
$Pages += @{
    Path = "link/url-generator/"
    Level = 3
    Category = "link"
    Title = "URL to QR Code Generator & Conversion Guide"
    MetaDesc = "Complete guide to converting URLs to QR codes. Learn redirects, URL structure, and best scanning practices for marketing campaigns."
    H1 = "URL to QR Code Conversion"
    Keywords = "url to qr code, convert link to qr, website qr guide"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Optimize URL lengths using shorteners to keep your QR code grid clean.",
        "Format parameters and tracking tokens (UTMs) correctly for scanning analytics.",
        "Compare static vs dynamic redirects for marketing print collateral."
    )
    FAQs = @(
        @{ Q = "Why does my QR code look dense and complicated?"; A = "Long URLs with many parameters create a denser QR code grid. Use shorter URLs to keep the modules large and easy to scan." }
    )
    HowTo = @(
        "Clean your destination URL of unnecessary parameters.",
        "Paste it into our generator widget above.",
        "Adjust colors and size for optimal scanning contrast."
    )
}

# Level 4 Sub-Sub-Category
$Pages += @{
    Path = "link/url-generator/free/"
    Level = 4
    Category = "link"
    Title = "Free Link to QR Code Generator Tool Hub"
    MetaDesc = "Access our free suite of link-to-QR converters. No registration required, unlimited scans, and native canvas downloads."
    H1 = "Free Link to QR Code Tools"
    Keywords = "free link to qr, free qr code creator, free link qr converter"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Explore multiple vector and image export presets for print media.",
        "No expiration dates and no account sign-ups required.",
        "Ensure fast page load times and secure browser generation."
    )
    FAQs = @(
        @{ Q = "Are there any hidden fees or limitations on these free tools?"; A = "No, all link converters on our site are 100% free with unlimited scans." }
    )
    HowTo = @(
        "Select your preferred link tool from the directory below.",
        "Generate your scannable code and save the high-res file."
    )
}

# Level 4.5 Niche Hub (segment 4)
$Pages += @{
    Path = "link/url-generator/free/links/"
    Level = 4.5
    Category = "link"
    Title = "Free Link QR Code Conversion Options"
    MetaDesc = "Compare various free link conversion options: static codes, dynamic redirects, custom logo embeds, and no-signup interfaces."
    H1 = "Link QR Code Options"
    Keywords = "link qr options, static vs dynamic qr link"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Select the right conversion method for your specific marketing goal.",
        "Incorporate custom assets to boost click-through rates.",
        "Maximize indexability and crawl paths for your destination URLs."
    )
    FAQs = @(
        @{ Q = "What is the benefit of adding a logo to a link QR code?"; A = "Logos build brand recognition and trust, increasing the scan rate by up to 30%." }
    )
    HowTo = @(
        "Review our detailed option guides below.",
        "Choose the appropriate tool for your target audience."
    )
}

# Level 5 Silo Sibling 1
$Pages += @{
    Path = "link/url-generator/free/links/no-signup/"
    Level = 5
    Category = "link"
    Title = "Free QR Code Generator from Link No Signup"
    MetaDesc = "Create a custom QR code from any website link instantly with no signup. Download high-resolution PNG or vector SVG files with no registration."
    H1 = "Free Link QR Code Generator - No Signup"
    Keywords = "free qr code generator from link no signup, qr generator no registration"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Convert links to QR codes immediately without sharing email or personal data.",
        "Instant client-side script outputs high-quality canvas assets.",
        "No limitations on usage frequency or monthly scans."
    )
    FAQs = @(
        @{ Q = "Do I need to verify an email to download the file?"; A = "No, the download triggers instantly inside your browser as soon as you click." },
        @{ Q = "Will the QR code stop working after a few weeks?"; A = "No. These are direct, static QR codes that point directly to your URL forever. They will never stop working." }
    )
    HowTo = @(
        "Paste your URL in the generator input box.",
        "Hit the generation trigger.",
        "Download your file as PNG or SVG immediately."
    )
}

# Level 5 Silo Sibling 2
$Pages += @{
    Path = "link/url-generator/free/links/unlimited/"
    Level = 5
    Category = "link"
    Title = "Free Unlimited Link QR Code Generator"
    MetaDesc = "Generate unlimited QR codes for website URLs with zero scan limits. Completely free static link converter with SVG vector exports."
    H1 = "Free Unlimited Link QR Code Generator"
    Keywords = "free unlimited qr code generator, link qr code generator no limits"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Run heavy marketing campaigns with zero scan caps or usage limits.",
        "Export vector templates that scale to large billboard sizes without pixelation.",
        "Maintain absolute control over your digital redirect assets."
    )
    FAQs = @(
        @{ Q = "Are there any hidden bandwidth or scan limits?"; A = "No. Since the QR code contains the direct URL and runs statically, we do not route scans through our servers. Your scans are unlimited." },
        @{ Q = "Can I generate 1,000 QR codes in a day?"; A = "Yes, you can generate as many codes as you need with no rate limits." }
    )
    HowTo = @(
        "Input your website domain or deep landing page link.",
        "Tweak sizes and colors as needed.",
        "Download as SVG to preserve infinite resolution."
    )
}

# Level 5 Silo Sibling 3
$Pages += @{
    Path = "link/url-generator/free/links/dynamic/"
    Level = 5
    Category = "link"
    Title = "Create Free Dynamic QR Codes for Links"
    MetaDesc = "Learn how to build dynamic redirect links for your QR codes. Edit destination URLs after printing using your own shorteners."
    H1 = "Create Free Dynamic QR Codes"
    Keywords = "create dynamic qr code free, editable qr code link"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Learn how to host your own redirects to change destinations anytime.",
        "Track scan locations and referrers using custom URL parameter methods.",
        "Avoid paying monthly subscription fees to third-party dynamic platforms."
    )
    FAQs = @(
        @{ Q = "What makes a QR code 'dynamic'?;"; A = "A dynamic QR code contains a redirect link instead of the final URL. By editing the target of the redirect link, you change where the QR code goes." },
        @{ Q = "Can I edit a static QR code after it is printed?"; A = "No. The data inside a static QR code is physically encoded into the black and white pattern and cannot be changed." }
    )
    HowTo = @(
        "Set up a redirect link on your domain (e.g. yoursite.com/go/promo).",
        "Generate a static QR code pointing to that redirect link.",
        "Edit the redirect destination on your server whenever you want to update the promo."
    )
}

# Level 5 Silo Sibling 4
$Pages += @{
    Path = "link/url-generator/free/links/custom-logo/"
    Level = 5
    Category = "link"
    Title = "Custom Link QR Code Generator with Logo"
    MetaDesc = "Embed your business logo inside your website link QR codes. Free custom logo overlay utility with smart canvas margins."
    H1 = "Custom Link QR Code Generator with Logo"
    Keywords = "custom link qr code generator with logo, brand qr generator"
    Niche = "link"
    ActiveTab = "url"
    Takeaway = @(
        "Embed corporate logos and brand colors to look more professional.",
        "Use high error correction to prevent logo overlap scan failures.",
        "Generate beautiful brand assets without coding skills."
    )
    FAQs = @(
        @{ Q = "What logo size is recommended?"; A = "We recommend keeping your logo size under 22% of the total QR code width to ensure reliable scanning." },
        @{ Q = "Does the logo need a white background?"; A = "Our script automatically draws a protective card background behind your logo so it doesn't merge with the QR code dots." }
    )
    HowTo = @(
        "Paste your link in the input field.",
        "Drag and drop your logo file into the upload box.",
        "Verify scanning from your screen and click download."
    )
}

# 4. VCARD SILO (Category 3)
# Level 2 Category Hub
$Pages += @{
    Path = "vcard/"
    Level = 2
    Category = "vcard"
    Title = "vCard QR Code Generator - Share Contact Details"
    MetaDesc = "Create an interactive vCard QR code containing your name, phone number, email, and website. Scan to save contacts instantly to phone address books."
    H1 = "vCard QR Code Generator"
    Keywords = "vcard qr code, contact qr code generator, share contact details qr"
    Niche = "vcard"
    ActiveTab = "vcard"
    Takeaway = @(
        "Convert full contact cards (names, addresses, websites) into single scannable codes.",
        "Native compatibility with Android Contacts and Apple Address Book apps.",
        "Perfect for resume designs, portfolio pages, and event networking."
    )
    FAQs = @(
        @{ Q = "What is a vCard QR code?"; A = "A vCard QR code stores contact data in a standardized VCF format. When scanned, modern smartphones recognize it as a contact card and offer a one-click save." },
        @{ Q = "How much contact details can I include?"; A = "You can include fields like name, phone, email, company, title, and address. Avoid too much text to keep the QR code easy to scan." }
    )
    HowTo = @(
        "Fill out your contact fields (first name, last name, phone, email).",
        "Add your business URL and company name if applicable.",
        "Generate the high-correction code and save to your mobile device."
    )
}

# Level 3 Sub-Category
$Pages += @{
    Path = "vcard/business-card/"
    Level = 3
    Category = "vcard"
    Title = "QR Code Business Card Setup & Printing Guide"
    MetaDesc = "Learn how to design, print, and share digital business cards using QR codes. Dimensions, materials, and placement tips."
    H1 = "QR Code Business Card Guide"
    Keywords = "qr code business card, digital business card qr, print contact qr"
    Niche = "vcard"
    ActiveTab = "vcard"
    Takeaway = @(
        "Design modern business cards that bridge print and digital networks.",
        "Select the right card stock and print DPI for sharp QR scanning.",
        "Embed vCard data templates that work offline."
    )
    FAQs = @(
        @{ Q = "What size should a QR code be on a business card?"; A = "We recommend a minimum size of 0.8 x 0.8 inches (2 x 2 cm) to ensure smartphone cameras can focus on it." }
    )
    HowTo = @(
        "Input your details in our vCard form.",
        "Adjust colors to contrast with your business card background.",
        "Export in high resolution PNG or vector SVG for print production."
    )
}

# Level 4 Sub-Sub-Category
$Pages += @{
    Path = "vcard/business-card/free/"
    Level = 4
    Category = "vcard"
    Title = "Free QR Code Business Card Hub"
    MetaDesc = "Create completely free contact QR codes for physical business cards. Unlimited creations, no accounts, and client-side processing."
    H1 = "Free QR Code Business Card Tools"
    Keywords = "free qr business card, free contact qr creator"
    Niche = "vcard"
    ActiveTab = "vcard"
    Takeaway = @(
        "Build contact codes for your entire sales or business team free.",
        "Ensure absolute confidentiality of team email addresses and cell numbers.",
        "Download print-ready vector file packs instantly."
    )
    FAQs = @(
        @{ Q = "Do you store the contact info I enter in the vCard form?"; A = "No. All text is converted to a QR code block directly inside your web browser. No contact data is sent to our servers." }
    )
    HowTo = @(
        "Pick a specialized vCard template from the section below.",
        "Fill out the profile fields and generate the card."
    )
}

# Level 4.5 Niche Hub (segment 4)
$Pages += @{
    Path = "vcard/business-card/free/contacts/"
    Level = 4.5
    Category = "vcard"
    Title = "Contact QR Code Layout Options"
    MetaDesc = "Explore contact sharing layouts: digital profiles, raw VCF files, mobile vCards, and custom logo business cards."
    H1 = "Contact QR Code Hub"
    Keywords = "contact qr layout, vcard format options"
    Niche = "vcard"
    ActiveTab = "vcard"
    Takeaway = @(
        "Choose between saving raw contacts or linking to a digital landing page.",
        "Incorporate profiles and brand graphics into card files.",
        "Structure address data correctly for international standards."
    )
    FAQs = @(
        @{ Q = "Should I use a raw vCard QR code or a link to a digital landing page?"; A = "A raw vCard works offline and saves instantly, but has a fixed size. A link to a digital landing page can be updated later but requires an internet connection to scan." }
    )
    HowTo = @(
        "Compare the contact profiles and decide on static vs link methods.",
        "Generate your selected format and print the digital code."
    )
}

# Level 5 Silo Sibling 1
$Pages += @{
    Path = "vcard/business-card/free/contacts/digital-profile/"
    Level = 5
    Category = "vcard"
    Title = "Free Digital Business Card QR Code with Logo"
    MetaDesc = "Generate a free digital business card QR code embedded with your company logo. Share clean contact details with a modern branded look."
    H1 = "Digital Business Card QR Code with Logo"
    Keywords = "free digital business card qr code generator with logo, brand contact qr"
    Niche = "vcard"
    ActiveTab = "vcard"
    Takeaway = @(
        "Increase network connections by including clear company branding.",
        "Leverage level 'H' error correction to embed clear icons in the center.",
        "Keep contact templates consistent across your entire business."
    )
    FAQs = @(
        @{ Q = "Can I use my personal headshot as the logo?"; A = "Yes, you can upload any square PNG or JPG photo to embed in the center of your contact QR code." },
        @{ Q = "Will the contact code scan on older Android versions?"; A = "Yes, our standard vCard formatting is recognized across both legacy and modern operating systems." }
    )
    HowTo = @(
        "Fill out the vCard contact form fields.",
        "Upload your corporate logo or profile picture.",
        "Save as SVG for high-quality commercial business card printing."
    )
}

# Level 5 Silo Sibling 2
$Pages += @{
    Path = "vcard/business-card/free/contacts/contact-qr/"
    Level = 5
    Category = "vcard"
    Title = "Create Free Contact Info QR Codes"
    MetaDesc = "Generate a free offline contact info QR code. Instant sharing of phone number, email address, and office details with zero account limits."
    H1 = "Create Free Contact Info QR Code"
    Keywords = "create contact info qr free, share phone number qr"
    Niche = "vcard"
    ActiveTab = "vcard"
    Takeaway = @(
        "Share phone numbers and email addresses without typing errors.",
        "Perfect for display stands, resume files, and email signatures.",
        "Runs fully offline with no server database required."
    )
    FAQs = @(
        @{ Q = "Does a phone scanner dial the number automatically?"; A = "No, for security reasons, the scanner displays the phone number and offers the user the option to Call or Save it." },
        @{ Q = "Can I generate a QR code that just dials a number?"; A = "Yes! You can format your input as a 'tel:' protocol to open the dialer directly." }
    )
    HowTo = @(
        "Fill in your name and contact phone number.",
        "Add an email address and generate the card.",
        "Display the generated code on your presentation slide or printed materials."
    )
}

# Level 5 Silo Sibling 3
$Pages += @{
    Path = "vcard/business-card/free/contacts/vcf-generator/"
    Level = 5
    Category = "vcard"
    Title = "Free VCF / vCard Link QR Code Generator"
    MetaDesc = "Generate a QR code linking to an online .vcf file. Great for heavy directories or rich digital cards with profile pictures."
    H1 = "Free VCF Link QR Code Generator"
    Keywords = "vcf qr code generator, link to vcf file qr"
    Niche = "vcard"
    ActiveTab = "url"
    Takeaway = @(
        "Host your .vcf contact file online and convert its link to a QR code.",
        "Keep the QR code grid simple and fast to scan by linking to files.",
        "Support digital files with rich profile images and portfolios."
    )
    FAQs = @(
        @{ Q = "Why is a VCF link QR code simpler than a raw vCard QR code?"; A = "A VCF link only contains a URL (e.g. 30 characters), while a raw vCard contains all your contact text (e.g. 300 characters). This makes the link QR code much cleaner and easier to scan." },
        @{ Q = "Where can I host my .vcf file?"; A = "You can host it on your own server, Dropbox, Google Drive (shared publicly), or any file hosting service." }
    )
    HowTo = @(
        "Upload your .vcf file to a public file host.",
        "Copy the direct download link.",
        "Paste the link into our generator and export your clean QR code."
    )
}

# Level 5 Silo Sibling 4
$Pages += @{
    Path = "vcard/business-card/free/contacts/mobile-vcard/"
    Level = 5
    Category = "vcard"
    Title = "Mobile vCard Business Card QR Code Generator"
    MetaDesc = "Create mobile-optimized vCard QR codes. Ensure seamless contact saving on Apple iOS and Google Android device address books."
    H1 = "Mobile vCard QR Code Generator"
    Keywords = "mobile vcard qr code, apple contact qr, android vcard qr"
    Niche = "vcard"
    ActiveTab = "vcard"
    Takeaway = @(
        "Incorporate phone prefix formats (+1 for USA) for international dialing compatibility.",
        "Format website and email links cleanly to prevent parsing bugs.",
        "Ensure address fields match native Apple and Android database structures."
    )
    FAQs = @(
        @{ Q = "Does iOS support saving notes or custom fields?"; A = "Yes, modern iOS versions parse standard vCard note fields, although basic fields like phone and email are the most reliable." },
        @{ Q = "What vCard version is used?"; A = "We use vCard 3.0, which has the widest cross-platform support on mobile devices." }
    )
    HowTo = @(
        "Enter your international phone format into our form.",
        "Include your business street address and website.",
        "Download your customized contact card template."
    )
}

# 5. PDF SILO (Category 4)
# Level 2 Category Hub
$Pages += @{
    Path = "pdf/"
    Level = 2
    Category = "pdf"
    Title = "PDF to QR Code Converter - Link PDF to QR Code"
    MetaDesc = "Convert any PDF document into a scannable QR code. Share restaurant menus, product user guides, and slide decks directly from your phone."
    H1 = "PDF to QR Code Converter"
    Keywords = "pdf to qr code, convert pdf to qr code, pdf qr generator"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Share large document files (manuals, menus, ebooks) with a simple scan.",
        "Perfect for contactless restaurant menus and product packaging guides.",
        "Convert public document links into high-contrast print codes."
    )
    FAQs = @(
        @{ Q = "How do users read a PDF QR code?"; A = "When users scan the QR code, their phone's camera opens the hosted PDF link directly in their mobile browser." },
        @{ Q = "Can I update the PDF without changing the QR code?"; A = "Yes! By linking the QR code to a permanent URL (like a Google Drive file), you can overwrite the file online without changing the QR pattern." }
    )
    HowTo = @(
        "Upload your PDF to Google Drive, Dropbox, or your own server.",
        "Make the file public and copy the direct link.",
        "Paste the link in our generator and download your PDF QR code."
    )
}

# Level 3 Sub-Category
$Pages += @{
    Path = "pdf/document-generator/"
    Level = 3
    Category = "pdf"
    Title = "Document to QR Code Conversion & Hosting Guide"
    MetaDesc = "Complete guide to hosting files and converting documents to QR codes. Learn file sharing, direct links, and download optimization."
    H1 = "Document to QR Code Hosting Guide"
    Keywords = "document to qr code, convert document to qr, file sharing qr"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Understand direct-download vs browser-preview file links.",
        "Learn how to configure permissions on Google Drive and OneDrive.",
        "Optimize PDF file size for fast mobile rendering."
    )
    FAQs = @(
        @{ Q = "Why does my PDF QR code download the file instead of opening it?"; A = "This depends on the link structure. Direct links ending in '?dl=1' force a download, while standard preview links open it in the browser." }
    )
    HowTo = @(
        "Upload your document to a cloud host.",
        "Ensure the link permission is set to 'Anyone with the link can view'.",
        "Convert the link to a high-contrast QR code."
    )
}

# Level 4 Sub-Sub-Category
$Pages += @{
    Path = "pdf/document-generator/free/"
    Level = 4
    Category = "pdf"
    Title = "Free PDF to QR Code Generator Hub"
    MetaDesc = "Free tools to convert PDF files and document links to QR codes. No limits, no sign-ups, and print-ready high-resolution formats."
    H1 = "Free PDF to QR Code Tools"
    Keywords = "free pdf to qr code, free document qr converter"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Generate document links for menus, guides, and brochures free.",
        "No monthly fees or subscriptions required.",
        "Download print-ready vector file packs instantly."
    )
    FAQs = @(
        @{ Q = "Do these free document QR codes have a file size limit?"; A = "Since we convert the link, there is no file size limit! The limit is only set by your file hosting provider." }
    )
    HowTo = @(
        "Select your preferred document link tool from the directory below.",
        "Generate your scannable code and save the high-res file."
    )
}

# Level 4.5 Niche Hub (segment 4)
$Pages += @{
    Path = "pdf/document-generator/free/files/"
    Level = 4.5
    Category = "pdf"
    Title = "File and PDF Link QR Code Layouts"
    MetaDesc = "Compare various free file conversion guides: Google Drive links, Dropbox sharing, no-expiration codes, and file format conversions."
    H1 = "File to QR Code Hub"
    Keywords = "file to qr code options, document link styles"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Select the right cloud host for fast, mobile-friendly previews.",
        "Learn how to change files without changing the printed code.",
        "Convert slides, spreadsheets, and word docs to scannable formats."
    )
    FAQs = @(
        @{ Q = "Which cloud host is best for PDF QR codes?"; A = "Google Drive and Dropbox are excellent because they offer reliable mobile preview interfaces without forcing account logins." }
    )
    HowTo = @(
        "Review our detailed file hosting tutorials below.",
        "Choose the cloud sharing method that suits your workflow."
    )
}

# Level 5 Silo Sibling 1
$Pages += @{
    Path = "pdf/document-generator/free/files/google-drive/"
    Level = 5
    Category = "pdf"
    Title = "Free PDF QR Code Generator for Google Drive Documents"
    MetaDesc = "Learn how to convert Google Drive PDF links into scannable QR codes. Step-by-step guide to permissions and direct link formatting."
    H1 = "Google Drive PDF to QR Code Guide"
    Keywords = "free pdf qr code generator google drive documents, google drive link to qr"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Convert Google Drive files to clean scannable codes.",
        "Learn how to extract direct-preview links from sharing pop-ups.",
        "Ensure your audience doesn't see 'Access Denied' screen prompts."
    )
    FAQs = @(
        @{ Q = "How do I make my Google Drive PDF public?"; A = "Right-click the file in Google Drive, select Share > Share, and change General Access to 'Anyone with the link' before copying." },
        @{ Q = "Can I replace the PDF in Google Drive?"; A = "Yes! You can right-click the file in Google Drive, select 'Manage versions', and upload a new PDF. The link and QR code remain exactly the same." }
    )
    HowTo = @(
        "Upload your document to Google Drive.",
        "Set sharing permissions to public view.",
        "Paste the link in our converter and download the resulting file."
    )
}

# Level 5 Silo Sibling 2
$Pages += @{
    Path = "pdf/document-generator/free/files/dropbox-link/"
    Level = 5
    Category = "pdf"
    Title = "Convert Dropbox PDF Links to QR Codes Free"
    MetaDesc = "Guide to converting Dropbox PDF file links into scannable QR codes. How to use dynamic settings and direct browser previews."
    H1 = "Convert Dropbox PDF to QR Code"
    Keywords = "convert dropbox pdf to qr code, dropbox link to qr free"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Generate scannable codes using clean Dropbox shared link structures.",
        "Force mobile browsers to preview files inline rather than downloading.",
        "Change file versions easily in your Dropbox directories."
    )
    FAQs = @(
        @{ Q = "How do I force Dropbox to display the PDF inline instead of downloading?"; A = "Change the end of the Dropbox shared link from 'dl=0' to 'raw=1' before generating your QR code." },
        @{ Q = "Do Dropbox shared links expire?"; A = "Free Dropbox account links do not expire by default, making them suitable for static QR codes." }
    )
    HowTo = @(
        "Copy your Dropbox shared link.",
        "Modify the URL suffix to 'raw=1' for inline browser view.",
        "Paste in the generator input box and export your PNG file."
    )
}

# Level 5 Silo Sibling 3
$Pages += @{
    Path = "pdf/document-generator/free/files/no-expiration/"
    Level = 5
    Category = "pdf"
    Title = "Create Permanent PDF QR Codes No Expiration"
    MetaDesc = "Learn the rules for creating permanent PDF QR codes with no expiration dates. Free offline static guides for brochures and menus."
    H1 = "Permanent PDF QR Codes - No Expiration"
    Keywords = "permanent pdf qr code no expiration, permanent file qr generator"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Avoid proprietary redirect systems that deactivate after trial periods.",
        "Format direct URLs to ensure permanent offline usability.",
        "Choose high contrast color combinations for long-term outdoor print durability."
    )
    FAQs = @(
        @{ Q = "Do static PDF QR codes ever expire?"; A = "No. Since the QR code contains the direct file link, it will function as long as the cloud host holds the file." },
        @{ Q = "Can I test if a printed code is permanent?"; A = "Yes, check the raw URL encoded in the pattern. If it points to your direct cloud drive, it is permanent and independent of any QR platform." }
    )
    HowTo = @(
        "Generate a direct link to your document on your own server or cloud space.",
        "Create a static code using our tool.",
        "Test across multiple platforms to ensure long-term scannability."
    )
}

# Level 5 Silo Sibling 4
$Pages += @{
    Path = "pdf/document-generator/free/files/file-converter/"
    Level = 5
    Category = "pdf"
    Title = "Online File Converter to QR Code Tool"
    MetaDesc = "Convert Word documents, Excel sheets, and PowerPoint presentations into QR codes. Learn file type conversion and sharing standards."
    H1 = "Online File to QR Code Converter Guide"
    Keywords = "online file converter to qr code, word to qr, excel to qr code"
    Niche = "pdf"
    ActiveTab = "url"
    Takeaway = @(
        "Convert Office documents to PDF first for seamless mobile compatibility.",
        "Generate clean link codes for shared spreadsheets and presentations.",
        "Keep files scannable across Google, Apple, and Microsoft ecosystems."
    )
    FAQs = @(
        @{ Q = "Can I convert a Word doc directly to a QR code?"; A = "Yes, but it is best to export the Word doc as a PDF first, host it, and then generate the QR code. This prevents mobile formatting issues." },
        @{ Q = "Does this support PowerPoint slides?"; A = "Yes, host your slides on Google Slides or OneDrive and convert the public link." }
    )
    HowTo = @(
        "Save your document as a mobile-friendly PDF file.",
        "Upload the file to OneDrive, Drive, or a web server.",
        "Generate the link code and download your print-ready file."
    )
}

# 6. SOCIAL SILO (Category 5)
# Level 2 Category Hub
$Pages += @{
    Path = "social/"
    Level = 2
    Category = "social"
    Title = "Social Media QR Code Generator - Share Social Profiles"
    MetaDesc = "Create custom QR codes for Facebook, Instagram, YouTube, and messaging links. Share your digital handles with a single scannable graphic."
    H1 = "Social Media QR Code Generator"
    Keywords = "social media qr code, facebook qr code generator, share social profiles qr"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Grow your social media followers by displaying scannable profiles.",
        "Link directly to Facebook pages, Instagram feeds, and YouTube channels.",
        "Incorporate custom messaging overlays to encourage user engagement."
    )
    FAQs = @(
        @{ Q = "What social networks are supported?"; A = "Our tool can convert links for Facebook, Instagram, YouTube, Twitter, TikTok, LinkedIn, and messaging channels." },
        @{ Q = "Can I combine multiple social profiles into one QR code?"; A = "Yes, by generating a link to a Linktree or similar profile hub, you can share all your networks in one QR code." }
    )
    HowTo = @(
        "Select your target social network or profile link.",
        "Paste the profile URL into the generator box.",
        "Brand the code with custom colors and save your file."
    )
}

# Level 3 Sub-Category
$Pages += @{
    Path = "social/messaging/"
    Level = 3
    Category = "social"
    Title = "Messaging App QR Code Generator Guide"
    MetaDesc = "Generate direct messaging links and QR codes for chat apps. Let customers contact your support chat on WhatsApp, Telegram, or Viber."
    H1 = "Messaging App QR Code Generator"
    Keywords = "messaging app qr code, chat links qr generator, customer support qr"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Bridge the gap between print flyers and immediate chat assistance.",
        "Create pre-filled message links so users don't have to type introductions.",
        "Deploy scannable support links on product packaging and checkout counters."
    )
    FAQs = @(
        @{ Q = "How do messaging QR codes open on mobile?"; A = "Scanning the code triggers the device to open the corresponding messaging app (like WhatsApp or Telegram) directly into a chat window." }
    )
    HowTo = @(
        "Specify your messaging service and country code.",
        "Input a pre-filled template message for the user.",
        "Download your chat QR code and verify its launch sequence."
    )
}

# Level 4 Sub-Sub-Category
$Pages += @{
    Path = "social/messaging/whatsapp/"
    Level = 4
    Category = "social"
    Title = "WhatsApp QR Code Generator & Link Maker"
    MetaDesc = "Create customized WhatsApp click-to-chat QR codes. Let clients start conversations with your phone number instantly. Free tool."
    H1 = "WhatsApp QR Code & Link Generator"
    Keywords = "whatsapp qr code generator, whatsapp link maker, click to chat qr"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Build secure click-to-chat links using the wa.me API format.",
        "Pre-fill messaging text to track which campaigns drive scans.",
        "Share business phone numbers safely without manual keyboard input."
    )
    FAQs = @(
        @{ Q = "Does the user need to save my number to chat?"; A = "No! With the wa.me link format, users can message you instantly without adding your number to their contacts." },
        @{ Q = "Is there a charge for generating WhatsApp QR codes?"; A = "No, static click-to-chat codes are completely free and unlimited." }
    )
    HowTo = @(
        "Input your full phone number including country code (omit leading zeros).",
        "Add an optional default message.",
        "Generate and download the image file."
    )
}

# Level 4.5 Niche Hub (segment 4)
$Pages += @{
    Path = "social/messaging/whatsapp/chat/"
    Level = 4.5
    Category = "social"
    Title = "WhatsApp QR Code Sharing Options"
    MetaDesc = "Explore WhatsApp integration styles: logo embeds, custom pre-filled texts, phone number links, and API integrations."
    H1 = "WhatsApp QR Sharing Hub"
    Keywords = "whatsapp qr formats, click to chat layout"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Select the right chat link format for customer support or sales.",
        "Embed the official green WhatsApp logo inside the QR code center.",
        "Format country codes correctly to ensure global compatibility."
    )
    FAQs = @(
        @{ Q = "Why should I add the WhatsApp logo to my QR code?"; A = "Adding the logo tells the user exactly what will happen when they scan (opens WhatsApp), building trust." }
    )
    HowTo = @(
        "Review our WhatsApp layout and string formatting guides below.",
        "Choose the appropriate configuration for your messaging campaign."
    )
}

# Level 5 Silo Sibling 1
$Pages += @{
    Path = "social/messaging/whatsapp/chat/chat-link/"
    Level = 5
    Category = "social"
    Title = "WhatsApp Chat Link QR Code Generator with Custom Logo"
    MetaDesc = "Create a custom branded WhatsApp QR code with the official chat logo. Let users open chats with pre-filled messages instantly."
    H1 = "WhatsApp Chat Link QR Code with Logo"
    Keywords = "whatsapp chat link qr code generator with custom logo, branded whatsapp qr"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Embed visual indicators like the green WhatsApp icon inside the QR code.",
        "Set pre-populated text templates to initiate guest chats immediately.",
        "Maintain clean visual branding with our custom color controls."
    )
    FAQs = @(
        @{ Q = "Where do I get the WhatsApp logo to upload?"; A = "You can download the official green logo in square format and drag it into our logo box." },
        @{ Q = "Will the logo cover too much of the QR code?"; A = "No, the script scales the logo safely to 22% and enforces high error correction to keep the code fully readable." }
    )
    HowTo = @(
        "Enter your phone number and pre-filled chat message.",
        "Upload the official WhatsApp green logo.",
        "Verify scanning from your screen and click download."
    )
}

# Level 5 Silo Sibling 2
$Pages += @{
    Path = "social/messaging/whatsapp/chat/qr-generator/"
    Level = 5
    Category = "social"
    Title = "Create Free WhatsApp QR Codes Online"
    MetaDesc = "Generate static WhatsApp QR codes online for free. Instantly convert chat links to print-ready vector SVG or PNG images."
    H1 = "Create Free WhatsApp QR Codes"
    Keywords = "create free whatsapp qr codes online, whatsapp static qr generator"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Create permanent chat links that do not routing through paid services.",
        "No monthly fees, expirations, or account sign-ups.",
        "Download high-res vector files suitable for business flyers."
    )
    FAQs = @(
        @{ Q = "Do these codes work worldwide?"; A = "Yes, as long as the country code is correct, the link will open the chat window for users anywhere in the world." },
        @{ Q = "Can I use this for personal chat links?"; A = "Yes! It works for both personal numbers and business profiles." }
    )
    HowTo = @(
        "Input your cell number with country prefix.",
        "Generate the static code and export in SVG vector format."
    )
}

# Level 5 Silo Sibling 3
$Pages += @{
    Path = "social/messaging/whatsapp/chat/contact-number/"
    Level = 5
    Category = "social"
    Title = "WhatsApp Phone Number QR Code Generator"
    MetaDesc = "Convert any WhatsApp phone number into a QR code. Learn standard formatting, dial prefixes, and connection parameters."
    H1 = "WhatsApp Phone Number QR Code Converter"
    Keywords = "whatsapp phone number qr code generator, wa me phone number links"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Avoid connection failures by formatting phone numbers correctly.",
        "Omit '+' signs, leading zeros, and parentheses in raw inputs.",
        "Build reliable offline scan-to-chat setups for print labels."
    )
    FAQs = @(
        @{ Q = "What is the correct number format?"; A = "Use the international format without zeros or special characters. For example, use '15551234567' instead of '+1 (555) 123-4567'." },
        @{ Q = "What happens if a user scans a number that is not on WhatsApp?"; A = "The WhatsApp app will open and display a notice saying 'The phone number is not on WhatsApp'." }
    )
    HowTo = @(
        "Enter your clean numeric phone number in our input box.",
        "Render the code and test with a mobile device.",
        "Print on high contrast material for product display packaging."
    )
}

# Level 5 Silo Sibling 4
$Pages += @{
    Path = "social/messaging/whatsapp/chat/business-api/"
    Level = 5
    Category = "social"
    Title = "WhatsApp Business API QR Code Generator Tool"
    MetaDesc = "Generate QR codes for WhatsApp Business profiles and API links. Support automation, greeting templates, and CRM integration."
    H1 = "WhatsApp Business API QR Code Guide"
    Keywords = "whatsapp business api qr code generator, business chat links qr"
    Niche = "social"
    ActiveTab = "whatsapp"
    Takeaway = @(
        "Convert API links (`https://api.whatsapp.com/send...`) to scannable formats.",
        "Route customers to automated chatbots and corporate greeting menus.",
        "Track marketing channels using custom text template parameters."
    )
    FAQs = @(
        @{ Q = "Does this work with official WhatsApp Business accounts?"; A = "Yes, you can input your verified business number or convert your custom API link directly." },
        @{ Q = "Can I trigger automated replies using this QR code?"; A = "Yes! By formatting your pre-filled message with a keyword (e.g. 'HELLO_PROMO'), your chatbot can recognize the code and reply instantly." }
    )
    HowTo = @(
        "Input your business number or API URL link.",
        "Add the keyword-rich greeting text.",
        "Download the branded QR code to place on marketing materials."
    )
}

# Helper: Generate Breadcrumbs HTML
function Get-Breadcrumbs {
    param($Page)
    $prefix = "../" * @($Page.Path.Split("/") | Where-Object { $_ -ne "" }).Count
    if ($Page.Level -eq 1) {
        return '<div class="breadcrumbs"><span>Home</span></div>'
    }
    
    $html = '<div class="breadcrumbs">'
    $html += "<a href=`"$($prefix)index.html`">Home</a>"
    
    $parts = @($Page.Path.Split("/") | Where-Object { $_ -ne "" })
    $currentPath = ""
    for ($i = 0; $i -lt $parts.Count - 1; $i++) {
        $part = $parts[$i]
        $currentPath += "$part/"
        $depthToRoot = $parts.Count - 1 - $i
        $rel = "../" * $depthToRoot
        # capitalize segment name
        $name = (Get-Culture).TextInfo.ToTitleCase($part.Replace("-", " "))
        $html += "<span class=`"separator`"></span><a href=`"$($rel)index.html`">$name</a>"
    }
    
    # current page
    $currentName = (Get-Culture).TextInfo.ToTitleCase($parts[-1].Replace("-", " "))
    $html += "<span class=`"separator`"></span><span>$currentName</span>"
    $html += '</div>'
    return $html
}

# Helper: Generate Left Sidebar (Vertical Silo Navigation)
# Shows parent-child links for the current category silo only
function Get-LeftSidebar {
    param($Page)
    $prefix = "../" * @($Page.Path.Split("/") | Where-Object { $_ -ne "" }).Count
    
    if ($Page.Category -eq "root") {
        # homepage Left Sidebar lists category hubs
        $html = "<h3>QR Code Categories</h3>`n<ul>"
        $html += "<li><a href=`"wifi/index.html`">WiFi QR Codes</a></li>"
        $html += "<li><a href=`"link/index.html`">Link to QR Code</a></li>"
        $html += "<li><a href=`"vcard/index.html`">vCard Contacts</a></li>"
        $html += "<li><a href=`"pdf/index.html`">PDF &amp; Documents</a></li>"
        $html += "<li><a href=`"social/index.html`">Social Media QR</a></li>"
        $html += "</ul>"
        return $html
    }
    
    # We build the list of paths in this category
    $siloPages = $Pages | Where-Object { $_.Category -eq $Page.Category } | Sort-Object Level
    
    $html = "<h3>Current Silo Navigation</h3>`n<ul>"
    $html += "<li><a href=`"$($prefix)index.html`">&larr; Main Home</a></li>"
    
    foreach ($p in $siloPages) {
        # Calculate relative path from current page to this page
        # To do this, we go up to root ($prefix) and then down to $p.Path
        $relPath = $prefix + $p.Path
        if ($relPath -eq "") { $relPath = "index.html" }
        elseif ($relPath.EndsWith("/")) { $relPath += "index.html" }
        
        $activeClass = ""
        if ($p.Path -eq $Page.Path) {
            $activeClass = " class=`"active`""
        }
        
        # Name of the link
        $name = $p.H1
        if ($p.Level -eq 5) {
            # indent level 5 links
            $name = "&nbsp;&nbsp;▪ " + $p.H1
        }
        
        $html += "<li><a href=`"$($relPath)`"$activeClass>$name</a></li>"
    }
    $html += "</ul>"
    return $html
}

# Helper: Generate Right Sidebar (Contextual Utilities - Exclusive Links)
# Links to other silos and trending tools, mutually exclusive with the left sidebar.
function Get-RightSidebar {
    param($Page)
    $prefix = "../" * @($Page.Path.Split("/") | Where-Object { $_ -ne "" }).Count
    
    $html = "<h3>Trending Utilities</h3>`n<ul>"
    
    # Select pages that are NOT in the current category
    $otherPages = $Pages | Where-Object { $_.Category -ne $Page.Category -and $_.Level -eq 5 } | Select-Object -First 6
    
    foreach ($p in $otherPages) {
        $relPath = $prefix + $p.Path
        if ($relPath.EndsWith("/")) { $relPath += "index.html" }
        
        $html += "<li><a href=`"$($relPath)`">$($p.Title)</a></li>"
    }
    
    $html += "</ul>"
    
    $html += "<h3>Branded Tools</h3>`n<ul>"
    # Select some level 2/3/4 pages from other categories, skipping Level 2 hubs if we are on root
    $otherHubs = $Pages | Where-Object { 
        $_.Category -ne $Page.Category -and 
        ($_.Level -eq 2 -or $_.Level -eq 3 -or $_.Level -eq 4) -and
        ($Page.Category -ne "root" -or $_.Level -ne 2)
    } | Select-Object -First 4
    foreach ($h in $otherHubs) {
        $relPath = $prefix + $h.Path
        if ($relPath.EndsWith("/")) { $relPath += "index.html" }
        $html += "<li><a href=`"$($relPath)`">$($h.H1)</a></li>"
    }
    $html += "</ul>"
    
    return $html
}

# Helper: Generate Schema JSON-LD
function Get-Schema {
    param($Page)
    $url = $SiteBaseUrl + $Page.Path
    
    # WebApplication Schema
    $webApp = @{
        "@context" = "https://schema.org"
        "@type" = "WebApplication"
        "name" = $Page.H1
        "url" = $url
        "applicationCategory" = "UtilityApplication"
        "operatingSystem" = "All"
        "browserRequirements" = "Requires JavaScript. Requires HTML5."
        "offers" = @{
            "@type" = "Offer"
            "price" = "0.00"
            "priceCurrency" = "USD"
        }
    }
    
    # BreadcrumbList Schema
    $breadcrumbs = @{
        "@context" = "https://schema.org"
        "@type" = "BreadcrumbList"
        "itemListElement" = @()
    }
    
    # Add Home
    $breadcrumbs.itemListElement += @{
        "@type" = "ListItem"
        "position" = 1
        "name" = "Home"
        "item" = $SiteBaseUrl
    }
    
    if ($Page.Level -gt 1) {
        $parts = @($Page.Path.Split("/") | Where-Object { $_ -ne "" })
        $currentPath = ""
        for ($i = 0; $i -lt $parts.Count; $i++) {
            $part = $parts[$i]
            $currentPath += "$part/"
            $breadcrumbs.itemListElement += @{
                "@type" = "ListItem"
                "position" = ($i + 2)
                "name" = (Get-Culture).TextInfo.ToTitleCase($part.Replace("-", " "))
                "item" = ($SiteBaseUrl + $currentPath)
            }
        }
    }
    
    # FAQPage Schema
    $faqList = @()
    foreach ($faq in $Page.FAQs) {
        $faqList += @{
            "@type" = "Question"
            "name" = $faq.Q
            "acceptedAnswer" = @{
                "@type" = "Answer"
                "text" = $faq.A
            }
        }
    }
    $faqPage = @{
        "@context" = "https://schema.org"
        "@type" = "FAQPage"
        "mainEntity" = $faqList
    }
    
    # HowTo Schema
    $stepList = @()
    $pos = 1
    foreach ($step in $Page.HowTo) {
        $stepList += @{
            "@type" = "HowToStep"
            "position" = $pos
            "text" = $step
        }
        $pos++
    }
    $howTo = @{
        "@context" = "https://schema.org"
        "@type" = "HowTo"
        "name" = "How to generate a $($Page.H1)"
        "step" = $stepList
    }
    
    # Encode schemas
    $webAppJson = $webApp | ConvertTo-Json -Depth 5
    $breadcrumbsJson = $breadcrumbs | ConvertTo-Json -Depth 5
    $faqJson = $faqPage | ConvertTo-Json -Depth 5
    $howToJson = $howTo | ConvertTo-Json -Depth 5
    
    return @"
    <script type="application/ld+json">
    $webAppJson
    </script>
    <script type="application/ld+json">
    $breadcrumbsJson
    </script>
    <script type="application/ld+json">
    $faqJson
    </script>
    <script type="application/ld+json">
    $howToJson
    </script>
"@
}

# Loop and create all pages
foreach ($Page in $Pages) {
    $dirPath = "d:\1 hour in clg\" + $Page.Path
    
    # Skip exams/plumbing-license-prep
    if ($dirPath -like "*exams/plumbing-license-prep*") {
        Write-Host "Skipping protected path: $dirPath"
        continue
    }
    
    # Create directory if it doesn't exist
    if ($Page.Path -ne "" -and !(Test-Path -Path $dirPath)) {
        New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
    }
    
    $prefix = "../" * @($Page.Path.Split("/") | Where-Object { $_ -ne "" }).Count
    
    $canonicalUrl = $SiteBaseUrl + $Page.Path
    if ($Page.Path -ne "" -and !$canonicalUrl.EndsWith("/")) {
        $canonicalUrl += "/"
    }
    
    $breadcrumbsHtml = Get-Breadcrumbs -Page $Page
    $leftSidebarHtml = Get-LeftSidebar -Page $Page
    $rightSidebarHtml = Get-RightSidebar -Page $Page
    $schemasHtml = Get-Schema -Page $Page
    
    # Form display setup
    $activeTextTab = if ($Page.ActiveTab -eq "text") { "active" } else { "" }
    $activeUrlTab = if ($Page.ActiveTab -eq "url") { "active" } else { "" }
    $activeWifiTab = if ($Page.ActiveTab -eq "wifi") { "active" } else { "" }
    $activeVcardTab = if ($Page.ActiveTab -eq "vcard") { "active" } else { "" }
    $activeWhatsappTab = if ($Page.ActiveTab -eq "whatsapp") { "active" } else { "" }
    
    $displayTextStyle = if ($Page.ActiveTab -eq "text") { "block" } else { "none" }
    $displayUrlStyle = if ($Page.ActiveTab -eq "url") { "block" } else { "none" }
    $displayWifiStyle = if ($Page.ActiveTab -eq "wifi") { "block" } else { "none" }
    $displayVcardStyle = if ($Page.ActiveTab -eq "vcard") { "block" } else { "none" }
    $displayWhatsappStyle = if ($Page.ActiveTab -eq "whatsapp") { "block" } else { "none" }
    
    # Generate Sibling Level 5 navigation list for lateral links
    $lateralLinksHtml = ""
    if ($Page.Level -eq 5) {
        $lateralLinksHtml = "<div class=`"niche-tags-container`">"
        $lateralLinksHtml += "<h4>Explore Sibling Tools</h4>"
        $lateralLinksHtml += "<div class=`"niche-tags-list`">"
        
        $siblings = $Pages | Where-Object { $_.Category -eq $Page.Category -and $_.Level -eq 5 -and $_.Path -ne $Page.Path }
        foreach ($sib in $siblings) {
            $rel = $prefix + $sib.Path
            if ($rel.EndsWith("/")) { $rel += "index.html" }
            $lateralLinksHtml += "<a href=`"$rel`" class=`"niche-tag-link`">$($sib.H1)</a>"
        }
        $lateralLinksHtml += "</div></div>"
    }

    # Generate Explore All Categories footer tag section
    $exploreCategoriesHtml = "<div class=`"niche-tags-container`">"
    $exploreCategoriesHtml += "<h4>Explore Branded QR Code Resources</h4>"
    $exploreCategoriesHtml += "<div class=`"niche-tags-list`">"
    $exploreCategoriesHtml += "<a href=`"$($prefix)wifi/index.html`" class=`"niche-tag-link`">WiFi QR Code Generator</a>"
    $exploreCategoriesHtml += "<a href=`"$($prefix)link/index.html`" class=`"niche-tag-link`">Link to QR Code Converter</a>"
    $exploreCategoriesHtml += "<a href=`"$($prefix)vcard/index.html`" class=`"niche-tag-link`">vCard Contact QR Code Maker</a>"
    $exploreCategoriesHtml += "<a href=`"$($prefix)pdf/index.html`" class=`"niche-tag-link`">PDF to QR Code Generator</a>"
    $exploreCategoriesHtml += "<a href=`"$($prefix)social/index.html`" class=`"niche-tag-link`">Social Media QR Code Creator</a>"
    $exploreCategoriesHtml += "</div></div>"

    # Quick summary items
    $summaryHtml = ""
    foreach ($item in $Page.Takeaway) {
        $summaryHtml += "<li>$item</li>"
    }
    
    # FAQ accordion items
    $faqHtml = ""
    foreach ($faq in $Page.FAQs) {
        $faqHtml += @"
        <div class="faq-item">
            <div class="faq-question">$($faq.Q)</div>
            <div class="faq-answer">$($faq.A)</div>
        </div>
"@
    }
    
    # HTML Template
    $htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="$($Page.MetaDesc)">
    <title>$($Page.Title)</title>
    <link rel="stylesheet" href="$($prefix)style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="canonical" href="$canonicalUrl" />
    
    $schemasHtml
    
    <script>var relPrefix = "$prefix";</script>
</head>
<body>

    <!-- Header Navigation Menu -->
    <header>
        <div class="nav-container">
            <div class="logo">
                <a href="$($prefix)index.html">QRCode<span>Hub</span></a>
            </div>
            <nav aria-label="Main Navigation" class="main-nav">
                <ul class="nav-list">
                    <li><a href="$($prefix)index.html">Home</a></li>
                    <li class="has-dropdown">
                        <a href="$($prefix)wifi/index.html">WiFi QR &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="$($prefix)wifi/index.html">WiFi Generator</a></li>
                            <li><a href="$($prefix)wifi/setup/index.html">Connection Setup</a></li>
                            <li><a href="$($prefix)wifi/setup/android/index.html">Android WiFi Guide</a></li>
                            <li><a href="$($prefix)wifi/setup/android/home-network/free-tool/index.html">Home WiFi Tool</a></li>
                        </ul>
                    </li>
                    <li class="has-dropdown">
                        <a href="$($prefix)link/index.html">Link QR &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="$($prefix)link/index.html">Link Converter</a></li>
                            <li><a href="$($prefix)link/url-generator/index.html">URL to QR Guide</a></li>
                            <li><a href="$($prefix)link/url-generator/free/index.html">Free Link Tools</a></li>
                            <li><a href="$($prefix)link/url-generator/free/links/no-signup/index.html">Link No Signup</a></li>
                        </ul>
                    </li>
                    <li class="has-dropdown">
                        <a href="$($prefix)vcard/index.html">vCard QR &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="$($prefix)vcard/index.html">vCard Generator</a></li>
                            <li><a href="$($prefix)vcard/business-card/index.html">Business Card Guide</a></li>
                            <li><a href="$($prefix)vcard/business-card/free/index.html">Free VCard Tools</a></li>
                            <li><a href="$($prefix)vcard/business-card/free/contacts/digital-profile/index.html">Branded Business Cards</a></li>
                        </ul>
                    </li>
                    <li class="has-dropdown">
                        <a href="$($prefix)pdf/index.html">Document QR &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="$($prefix)pdf/index.html">PDF Converter</a></li>
                            <li><a href="$($prefix)pdf/document-generator/index.html">Document Guide</a></li>
                            <li><a href="$($prefix)pdf/document-generator/free/index.html">Free PDF Tools</a></li>
                            <li><a href="$($prefix)pdf/document-generator/free/files/google-drive/index.html">Google Drive to QR</a></li>
                        </ul>
                    </li>
                    <li class="has-dropdown">
                        <a href="$($prefix)social/index.html">Social QR &#9660;</a>
                        <ul class="dropdown">
                            <li><a href="$($prefix)social/index.html">Social Media Generator</a></li>
                            <li><a href="$($prefix)social/messaging/index.html">Messaging Chat QR</a></li>
                            <li><a href="$($prefix)social/messaging/whatsapp/index.html">WhatsApp Link Tool</a></li>
                            <li><a href="$($prefix)social/messaging/whatsapp/chat/chat-link/index.html">WhatsApp custom Logo</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="search-container">
                <span class="search-icon">&#128269;</span>
                <input type="text" id="header-search" class="search-input" placeholder="Search QR tools...">
                <div id="search-dropdown" class="search-results-dropdown"></div>
            </div>
        </div>
    </header>

    <main>
        <div class="page-layout">
            <!-- Left Sidebar (Vertical Silo Navigation) -->
            <aside class="sidebar-left">
                $leftSidebarHtml
            </aside>
            
            <!-- Central Main Content Column -->
            <div class="main-content">
                $breadcrumbsHtml
                
                <section class="hero">
                    <h1>$($Page.H1)</h1>
                    <p>$($Page.MetaDesc)</p>
                </section>
                
                <!-- Quick Takeaway Block -->
                <div class="takeaway-box">
                    <h4>Quick Summary &amp; Key Takeaways</h4>
                    <ul>
                        $summaryHtml
                    </ul>
                </div>
                
                <!-- Interactive Generator Widget -->
                <article class="glass-card">
                    <h2 style="margin-top:0; font-size: 1.4rem; margin-bottom: 1.5rem;">Configure Custom QR Code</h2>
                    
                    <div class="qr-widget-container">
                        <!-- Left: Inputs -->
                        <div class="qr-inputs-panel">
                            <div class="qr-tabs">
                                <button type="button" class="qr-tab-btn $activeUrlTab" data-mode="url">URL Link</button>
                                <button type="button" class="qr-tab-btn $activeTextTab" data-mode="text">Plain Text</button>
                                <button type="button" class="qr-tab-btn $activeWifiTab" data-mode="wifi">WiFi Network</button>
                                <button type="button" class="qr-tab-btn $activeVcardTab" data-mode="vcard">vCard Contact</button>
                                <button type="button" class="qr-tab-btn $activeWhatsappTab" data-mode="whatsapp">WhatsApp Chat</button>
                            </div>
                            
                            <!-- URL Field -->
                            <div id="fields-url" class="form-group-fields" style="display: $displayUrlStyle;">
                                <div class="input-group">
                                    <label for="input-url">Destination Link / Website URL</label>
                                    <input type="url" id="input-url" class="form-input" placeholder="e.g. www.example.com/file.pdf" value="https://eduprosuite-org.github.io/qrcode/">
                                </div>
                            </div>
                            
                            <!-- Text Field -->
                            <div id="fields-text" class="form-group-fields" style="display: $displayTextStyle;">
                                <div class="input-group">
                                    <label for="input-text">Raw Text Content</label>
                                    <textarea id="input-text" class="form-input" rows="3" placeholder="Enter custom message or code content..."></textarea>
                                </div>
                            </div>
                            
                            <!-- WiFi Fields -->
                            <div id="fields-wifi" class="form-group-fields" style="display: $displayWifiStyle;">
                                <div class="input-group" style="margin-bottom: 0.8rem;">
                                    <label for="wifi-ssid">WiFi Network Name (SSID)</label>
                                    <input type="text" id="wifi-ssid" class="form-input" placeholder="SSID Name" value="WiFi-Network">
                                </div>
                                <div class="input-group" style="margin-bottom: 0.8rem;">
                                    <label for="wifi-pass">WiFi Password (WPA/WEP)</label>
                                    <input type="password" id="wifi-pass" class="form-input" placeholder="Password">
                                </div>
                                <div class="control-row">
                                    <div class="input-group">
                                        <label for="wifi-enc">Security Protocol</label>
                                        <select id="wifi-enc" class="form-input" style="padding:0.7rem 0.8rem;">
                                            <option value="WPA">WPA/WPA2</option>
                                            <option value="WEP">WEP</option>
                                            <option value="nopass">None (Open)</option>
                                        </select>
                                    </div>
                                    <div class="input-group" style="justify-content: center; flex-direction:row; align-items:center; gap: 0.5rem; margin-top:1.2rem;">
                                        <input type="checkbox" id="wifi-hidden" style="width: 18px; height: 18px; cursor: pointer;">
                                        <label for="wifi-hidden" style="cursor: pointer; margin:0; text-transform:none;">Hidden Network</label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- vCard Fields -->
                            <div id="fields-vcard" class="form-group-fields" style="display: $displayVcardStyle;">
                                <div class="control-row" style="margin-bottom: 0.8rem;">
                                    <div class="input-group">
                                        <label for="vcard-first">First Name</label>
                                        <input type="text" id="vcard-first" class="form-input" placeholder="First Name" value="John">
                                    </div>
                                    <div class="input-group">
                                        <label for="vcard-last">Last Name</label>
                                        <input type="text" id="vcard-last" class="form-input" placeholder="Last Name" value="Doe">
                                    </div>
                                </div>
                                <div class="control-row" style="margin-bottom: 0.8rem;">
                                    <div class="input-group">
                                        <label for="vcard-phone">Mobile Phone</label>
                                        <input type="tel" id="vcard-phone" class="form-input" placeholder="+1234567890">
                                    </div>
                                    <div class="input-group">
                                        <label for="vcard-email">Email Address</label>
                                        <input type="email" id="vcard-email" class="form-input" placeholder="email@address.com">
                                    </div>
                                </div>
                                <div class="control-row" style="margin-bottom: 0.8rem;">
                                    <div class="input-group">
                                        <label for="vcard-org">Organization</label>
                                        <input type="text" id="vcard-org" class="form-input" placeholder="Company Name">
                                    </div>
                                    <div class="input-group">
                                        <label for="vcard-title">Job Title</label>
                                        <input type="text" id="vcard-title" class="form-input" placeholder="e.g. Director">
                                    </div>
                                </div>
                                <div class="control-row" style="margin-bottom: 0.8rem;">
                                    <div class="input-group">
                                        <label for="vcard-web">Website Link</label>
                                        <input type="url" id="vcard-web" class="form-input" placeholder="e.g. www.yoursite.com">
                                    </div>
                                    <div class="input-group">
                                        <label for="vcard-addr">Office Address</label>
                                        <input type="text" id="vcard-addr" class="form-input" placeholder="e.g. 100 Main St, NY">
                                    </div>
                                </div>
                            </div>
                            
                            <!-- WhatsApp Fields -->
                            <div id="fields-whatsapp" class="form-group-fields" style="display: $displayWhatsappStyle;">
                                <div class="input-group" style="margin-bottom: 0.8rem;">
                                    <label for="wa-phone">WhatsApp Number (with country code)</label>
                                    <input type="tel" id="wa-phone" class="form-input" placeholder="e.g. 15551234567" value="15551234567">
                                </div>
                                <div class="input-group">
                                    <label for="wa-message">Pre-Filled Welcome Message</label>
                                    <textarea id="wa-message" class="form-input" rows="2" placeholder="e.g. Hello, I would like to get a quote..."></textarea>
                                </div>
                            </div>
                            
                            <!-- Customisation Section -->
                            <div class="customization-section">
                                <div class="control-row">
                                    <div class="input-group">
                                        <label>Custom Colors</label>
                                        <div style="display:flex; gap:0.5rem;">
                                            <div class="color-picker-wrapper" style="flex:1;">
                                                <input type="color" id="qr-fg" class="color-input" value="#000000" title="Foreground Color">
                                                <span style="font-size:0.8rem; color:var(--text-secondary);">Dots</span>
                                            </div>
                                            <div class="color-picker-wrapper" style="flex:1;">
                                                <input type="color" id="qr-bg" class="color-input" value="#ffffff" title="Background Color">
                                                <span style="font-size:0.8rem; color:var(--text-secondary);">Card</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="input-group">
                                        <div class="range-slider-wrapper">
                                            <div class="range-slider-row">
                                                <label>QR Code Size</label>
                                                <span id="size-val">300x300</span>
                                            </div>
                                            <input type="range" id="qr-size" class="range-input" min="200" max="600" step="50" value="300" oninput="document.getElementById('size-val').textContent = this.value + 'x' + this.value">
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="input-group">
                                    <label>Add Branded Center Logo</label>
                                    <div class="logo-upload-box" id="logo-dropzone">
                                        <span>&#128194;</span>
                                        <p>Drag &amp; Drop Logo here or click to browse</p>
                                        <input type="file" id="logo-file" accept="image/png, image/jpeg" style="display:none;">
                                    </div>
                                    <div class="logo-preview-container" id="logo-preview-container" style="display:none;">
                                        <img id="logo-preview-img" class="logo-preview-img" alt="Branded Logo Preview">
                                        <span style="font-size:0.85rem; color:var(--text-secondary); flex-grow:1;">Branded Logo Embedded</span>
                                        <button type="button" id="remove-logo-btn" class="remove-logo-btn">Remove Logo</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Right: Output Canvas -->
                        <div class="qr-output-panel">
                            <div class="qr-canvas-container">
                                <canvas id="qr-canvas"></canvas>
                            </div>
                            <div class="qr-actions">
                                <button type="button" id="download-png" class="btn btn-primary">&#128190; Download PNG Image</button>
                                <button type="button" id="download-svg" class="btn btn-secondary">&#128396; Download Vector SVG</button>
                            </div>
                        </div>
                    </div>
                </article>
                
                <!-- Detailed Silo Article -->
                <section class="glass-card" style="margin-top:2rem;">
                    <h2>Overview of $($Page.H1)</h2>
                    <p>In modern digital environments, sharing information efficiently is a competitive advantage. This custom tool is designed to convert high-intent data strings into static scannable matrices conforming to ISO/IEC 18004 standards. Running completely locally in your client's web browser, it ensures 100% data safety, high privacy, and instantaneous execution speeds.</p>
                    
                    <h3>How it Works</h3>
                    <p>The matrix uses an algorithm to convert your text or parameters into modular grids of dark and light dots. Our generator embeds a correction matrix using the Reed-Solomon error correction algorithm. By forcing the correction level to 'H' (High), the generated QR code can lose up to 30% of its surface area (such as when a custom logo is overlayed in the center) and still retain full decoding capabilities on mobile device camera scanners.</p>
                    
                    <h3>Scanning Requirements</h3>
                    <p>Smartphone camera systems parse patterns by searching for three distinct square finder patterns in the corners of the code. To guarantee immediate scanning performance, ensure there is high contrast between the foreground dots and the background card. A quiet zone (margin) of at least 4 modules wide should surround the code to separate it from neighboring text or graphics.</p>
                </section>
                
                <!-- FAQ Accordion section -->
                <section class="glass-card">
                    <h2>Frequently Asked Questions</h2>
                    <div class="faq-container">
                        $faqHtml
                    </div>
                </section>
                
                <!-- Sibling lateral links (for Level 5 pages only) -->
                $lateralLinksHtml
                
                <!-- All category links for bottom-up flow -->
                $exploreCategoriesHtml
            </div>
            
            <!-- Right Sidebar (Contextual Utilities) -->
            <aside class="sidebar-right">
                $rightSidebarHtml
            </aside>
        </div>
    </main>

    <!-- Footer Area -->
    <footer>
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-col" style="grid-column: span 1;">
                    <h4>QRCodeHub</h4>
                    <p style="font-size:0.85rem; color:var(--text-secondary);">Interactive client-side QR code generator providing customized, print-ready vector SVG and PNG downloads with zero limits.</p>
                    <a href="$($prefix)index.html" style="font-weight:700; color:var(--primary);">Go back to Homepage</a>
                </div>
                <div class="footer-col">
                    <h4>QR Code Types</h4>
                    <ul>
                        <li><a href="$($prefix)wifi/index.html">WiFi Network</a></li>
                        <li><a href="$($prefix)link/index.html">Link / Website URL</a></li>
                        <li><a href="$($prefix)vcard/index.html">vCard Contact Card</a></li>
                        <li><a href="$($prefix)pdf/index.html">PDF Document</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Sitemaps</h4>
                    <ul>
                        <li><a href="$($prefix)sitemap_index.xml">Sitemap Index</a></li>
                        <li><a href="$($prefix)sitemap-wifi.xml">WiFi Sitemap</a></li>
                        <li><a href="$($prefix)sitemap-link.xml">Link Sitemap</a></li>
                        <li><a href="$($prefix)sitemap-vcard.xml">vCard Sitemap</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>Legal &amp; Info</h4>
                    <ul>
                        <li><a href="$($prefix)index.html">Privacy Policy</a></li>
                        <li><a href="$($prefix)index.html">Terms of Service</a></li>
                        <li><a href="$($prefix)index.html">Contact Us</a></li>
                        <li><a href="$($prefix)index.html">About Developer</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <div>&copy; 2026 QRCodeHub Portal. Built for eduprosuite. All rights reserved.</div>
                <div>Hosted statically on GitHub Pages. Proximity to GSC verification ready.</div>
            </div>
        </div>
    </footer>

    <!-- QRious JavaScript Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrious/4.0.2/qrious.min.js"></script>
    <script src="$($prefix)app.js"></script>
</body>
</html>
"@

    # Save to file
    $filePath = Join-Path $dirPath "index.html"
    [System.IO.File]::WriteAllText($filePath, $htmlContent, [System.Text.Encoding]::UTF8)
    Write-Host "Generated: $filePath"
}

Write-Host "`nAll 41 directory pages generated successfully!"
