# PowerShell Site Generator for Typing Speed Test & Content Hub (Tier 1 Focus)
# Workspace: d:\1 hour in clg\typing

$targetDir = Join-Path $PSScriptRoot "typing"
if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

Write-Host "Initializing Site Generation for eduprosuite-org/typing..." -ForegroundColor Cyan

# ----------------------------------------------------
# 1. WRITE CORE CSS (style.css)
# ----------------------------------------------------
$cssContent = @'
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap');

:root {
    --bg-primary: #090d16;
    --bg-secondary: #0f172a;
    --bg-card: rgba(30, 41, 59, 0.45);
    --border-color: rgba(255, 255, 255, 0.08);
    --text-primary: #f8fafc;
    --text-secondary: #94a3b8;
    --accent-teal: #14b8a6;
    --accent-indigo: #6366f1;
    --accent-indigo-glow: rgba(99, 102, 241, 0.15);
    --correct: #10b981;
    --incorrect: #ef4444;
    --incorrect-bg: rgba(239, 68, 68, 0.15);
    --cursor: #f59e0b;
    --max-width: 1200px;
    --font-sans: 'Inter', sans-serif;
    --font-mono: 'JetBrains Mono', monospace;
}

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    background-color: var(--bg-primary);
    color: var(--text-primary);
    font-family: var(--font-sans);
    line-height: 1.6;
    overflow-x: hidden;
}

header {
    background-color: var(--bg-secondary);
    border-bottom: 1px solid var(--border-color);
    position: sticky;
    top: 0;
    z-index: 1000;
    backdrop-filter: blur(8px);
}

.nav-container {
    max-width: var(--max-width);
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 1.5rem;
    height: 70px;
}

.logo-section a {
    color: var(--text-primary);
    text-decoration: none;
    font-size: 1.5rem;
    font-weight: 700;
    letter-spacing: -0.025em;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.logo-section a span {
    color: var(--accent-teal);
}

.nav-menu {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    list-style: none;
}

.nav-item {
    position: relative;
}

.nav-link {
    color: var(--text-secondary);
    text-decoration: none;
    font-weight: 500;
    font-size: 0.95rem;
    padding: 0.5rem 0.75rem;
    border-radius: 6px;
    transition: all 0.2s ease;
}

.nav-link:hover, .nav-item:hover .nav-link {
    color: var(--text-primary);
    background-color: rgba(255, 255, 255, 0.05);
}

.dropdown-menu {
    position: absolute;
    top: 100%;
    left: 0;
    background-color: var(--bg-secondary);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    padding: 0.5rem 0;
    min-width: 260px;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.3);
    opacity: 0;
    visibility: hidden;
    transform: translateY(10px);
    transition: all 0.2s ease;
}

.nav-item:hover .dropdown-menu {
    opacity: 1;
    visibility: visible;
    transform: translateY(0);
}

.dropdown-link {
    display: block;
    padding: 0.6rem 1.2rem;
    color: var(--text-secondary);
    text-decoration: none;
    font-size: 0.9rem;
    transition: all 0.2s ease;
}

.dropdown-link:hover {
    color: var(--text-primary);
    background-color: rgba(255, 255, 255, 0.05);
}

.search-wrapper {
    position: relative;
    width: 250px;
}

.search-input {
    width: 100%;
    padding: 0.5rem 1rem 0.5rem 2.2rem;
    background-color: rgba(255, 255, 255, 0.05);
    border: 1px solid var(--border-color);
    border-radius: 20px;
    color: var(--text-primary);
    font-size: 0.85rem;
    transition: all 0.3s ease;
}

.search-input:focus {
    outline: none;
    border-color: var(--accent-indigo);
    background-color: rgba(255, 255, 255, 0.08);
    box-shadow: 0 0 0 3px var(--accent-indigo-glow);
}

.search-icon {
    position: absolute;
    left: 0.75rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--text-secondary);
    pointer-events: none;
    width: 14px;
    height: 14px;
}

.search-results {
    position: absolute;
    top: 110%;
    right: 0;
    width: 320px;
    background-color: var(--bg-secondary);
    border: 1px solid var(--border-color);
    border-radius: 8px;
    max-height: 300px;
    overflow-y: auto;
    z-index: 1100;
    box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.4);
    display: none;
}

.search-result-item {
    display: block;
    padding: 0.75rem 1rem;
    color: var(--text-secondary);
    text-decoration: none;
    border-bottom: 1px solid rgba(255, 255, 255, 0.03);
    font-size: 0.85rem;
    transition: background-color 0.2s ease;
}

.search-result-item:hover {
    background-color: rgba(255, 255, 255, 0.05);
    color: var(--text-primary);
}

.layout-container {
    max-width: var(--max-width);
    margin: 2rem auto;
    padding: 0 1.5rem;
    display: grid;
    grid-template-columns: 260px 1fr;
    gap: 2.5rem;
}

.three-column-grid {
    grid-template-columns: 260px 1fr 280px;
}

.sidebar {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

.sidebar-title {
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: var(--text-secondary);
    margin-bottom: 0.75rem;
    font-weight: 700;
    border-bottom: 1px solid var(--border-color);
    padding-bottom: 0.5rem;
}

.sidebar-menu {
    list-style: none;
}

.sidebar-item {
    margin-bottom: 0.4rem;
}

.sidebar-link {
    display: block;
    color: var(--text-secondary);
    text-decoration: none;
    padding: 0.4rem 0.75rem;
    border-radius: 6px;
    font-size: 0.9rem;
    transition: all 0.2s ease;
}

.sidebar-link:hover {
    color: var(--text-primary);
    background-color: rgba(255, 255, 255, 0.04);
    padding-left: 1rem;
}

.sidebar-link.active {
    color: var(--accent-teal);
    background-color: rgba(20, 184, 166, 0.08);
    font-weight: 600;
}

main {
    min-width: 0;
}

.breadcrumbs {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    list-style: none;
    font-size: 0.8rem;
    color: var(--text-secondary);
    margin-bottom: 1.5rem;
}

.breadcrumbs a {
    color: var(--text-secondary);
    text-decoration: none;
    transition: color 0.2s;
}

.breadcrumbs a:hover {
    color: var(--text-primary);
}

.breadcrumbs li:not(:last-child)::after {
    content: "/";
    margin-left: 0.5rem;
    color: rgba(255, 255, 255, 0.2);
}

.breadcrumbs li:last-child {
    color: var(--accent-teal);
    font-weight: 500;
}

.takeaway-card {
    background: linear-gradient(135deg, rgba(99, 102, 241, 0.08), rgba(20, 184, 166, 0.05));
    border: 1px solid rgba(99, 102, 241, 0.2);
    border-radius: 12px;
    padding: 1.25rem 1.5rem;
    margin-bottom: 2rem;
    box-shadow: 0 4px 20px -2px rgba(0, 0, 0, 0.15);
}

.takeaway-title {
    font-size: 0.95rem;
    font-weight: 700;
    color: var(--text-primary);
    margin-bottom: 0.75rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.takeaway-list {
    list-style: none;
}

.takeaway-list li {
    font-size: 0.875rem;
    color: var(--text-secondary);
    margin-bottom: 0.5rem;
    padding-left: 1.25rem;
    position: relative;
}

.takeaway-list li::before {
    content: "•";
    color: var(--accent-teal);
    font-size: 1.2rem;
    position: absolute;
    left: 0;
    top: -0.1rem;
}

h1 {
    font-size: 2.25rem;
    font-weight: 800;
    letter-spacing: -0.03em;
    margin-bottom: 1rem;
    background: linear-gradient(to right, #fff, #94a3b8);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

p.intro-text {
    font-size: 1.125rem;
    color: var(--text-secondary);
    margin-bottom: 2rem;
}

.typing-wrapper {
    background: var(--bg-card);
    backdrop-filter: blur(12px);
    border: 1px solid var(--border-color);
    border-radius: 16px;
    padding: 2rem;
    margin-bottom: 2.5rem;
    position: relative;
    box-shadow: 0 20px 25px -5px rgba(0,0,0,0.25);
}

.stats-dashboard {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 1.25rem;
    margin-bottom: 2rem;
}

.stat-card {
    background-color: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255, 255, 255, 0.05);
    border-radius: 10px;
    padding: 1rem;
    text-align: center;
}

.stat-value {
    font-size: 2rem;
    font-weight: 700;
    font-family: var(--font-mono);
    color: var(--accent-teal);
    line-height: 1.2;
}

.stat-label {
    font-size: 0.75rem;
    text-transform: uppercase;
    color: var(--text-secondary);
    margin-top: 0.25rem;
    letter-spacing: 0.05em;
}

.text-display-box {
    background-color: #020617;
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 1.5rem;
    font-family: var(--font-mono);
    font-size: 1.3rem;
    line-height: 1.7;
    height: 180px;
    overflow-y: auto;
    position: relative;
    margin-bottom: 1.5rem;
    user-select: none;
    outline: none;
    cursor: text;
}

.focus-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(9, 13, 22, 0.9);
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 12px;
    font-size: 1.1rem;
    color: var(--text-secondary);
    cursor: pointer;
    transition: opacity 0.2s ease;
    z-index: 10;
    font-family: var(--font-sans);
}

.char {
    color: #475569;
    position: relative;
    transition: color 0.1s ease;
}

.char.correct {
    color: var(--correct);
}

.char.incorrect {
    color: var(--incorrect);
    background-color: var(--incorrect-bg);
}

.char.current {
    color: var(--text-primary);
    background-color: rgba(6, 182, 212, 0.15);
    border-left: 2px solid var(--cursor);
}

.typing-input-hidden {
    position: absolute;
    opacity: 0;
    pointer-events: none;
}

.controls-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
}

.test-settings {
    display: flex;
    gap: 0.75rem;
    align-items: center;
}

.settings-label {
    font-size: 0.85rem;
    color: var(--text-secondary);
}

.select-styled {
    background-color: var(--bg-secondary);
    border: 1px solid var(--border-color);
    color: var(--text-primary);
    padding: 0.5rem 1rem;
    border-radius: 8px;
    outline: none;
    font-size: 0.85rem;
    cursor: pointer;
}

.select-styled:focus {
    border-color: var(--accent-indigo);
}

.btn-primary {
    background: linear-gradient(135deg, var(--accent-indigo), var(--accent-teal));
    color: #ffffff;
    border: none;
    padding: 0.6rem 1.5rem;
    border-radius: 8px;
    font-weight: 600;
    font-size: 0.9rem;
    cursor: pointer;
    transition: all 0.2s ease;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
}

.btn-primary:hover {
    opacity: 0.95;
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);
}

.guide-section {
    margin-bottom: 2.5rem;
}

.guide-section h2 {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 1rem;
    color: var(--text-primary);
    border-left: 3px solid var(--accent-teal);
    padding-left: 0.75rem;
}

.guide-section p {
    color: var(--text-secondary);
    margin-bottom: 1rem;
    font-size: 0.975rem;
}

.guide-section ul, .guide-section ol {
    margin-left: 1.5rem;
    margin-bottom: 1rem;
    color: var(--text-secondary);
    font-size: 0.975rem;
}

.guide-section li {
    margin-bottom: 0.5rem;
}

.faq-card {
    background-color: rgba(255, 255, 255, 0.01);
    border: 1px solid var(--border-color);
    border-radius: 10px;
    padding: 1.25rem;
    margin-bottom: 1rem;
}

.faq-question {
    font-size: 1rem;
    font-weight: 600;
    color: var(--text-primary);
    margin-bottom: 0.5rem;
}

.faq-answer {
    font-size: 0.9rem;
    color: var(--text-secondary);
}

