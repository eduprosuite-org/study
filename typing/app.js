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