.lateral-links-card {
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid var(--border-color);
    border-radius: 12px;
    padding: 1.5rem;
    margin: 2.5rem 0;
}

.lateral-links-title {
    font-size: 1rem;
    font-weight: 700;
    margin-bottom: 1rem;
    color: var(--text-primary);
}

.lateral-links-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 1rem;
}

.lateral-link-item {
    background: rgba(255, 255, 255, 0.02);
    border: 1px solid rgba(255,255,255,0.03);
    border-radius: 8px;
    padding: 1rem;
    text-decoration: none;
    transition: all 0.2s ease;
    display: flex;
    flex-direction: column;
}

.lateral-link-item:hover {
    border-color: var(--accent-indigo);
    background: rgba(99, 102, 241, 0.05);
}

.lateral-link-title {
    font-size: 0.9rem;
    font-weight: 600;
    color: var(--text-primary);
    margin-bottom: 0.25rem;
}

.lateral-link-desc {
    font-size: 0.75rem;
    color: var(--text-secondary);
}

footer {
    background-color: var(--bg-secondary);
    border-top: 1px solid var(--border-color);
    padding: 4rem 1.5rem 2rem;
    margin-top: 5rem;
}

.footer-container {
    max-width: var(--max-width);
    margin: 0 auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 2.5rem;
    margin-bottom: 3rem;
}

.footer-column h3 {
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: var(--text-primary);
    margin-bottom: 1.25rem;
    font-weight: 700;
}

.footer-links {
    list-style: none;
}

.footer-links li {
    margin-bottom: 0.6rem;
}

.footer-links a {
    color: var(--text-secondary);
    text-decoration: none;
    font-size: 0.85rem;
    transition: color 0.2s;
}

.footer-links a:hover {
    color: var(--text-primary);
}

.footer-info {
    text-align: center;
    border-top: 1px solid rgba(255, 255, 255, 0.05);
    padding-top: 1.5rem;
    font-size: 0.8rem;
    color: var(--text-secondary);
}

@media (max-width: 1024px) {
    .layout-container {
        grid-template-columns: 1fr;
    }
    
    .three-column-grid {
        grid-template-columns: 1fr;
    }
    
    .sidebar {
        order: 2;
    }
}

@media (max-width: 768px) {
    .nav-container {
        flex-direction: column;
        height: auto;
        padding: 1rem;
        gap: 1rem;
    }
    
    .nav-menu {
        flex-wrap: wrap;
        justify-content: center;
        gap: 1rem;
    }
    
    .search-wrapper {
        width: 100%;
    }
    
    .stats-dashboard {
        grid-template-columns: repeat(2, 1fr);
    }
    
    h1 {
        font-size: 1.75rem;
    }
}
'@

$cssPath = Join-Path $targetDir "style.css"
$cssContent | Out-File -FilePath $cssPath -Encoding utf8 -Force
Write-Host "Created style.css successfully." -ForegroundColor Green

# ----------------------------------------------------
# 2. WRITE CLIENT-SIDE JS ENGINE (app.js)
# ----------------------------------------------------
$jsContent = @'
document.addEventListener("DOMContentLoaded", () => {
    const TEXT_DATASETS = {
        "standard": "The quick brown fox jumps over the lazy dog. Typing is an essential skill in the modern digital workplace. Developing speed and accuracy requires consistent practice and proper hand posture. Touch typing allows you to type without looking at the keyboard, which increases your overall productivity and reduces strain on your neck and eyes. Always try to keep your wrists level and use all ten fingers on the home row keys. Regular practice sessions of just fifteen minutes a day can dramatically improve your words per minute score over time.",
        "clerk-steno": "This memorandum serves to notify all administrative staff regarding the upcoming quarterly reviews. Please ensure that all client reports, meeting minutes, and financial statements are updated and filed in the database by Friday afternoon. The executive board will evaluate departmental efficiency, budget compliance, and service performance. Your cooperation in completing these tasks in a timely and professional manner is highly appreciated.",
        "administrative": "The administrative assistant is responsible for coordinating office schedules, managing incoming correspondence, and preparing official documents. Daily tasks include answering inquiries, organizing file storage systems, and scheduling travel arrangements. Strong communication skills and attention to detail are required to maintain smooth daily operations and support organizational goals.",
        "court-reporter": "Q: State your full name for the record. A: My name is Robert Vance. Q: Were you present at the scene of the incident on the night of November twelfth? A: Yes, I was standing near the intersection. Q: Describe what you observed at approximately ten o'clock PM. A: I saw a silver sedan traveling northbound at a high rate of speed. It failed to stop at the red light and collided with the delivery truck. Q: Did you call emergency services immediately? A: Yes, I dialed nine one one.",
        "keystroke-kph": "AC-9827 10/14/2026 582.40 USD TX-8371 11/20/2026 120.50 USD KB-2938 12/05/2026 890.00 USD NY-4829 01/18/2027 45.12 USD CA-9281 02/22/2027 312.99 USD FL-7362 03/15/2027 1500.00 USD IL-3829 04/10/2027 99.95 USD GA-1029 05/01/2027 670.30 USD MA-5829 06/12/2027 432.88 USD OH-7281 07/04/2027 89.00 USD",
        "10-key-data": "48291 58291 10294 85739 20491 58204 93821 57392 10294 85930 29381 48201 58392 10294 75839 20481 58204 93821 57392 10294 85930 29381 48201 58392 10294 75839 20481 58204 93821 57392 10294 85930"
    };

    const SITE_PAGES = [
        { title: "Typing Test Home - WPM/CPM Speed Calculator", url: "https://eduprosuite-org.github.io/typing/" },
        { title: "Civil Service & Professional Exams Guide Hub", url: "https://eduprosuite-org.github.io/typing/govt-exams/" },
        { title: "Civil Service Typing Standards & Formats", url: "https://eduprosuite-org.github.io/typing/govt-exams/civil-service/" },
        { title: "US Federal Clerical Typing Exams Guide", url: "https://eduprosuite-org.github.io/typing/govt-exams/civil-service/federal/" },
        { title: "Federal Clerk/Stenographer Typing Speed Simulator", url: "https://eduprosuite-org.github.io/typing/govt-exams/civil-service/federal/clerk-steno/practice-test/" },
        { title: "Federal Clerk/Stenographer Study & Grading Rules", url: "https://eduprosuite-org.github.io/typing/govt-exams/civil-service/federal/clerk-steno/study-guide/" },
        { title: "State & Municipal Typing Exams Guide", url: "https://eduprosuite-org.github.io/typing/govt-exams/civil-service/state-local/" },
        { title: "State Administrative Assistant Typing Practice Test", url: "https://eduprosuite-org.github.io/typing/govt-exams/civil-service/state-local/administrative/practice-test/" },
        { title: "State Administrative Assistant Exam Study Guide", url: "https://eduprosuite-org.github.io/typing/govt-exams/civil-service/state-local/administrative/study-guide/" },
        { title: "Professional Licensing Office Typing Hub", url: "https://eduprosuite-org.github.io/typing/govt-exams/professional/" },
        { title: "Court Reporter & Judicial Typing Exam Guide", url: "https://eduprosuite-org.github.io/typing/govt-exams/professional/judicial/" },
        { title: "Court Reporter Practice Test - Legal Typing Simulator", url: "https://eduprosuite-org.github.io/typing/govt-exams/professional/judicial/court-reporter/practice-test/" },
        { title: "Court Reporter Grading Criteria & WPM Guide", url: "https://eduprosuite-org.github.io/typing/govt-exams/professional/judicial/court-reporter/study-guide/" },
        { title: "Employment Data Entry Placement Tests Guide", url: "https://eduprosuite-org.github.io/typing/govt-exams/professional/data-entry/" },
        { title: "Keystrokes Per Hour (KPH) Data Entry Simulator", url: "https://eduprosuite-org.github.io/typing/govt-exams/professional/data-entry/keystroke-kph/practice-test/" },
        { title: "Data Entry Speed Standards (KPH) Study Guide", url: "https://eduprosuite-org.github.io/typing/govt-exams/professional/data-entry/keystroke-kph/study-guide/" },
        { title: "Standard Typing Speed Tests Directory", url: "https://eduprosuite-org.github.io/typing/speed-tests/" },
        { title: "Time-Based Typing Speed Tests Hub", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/" },
        { title: "Minute-Interval Speed Tests Directory", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/minutes/" },
        { title: "1 Minute Typing Speed Test - WPM Simulator", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/minutes/1-minute/practice-test/" },
        { title: "1 Minute Speed Optimization Tips & Study Guide", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/minutes/1-minute/study-guide/" },
        { title: "5 Minute Typing Speed Test - WPM Practice Simulator", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/minutes/5-minute/practice-test/" },
        { title: "5 Minute Pace & Endurance Development Study Guide", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/minutes/5-minute/study-guide/" },
        { title: "10 Minute Typing Speed Test - Exam WPM Simulator", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/minutes/10-minute/practice-test/" },
        { title: "10 Minute Typing Stamina & Grading Study Guide", url: "https://eduprosuite-org.github.io/typing/speed-tests/duration/minutes/10-minute/study-guide/" },
        { title: "Typing Skill Keyboards & Practice Hub", url: "https://eduprosuite-org.github.io/typing/speed-tests/skills/" },
        { title: "Numeric 10-Key Keystrokes & Keypad Practice", url: "https://eduprosuite-org.github.io/typing/speed-tests/skills/keypad/" },
        { title: "10-Key Numeric Typing Test - Keystrokes Simulator", url: "https://eduprosuite-org.github.io/typing/speed-tests/skills/keypad/10-key-data/practice-test/" },
        { title: "10-Key Touch Typing Standards & Placement Guide", url: "https://eduprosuite-org.github.io/typing/speed-tests/skills/keypad/10-key-data/study-guide/" },
        { title: "English Alphabetic & Paragraph Typing Hub", url: "https://eduprosuite-org.github.io/typing/speed-tests/skills/alphabet/" },
        { title: "English Pro Paragraph Typing Speed Test Simulator", url: "https://eduprosuite-org.github.io/typing/speed-tests/skills/alphabet/english-pro/practice-test/" },
        { title: "English Paragraph Typing Speed Rules & Study Guide", url: "https://eduprosuite-org.github.io/typing/speed-tests/skills/alphabet/english-pro/study-guide/" }
    ];

    const searchInput = document.getElementById("nav-search-input");
    const searchResults = document.getElementById("search-results");

    if (searchInput && searchResults) {
        searchInput.addEventListener("input", (e) => {
            const query = e.target.value.toLowerCase().trim();
            searchResults.innerHTML = "";
            if (query.length < 2) {
                searchResults.style.display = "none";
                return;
            }

            const matches = SITE_PAGES.filter(page => 
                page.title.toLowerCase().includes(query)
            );

            if (matches.length > 0) {
                matches.forEach(match => {
                    const item = document.createElement("a");
                    item.href = match.url;
                    item.className = "search-result-item";
                    item.textContent = match.title;
                    searchResults.appendChild(item);
                });
                searchResults.style.display = "block";
            } else {
                const noResult = document.createElement("div");
                noResult.className = "search-result-item";
                noResult.style.color = "var(--text-secondary)";
                noResult.textContent = "No tests found.";
                searchResults.appendChild(noResult);
                searchResults.style.display = "block";
            }
        });

        document.addEventListener("click", (e) => {
            if (!searchInput.contains(e.target) && !searchResults.contains(e.target)) {
                searchResults.style.display = "none";
            }
        });
    }

    const wrapper = document.querySelector(".typing-wrapper");
    if (!wrapper) return;

    const textDisplay = document.getElementById("text-display");
    const typingInput = document.getElementById("typing-input");
    const focusOverlay = document.getElementById("focus-overlay");
    const wpmVal = document.getElementById("wpm-val");
    const cpmVal = document.getElementById("cpm-val");
    const accuracyVal = document.getElementById("accuracy-val");
    const timerVal = document.getElementById("timer-val");
    const timerSelect = document.getElementById("timer-select");
    const restartBtn = document.getElementById("restart-btn");

    const testType = wrapper.getAttribute("data-test-type") || "standard";
    const rawTargetText = TEXT_DATASETS[testType] || TEXT_DATASETS["standard"];
    
    let timer = 60;
    let timeElapsed = 0;
    let timerInterval = null;
    let isTestRunning = false;
    let totalTyped = 0;
    let correctKeystrokes = 0;

    function initText() {
        textDisplay.innerHTML = "";
        rawTargetText.split("").forEach(char => {
            const span = document.createElement("span");
            span.className = "char";
            span.textContent = char;
            textDisplay.appendChild(span);
        });
        if (textDisplay.firstChild) {
            textDisplay.firstChild.classList.add("current");
        }
    }

    function startTimer() {
        if (isTestRunning) return;
        isTestRunning = true;
        if (timerSelect) timerSelect.disabled = true;

        timerInterval = setInterval(() => {
            timer--;
            timeElapsed++;
            if (timerVal) timerVal.textContent = timer + "s";
            
            calculateMetrics();

            if (timer <= 0) {
                endTest();
            }
        }, 1000);
    }

    function calculateMetrics() {
        const timeInMin = timeElapsed / 60 || 0.01;
        const wpm = Math.round((correctKeystrokes / 5) / timeInMin);
        const cpm = Math.round(correctKeystrokes / timeInMin);
        const kph = Math.round(totalTyped / (timeElapsed / 3600 || 0.0001));
        const accuracy = totalTyped > 0 ? Math.round((correctKeystrokes / totalTyped) * 100) : 100;

        if (wpmVal) {
            if (testType === "10-key-data" || testType === "keystroke-kph") {
                wpmVal.textContent = kph;
                const parent = wpmVal.closest(".stat-card");
                if (parent) parent.querySelector(".stat-label").textContent = "KPH (Keystrokes)";
            } else {
                wpmVal.textContent = wpm;
            }
        }

        if (cpmVal) {
            cpmVal.textContent = cpm;
        }

        if (accuracyVal) {
            accuracyVal.textContent = accuracy + "%";
        }
    }

    function endTest() {
        clearInterval(timerInterval);
        typingInput.disabled = true;
        calculateMetrics();
        alert(`Test complete! Final results compiled.`);
    }

    function resetTest() {
        clearInterval(timerInterval);
        isTestRunning = false;
        if (timerSelect) {
            timer = parseInt(timerSelect.value);
            timerSelect.disabled = false;
        } else {
            const wrapperDuration = wrapper.getAttribute("data-duration");
            timer = wrapperDuration ? parseInt(wrapperDuration) : 60;
        }
        timeElapsed = 0;
        totalTyped = 0;
        correctKeystrokes = 0;
        
        if (timerVal) timerVal.textContent = timer + "s";
        if (wpmVal) wpmVal.textContent = "0";
        if (cpmVal) cpmVal.textContent = "0";
        if (accuracyVal) accuracyVal.textContent = "100%";
        
        typingInput.value = "";
        typingInput.disabled = false;
        initText();
        
        focusOverlay.style.opacity = "1";
        focusOverlay.style.pointerEvents = "auto";
    }

    typingInput.addEventListener("input", () => {
        if (timer <= 0) return;
        startTimer();

        const typedText = typingInput.value;
        const spans = textDisplay.querySelectorAll(".char");
        totalTyped = typedText.length;

        correctKeystrokes = 0;
        spans.forEach((span, idx) => {
            span.className = "char";
            if (idx === typedText.length) {
                span.classList.add("current");
            }
            if (idx < typedText.length) {
                if (typedText[idx] === span.textContent) {
                    span.classList.add("correct");
                    correctKeystrokes++;
                } else {
                    span.classList.add("incorrect");
                }
            }
        });

        calculateMetrics();

        if (typedText.length >= rawTargetText.length) {
            endTest();
        }
    });

    focusOverlay.addEventListener("click", () => {
        focusOverlay.style.opacity = "0";
        focusOverlay.style.pointerEvents = "none";
        typingInput.focus();
    });

    typingInput.addEventListener("blur", () => {
        if (timer > 0 && !isTestRunning) {
            focusOverlay.style.opacity = "1";
            focusOverlay.style.pointerEvents = "auto";
        }
    });

    if (timerSelect) {
        timerSelect.addEventListener("change", () => {
            timer = parseInt(timerSelect.value);
            if (timerVal) timerVal.textContent = timer + "s";
        });
    }

    if (restartBtn) {
        restartBtn.addEventListener("click", resetTest);
    }

    resetTest();
});
'@

$jsPath = Join-Path $targetDir "app.js"
$jsContent | Out-File -FilePath $jsPath -Encoding utf8 -Force
Write-Host "Created app.js successfully." -ForegroundColor Green

# ----------------------------------------------------
# 3. DEFINE TAXONOMY DATA
# ----------------------------------------------------
$pages = @()

# 3.1 Homepage (Level 1)
$pages += @{
    Path = ""
    Title = "Typing Speed Test Online - Free WPM & Accuracy Calculator"
    Desc = "Test your typing speed online. Calculate words per minute (WPM), characters per minute (CPM), and accuracy in real-time with customizable timers and professional datasets."
    Depth = 0
    IsTool = $true
    TestType = "standard"
    Takeaway = @("Instantly measure your core typing speed (WPM) and accuracy.", "Includes customizable duration timers ranging from 1 to 10 minutes.", "Pure client-side JavaScript execution with zero latency or cookies.")
    Content = @'
<h1>Free Online Typing Speed Test</h1>
<p class="intro-text">Welcome to TypingPro, the ultimate clean and lightweight client-side typing simulator. Measure your Words Per Minute (WPM) and keystroke accuracy against standardized English paragraphs. Select a preset timer to test your endurance, or explore standard office placement and civil service exam prep modules in the sidebars.</p>
'@
    Faqs = @()
    Howto = @()
}

# 3.2 Main Categories (Level 2)
$pages += @{
    Path = "govt-exams"
    Title = "Civil Service & Professional Office Typing Exam Hub"
    Desc = "Prepare for professional and civil service typing exams in the US, UK, Canada, and Australia. Practice with standardized simulators and study scoring guidelines."
    Depth = 1
    IsTool = $false
    Takeaway = @("Comprehensive resources for civil service, court reporter, and data entry exams.", "Outlines exact words per minute (WPM) and keystrokes per hour (KPH) targets.", "Exclusive vertical left sidebar detailing all exam sub-categories.")
    Content = @'
<h1>Civil Service & Professional Office Typing Exam Hub</h1>
<p class="intro-text">Standardized typing and keyboard skills tests are a critical benchmark for government, administrative, and legal professions. Discover practice simulators and guides tailored to federal, state, and specialized judicial exams.</p>
<div class="guide-section">
    <h2>Explore Tier 1 Job Certifications</h2>
    <p>Use the Left Sidebar to navigate directly to your target exam prep silo. Our testing categories are organized into three primary areas:</p>
    <ul>
        <li><strong>Civil Service (Federal & State):</strong> Standard WPM benchmarks for federal clerks, steno roles, and administrative assistant positions.</li>
        <li><strong>Judicial & Legal (Court Reporters):</strong> High-speed transcription and steno training benchmarks for courtrooms.</li>
        <li><strong>Placement & Clerical (Data Entry):</strong> Alphanumeric and numerical keypad assessments focused on Keystrokes Per Hour (KPH).</li>
    </ul>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests"
    Title = "Standard Typing Speed Tests - WPM & Accuracy Simulators"
    Desc = "Practice standard typing speed tests. Track WPM and CPM across multiple intervals and check your alphabetic and numeric keypad accuracy online."
    Depth = 1
    IsTool = $false
    Takeaway = @("Standard typing assessments ranging from 1 to 10 minutes.", "Dedicated numeric keypad (10-key) and paragraph skill simulators.", "Clean, distraction-free environment for pure typing practice.")
    Content = @'
<h1>Standard Typing Speed Tests</h1>
<p class="intro-text">Improve your everyday keyboard productivity and typing mechanics. Choose from duration-based simulators to build stamina, or keypad tests to optimize your alphanumeric data entry accuracy.</p>
<div class="guide-section">
    <h2>Typing Speed Test Categorization</h2>
    <p>Navigate through the Left Sidebar to explore specific practice categories:</p>
    <ul>
        <li><strong>Duration Tests:</strong> 1-minute, 5-minute, and 10-minute speed tests designed to develop pacing, muscle memory, and stamina.</li>
        <li><strong>Skill-Specific Keyboards:</strong> Numeric 10-key keypad and alphabetic paragraph tests to refine high-accuracy touch typing.</li>
    </ul>
</div>
'@
    Faqs = @()
    Howto = @()
}

# 3.3 Sub-Categories (Level 3)
$pages += @{
    Path = "govt-exams/civil-service"
    Title = "Civil Service Typing Exams & WPM Benchmarks"
    Desc = "Discover civil service typing speed requirements, federal clerk testing criteria, and administrative assistant practice simulators."
    Depth = 2
    IsTool = $false
    Takeaway = @("Covers both US Federal and State-level clerical typing tests.", "Details typical WPM and error-rate calculations used by examiners.", "Practice tests simulate real civil service exam text formats.")
    Content = @'
<h1>Civil Service Typing Exams & Benchmarks</h1>
<p class="intro-text">Civil service typing tests measure candidate speed and accuracy to qualify for clerical, administrative, and public office roles. Learn the guidelines and practice with realistic prompts.</p>
<div class="guide-section">
    <h2>US Federal & State Requirements</h2>
    <p>Administrative and clerk positions usually require a minimum speed threshold of 35 to 45 Words Per Minute (WPM) with a 95% or higher accuracy rating. We provide dedicated practice paths for:</p>
    <ul>
        <li><strong>Federal Clerk/Stenographer:</strong> High-reliability clerical assessments.</li>
        <li><strong>State Administrative Assistant:</strong> Focuses on daily operational drafting, speed, and pacing.</li>
    </ul>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/professional"
    Title = "Office & Professional Office Typing Certifications"
    Desc = "Master professional-level typing tests including judicial court reporter speed requirements and corporate data entry KPH benchmarks."
    Depth = 2
    IsTool = $false
    Takeaway = @("Focuses on judicial stenography, legal typists, and corporate clerks.", "Details data entry metrics measured in Keystrokes Per Hour (KPH).", "Tailored training resources for high-speed professional certifications.")
    Content = @'
<h1>Office & Professional Office Typing Certifications</h1>
<p class="intro-text">Certain specialized careers require typing speeds far exceeding standard benchmarks. Explore the requirements and simulator tools for professional legal and data entry positions.</p>
<div class="guide-section">
    <h2>Specialized Keyboarding Standards</h2>
    <p>Select your specialized practice niche in the Left Sidebar:</p>
    <ul>
        <li><strong>Court Reporter:</strong> Requires high WPM rates and precise legal transcription structures.</li>
        <li><strong>Data Entry (KPH):</strong> Focuses on rapid alphanumeric data input measured in Keystrokes Per Hour (KPH) rather than WPM.</li>
    </ul>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/duration"
    Title = "Time-Based Typing Speed Tests Directory"
    Desc = "Select from 1-minute, 5-minute, and 10-minute online typing speed tests to measure WPM, CPM, and error rates in real-time."
    Depth = 2
    IsTool = $false
    Takeaway = @("Standard testing durations preferred by schools and employers.", "Tracks real-time WPM, CPM, and keystroke accuracy.", "Simulators work on all desktop and mobile web browsers.")
    Content = @'
<h1>Time-Based Typing Speed Tests</h1>
<p class="intro-text">The length of a typing test heavily impacts pacing and accuracy. Select a testing duration below to practice maintainable typing speed and develop keyboard endurance.</p>
<div class="guide-section">
    <h2>Choose Your Testing Duration</h2>
    <ul>
        <li><strong>1 Minute Speed Test:</strong> Ideal for rapid warmups and checking raw speed.</li>
        <li><strong>5 Minute Speed Test:</strong> Standard interval for job screening and classroom checks.</li>
        <li><strong>10 Minute Speed Test:</strong> The ultimate endurance test for civil service and professional exams.</li>
    </ul>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/skills"
    Title = "Typing Skill Keyboards & Practice Hub"
    Desc = "Develop specialized keyboard skills. Practice with numeric 10-key keypad tests and professional English paragraph tests."
    Depth = 2
    IsTool = $false
    Takeaway = @("Targeted practice for specific areas of the computer keyboard.", "10-Key numeric testing for financial and accounting roles.", "Advanced alphabetic paragraph tests for content writers.")
    Content = @'
<h1>Typing Skill Keyboards & Practice Hub</h1>
<p class="intro-text">General typing speed is composed of distinct technical skills. Refine your numerical data entry using 10-key touch practice, or optimize your alphabetic flow with paragraph simulators.</p>
<div class="guide-section">
    <h2>Keypad vs. Alphabetic Keyboards</h2>
    <p>Target your weakness and practice specialized keyboarding:</p>
    <ul>
        <li><strong>Numeric Keypad (10-Key):</strong> Focuses on numeric keystroke speed (KPH) using only the right-hand keypad.</li>
        <li><strong>Alphabet Paragraphs:</strong> Develops rhythm, punctuation speed, and sentence flow.</li>
    </ul>
</div>
'@
    Faqs = @()
    Howto = @()
}

# 3.4 Sub-Sub-Categories (Level 4)
$pages += @{
    Path = "govt-exams/civil-service/federal"
    Title = "US Federal Clerical Typing Exams - Guidelines & Simulators"
    Desc = "Learn about US Federal government clerical typing speed assessments, steno tests, and WPM scoring rules."
    Depth = 3
    IsTool = $false
    Takeaway = @("Federal civil service clerical positions require a certified typing test.", "Minimum speed benchmark is 40 WPM for clerk-stenographer roles.", "Features guidelines on how federal examiners calculate typing errors.")
    Content = @'
<h1>US Federal Clerical Typing Exams</h1>
<p class="intro-text">Candidates applying for federal clerical and stenographer positions must pass a standardized keyboarding exam. Learn what to expect and access practice materials.</p>
<div class="guide-section">
    <h2>Federal Clerk Requirements</h2>
    <p>Under federal guidelines, typing tests are administered to verify that clerks can type at a minimum speed of 40 WPM with an accuracy rate of 95% or higher. Examinees are given custom business correspondence texts to transcribe. Practice using the Left Sidebar links.</p>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/civil-service/state-local"
    Title = "State & Municipal Typing Exams - Practice & WPM Benchmarks"
    Desc = "Prepare for state-level and local municipal civil service typing tests. Check administrative assistant WPM speed requirements."
    Depth = 3
    IsTool = $false
    Takeaway = @("Prepares candidates for state, county, and local municipal exams.", "Focuses on administrative assistant and office clerk placement tests.", "Learn pacing strategies to avoid formatting errors during the exam.")
    Content = @'
<h1>State & Municipal Typing Exams</h1>
<p class="intro-text">State and local municipal governments administer typing speed tests to qualify candidates for administrative roles. Access our study materials and practice tests in the sidebar.</p>
<div class="guide-section">
    <h2>State Administrative Guidelines</h2>
    <p>State examinations typically require typing speeds of 35 to 45 WPM. Candidates are tested on data entry accuracy, layout formatting, and general transcription. Regular practice builds the muscle memory needed to pass on the first attempt.</p>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/professional/judicial"
    Title = "Court Reporter & Judicial Typing Exam Guide"
    Desc = "Master courtroom keyboarding requirements. Learn about stenographer certifications, legal clerk steno speed requirements, and WPM standards."
    Depth = 3
    IsTool = $false
    Takeaway = @("Court reporters use specialized stenotype and high-speed QWERTY boards.", "State certifications require speeds ranging from 60 to 225+ WPM.", "Study guides explain legal transcription standards and notation formats.")
    Content = @'
<h1>Court Reporter & Judicial Typing Exam Guide</h1>
<p class="intro-text">Judicial typing assessments, including courtroom stenography and legal secretary clerk tests, represent the highest speed tier in professional keyboarding. Discover requirements and practice tests below.</p>
<div class="guide-section">
    <h2>Judicial Keyboarding Standards</h2>
    <p>Court reporters transcribe spoken dialogue in real-time. QWERTY typing tests for judicial clerks require a minimum of 60 WPM, while specialized stenography certifications demand speeds of 180 to 225 WPM with 97% accuracy.</p>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/professional/data-entry"
    Title = "Data Entry & Clerical Placement Tests - KPH Standards"
    Desc = "Understand clerical placement requirements. Learn how Keystrokes Per Hour (KPH) is calculated and practice with alphanumeric datasets."
    Depth = 3
    IsTool = $false
    Takeaway = @("Corporate placement exams assess alphanumeric input speed in KPH.", "Keyboards require high-accuracy usage of both numbers and letters.", "Standard benchmarks require 8,000 to 10,000 Keystrokes Per Hour.")
    Content = @'
<h1>Data Entry & Clerical Placement Tests</h1>
<p class="intro-text">Corporate and industrial data entry placement tests assess your alphanumeric typing speed. Unlike standard prose tests, these exams focus heavily on mixed codes, invoice formats, and KPH metrics.</p>
<div class="guide-section">
    <h2>Keystrokes Per Hour (KPH) Benchmarks</h2>
    <p>Data entry speed is calculated by dividing total keystrokes by the time elapsed. 8,000 KPH is the standard clerical benchmark, while advanced positions require 10,000 to 12,000 KPH. Transcribing mixed numbers, uppercase codes, and text lines requires high focus.</p>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/duration/minutes"
    Title = "Minute-Interval Speed Tests Directory"
    Desc = "Choose from standard minute-interval typing speed tests. Track WPM and CPM over 1-minute, 5-minute, and 10-minute intervals."
    Depth = 3
    IsTool = $false
    Takeaway = @("Interval tests allow developers and students to check stamina.", "Tracks performance drops over extended typing sessions.", "Standardized text database resets on every session.")
    Content = @'
<h1>Minute-Interval Speed Tests</h1>
<p class="intro-text">Pacing is key to maintaining a high WPM score. Select a minute-interval test from the Left Sidebar to warm up or test your long-term keyboard stamina.</p>
<div class="guide-section">
    <h2>Standardized Intervals</h2>
    <ul>
        <li><strong>1 Minute:</strong> Focuses on burst speed and muscle memory.</li>
        <li><strong>5 Minutes:</strong> Standard hiring and educational screening test length.</li>
        <li><strong>10 Minutes:</strong> Tests typing posture, focus, and stamina.</li>
    </ul>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/skills/keypad"
    Title = "Numeric 10-Key Keystrokes & Keypad Practice"
    Desc = "Improve your numeric keypad speed. Practice 10-key touch typing online, calculate numeric KPH, and improve numeric accuracy."
    Depth = 3
    IsTool = $false
    Takeaway = @("Focuses exclusively on the right-hand numeric keypad (10-key).", "Teaches touch-typing positioning for numbers 0 through 9.", "Indispensable for finance, data entry, and database administration.")
    Content = @'
<h1>Numeric 10-Key Keystrokes & Keypad Practice</h1>
<p class="intro-text">The numeric keypad requires a unique touch typing layout. Learn the home row position for the 10-key keypad and practice numeric datasets to improve your clerical speed.</p>
<div class="guide-section">
    <h2>10-Key Numeric Touch Typing</h2>
    <p>Place your right index, middle, and ring fingers on the 4, 5, and 6 keys (the home row). Use the index finger for 1, 4, 7; middle finger for 2, 5, 8; and ring finger for 3, 6, 9. Use the thumb for 0 and the pinky for the Enter key. Consistent practice builds rapid numerical input speed.</p>
</div>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/skills/alphabet"
    Title = "English Alphabetic & Paragraph Typing Hub"
    Desc = "Refine your prose typing. Practice with complex alphabetic paragraphs to improve finger coordination and punctuation speed."
    Depth = 3
    IsTool = $false
    Takeaway = @("Utilizes English paragraphs with standard punctuation and capitalization.", "Improves sentence rhythm and reduces errors on transition keys.", "Measures typing speed in standard Words Per Minute (WPM).")
    Content = @'
<h1>English Alphabetic & Paragraph Typing</h1>
<p class="intro-text">Prose typing speed is built upon transitioning fluidly between words. Practice using complex paragraph templates to build natural sentence rhythm and keyboard speed.</p>
<div class="guide-section">
    <h2>Fluid Prose Keyboarding</h2>
    <p>Unlike short word drills, paragraph tests introduce capital letters, commas, periods, and apostrophes. This teaches you to incorporate the Shift keys and outer-ring punctuation keys into your muscle memory without breaking your flow.</p>
</div>
'@
    Faqs = @()
    Howto = @()
}

# 3.5 Deep Level 5 Pages (Interactive Tools & Study Guides)

# 3.5.1 Federal Clerk/Steno
$pages += @{
    Path = "govt-exams/civil-service/federal/clerk-steno/practice-test"
    Title = "Federal Clerk & Stenographer Typing Test Simulator"
    Desc = "Practice the US Federal Clerk & Stenographer typing speed test online. Calculate WPM and accuracy on government clerical texts."
    Depth = 5
    IsTool = $true
    TestType = "clerk-steno"
    Takeaway = @("Simulates the exact text formatting used in federal clerical exams.", "Displays real-time WPM, CPM, and character accuracy.", "Requires a target score of 40 WPM or higher to pass.")
    Content = @'
<h1>Federal Clerk & Stenographer Practice Test</h1>
<p class="intro-text">This interactive simulator uses official civil service style texts. Click inside the display box below and begin typing. Keep your wrists level and use a steady pace to maintain high accuracy.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/civil-service/federal/clerk-steno/study-guide"
    Title = "Federal Clerk/Stenographer Exam Study Guide & Rules"
    Desc = "Study US Federal government typing speed test rules, scoring methods, and evaluation criteria. Prepare for clerk-stenographer exams."
    Depth = 5
    IsTool = $false
    Takeaway = @("Outlines the official scoring and error deduction rules.", "Explains the difference between net speed and gross WPM.", "Provides step-by-step methods to improve transcription focus.")
    Content = @'
<h1>Federal Clerk/Stenographer Exam Study Guide</h1>
<p class="intro-text">Passing the US Federal typing test requires understanding the specific scoring rules and grading metrics used by federal examiners. Review our comprehensive guide below.</p>
<div class="guide-section">
    <h2>Scoring & Error Calculation Rules</h2>
    <p>Federal typing tests calculate <strong>Net WPM</strong>. The formula used is:</p>
    <p><code>Net WPM = (Total Keystrokes / 5 - Errors) / Test Duration (Minutes)</code></p>
    <p>For example, if you type 2,000 keystrokes (400 gross words) in a 5-minute test and make 5 errors, your Net WPM is: <code>(400 - 5) / 5 = 79 WPM</code>.</p>
    <ul>
        <li><strong>What Counts as a Full Error:</strong> Misspelled words, omitted words, inserted words, and formatting errors (such as forgetting to capitalize).</li>
        <li><strong>Passing Threshold:</strong> A minimum of 40 Net WPM is required for most clerk-stenographer positions.</li>
    </ul>
</div>
'@
    Faqs = @(
        @{ q = "What is the minimum passing typing speed for federal clerk jobs?"; a = "The standard minimum speed is 40 Net WPM on a 5-minute test with 95% accuracy." },
        @{ q = "How are errors penalized on the federal steno typing exam?"; a = "Each error deducts one full word from your total word count before dividing by the time in minutes." },
        @{ q = "Are there formatting requirements in federal exams?"; a = "Yes, capitalization, spacing, and punctuation must match the source text exactly. Deviations count as errors." }
    )
    Howto = @(
        "Maintain proper posture by keeping your spine straight and wrists elevated above the home row.",
        "Focus on accuracy first. Keep your speed under control; making errors penalizes your score heavily.",
        "Practice daily for 15-20 minutes with business correspondence datasets."
    )
}

# 3.5.2 State Admin
$pages += @{
    Path = "govt-exams/civil-service/state-local/administrative/practice-test"
    Title = "State Administrative Assistant Typing Practice Test"
    Desc = "Take a free state administrative assistant typing practice test. Measure your WPM, CPM, and accuracy on administrative text templates."
    Depth = 5
    IsTool = $true
    TestType = "administrative"
    Takeaway = @("Simulates municipal and state clerk exam text structures.", "Measures real-time typing speed and accuracy.", "Allows duration adjustments (1 to 10 minutes) for custom practice.")
    Content = @'
<h1>State Administrative Assistant Practice Test</h1>
<p class="intro-text">Start practicing for your state or local municipal administrative assistant typing test. Use the simulator below to check your WPM. Aim for 35 to 45 WPM with high accuracy.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/civil-service/state-local/administrative/study-guide"
    Title = "State Administrative Assistant Exam Study Guide"
    Desc = "Read state and municipal typing speed test requirements and study advice for administrative assistant candidates."
    Depth = 5
    IsTool = $false
    Takeaway = @("Lists typical state civil service typing test durations.", "Details administrative keyboarding accuracy benchmarks.", "Provides tips on managing keyboard test anxiety during the exam.")
    Content = @'
<h1>State Administrative Assistant Study Guide</h1>
<p class="intro-text">State and local clerical exams test a candidate's keyboarding proficiency. Learn how state agencies grade typing speed and follow our practice tips to succeed.</p>
<div class="guide-section">
    <h2>Exam Formats & Evaluation Criteria</h2>
    <p>State agencies generally use a 3-minute or 5-minute typing test. The scoring system evaluates:</p>
    <ul>
        <li><strong>Gross Speed:</strong> Total words typed in the time limit.</li>
        <li><strong>Accuracy:</strong> Percentage of correctly typed characters. The minimum acceptable accuracy is 95%.</li>
        <li><strong>Formatting:</strong> Transcribing paragraph breaks and double spacing when required.</li>
    </ul>
</div>
'@
    Faqs = @(
        @{ q = "What typing speed do state administrative assistant jobs require?"; a = "Most state clerical jobs require a typing speed between 35 and 45 Gross WPM with a minimum 95% accuracy rate." },
        @{ q = "How long are state civil service typing tests?"; a = "They are typically 3 or 5 minutes long, depending on the municipality." }
    )
    Howto = @(
        "Warm up your fingers with light typing exercises for 5 minutes before the exam.",
        "Pace yourself. Do not rush the first paragraph; establish a steady rhythm instead.",
        "Practice touch typing without looking at the keyboard to maintain eye contact with the source text."
    )
}

# 3.5.3 Court Reporter
$pages += @{
    Path = "govt-exams/professional/judicial/court-reporter/practice-test"
    Title = "Court Reporter Legal Typing Practice Test"
    Desc = "Practice legal typing online. Real-time courtroom transcript typing test simulator to measure your WPM and steno accuracy."
    Depth = 5
    IsTool = $true
    TestType = "court-reporter"
    Takeaway = @("Simulates legal testimony and dialog transcripts.", "Calculates real-time words per minute and error tracking.", "Designed for court reporter candidates and legal typists.")
    Content = @'
<h1>Court Reporter Practice Test</h1>
<p class="intro-text">Use the Q&A dialog simulator below to test your legal transcription flow. Legal typing requires adapting to conversational dialogue formats quickly.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/professional/judicial/court-reporter/study-guide"
    Title = "Court Reporter Certification & Grading Study Guide"
    Desc = "Explore courtroom keyboarding requirements, legal steno certifications, and court reporter speed standards."
    Depth = 5
    IsTool = $false
    Takeaway = @("Details NCRA certification speed standards.", "Explains judicial transcript layouts and shorthand rules.", "Offers advice on transition from QWERTY to stenotype keyboards.")
    Content = @'
<h1>Court Reporter Certification Study Guide</h1>
<p class="intro-text">Becoming a certified court reporter requires passing high-speed transcription exams. Learn about the standards and evaluation criteria used by national certification boards.</p>
<div class="guide-section">
    <h2>Stenography & QWERTY Standards</h2>
    <p>The National Court Reporters Association (NCRA) certifies reporters through several exams:</p>
    <ul>
        <li><strong>Registered Professional Reporter (RPR):</strong> Requires transcribing literary text at 180 WPM, jury charge at 200 WPM, and testimony/Q&A dialog at 225 WPM.</li>
        <li><strong>Legal Secretary/Typist:</strong> QWERTY keyboard tests usually require 60 to 70 WPM on legal correspondence.</li>
    </ul>
</div>
'@
    Faqs = @(
        @{ q = "How fast must a court reporter type?"; a = "Professional stenotype operators must type up to 225 WPM. Legal typists using QWERTY keyboards require 60 to 70 WPM." },
        @{ q = "What accuracy rate is required for court reporter certification?"; a = "The NCRA RPR certification requires a minimum accuracy rate of 97%." }
    )
    Howto = @(
        "Familiarize yourself with legal terminology to avoid pausing on unfamiliar words.",
        "Practice double-space formatting and capitalizing speaker identifiers (Q and A).",
        "Train with audio recordings to build real-time conversational transcription speeds."
    )
}

# 3.5.4 KPH Data Entry
$pages += @{
    Path = "govt-exams/professional/data-entry/keystroke-kph/practice-test"
    Title = "Keystrokes Per Hour (KPH) Data Entry Simulator"
    Desc = "Take a free alphanumeric data entry typing test. Calculate your keystrokes per hour (KPH) and placement test accuracy."
    Depth = 5
    IsTool = $true
    TestType = "keystroke-kph"
    Takeaway = @("Measures alphanumeric KPH speed and character accuracy.", "Includes mixed text, numbers, codes, and uppercase sequences.", "Simulates standard pre-employment clerical placement tests.")
    Content = @'
<h1>Keystrokes Per Hour (KPH) Simulator</h1>
<p class="intro-text">Alphanumeric data entry is measured in Keystrokes Per Hour (KPH) rather than WPM. Focus on transcribing codes, dates, and currency values correctly in the tool below.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "govt-exams/professional/data-entry/keystroke-kph/study-guide"
    Title = "Data Entry Speed Standards (KPH) Study Guide"
    Desc = "Study corporate data entry speed standards, pre-employment KPH requirements, and alphanumeric keyboarding tips."
    Depth = 5
    IsTool = $false
    Takeaway = @("Explains the KPH metrics used by corporate recruiters.", "Outlines typical alphanumeric typing test structures.", "Provides tips on using the numeric keypad alongside standard keys.")
    Content = @'
<h1>Data Entry KPH Speed Standards Guide</h1>
<p class="intro-text">Data entry positions require typing alphanumeric strings with 100% accuracy. Learn how employers measure KPH and discover strategies to improve your placement scores.</p>
<div class="guide-section">
    <h2>Calculating Keystrokes Per Hour (KPH)</h2>
    <p>KPH measures the total number of characters typed in an hour. The formula is:</p>
    <p><code>KPH = Total Keystrokes / (Duration in Seconds / 3600)</code></p>
    <ul>
        <li><strong>Standard Clerk Speed:</strong> 8,000 KPH (approx. 27 WPM with complex characters).</li>
        <li><strong>High-Speed Clerk:</strong> 10,000 to 12,000 KPH (approx. 33-40 WPM on mixed data).</li>
        <li><strong>Deduction Rules:</strong> Errors are heavily penalized in pre-employment screenings, often discarding records with a single incorrect character.</li>
    </ul>
</div>
'@
    Faqs = @(
        @{ q = "What is a good KPH speed for data entry?"; a = "A speed of 8,000 KPH is considered standard for entry-level jobs, while 10,000+ KPH is expected for advanced roles." },
        @{ q = "How do you convert WPM to KPH?"; a = "As a rule of thumb, multiply your WPM by 300 to estimate your KPH on standard text. (e.g. 40 WPM x 300 = 12,000 KPH)." }
    )
    Howto = @(
        "Utilize a standard QWERTY keyboard with a dedicated physical numeric keypad.",
        "Keep your left hand positioned on the alphabetic keyboard and your right hand on the numeric keypad.",
        "Minimize looking back and forth between the screen and the data sheet to prevent transcription errors."
    )
}

# 3.5.5 WPM Tests (1m, 5m, 10m)
$pages += @{
    Path = "speed-tests/duration/minutes/1-minute/practice-test"
    Title = "1 Minute Typing Speed Test - Free Online WPM Simulator"
    Desc = "Take a free 1-minute typing speed test online. Calculate WPM, CPM, and character accuracy with this quick warm-up tool."
    Depth = 5
    IsTool = $true
    TestType = "standard"
    Takeaway = @("Quick 60-second typing warmup simulator.", "Measures raw speed (WPM) and visual character highlights.", "Resets immediately for continuous practice.")
    Content = @'
<h1>1 Minute Typing Speed Test</h1>
<p class="intro-text">Warm up your fingers with our 1-minute typing test. This quick simulator is excellent for testing burst speed, new mechanical keyboard layouts, or just daily checks.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/duration/minutes/1-minute/study-guide"
    Title = "1 Minute Speed Optimization Tips & Study Guide"
    Desc = "Learn how to optimize your 1-minute typing test speed. Discover finger warmups, posture tips, and pacing techniques."
    Depth = 5
    IsTool = $false
    Takeaway = @("Warmup exercises to prepare fingers for speed bursts.", "Techniques to eliminate cognitive pauses between letters.", "Analysis of standard keyboard key layout travel times.")
    Content = @'
<h1>1-Minute Typing Speed Guide</h1>
<p class="intro-text">Optimizing speed on a 1-minute typing test requires maximizing your burst speed and minimizing finger transition latency. Read our techniques below to break your speed records.</p>
<div class="guide-section">
    <h2>Burst Speed vs. Stamina</h2>
    <p>A 1-minute typing test represents a sprint. Pacing is less important than raw finger velocity. To maximize speed, make sure you are touch typing correctly with all ten fingers and keeping your keyboard clean to prevent key travel delays.</p>
</div>
'@
    Faqs = @(
        @{ q = "What is a good score on a 1-minute typing test?"; a = "A score of 40 WPM is average, 60 WPM is professional, and 100+ WPM is elite." }
    )
    Howto = @(
        "Perform light finger stretches before typing to improve flexibility.",
        "Maintain visual focus on the word ahead of the one you are currently typing.",
        "Avoid using your wrists to drive finger movements; keep wrists steady."
    )
}

$pages += @{
    Path = "speed-tests/duration/minutes/5-minute/practice-test"
    Title = "5 Minute Typing Speed Test - Free Practice Simulator"
    Desc = "Take a 5-minute online typing test. Build pacing and accuracy over a standard corporate and educational testing duration."
    Depth = 5
    IsTool = $true
    TestType = "standard"
    Takeaway = @("Standard 5-minute educational test duration.", "Helps candidates build pacing and control on prose text.", "Tracks WPM, CPM, and keystroke errors in real-time.")
    Content = @'
<h1>5 Minute Typing Speed Test</h1>
<p class="intro-text">The 5-minute typing test is the standard length preferred by educational systems and employment recruiters. Focus on maintaining a steady rhythm to minimize error rates.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/duration/minutes/5-minute/study-guide"
    Title = "5 Minute Pace & Endurance Development Study Guide"
    Desc = "Improve your 5-minute typing endurance. Read study guides and pacing techniques for standard employment keyboard screenings."
    Depth = 5
    IsTool = $false
    Takeaway = @("Establishes sustainable typing pace guides.", "Techniques to prevent finger cramping and fatigue.", "Explains how typing speed decreases over 5-minute intervals.")
    Content = @'
<h1>5-Minute Typing Pace & Stamina Guide</h1>
<p class="intro-text">Typing at high speeds for 5 minutes requires developing physical stamina and steady pacing. Read our guide to learn how to prevent fatigue and maintain consistency.</p>
<div class="guide-section">
    <h2>Developing Keyboarding Stamina</h2>
    <p>During a 5-minute typing test, many candidates experience a sharp decrease in speed after the third minute due to finger fatigue. To counter this, keep your shoulders relaxed, wrists elevated, and breathe steadily. Focus on a rhythm that feels comfortable rather than sprinting.</p>
</div>
'@
    Faqs = @(
        @{ q = "Why do 5-minute typing tests matter for jobs?"; a = "Most employers use a 5-minute test because it measures consistent pacing and focus, which are critical for office productivity." }
    )
    Howto = @(
        "Establish a comfortable rhythmic cadence (e.g., tap-tap-tap-tap) and try to maintain it.",
        "Relax your grip on the keys; do not strike keys harder than necessary.",
        "Practice typing without pauses, making smooth transitions between sentences."
    )
}

$pages += @{
    Path = "speed-tests/duration/minutes/10-minute/practice-test"
    Title = "10 Minute Typing Speed Test - Professional Simulator"
    Desc = "Take a professional 10-minute typing speed test online. Build advanced keyboard endurance and accuracy on standard prose."
    Depth = 5
    IsTool = $true
    TestType = "standard"
    Takeaway = @("Advanced 10-minute endurance typing test.", "Measures focus drops and physical typing fatigue over time.", "Calculates exact final words per minute and error totals.")
    Content = @'
<h1>10 Minute Typing Speed Test</h1>
<p class="intro-text">Prepare for the ultimate keyboarding endurance test. The 10-minute typing test is used for high-standard clerk and steno certifications. Stay relaxed and focus on accuracy.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/duration/minutes/10-minute/study-guide"
    Title = "10 Minute Typing Stamina & Grading Study Guide"
    Desc = "Prepare for 10-minute typing tests. Study guidelines on posture, focus maintenance, and high-stamina touch typing."
    Depth = 5
    IsTool = $false
    Takeaway = @("Detailed posture guides to prevent repetitive strain injuries (RSI).", "Strategies for maintaining cognitive focus on long texts.", "Explains how typing error rates escalate during long sessions.")
    Content = @'
<h1>10-Minute Typing Endurance Guide</h1>
<p class="intro-text">Passing a 10-minute typing speed test requires more than speed; it requires physical ergonomics and mental focus. Learn the techniques to maintain 98%+ accuracy for the full 10 minutes.</p>
<div class="guide-section">
    <h2>Ergonomics & Ergonomic Alignment</h2>
    <p>When typing for 10 minutes, poor ergonomics can lead to wrist fatigue, shoulder tension, and increased typing errors. Position your keyboard at elbow height, keep your wrists straight (do not rest them on the table while typing), and place your feet flat on the floor. This provides a solid foundation for high-speed touch typing.</p>
</div>
'@
    Faqs = @(
        @{ q = "How do you maintain focus on a 10-minute typing test?"; a = "Avoid looking at your WPM score during the test. Read the text one sentence at a time and maintain a steady breath." }
    )
    Howto = @(
        "Set up an ergonomic workspace with keyboard, chair, and screen at proper heights.",
        "Take deep, steady breaths to keep your heart rate calm and prevent typing anxiety.",
        "Practice 10-minute sessions twice a day to build standard keyboard stamina."
    )
}

# 3.5.6 10-Key Numeric
$pages += @{
    Path = "speed-tests/skills/keypad/10-key-data/practice-test"
    Title = "10-Key Numeric Keypad Typing Speed Test"
    Desc = "Take a free 10-key numeric typing test. Calculate your numeric keypad keystrokes per hour (KPH) and data entry accuracy."
    Depth = 5
    IsTool = $true
    TestType = "10-key-data"
    Takeaway = @("Measures numeric keypad speed (KPH) and accuracy.", "Uses numerical lists simulating accounting and invoice data logs.", "Clean interface with focus indicators for continuous practice.")
    Content = @'
<h1>10-Key Numeric Keypad Practice Test</h1>
<p class="intro-text">Place your hand on your numeric keypad and begin transcribing the numbers below. This test measures your numeric Keystrokes Per Hour (KPH). Focus on accuracy to prevent decimal errors.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/skills/keypad/10-key-data/study-guide"
    Title = "10-Key Touch Typing Standards & Placement Guide"
    Desc = "Improve your numeric keypad speed. Read study guides, home row layout references, and touch-typing tips for numbers."
    Depth = 5
    IsTool = $false
    Takeaway = @("Lists key layout placements for the standard numeric keypad.", "Explains how 10-key touch typing speed is evaluated.", "Outlines typical pre-employment thresholds for financial roles.")
    Content = @'
<h1>10-Key Numeric Keypad Study Guide</h1>
<p class="intro-text">The numeric keypad (10-key) is an essential tool for bookkeeping, data entry, and accounting. Learn how to touch type numbers without looking at your hand.</p>
<div class="guide-section">
    <h2>10-Key Home Row Position</h2>
    <p>Just like standard keyboarding, the numeric keypad uses a home row. The <strong>5 key</strong> features a raised physical bump. Place your middle finger on 5, index finger on 4, and ring finger on 6. Your pinky finger handles the Enter and mathematical operator keys (+, -), while your thumb presses the 0 key.</p>
</div>
'@
    Faqs = @(
        @{ q = "What is a good 10-key speed in KPH?"; a = "A speed of 8,000 KPH is average, while 10,000 to 12,000 KPH is expected for experienced accounting clerks." }
    )
    Howto = @(
        "Rest your hand on the numeric keypad home row (4, 5, 6) and use the physical bump on 5 to align your hand.",
        "Keep your eyes on the numbers you are transcribing, never look down at the keypad.",
        "Practice using the right-hand numeric keypad daily to build numeric muscle memory."
    )
}

# 3.5.7 English Prose
$pages += @{
    Path = "speed-tests/skills/alphabet/english-pro/practice-test"
    Title = "English Pro Paragraph Typing Speed Test Simulator"
    Desc = "Practice advanced English paragraph typing. Test WPM and accuracy on literary texts with punctuation and capitalization."
    Depth = 5
    IsTool = $true
    TestType = "standard"
    Takeaway = @("Uses real English paragraph templates with complex sentences.", "Calculates exact words per minute and error tracking.", "Helps developers, writers, and students check core prose speed.")
    Content = @'
<h1>English Pro Paragraph Practice Test</h1>
<p class="intro-text">Improve your everyday sentence typing. This simulator uses complex English paragraphs containing capital letters, punctuation marks, and diverse word lengths to check your prose speed.</p>
'@
    Faqs = @()
    Howto = @()
}

$pages += @{
    Path = "speed-tests/skills/alphabet/english-pro/study-guide"
    Title = "English Paragraph Typing Speed Rules & Study Guide"
    Desc = "Improve your prose typing speed. Learn about keyboard spacing, punctuation transitions, and standard English WPM grading rules."
    Depth = 5
    IsTool = $false
    Takeaway = @("Explains the standard 5-character word calculation logic.", "Details tips on managing shift keys for rapid capitalization.", "Outlines pacing guidelines to maintain consistent prose flow.")
    Content = @'
<h1>English Paragraph Keyboarding Guide</h1>
<p class="intro-text">Typing standard English prose requires managing spacing, capitalization, and punctuation fluidly. Learn how to maintain high speed when writing paragraphs.</p>
<div class="guide-section">
    <h2>Shift Key & Punctuation Transitions</h2>
    <p>Many keyboarders lose speed when hitting capital letters or punctuation marks. To prevent this, always use the opposite hand's Shift key to capitalize a letter (e.g., use the Left Shift key for letters typed with the right hand, and vice versa). Keep your fingers relaxed when reaching for commas, periods, and apostrophes.</p>
</div>
'@
    Faqs = @(
        @{ q = "How is a 'Word' defined in standard typing tests?"; a = "A word is defined as exactly 5 keystrokes, including spaces and punctuation marks. This standardizes scoring across varying word lengths." }
    )
    Howto = @(
        "Coordinate your left and right Shift keys to capitalize letters fluidly.",
        "Keep a light, flexible touch on the keyboard to speed up reach movements to outer keys.",
        "Analyze which punctuation transitions slow down your flow and run short targeted drill sessions."
    )
}

# ----------------------------------------------------
# 4. SITE GENERATION LOOP
# ----------------------------------------------------
foreach ($page in $pages) {
    # Determine the directory path
    $pageDir = $targetDir
    if ($page.Path -ne "") {
        $pageDir = Join-Path $targetDir $page.Path
    }
    
    if (-not (Test-Path $pageDir)) {
        New-Item -ItemType Directory -Path $pageDir -Force | Out-Null
    }
    
    # Calculate depth relative paths
    $depth = $page.Depth
    $rootRel = "./"
    if ($depth -eq 1) { $rootRel = "../" }
    elseif ($depth -eq 2) { $rootRel = "../../" }
    elseif ($depth -eq 3) { $rootRel = "../../../" }
    elseif ($depth -eq 5) { $rootRel = "../../../../../" }
    
    $canonicalUrl = "https://eduprosuite-org.github.io/typing/"
    if ($page.Path -ne "") {
        $canonicalUrl = "https://eduprosuite-org.github.io/typing/" + $page.Path + "/"
    }
    
    # Render Left Sidebar (Parent-child structural links only)
    $leftSidebarHtml = ""
    if ($page.Path -like "govt-exams*") {
        $leftSidebarHtml = @"
        <div class="sidebar">
            <h3 class="sidebar-title">Exams Silo</h3>
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="${rootRel}" class="sidebar-link">Homepage</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/" class="sidebar-link $(if($page.Path -eq "govt-exams"){"active"})">Exams Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/" class="sidebar-link $(if($page.Path -eq "govt-exams/civil-service"){"active"})">Civil Service</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/federal/" class="sidebar-link $(if($page.Path -eq "govt-exams/civil-service/federal"){"active"})">Federal Exams</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/federal/clerk-steno/practice-test/" class="sidebar-link $(if($page.Path -eq "govt-exams/civil-service/federal/clerk-steno/practice-test"){"active"})">Clerk/Steno Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/federal/clerk-steno/study-guide/" class="sidebar-link $(if($page.Path -eq "govt-exams/civil-service/federal/clerk-steno/study-guide"){"active"})">Clerk/Steno Guide</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/state-local/" class="sidebar-link $(if($page.Path -eq "govt-exams/civil-service/state-local"){"active"})">State/Local Exams</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/state-local/administrative/practice-test/" class="sidebar-link $(if($page.Path -eq "govt-exams/civil-service/state-local/administrative/practice-test"){"active"})">Administrative Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/state-local/administrative/study-guide/" class="sidebar-link $(if($page.Path -eq "govt-exams/civil-service/state-local/administrative/study-guide"){"active"})">Administrative Guide</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/" class="sidebar-link $(if($page.Path -eq "govt-exams/professional"){"active"})">Professional Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/judicial/" class="sidebar-link $(if($page.Path -eq "govt-exams/professional/judicial"){"active"})">Judicial Exams</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/judicial/court-reporter/practice-test/" class="sidebar-link $(if($page.Path -eq "govt-exams/professional/judicial/court-reporter/practice-test"){"active"})">Court Reporter Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/judicial/court-reporter/study-guide/" class="sidebar-link $(if($page.Path -eq "govt-exams/professional/judicial/court-reporter/study-guide"){"active"})">Court Reporter Guide</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/data-entry/" class="sidebar-link $(if($page.Path -eq "govt-exams/professional/data-entry"){"active"})">Data Entry Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/data-entry/keystroke-kph/practice-test/" class="sidebar-link $(if($page.Path -eq "govt-exams/professional/data-entry/keystroke-kph/practice-test"){"active"})">KPH Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/data-entry/keystroke-kph/study-guide/" class="sidebar-link $(if($page.Path -eq "govt-exams/professional/data-entry/keystroke-kph/study-guide"){"active"})">KPH Guide</a></li>
            </ul>
        </div>
"@
    } elseif ($page.Path -like "speed-tests*") {
        $leftSidebarHtml = @"
        <div class="sidebar">
            <h3 class="sidebar-title">Speed Tests Silo</h3>
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="${rootRel}" class="sidebar-link">Homepage</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/" class="sidebar-link $(if($page.Path -eq "speed-tests"){"active"})">Speed Tests Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration"){"active"})">Time-Based Tests</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration/minutes"){"active"})">Minute Intervals</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/1-minute/practice-test/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration/minutes/1-minute/practice-test"){"active"})">1 Min Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/1-minute/study-guide/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration/minutes/1-minute/study-guide"){"active"})">1 Min Guide</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/5-minute/practice-test/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration/minutes/5-minute/practice-test"){"active"})">5 Min Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/5-minute/study-guide/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration/minutes/5-minute/study-guide"){"active"})">5 Min Guide</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/10-minute/practice-test/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration/minutes/10-minute/practice-test"){"active"})">10 Min Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/10-minute/study-guide/" class="sidebar-link $(if($page.Path -eq "speed-tests/duration/minutes/10-minute/study-guide"){"active"})">10 Min Guide</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/" class="sidebar-link $(if($page.Path -eq "speed-tests/skills"){"active"})">Skills Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/keypad/" class="sidebar-link $(if($page.Path -eq "speed-tests/skills/keypad"){"active"})">Keypad Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/keypad/10-key-data/practice-test/" class="sidebar-link $(if($page.Path -eq "speed-tests/skills/keypad/10-key-data/practice-test"){"active"})">10-Key Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/keypad/10-key-data/study-guide/" class="sidebar-link $(if($page.Path -eq "speed-tests/skills/keypad/10-key-data/study-guide"){"active"})">10-Key Guide</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/alphabet/" class="sidebar-link $(if($page.Path -eq "speed-tests/skills/alphabet"){"active"})">Alphabet Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/alphabet/english-pro/practice-test/" class="sidebar-link $(if($page.Path -eq "speed-tests/skills/alphabet/english-pro/practice-test"){"active"})">English Paragraph Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/alphabet/english-pro/study-guide/" class="sidebar-link $(if($page.Path -eq "speed-tests/skills/alphabet/english-pro/study-guide"){"active"})">English Paragraph Guide</a></li>
            </ul>
        </div>
"@
    } else {
        # Root Homepage left sidebar
        $leftSidebarHtml = @"
        <div class="sidebar">
            <h3 class="sidebar-title">Categories</h3>
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="${rootRel}govt-exams/" class="sidebar-link">Exams Hub</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/" class="sidebar-link">Speed Tests Hub</a></li>
            </ul>
        </div>
"@
    }

    # Render Right Sidebar (Contextual Utilities - completely exclusive to Left Sidebar links)
    $rightSidebarHtml = ""
    if ($page.Path -like "govt-exams*") {
        $rightSidebarHtml = @"
        <div class="sidebar">
            <h3 class="sidebar-title">Trending Utilities</h3>
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/1-minute/practice-test/" class="sidebar-link">1 Minute WPM Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/5-minute/practice-test/" class="sidebar-link">5 Minute WPM Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/10-minute/practice-test/" class="sidebar-link">10 Minute WPM Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/keypad/10-key-data/practice-test/" class="sidebar-link">10-Key Numeric Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/alphabet/english-pro/practice-test/" class="sidebar-link">English Paragraph Test</a></li>
            </ul>
        </div>
"@
    } elseif ($page.Path -like "speed-tests*") {
        $rightSidebarHtml = @"
        <div class="sidebar">
            <h3 class="sidebar-title">Exam Practicing</h3>
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/federal/clerk-steno/practice-test/" class="sidebar-link">Federal Clerk/Steno Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/civil-service/state-local/administrative/practice-test/" class="sidebar-link">State Administrative Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/judicial/court-reporter/practice-test/" class="sidebar-link">Court Reporter Legal Test</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/data-entry/keystroke-kph/practice-test/" class="sidebar-link">KPH Data Entry Test</a></li>
            </ul>
        </div>
"@
    } else {
        # Homepage right sidebar
        $rightSidebarHtml = @"
        <div class="sidebar">
            <h3 class="sidebar-title">Featured Tests</h3>
            <ul class="sidebar-menu">
                <li class="sidebar-item"><a href="${rootRel}speed-tests/duration/minutes/1-minute/practice-test/" class="sidebar-link">1 Minute WPM Simulator</a></li>
                <li class="sidebar-item"><a href="${rootRel}govt-exams/professional/data-entry/keystroke-kph/practice-test/" class="sidebar-link">Alphanumeric KPH Simulator</a></li>
                <li class="sidebar-item"><a href="${rootRel}speed-tests/skills/keypad/10-key-data/practice-test/" class="sidebar-link">10-Key Keypad Simulator</a></li>
            </ul>
        </div>
"@
    }

    # Render Breadcrumbs
    $breadcrumbsHtml = "<li><a href='${rootRel}'>Home</a></li>"
    if ($page.Path -ne "") {
        $parts = $page.Path.Split("/")
        $accumulated = ""
        for ($i=0; $i -lt $parts.Length; $i++) {
            $part = $parts[$i]
            $accumulated += $part
            $urlPath = $rootRel + $accumulated + "/"
            
            # Format display label
            $label = $part -replace "-", " "
            # Capitalize
            $label = (Get-Culture).TextInfo.ToTitleCase($label)
            
            if ($i -eq $parts.Length - 1) {
                $breadcrumbsHtml += "<li>$label</li>"
            } else {
                $breadcrumbsHtml += "<li><a href='${urlPath}'>$label</a></li>"
            }
            $accumulated += "/"
        }
    }

    # Render Quick Takeaway Block
    $takeawayHtml = ""
    if ($page.Takeaway -and $page.Takeaway.Count -gt 0) {
        $takeawayHtml = @"
        <div class="takeaway-card">
            <div class="takeaway-title">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-teal)" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z"></path><line x1="4" y1="22" x2="4" y2="15"></line></svg>
                Quick Summary / TL;DR
            </div>
            <ul class="takeaway-list">
"@
        foreach ($bullet in $page.Takeaway) {
            $takeawayHtml += "<li>$bullet</li>"
        }
        $takeawayHtml += "</ul></div>"
    }

    # Render Interactive Simulator Area
    $simulatorHtml = ""
    if ($page.IsTool -eq $true) {
        $timerSelectHtml = ""
        if ($page.Path -eq "") {
            # Homepage timer selector
            $timerSelectHtml = @"
                <div class="test-settings">
                    <span class="settings-label">Duration:</span>
                    <select id="timer-select" class="select-styled" aria-label="Select Test Duration">
                        <option value="60">1 Minute</option>
                        <option value="120">2 Minutes</option>
                        <option value="300">5 Minutes</option>
                        <option value="600">10 Minutes</option>
                    </select>
                </div>
"@
        }
        
        $durationAttr = ""
        if ($page.Path -like "*1-minute*") { $durationAttr = "data-duration='60'" }
        elseif ($page.Path -like "*5-minute*") { $durationAttr = "data-duration='300'" }
        elseif ($page.Path -like "*10-minute*") { $durationAttr = "data-duration='600'" }

        $simulatorHtml = @"
        <div class="typing-wrapper" data-test-type="$($page.TestType)" $durationAttr>
            <div class="stats-dashboard">
                <div class="stat-card">
                    <div id="wpm-val" class="stat-value">0</div>
                    <div class="stat-label">WPM (Words)</div>
                </div>
                <div class="stat-card">
                    <div id="cpm-val" class="stat-value">0</div>
                    <div class="stat-label">CPM (Chars)</div>
                </div>
                <div class="stat-card">
                    <div id="accuracy-val" class="stat-value">100%</div>
                    <div class="stat-label">Accuracy</div>
                </div>
                <div class="stat-card">
                    <div id="timer-val" class="stat-value">60s</div>
                    <div class="stat-label">Time Left</div>
                </div>
            </div>

            <div id="text-display" class="text-display-box" tabindex="0">
                <!-- Spans inserted dynamically by JS -->
            </div>
            
            <div id="focus-overlay" class="focus-overlay">
                Click here or press any key to focus and start typing
            </div>

            <input type="text" id="typing-input" class="typing-input-hidden" autocomplete="off" aria-label="Keyboard input display box" />

            <div class="controls-bar">
                $timerSelectHtml
                <button id="restart-btn" class="btn-primary">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M21.5 2v6h-6M21.34 15.57a10 10 0 1 1-.57-8.38l5.67-5.67"></path></svg>
                    Restart Simulator
                </button>
            </div>
        </div>
"@
    }

    # Render FAQs & How-To Guides
    $guidesHtml = ""
    if ($page.Faqs -and $page.Faqs.Count -gt 0) {
        $guidesHtml += "<div class='guide-section'><h2>Frequently Asked Questions</h2>"
        foreach ($faq in $page.Faqs) {
            $guidesHtml += @"
            <div class="faq-card">
                <h3 class="faq-question">$($faq.q)</h3>
                <p class="faq-answer">$($faq.a)</p>
            </div>
"@
        }
        $guidesHtml += "</div>"
    }

    if ($page.Howto -and $page.Howto.Count -gt 0) {
        $guidesHtml += "<div class='guide-section'><h2>How to Improve Your Speed - Step-by-Step</h2><ol>"
        foreach ($step in $page.Howto) {
            $guidesHtml += "<li>$step</li>"
        }
        $guidesHtml += "</ol></div>"
    }

    # Render Lateral Links (Sibling Level 5 pages inside the exact same sub-silo)
    $lateralLinksHtml = ""
    if ($depth -eq 5) {
        $lateralTitle = "Practice Sibling Tests & Guides"
        $lateralLinksHtml = @"
        <div class="lateral-links-card">
            <h3 class="lateral-links-title">$lateralTitle</h3>
            <div class="lateral-links-grid">
"@
        # Get sibling pages
        $currentSubSilo = $page.Path -replace "/practice-test$|/study-guide$", ""
        foreach ($sib in $pages) {
            if ($sib.Depth -eq 5 -and $sib.Path -like "$currentSubSilo*" -and $sib.Path -ne $page.Path) {
                # Format relative URL
                $sibRelUrl = "../" + ($sib.Path.Split("/")[-1]) + "/"
                $lateralLinksHtml += @"
                <a href="$sibRelUrl" class="lateral-link-item">
                    <span class="lateral-link-title">$($sib.Title)</span>
                    <span class="lateral-link-desc">$($sib.Desc)</span>
                </a>
"@
            }
        }
        $lateralLinksHtml += "</div></div>"
    }

    # Build JSON-LD Schema Blocks
    # 1. Breadcrumb Schema
    $breadcrumbSchema = @{
        "@context" = "https://schema.org"
        "@type" = "BreadcrumbList"
        "itemListElement" = @()
    }
    
    $breadcrumbSchema.itemListElement += @{
        "@type" = "ListItem"
        "position" = 1
        "name" = "Home"
        "item" = "https://eduprosuite-org.github.io/typing/"
    }
    
    if ($page.Path -ne "") {
        $parts = $page.Path.Split("/")
        $accum = ""
        for ($k=0; $k -lt $parts.Length; $k++) {
            $accum += $parts[$k]
            $label = $parts[$k] -replace "-", " "
            $label = (Get-Culture).TextInfo.ToTitleCase($label)
            $breadcrumbSchema.itemListElement += @{
                "@type" = "ListItem"
                "position" = $k + 2
                "name" = $label
                "item" = "https://eduprosuite-org.github.io/typing/" + $accum + "/"
            }
            $accum += "/"
        }
    }
    
    $schemaBlocks = ""
    $schemaBlocks += "<script type='application/ld+json'>" + ($breadcrumbSchema | ConvertTo-Json -Depth 5) + "</script>`n"

    # 2. WebApplication Schema (on Interactive tools)
    if ($page.IsTool -eq $true) {
        $webAppSchema = @{
            "@context" = "https://schema.org"
            "@type" = "WebApplication"
            "name" = $page.Title
            "url" = $canonicalUrl
            "operatingSystem" = "All"
            "applicationCategory" = "EducationalApplication"
            "browserRequirements" = "Requires JavaScript. Requires HTML5."
            "offers" = @{
                "@type" = "Offer"
                "price" = "0.00"
                "priceCurrency" = "USD"
            }
        }
        $schemaBlocks += "<script type='application/ld+json'>" + ($webAppSchema | ConvertTo-Json -Depth 5) + "</script>`n"
    }

    # 3. FAQ Schema (on Study Guides)
    if ($page.Faqs -and $page.Faqs.Count -gt 0) {
        $faqSchema = @{
            "@context" = "https://schema.org"
            "@type" = "FAQPage"
            "mainEntity" = @()
        }
        foreach ($faq in $page.Faqs) {
            $faqSchema.mainEntity += @{
                "@type" = "Question"
                "name" = $faq.q
                "acceptedAnswer" = @{
                    "@type" = "Answer"
                    "text" = $faq.a
                }
            }
        }
        $schemaBlocks += "<script type='application/ld+json'>" + ($faqSchema | ConvertTo-Json -Depth 5) + "</script>`n"
    }

    # 4. How-To Schema (on Study Guides)
    if ($page.Howto -and $page.Howto.Count -gt 0) {
        $howtoSchema = @{
            "@context" = "https://schema.org"
            "@type" = "HowTo"
            "name" = "How to improve typing speed and pass typing exams"
            "step" = @()
        }
        $idx = 1
        foreach ($step in $page.Howto) {
            $howtoSchema.step += @{
                "@type" = "HowToStep"
                "position" = $idx
                "text" = $step
            }
            $idx++
        }
        $schemaBlocks += "<script type='application/ld+json'>" + ($howtoSchema | ConvertTo-Json -Depth 5) + "</script>`n"
    }

    # Combine into full HTML layout
    $htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$($page.Title)</title>
    <meta name="description" content="$($page.Desc)">
    <link rel="canonical" href="$canonicalUrl" />
    <link rel="stylesheet" href="${rootRel}style.css">
    $schemaBlocks
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo-section">
                <a href="${rootRel}"><span>Typing</span>Pro</a>
            </div>
            <nav>
                <ul class="nav-menu">
                    <li class="nav-item">
                        <a href="${rootRel}govt-exams/" class="nav-link">Exams</a>
                        <div class="dropdown-menu">
                            <a href="${rootRel}govt-exams/civil-service/" class="dropdown-link">Civil Service Tests</a>
                            <a href="${rootRel}govt-exams/professional/" class="dropdown-link">Professional Certs</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="${rootRel}speed-tests/" class="nav-link">Speed Tests</a>
                        <div class="dropdown-menu">
                            <a href="${rootRel}speed-tests/duration/" class="dropdown-link">Duration-Based</a>
                            <a href="${rootRel}speed-tests/skills/" class="dropdown-link">Specialty Keyboards</a>
                        </div>
                    </li>
                </ul>
            </nav>
            <div class="search-wrapper">
                <svg class="search-icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <input type="text" id="nav-search-input" class="search-input" placeholder="Search typing tests..." aria-label="Search typing tests input" autocomplete="off">
                <div id="search-results" class="search-results"></div>
            </div>
        </div>
    </header>

    <div class="layout-container $(if($page.IsTool -eq $true){"three-column-grid"})">
        <!-- Left Sidebar: Silo Navigation -->
        $leftSidebarHtml

        <!-- Main Body -->
        <main>
            <ul class="breadcrumbs">
                $breadcrumbsHtml
            </ul>

            $takeawayHtml

            $($page.Content)

            $simulatorHtml

            $guidesHtml

            $lateralLinksHtml
        </main>

        <!-- Right Sidebar: Contextual Utilities (only if interactive tool page) -->
        $(if($page.IsTool -eq $true){$rightSidebarHtml})
    </div>

        <footer>
        <div class="footer-content" style="flex-direction: column; gap: 1.5rem;">
            <div style="display: flex; gap: 2rem; justify-content: center; flex-wrap: wrap;">
                <a href="$(if ($relPath) {$relPath} else {"../../"})index.html" style="color: var(--text-secondary); text-decoration: none;">Home</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/journeyman/index.html" style="color: var(--text-secondary); text-decoration: none;">Journeyman Exams</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/master-contractor/index.html" style="color: var(--text-secondary); text-decoration: none;">Master Exams</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-license-prep/tradesman-other/index.html" style="color: var(--text-secondary); text-decoration: none;">Tradesman Exams</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})wiki/index.html" style="color: var(--text-secondary); text-decoration: none;">Blog</a>
            </div>
            <div style="display: flex; gap: 1.5rem; justify-content: center; flex-wrap: wrap; font-size: 0.9rem; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 0.75rem;">
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/ca-real-estate-math/index.html" style="color: var(--text-secondary); text-decoration: none;">CA Real Estate Math</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/vic-lea-electrician-prep/index.html" style="color: var(--text-secondary); text-decoration: none;">Vic LEA Electrician</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/plumbing-aptitude-test/index.html" style="color: var(--text-secondary); text-decoration: none;">Plumbing Aptitude</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/sarasota-adu-permit-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Sarasota ADU Permits</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/gwinnett-home-occupation-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Gwinnett Home Occupation</a>
                <a href="$(if ($relPath) {$relPath} else {"../../"})exams/douglas-co-residential-building-checklist/index.html" style="color: var(--text-secondary); text-decoration: none;">Douglas County Building</a>
            </div>
            <div>Â© 2026 ExamPrep Portal. All rights reserved.</div>
        </div>
    </footer>

    <script src="${rootRel}app.js"></script>
</body>
</html>
"@

    # Save to file
    $filePath = Join-Path $pageDir "index.html"
    $htmlContent | Out-File -FilePath $filePath -Encoding utf8 -Force
    Write-Host "Generated: $($filePath.Substring($targetDir.Length))" -ForegroundColor DarkGreen
}

# ----------------------------------------------------
# 5. WRITE TECHNICAL SEO FILES & SITEMAPS
# ----------------------------------------------------
# 5.1 robots.txt
$robotsContent = @'
User-agent: *
Allow: /
Disallow: /assets/
Disallow: /temp/

Sitemap: https://eduprosuite-org.github.io/typing/sitemap_index.xml
'@

$robotsPath = Join-Path $targetDir "robots.txt"
$robotsContent | Out-File -FilePath $robotsPath -Encoding utf8 -Force
Write-Host "Created robots.txt successfully." -ForegroundColor Green

# 5.2 sitemap_index.xml
$sitemapIndexContent = @'
<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
   <sitemap>
      <loc>https://eduprosuite-org.github.io/typing/sitemap-govt-exams.xml</loc>
   </sitemap>
   <sitemap>
      <loc>https://eduprosuite-org.github.io/typing/sitemap-speed-tests.xml</loc>
   </sitemap>
</sitemapindex>
'@

$sitemapIndexPath = Join-Path $targetDir "sitemap_index.xml"
$sitemapIndexContent | Out-File -FilePath $sitemapIndexPath -Encoding utf8 -Force
Write-Host "Created sitemap_index.xml successfully." -ForegroundColor Green

# 5.3 sitemap-govt-exams.xml
$sitemapExamsContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
   <url>
      <loc>https://eduprosuite-org.github.io/typing/</loc>
      <changefreq>daily</changefreq>
      <priority>1.0</priority>
   </url>
"@

# 5.4 sitemap-speed-tests.xml
$sitemapSpeedContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
   <url>
      <loc>https://eduprosuite-org.github.io/typing/</loc>
      <changefreq>daily</changefreq>
      <priority>1.0</priority>
   </url>
"@

foreach ($p in $pages) {
    if ($p.Path -eq "") { continue }
    $loc = "https://eduprosuite-org.github.io/typing/" + $p.Path + "/"
    $priority = "0.6"
    if ($p.Depth -eq 1) { $priority = "0.9" }
    elseif ($p.Depth -eq 2) { $priority = "0.8" }
    elseif ($p.Depth -eq 5 -and $p.IsTool -eq $true) { $priority = "0.7" }

    $urlNode = @"
   <url>
      <loc>$loc</loc>
      <changefreq>weekly</changefreq>
      <priority>$priority</priority>
   </url>
"@

    if ($p.Path -like "govt-exams*") {
        $sitemapExamsContent += $urlNode
    } else {
        $sitemapSpeedContent += $urlNode
    }
}

$sitemapExamsContent += "</urlset>"
$sitemapSpeedContent += "</urlset>"

$sitemapExamsPath = Join-Path $targetDir "sitemap-govt-exams.xml"
$sitemapExamsContent | Out-File -FilePath $sitemapExamsPath -Encoding utf8 -Force
Write-Host "Created sitemap-govt-exams.xml successfully." -ForegroundColor Green

$sitemapSpeedPath = Join-Path $targetDir "sitemap-speed-tests.xml"
$sitemapSpeedContent | Out-File -FilePath $sitemapSpeedPath -Encoding utf8 -Force
Write-Host "Created sitemap-speed-tests.xml successfully." -ForegroundColor Green

Write-Host "All files written and technical SEO configurations finalized." -ForegroundColor Cyan

