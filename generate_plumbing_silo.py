import os
import csv
import json

# Setup directories
base_dir = "exams/plumbing-license-prep"
silos = {
    "journeyman": os.path.join(base_dir, "journeyman"),
    "master-contractor": os.path.join(base_dir, "master-contractor"),
    "tradesman-other": os.path.join(base_dir, "tradesman-other"),
    "general": os.path.join(base_dir, "general")
}

# Create base directories
os.makedirs(base_dir, exist_ok=True)
for silo_path in silos.values():
    os.makedirs(silo_path, exist_ok=True)

# Define the 13 products
products = [
    {
        "id": "general-prep",
        "silo": "journeyman",
        "name": "General Journeyman Plumber License Prep",
        "title": "Journeyman Plumber License Exam Prep - Study Guide & Mock Tests",
        "desc": "Prepare for your Journeyman Plumber license exam with 10 comprehensive practice tests, a standard exam simulator, and step-by-step solutions.",
        "keywords": ["journeyman plumber practice test", "journeyman plumber test", "journeyman plumber exam prep", "journeyman plumber test prep", "journeyman plumber license test", "journeyman plumber exam", "journeyman plumber practice exam", "journeyman plumber practice test free", "journeyman plumber test questions", "journeyman's exam plumbing", "plumbing journeyman test prep", "journeyman plumbing test study guide", "journeyman plumber exam study guide"],
        "price": "$19.99",
        "faqs": [
            {"q": "What is covered on the Journeyman Plumber Exam?", "a": "The exam covers key topics including drainage system sizing, venting requirements, water supply and distribution, fixture installation, local plumbing codes, safety protocols, and isometric drawings."},
            {"q": "How many questions are usually on the journeyman plumbing test?", "a": "It typically ranges from 80 to 120 multiple-choice questions depending on the state, with a time limit of 3 to 4 hours."},
            {"q": "What is the passing score for the journeyman's exam plumbing?", "a": "Most states require a minimum score of 70% or 75% to pass and obtain your plumbing license."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Ultimate Journeyman Plumber License Exam Prep Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">To become a certified <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber License Exam Prep">journeyman plumber</a>, you must demonstrate proficiency in installing, maintaining, and repairing sanitary drainage systems, venting systems, and water distribution grids. This study guide helps you master the core exam domains required to pass the licensing exam.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">1. Sanitary Drainage & Venting Systems</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">One of the most heavily tested sections on the <a href="../../journeyman/general-prep/practice.html" title="Journeyman Plumber Practice Test">journeyman plumber test</a> is venting and drainage sizing. Vents are critical for maintaining atmospheric pressure inside the drainage pipes, preventing siphonage of the trap seal. A common rule is that a fixture trap must be placed within a specific distance from the vent stack based on the drain pipe size.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">2. Water Supply & Distribution</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Water distribution systems require careful calculations of fixture units (WSFU) and pressure drops. You must understand how to size water service pipes from the street to the building and calculate flow rates. Cross-connection control and backflow prevention are also vital to protect the potable water supply from contamination.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Use our premium <a href="../../general/free-prep/index.html" title="Free Journeyman Plumber Practice Test">free journeyman plumber practice test</a> to test your knowledge on cross-connections and water service sizing before trying the timed mock tests.</p>
        """,
        "questions": [
            {"Category": "Venting", "Question": "What type of vent is installed to prevent trap siphonage by connecting to the fixture drain downstream of the trap?", "OptionA": "Relief vent", "OptionB": "Wet vent", "OptionC": "Individual vent", "OptionD": "Circuit vent", "CorrectOption": "OptionC", "Explanation": "An individual vent is dedicated to venting a single fixture trap, protecting it from siphonage or backpressure."},
            {"Category": "Potable Water", "Question": "Which of the following describes a cross-connection in plumbing systems?", "OptionA": "A connection between hot and cold water lines", "OptionB": "A physical connection between potable water supply and a non-potable source", "OptionC": "A loop system in water distribution", "OptionD": "A connection between copper and PEX piping", "CorrectOption": "OptionB", "Explanation": "A cross-connection is any physical link between potable water and a source of pollution or contamination."},
            {"Category": "Drainage", "Question": "What is the minimum required slope for a horizontal drainage pipe of 2 inches in diameter?", "OptionA": "1/8 inch per foot", "OptionB": "1/4 inch per foot", "OptionC": "1/2 inch per foot", "OptionD": "1/16 inch per foot", "CorrectOption": "OptionB", "Explanation": "Horizontal drainage pipes of 2 inches or smaller require a minimum slope of 1/4 inch per foot to maintain self-cleansing velocity."},
            {"Category": "Venting", "Question": "What is the maximum horizontal distance between a 1-1/2 inch trap and its vent?", "OptionA": "3 feet 6 inches", "OptionB": "5 feet", "OptionC": "6 feet", "OptionD": "8 feet", "CorrectOption": "OptionC", "Explanation": "Under standard plumbing codes, the maximum horizontal distance between a 1-1/2 inch fixture trap and its vent is 6 feet."},
            {"Category": "Materials", "Question": "Which piping material is NOT approved for water distribution inside residential buildings?", "OptionA": "PEX", "OptionB": "Copper (Type M)", "OptionC": "PVC", "OptionD": "CPVC", "CorrectOption": "OptionC", "Explanation": "PVC is generally not approved for hot water distribution inside residential buildings due to temperature limitations; CPVC and PEX are approved."},
            {"Category": "Traps", "Question": "What is the minimum depth of a fixture trap water seal?", "OptionA": "1 inch", "OptionB": "2 inches", "OptionC": "3 inches", "OptionD": "4 inches", "CorrectOption": "OptionB", "Explanation": "Standard codes require fixture traps to have a liquid seal depth of at least 2 inches and a maximum of 4 inches."},
            {"Category": "Sizing", "Question": "What is the minimum size of a water service pipe from the main supply source to the building?", "OptionA": "1/2 inch", "OptionB": "3/4 inch", "OptionC": "1 inch", "OptionD": "1-1/4 inches", "CorrectOption": "OptionB", "Explanation": "The minimum size of a water service pipe is 3/4 inch to ensure adequate volume and pressure."},
            {"Category": "Sewer", "Question": "What is the main purpose of a cleanout in a building drain?", "OptionA": "To vent sewer gases", "OptionB": "To allow inspection of sewer lines", "OptionC": "To provide access for clearing blockages", "OptionD": "To adjust water flow rates", "CorrectOption": "OptionC", "Explanation": "Cleanouts are removable caps installed to allow access to clear obstructions in drainage piping."},
            {"Category": "Venting", "Question": "What is the minimum size of a dry vent stack?", "OptionA": "1 inch", "OptionB": "1-1/4 inches", "OptionC": "1-1/2 inches", "OptionD": "2 inches", "CorrectOption": "OptionB", "Explanation": "The minimum diameter of a dry vent stack is 1-1/4 inches."},
            {"Category": "Hangers", "Question": "How often must horizontal copper tubing be supported?", "OptionA": "Every 6 feet", "OptionB": "Every 8 feet", "OptionC": "Every 10 feet", "OptionD": "Every 12 feet", "CorrectOption": "OptionD", "Explanation": "Horizontal copper tubing of 1-1/2 inches and smaller must be supported at intervals not exceeding 12 feet under standard codes."}
        ]
    },
    {
        "id": "texas-prep",
        "silo": "journeyman",
        "name": "Texas Journeyman Plumber Prep",
        "title": "Texas Journeyman Plumber License Practice Test & Study Guide",
        "desc": "Ace the TSBPE Texas Journeyman Plumber Exam. Features 10 practice tests, state code requirements, and local calculations.",
        "price": "$19.99",
        "keywords": ["journeyman plumber practice test texas", "texas journeyman plumbing practice test", "texas journeyman plumber exam"],
        "faqs": [
            {"q": "Who administers the plumbing exam in Texas?", "a": "The Texas State Board of Plumbing Examiners (TSBPE) administers the journeyman plumber exam and licensing."},
            {"q": "What code book is used for the Texas Journeyman plumbing test?", "a": "Texas utilizes both the International Plumbing Code (IPC) and the Uniform Plumbing Code (UPC). You must study both versions as selected by your local jurisdiction."},
            {"q": "Does the Texas plumber exam require drawing isometric layouts?", "a": "Yes, the Texas journeyman exam contains a practical layout and design portion that includes drawing plumbing isometric designs."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Texas TSBPE Journeyman Plumber Exam Prep Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">To obtain a <a href="../../journeyman/texas-prep/index.html" title="Texas Journeyman Plumber Exam Prep">Texas Journeyman Plumber</a> license from the TSBPE, candidates must pass a rigorous multi-part exam including code multiple-choice questions, a safety portion, and drawing three-dimensional isometric designs.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">State Licensing Requirements</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">The <a href="../../journeyman/texas-prep/practice.html" title="Texas Journeyman Plumber Practice Test">texas journeyman plumbing practice test</a> targets specific requirements of the Texas State Board, including the Plumbing License Law and Board Rules. Candidates must have at least 8,000 hours of experience registered with the board before taking the exam.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">For more general practice, check out our <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber Practice Test">journeyman plumber practice test</a> to build core code competencies before focusing on specific Texas rules.</p>
        """,
        "questions": [
            {"Category": "TSBPE Rules", "Question": "Which state agency administers plumbing licenses and regulation in Texas?", "OptionA": "TDLR", "OptionB": "TSBPE", "OptionC": "TCEQ", "OptionD": "Texas DPS", "CorrectOption": "OptionB", "Explanation": "The Texas State Board of Plumbing Examiners (TSBPE) is the agency responsible for licensing plumbers in Texas."},
            {"Category": "IPC/UPC Codes", "Question": "In Texas, horizontal drainage piping must be supported at what maximum intervals for cast-iron pipe?", "OptionA": "Every 5 feet", "OptionB": "Every 10 feet", "OptionC": "Every 8 feet", "OptionD": "At each story height", "CorrectOption": "OptionA", "Explanation": "Cast-iron piping must be supported at maximum intervals of 5 feet, or 10 feet where 10-foot lengths are used."},
            {"Category": "Venting", "Question": "What is the maximum length of a 2-inch vent pipe under TSBPE IPC rules?", "OptionA": "40 feet", "OptionB": "75 feet", "OptionC": "150 feet", "OptionD": "200 feet", "CorrectOption": "OptionC", "Explanation": "Under International Plumbing Code rules, a 2-inch vent serving standard fixture unit loads has a maximum allowable length of 150 feet."},
            {"Category": "Water Heaters", "Question": "What is the minimum sizing for a temperature and pressure (T&P) relief valve discharge pipe?", "OptionA": "1/2 inch", "OptionB": "3/4 inch", "OptionC": "1 inch", "OptionD": "Size of the valve outlet", "CorrectOption": "OptionD", "Explanation": "The T&P valve discharge pipe must not be smaller than the diameter of the outlet of the valve it serves (typically 3/4 inch)."},
            {"Category": "Sewer Sizing", "Question": "What is the minimum size of a building sewer in Texas?", "OptionA": "2 inches", "OptionB": "3 inches", "OptionC": "4 inches", "OptionD": "6 inches", "CorrectOption": "OptionB", "Explanation": "Standard Texas codes require building sewers to be a minimum of 3 inches in diameter."},
            {"Category": "TSBPE Rules", "Question": "A Journeyman Plumber in Texas may supervise how many Apprentice Plumbers on a commercial job site?", "OptionA": "1", "OptionB": "2", "OptionC": "3", "OptionD": "Unlimited", "CorrectOption": "OptionC", "Explanation": "Texas board rules allow a Journeyman to supervise up to 3 apprentices on a commercial job site."},
            {"Category": "Venting", "Question": "Under IPC rules, what is the maximum load in fixture units (DFUs) allowed on a 3-inch horizontal branch drain?", "OptionA": "20 DFUs", "OptionB": "40 DFUs", "OptionC": "60 DFUs", "OptionD": "160 DFUs", "CorrectOption": "OptionA", "Explanation": "A 3-inch horizontal branch can handle up to 20 DFUs under standard IPC drainage tables."},
            {"Category": "Backflow", "Question": "What backflow prevention device is required for a commercial carbonated beverage dispenser?", "OptionA": "Double check valve", "OptionB": "Reduced pressure zone (RPZ) backflow preventer", "OptionC": "Vented double check valve (ASSE 1022)", "OptionD": "Atmospheric vacuum breaker", "CorrectOption": "OptionC", "Explanation": "An ASSE 1022 backflow preventer with an intermediate atmospheric vent is required for carbonators to prevent copper poisoning."},
            {"Category": "Sizing", "Question": "What is the minimum height that a vent pipe must terminate above a roof in Texas?", "OptionA": "6 inches", "OptionB": "12 inches", "OptionC": "18 inches", "OptionD": "24 inches", "CorrectOption": "OptionA", "Explanation": "Vents must terminate at least 6 inches above the roof line, or higher if local snow load adjustments apply."},
            {"Category": "Drawings", "Question": "What projection angle is used to draw a standard plumbing isometric sketch?", "OptionA": "30 degrees", "OptionB": "45 degrees", "OptionC": "60 degrees", "OptionD": "90 degrees", "CorrectOption": "OptionA", "Explanation": "Isometric drawings represent 3D piping layouts with axes angled at 30 degrees to the horizontal."}
        ]
    },
    {
        "id": "va-prep",
        "silo": "journeyman",
        "name": "Virginia (VA) Journeyman Plumber Prep",
        "title": "Virginia Journeyman Plumber License Exam Simulator",
        "desc": "Pass your DPOR Virginia Journeyman Plumber exam. Features interactive mock tests, Virginia state amendments, and IPC guidelines.",
        "price": "$19.99",
        "keywords": ["va journeyman plumber practice test"],
        "faqs": [
            {"q": "Which code is used for the Virginia Journeyman Plumber Exam?", "a": "Virginia uses the Virginia Construction Code, Part I of the Virginia Uniform Statewide Building Code (USBC), which incorporates the International Plumbing Code (IPC) with Virginia amendments."},
            {"q": "How many hours of experience are needed in Virginia?", "a": "Virginia DPOR requires 4 years of experience and a registered apprenticeship, or 240 hours of formal vocational training + 4 years of experience."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Virginia DPOR Journeyman Plumber Exam Prep Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">To obtain your license in Virginia, you must apply to the Department of Professional and Occupational Regulation (DPOR) and pass the licensing exam. The <a href="../../journeyman/va-prep/practice.html" title="Virginia Journeyman Plumber Practice Test">va journeyman plumber practice test</a> focuses on the USBC and IPC specifications.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">Virginia State Amendments</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Virginia introduces specific local amendments to the IPC, such as specific requirements for water heater pan sizing, thermal expansion tanks, and local sewer depth parameters. Our mock test guides you through these Virginia DPOR specifics.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">For general testing strategy, take a look at our <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber Test Prep">journeyman plumber test prep</a> which covers standard plumbing principles.</p>
        """,
        "questions": [
            {"Category": "DPOR Rules", "Question": "Which agency issues plumbing licenses in the state of Virginia?", "OptionA": "Virginia Board of Contractors", "OptionB": "DPOR", "OptionC": "Virginia DHCD", "OptionD": "Virginia DHP", "CorrectOption": "OptionB", "Explanation": "The Department of Professional and Occupational Regulation (DPOR) governs plumbing licensure under the Board for Contractors."},
            {"Category": "USBC Amendments", "Question": "Under Virginia Uniform Statewide Building Code rules, what is the maximum water temperature from a shower head?", "OptionA": "110°F", "OptionB": "120°F", "OptionC": "130°F", "OptionD": "140°F", "CorrectOption": "OptionB", "Explanation": "The USBC restricts shower outlet temperatures to a maximum of 120°F (49°C) to prevent scalding."},
            {"Category": "Water Sizing", "Question": "What is the minimum pressure required at the building entry point for water supply systems?", "OptionA": "20 psi", "OptionB": "30 psi", "OptionC": "40 psi", "OptionD": "80 psi", "CorrectOption": "OptionC", "Explanation": "Virginia codes require a minimum static water pressure of 40 psi at the fixture outlets or service entrance."},
            {"Category": "Hangers", "Question": "What is the maximum horizontal support spacing for PEX piping under Virginia USBC?", "OptionA": "2 feet 8 inches (32 inches)", "OptionB": "4 feet", "OptionC": "6 feet", "OptionD": "10 feet", "CorrectOption": "OptionA", "Explanation": "PEX tubing must be supported horizontally at intervals not exceeding 32 inches (or 2.67 feet) to prevent sagging."},
            {"Category": "Cleanouts", "Question": "What is the maximum spacing between cleanouts on horizontal drainage lines of 4 inches and smaller in Virginia?", "OptionA": "50 feet", "OptionB": "75 feet", "OptionC": "100 feet", "OptionD": "150 feet", "CorrectOption": "OptionC", "Explanation": "Cleanouts must be installed at intervals of not more than 100 feet for pipes up to 4 inches in diameter."},
            {"Category": "Venting", "Question": "What is the minimum height a vent terminal must extend above the roof in Virginia to prevent frost closure?", "OptionA": "6 inches", "OptionB": "12 inches", "OptionC": "18 inches", "OptionD": "24 inches", "CorrectOption": "OptionB", "Explanation": "Virginia amendments require vents to terminate at least 12 inches above the roof line to avoid frost closure."},
            {"Category": "Soil Pipes", "Question": "What is the minimum size of a building drain carrying discharge from three water closets?", "OptionA": "2 inches", "OptionB": "3 inches", "OptionC": "4 inches", "OptionD": "5 inches", "CorrectOption": "OptionB", "Explanation": "A 3-inch drain can carry up to three water closets under standard IPC fixture unit tables."},
            {"Category": "Venting", "Question": "What type of trap is strictly prohibited from being installed in a sanitary drainage system?", "OptionA": "P-trap", "OptionB": "S-trap", "OptionC": "Drum trap", "OptionD": "Bell trap", "CorrectOption": "OptionB", "Explanation": "S-traps are prohibited because they are highly susceptible to siphonage under drainage loads."},
            {"Category": "Materials", "Question": "What is the minimum thickness required for copper water service piping installed underground?", "OptionA": "Type K", "OptionB": "Type L", "OptionC": "Type M", "OptionD": "DWV", "CorrectOption": "OptionA", "Explanation": "Underground water service pipes must be copper Type K or L; Type K is preferred for maximum durability."},
            {"Category": "Materials", "Question": "What color indicates CPVC pipe used for fire sprinkler systems in Virginia?", "OptionA": "Grey", "OptionB": "Beige/Tan", "OptionC": "Orange", "OptionD": "Blue", "CorrectOption": "OptionC", "Explanation": "Orange CPVC piping is chemically rated and color-coded specifically for fire protection systems."}
        ]
    },
    {
        "id": "kansas-prep",
        "silo": "journeyman",
        "name": "Kansas Journeyman Plumber Prep",
        "title": "Kansas Journeyman Plumber Practice Test - Interactive Prep Portal",
        "desc": "Get ready for the Kansas Journeyman Plumber Exam. Pro-level mock tests, regional requirements, and IPC / UPC code questions.",
        "price": "$19.99",
        "keywords": ["kansas journeyman plumber test"],
        "faqs": [
            {"q": "Is plumbing licensing regulated statewide in Kansas?", "a": "No, Kansas regulates plumbing at the county or municipal level (e.g., Wichita, Topeka, Johnson County). Most local jurisdictions require passing the Prometric or ICC Journeyman exam."},
            {"q": "What code book is used in Kansas?", "a": "Different cities in Kansas adopt either the International Plumbing Code (IPC) or the Uniform Plumbing Code (UPC). Our practice tests cover core elements of both systems."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Kansas Journeyman Plumber Test Study Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Passing the <a href="../../journeyman/kansas-prep/practice.html" title="Kansas Journeyman Plumber Test">kansas journeyman plumber test</a> requires a thorough understanding of whichever code version is adopted by your local municipality. Usually, this refers to the International Plumbing Code (IPC) or International Residential Code (IRC).</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">Local Licensing Authorities</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Because licensing is not centralized, you must consult your local city hall or county clerk's office. Most testing is done through the International Code Council (ICC) or Prometric testing services. Our simulator mimics the style of these standard national testing formats.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Need a solid overview of general codes? Take our <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber Exam Prep">journeyman plumber exam prep</a> course for a quick refresher.</p>
        """,
        "questions": [
            {"Category": "Codes", "Question": "In areas adopting the UPC, what is the maximum number of fixture units allowed on a 2-inch horizontal vent pipe?", "OptionA": "12 DFUs", "OptionB": "24 DFUs", "OptionC": "32 DFUs", "OptionD": "48 DFUs", "CorrectOption": "OptionB", "Explanation": "Uniform Plumbing Code regulations restrict a 2-inch horizontal vent line to a maximum load of 24 DFUs."},
            {"Category": "Valves", "Question": "What valve must be installed on the cold water inlet of a water heater?", "OptionA": "Gate valve", "OptionB": "Full-open shutoff valve", "OptionC": "Check valve", "OptionD": "Globe valve", "CorrectOption": "OptionB", "Explanation": "A full-open shutoff valve (such as a ball valve or gate valve) must be installed on the cold water supply pipe to the heater."},
            {"Category": "Venting", "Question": "What is the minimum sizing for a vent serving a wet-vented bathroom group?", "OptionA": "1-1/4 inches", "OptionB": "1-1/2 inches", "OptionC": "2 inches", "OptionD": "3 inches", "CorrectOption": "OptionC", "Explanation": "Under IPC rules, the wet-vent portion of a bathroom group must be a minimum of 2 inches in diameter."},
            {"Category": "Backflow", "Question": "What backflow prevention assembly consists of two independently acting check valves with an intermediate relief valve?", "OptionA": "Double check valve assembly", "OptionB": "Reduced pressure zone (RPZ) preventer", "OptionC": "Pressure vacuum breaker", "OptionD": "Atmospheric vacuum breaker", "CorrectOption": "OptionB", "Explanation": "The Reduced Pressure Zone (RPZ) backflow preventer contains two check valves and a differential relief valve in between."},
            {"Category": "Water Sizing", "Question": "What is the equivalent fixture unit value of a residential kitchen sink?", "OptionA": "1 DFU", "OptionB": "2 DFUs", "OptionC": "3 DFUs", "OptionD": "4 DFUs", "CorrectOption": "OptionB", "Explanation": "A residential kitchen sink is rated at 2 drainage fixture units (DFUs)."},
            {"Category": "Materials", "Question": "What color is standard Schedule 40 ABS drainage pipe?", "OptionA": "White", "OptionB": "Black", "OptionC": "Grey", "OptionD": "Green", "CorrectOption": "OptionB", "Explanation": "ABS (Acrylonitrile Butadiene Styrene) piping is universally black in color."},
            {"Category": "Cleanouts", "Question": "What is the minimum required clearance in front of a cleanout for a 3-inch pipe?", "OptionA": "12 inches", "OptionB": "18 inches", "OptionC": "24 inches", "OptionD": "36 inches", "CorrectOption": "OptionB", "Explanation": "A cleanout serving a 3-inch pipe must have at least 18 inches of clearance for rodding access."},
            {"Category": "Venting", "Question": "Vents terminating through a roof in heavy snow areas like Kansas must terminate at least how high?", "OptionA": "6 inches", "OptionB": "12 inches", "OptionC": "18 inches", "OptionD": "24 inches", "CorrectOption": "OptionB", "Explanation": "In colder climates, ventialtion pipes must terminate at least 12 inches above the roof to prevent snow blockage."},
            {"Category": "Sewer Sizing", "Question": "What is the minimum slope for a 4-inch building sewer pipe?", "OptionA": "1/16 inch per foot", "OptionB": "1/8 inch per foot", "OptionC": "1/4 inch per foot", "OptionD": "1/2 inch per foot", "CorrectOption": "OptionB", "Explanation": "For pipes of 4 inches and larger, the minimum allowed slope is 1/8 inch per foot under standard code."},
            {"Category": "Sewer Sizing", "Question": "Which fixture does NOT require a separate trap?", "OptionA": "Water closet", "OptionB": "Bidet", "OptionC": "Lavatory", "OptionD": "Laundry tub", "CorrectOption": "OptionA", "Explanation": "Water closets have an integral trap built directly into the fixture casting, so they do not require an external trap."}
        ]
    },
    {
        "id": "ma-prep",
        "silo": "journeyman",
        "name": "Massachusetts (MA) Journeyman Plumber Prep",
        "title": "Massachusetts Journeyman Plumber Practice Test - 248 CMR Prep",
        "desc": "Master the 248 CMR Massachusetts State Plumbing Code. Features 10 customized practice tests and state board licensing questions.",
        "price": "$19.99",
        "keywords": ["ma journeyman plumbing practice test"],
        "faqs": [
            {"q": "What code book is used in Massachusetts?", "a": "Massachusetts uses its own unique state code: 248 CMR (Massachusetts State Plumbing Code). It is not based on the IPC or UPC."},
            {"q": "Are double-compartment sinks allowed on a single trap in MA?", "a": "Under 248 CMR, certain restrictions apply. Generally, a double-compartment sink can share a trap, but strict piping sizes must be adhered to."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Massachusetts 248 CMR Plumber Exam Prep Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">To obtain a license in Massachusetts, you must pass the state board exam which is based entirely on the **248 CMR (Massachusetts State Plumbing Code)**. The <a href="../../journeyman/ma-prep/practice.html" title="Massachusetts Journeyman Plumber Practice Test">ma journeyman plumbing practice test</a> is tailormade for these unique rules.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">Unique Massachusetts Regulations</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">248 CMR is significantly different from national model codes. For example, wet venting is highly restricted, and the state board requires specific materials and approval markings (Massachusetts Product Approval). Our mock tests reflect these strict state-specific regulations.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">For more general practice, you can take a look at our <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber License Test">journeyman plumber license test</a> to understand core drainage laws before diving into 248 CMR details.</p>
        """,
        "questions": [
            {"Category": "248 CMR", "Question": "Which regulatory board governs plumbing licensing and codes in Massachusetts?", "OptionA": "DPOR", "OptionB": "Board of State Examiners of Plumbers and Gas Fitters", "OptionC": "Massachusetts Department of Public Safety", "OptionD": "TSBPE", "CorrectOption": "OptionB", "Explanation": "Licensing and codes are administered by the Massachusetts Board of State Examiners of Plumbers and Gas Fitters."},
            {"Category": "248 CMR", "Question": "What is the minimum size of a building drain in Massachusetts under 248 CMR?", "OptionA": "2 inches", "OptionB": "3 inches", "OptionC": "4 inches", "OptionD": "6 inches", "CorrectOption": "OptionC", "Explanation": "Unlike model codes, 248 CMR requires the main building drain to be a minimum of 4 inches in diameter."},
            {"Category": "248 CMR", "Question": "What is the maximum length of a fixture tailpiece under 248 CMR rules?", "OptionA": "18 inches", "OptionB": "24 inches", "OptionC": "30 inches", "OptionD": "36 inches", "CorrectOption": "OptionB", "Explanation": "The maximum vertical distance from the fixture outlet to the trap weir is 24 inches in Massachusetts."},
            {"Category": "248 CMR", "Question": "Under 248 CMR, what is the minimum vent size for a residential water closet?", "OptionA": "1-1/2 inches", "OptionB": "2 inches", "OptionC": "3 inches", "OptionD": "4 inches", "CorrectOption": "OptionB", "Explanation": "In Massachusetts, a water closet must be vented with a pipe of at least 2 inches in diameter."},
            {"Category": "248 CMR", "Question": "What is the minimum diameter of a wet vent under 248 CMR?", "OptionA": "1-1/2 inches", "OptionB": "2 inches", "OptionC": "3 inches", "OptionD": "Wet venting is prohibited in MA", "CorrectOption": "OptionB", "Explanation": "Under 248 CMR, where wet venting is permitted for bathroom groups, it must be at least 2 inches in diameter."},
            {"Category": "248 CMR", "Question": "Which material is strictly prohibited for sanitary drainage piping inside a building in MA?", "OptionA": "Cast iron", "OptionB": "PVC Schedule 40", "OptionC": "Lead pipe", "OptionD": "ABS Schedule 40", "CorrectOption": "OptionC", "Explanation": "Lead piping is prohibited for new sanitary installations under modern 248 CMR standards."},
            {"Category": "248 CMR", "Question": "What is the required test pressure for a water system piping inspection in Massachusetts?", "OptionA": "50 psi", "OptionB": "100 psi", "OptionC": "125 psi", "OptionD": "Working pressure or 150 psi", "CorrectOption": "OptionD", "Explanation": "Massachusetts codes require water piping to be tested at 150% of the working pressure or 125 psi, whichever is greater."},
            {"Category": "248 CMR", "Question": "Can a trap serve more than one fixture under 248 CMR?", "OptionA": "Yes, for up to three laundry tubs", "OptionB": "No, every fixture must have an individual trap", "OptionC": "Yes, for a double-compartment residential sink", "OptionD": "Only with board approval", "CorrectOption": "OptionC", "Explanation": "A single trap is permitted for a double-compartment residential sink where the outlets are close together (within 30 inches)."},
            {"Category": "248 CMR", "Question": "What is the maximum fixture unit value allowed on a 2-inch horizontal waste line under 248 CMR?", "OptionA": "4 DFUs", "OptionB": "8 DFUs", "OptionC": "10 DFUs", "OptionD": "12 DFUs", "CorrectOption": "OptionB", "Explanation": "A 2-inch horizontal waste line can carry up to 8 drainage fixture units (DFUs) under 248 CMR drainage tables."},
            {"Category": "248 CMR", "Question": "What type of joint is required when connecting copper pipe to cast iron?", "OptionA": "Threaded joint", "OptionB": "Solder joint", "OptionC": "Caulked joint or approved adapter coupling", "OptionD": "Welded joint", "CorrectOption": "OptionC", "Explanation": "Approved mechanical adapter couplings or caulked joints are used to connect dissimilar metals."}
        ]
    },
    {
        "id": "wssc-prep",
        "silo": "journeyman",
        "name": "WSSC Journeyman Plumber Prep",
        "title": "WSSC Journeyman Plumber License Practice Test & Study Guide",
        "desc": "Pass the WSSC (Washington Suburban Sanitary Commission) Journeyman Plumber Exam. Features local code regulations and mock tests.",
        "price": "$19.99",
        "keywords": ["wssc journeyman plumbing test", "wssc journeyman test"],
        "faqs": [
            {"q": "What is the WSSC?", "a": "The Washington Suburban Sanitary Commission (WSSC) regulates plumbing and gas fitting services in Prince George's and Montgomery Counties in Maryland."},
            {"q": "What code book does the WSSC use?", "a": "WSSC adopts the International Plumbing Code (IPC) with extensive local WSSC amendments."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">WSSC Maryland Journeyman Plumber Exam Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">To practice plumbing in the Maryland suburbs of Washington D.C., you must pass the WSSC license exam. The <a href="../../journeyman/wssc-prep/practice.html" title="WSSC Journeyman Plumber Practice Test">wssc journeyman plumbing test</a> ensures you are fully prepared for this specific regional license.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">WSSC Local Amendments</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">WSSC maintains its own plumbing and fuel gas code book. Key items include grease trap sizing, local main water pipe setbacks, and strict requirements for gas piping materials (such as corrugated stainless steel tubing - CSST). Our simulator questions reflect these local code guidelines.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Need more preparation material? View our <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber License Test">journeyman plumber license test</a> to practice fundamental drainage calculations.</p>
        """,
        "questions": [
            {"Category": "WSSC Code", "Question": "The WSSC governs plumbing and gas fitting in which two Maryland counties?", "OptionA": "Baltimore & Harford", "OptionB": "Montgomery & Prince George's", "OptionC": "Howard & Anne Arundel", "OptionD": "Frederick & Carroll", "CorrectOption": "OptionB", "Explanation": "The WSSC regulates plumbing in Montgomery and Prince George's counties, Maryland."},
            {"Category": "WSSC Code", "Question": "Under WSSC code, what is the minimum size of a residential grease interceptor?", "OptionA": "50 gallons", "OptionB": "100 gallons", "OptionC": "500 gallons", "OptionD": "Grease interceptors are not required for residences", "CorrectOption": "OptionD", "Explanation": "Residential kitchens generally do not require grease interceptors; they are required for commercial food service establishments."},
            {"Category": "WSSC Code", "Question": "What is the WSSC requirement for testing drainage piping with water?", "OptionA": "5-foot head of water", "OptionB": "10-foot head of water", "OptionC": "15 psi air pressure", "OptionD": "20 psi air pressure", "CorrectOption": "OptionB", "Explanation": "WSSC requires drainage piping to be water-tested by filling the pipes to a head of at least 10 feet of water."},
            {"Category": "WSSC Code", "Question": "What gas piping material is allowed under WSSC regulations with specific bonding rules?", "OptionA": "PVC", "OptionB": "CSST (Corrugated Stainless Steel)", "OptionC": "Lead pipe", "OptionD": "Galvanized pipe", "CorrectOption": "OptionB", "Explanation": "CSST is allowed but requires electrical bonding to the grounding electrode system under WSSC and national codes."},
            {"Category": "Venting", "Question": "What is the minimum diameter of a vent line serving a residential kitchen sink under WSSC code?", "OptionA": "1-1/4 inches", "OptionB": "1-1/2 inches", "OptionC": "2 inches", "OptionD": "3 inches", "CorrectOption": "OptionB", "Explanation": "A 1-1/2 inch vent is the standard minimum size for a residential kitchen sink waste line under WSSC IPC guidelines."},
            {"Category": "Backflow", "Question": "How often must backflow prevention assemblies be tested under WSSC water regulation?", "OptionA": "Every 6 months", "OptionB": "Annually", "OptionC": "Every 2 years", "OptionD": "Only upon installation", "CorrectOption": "OptionB", "Explanation": "Backflow prevention assemblies must be inspected and tested annually by a certified backflow tester."},
            {"Category": "Water Heaters", "Question": "Under WSSC code, water heaters located in attics must have what auxiliary safety item?", "OptionA": "An emergency alarm", "OptionB": "A secondary drain pan with a drain pipe line", "OptionC": "A dual T&P valve", "OptionD": "An automatic shutoff timer", "CorrectOption": "OptionB", "Explanation": "An auxiliary drain pan is required beneath water heaters in attics or ceiling spaces to prevent property damage."},
            {"Category": "Cleanouts", "Question": "What is the required spacing between cleanouts on a straight horizontal run under WSSC code?", "OptionA": "Every 50 feet", "OptionB": "Every 75 feet", "OptionC": "Every 100 feet", "OptionD": "Every 150 feet", "CorrectOption": "OptionC", "Explanation": "Cleanouts must be installed at straight-line intervals not exceeding 100 feet."},
            {"Category": "Venting", "Question": "What is the minimum vent termination height above the roof line under WSSC regulations?", "OptionA": "6 inches", "OptionB": "12 inches", "OptionC": "18 inches", "OptionD": "24 inches", "CorrectOption": "OptionB", "Explanation": "WSSC requires vent terminals to extend at least 12 inches above the roof line to prevent winter frost closure."},
            {"Category": "TSBPE Rules", "Question": "Which type of trap is permitted for a residential bathtub in WSSC?", "OptionA": "S-trap", "OptionB": "P-trap", "OptionC": "Bell trap", "OptionD": "Crown vented trap", "CorrectOption": "OptionB", "Explanation": "Bathtubs must be fitted with a standard P-trap to ensure a reliable sewer gas seal."}
        ]
    },
    {
        "id": "master-prep",
        "silo": "master-contractor",
        "name": "Master Plumbing Practice Test",
        "title": "Master Plumber License Exam Practice Test & Study Guide",
        "desc": "Pass your Master Plumber licensing exam. Features advanced code calculations, business administration, and mock exams.",
        "price": "$19.99",
        "keywords": ["master plumbing practice test"],
        "faqs": [
            {"q": "What is the difference between a Journeyman and a Master Plumber?", "a": "A journeyman can perform installation work under supervision. A Master Plumber can design plumbing systems, pull municipal permits, run a business, and contract work independently."},
            {"q": "What mathematical formulas are tested on the Master Plumber Exam?", "a": "Expect complex water supply pipe sizing, sizing offset loops, calculating stormwater drainage requirements, and business/tax estimations."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Advanced Master Plumber Exam Study Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">The <a href="../../master-contractor/master-prep/index.html" title="Master Plumbing Practice Test">master plumbing practice test</a> prepares you for the highest plumbing credential. In addition to advanced code knowledge, candidates are tested on system engineering, gas sizing, and business operations.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">1. System Design and Engineering</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">As a Master Plumber, you must size large main stacks, booster pump systems, and commercial water filtration systems. You must master the Hunter's Curve for estimating water supply demands (fixture units) to size main building supply pipes accurately.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">2. Business & Law</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Master exams often contain a dedicated Business and Law section. This covers OSHA requirements, workers' compensation insurance, mechanics' liens, tax calculations, and basic accounting terms.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Verify your contractor knowledge using our <a href="../../master-contractor/contractor-prep/index.html" title="Plumbing Contractor Practice Test">plumbing contractor practice test</a> to ensure you cover commercial bidding regulations.</p>
        """,
        "questions": [
            {"Category": "Design Sizing", "Question": "Using Hunter's Curve, what is the demand in gallons per minute (GPM) for a water system with 100 flush valve water closets?", "OptionA": "50 GPM", "OptionB": "100 GPM", "OptionC": "208 GPM", "OptionD": "350 GPM", "CorrectOption": "OptionC", "Explanation": "Based on Hunter's Curve estimation, 100 flush-valve fixture units translate to a peak demand of approximately 208 GPM."},
            {"Category": "Storm Drainage", "Question": "What is the required sizing of a horizontal storm drain pipe with a 1/4 inch slope for a roof area of 10,000 sq ft (assuming 3 inches per hour rainfall)?", "OptionA": "3 inches", "OptionB": "4 inches", "OptionC": "5 inches", "OptionD": "6 inches", "CorrectOption": "OptionD", "Explanation": "Under standard IPC storm drainage tables, a 6-inch horizontal storm drain at 1/4 inch slope can handle up to 13,600 sq ft of roof area."},
            {"Category": "Business Law", "Question": "Which type of insurance covers workers injured on a plumbing job site?", "OptionA": "General Liability", "OptionB": "Workers' Compensation", "OptionC": "Professional Indemnity", "OptionD": "Property Insurance", "CorrectOption": "OptionB", "Explanation": "Workers' Compensation is state-mandated insurance designed to pay medical bills and lost wages for workers injured on the job."},
            {"Category": "Gas Sizing", "Question": "What is the maximum capacity of a 1/2 inch black iron gas pipe carrying natural gas over a length of 50 feet?", "OptionA": "25,000 BTU", "OptionB": "44,000 BTU", "OptionC": "72,000 BTU", "OptionD": "120,000 BTU", "CorrectOption": "OptionB", "Explanation": "Under standard gas piping tables, a 1/2 inch pipe at 50 feet has a maximum capacity of approximately 44,000 BTUs/hour."},
            {"Category": "Water Sizing", "Question": "Potable water supply systems must be designed to limit maximum water velocity to how many feet per second (fps) to prevent water hammer?", "OptionA": "5 fps", "OptionB": "8 fps", "OptionC": "10 fps", "OptionD": "12 fps", "CorrectOption": "OptionB", "Explanation": "Standard engineering designs restrict hot/cold copper pipe velocities to 8 fps to prevent erosion and water hammer noise."},
            {"Category": "Venting", "Question": "What is the maximum fixture unit load allowed on a 4-inch stack vent?", "OptionA": "100 DFUs", "OptionB": "250 DFUs", "OptionC": "500 DFUs", "OptionD": "1000 DFUs", "CorrectOption": "OptionD", "Explanation": "A 4-inch stack vent can handle up to 1,000 drainage fixture units under standard drainage codes."},
            {"Category": "Valves", "Question": "What backflow prevention device is required for a commercial boiler system with chemical additives?", "OptionA": "Double check valve", "OptionB": "Atmospheric vacuum breaker", "OptionC": "Reduced pressure zone (RPZ) backflow preventer", "OptionD": "Hose bibb vacuum breaker", "CorrectOption": "OptionC", "Explanation": "Chemical boiler systems present a high health hazard, requiring a reduced pressure zone (RPZ) backflow preventer."},
            {"Category": "Materials", "Question": "What is the maximum spacing between horizontal supports for 2-inch PVC drainage pipe?", "OptionA": "4 feet", "OptionB": "6 feet", "OptionC": "8 feet", "OptionD": "10 feet", "CorrectOption": "OptionA", "Explanation": "PVC horizontal drainage piping must be supported every 4 feet under standard codes to prevent line sag."},
            {"Category": "Safety", "Question": "Under OSHA guidelines, how far must a ladder extend above the edge of a trench?", "OptionA": "1 foot", "OptionB": "2 feet", "OptionC": "3 feet", "OptionD": "5 feet", "CorrectOption": "OptionC", "Explanation": "OSHA requires ladders to extend at least 3 feet above the landing surface for safe egress from trenches."},
            {"Category": "Drawings", "Question": "An isometric drawing shows piping offsets at what standard angle to show vertical rises?", "OptionA": "30 degrees", "OptionB": "45 degrees", "OptionC": "90 degrees", "OptionD": "120 degrees", "CorrectOption": "OptionC", "Explanation": "Vertical rises are represented with vertical lines (90 degrees to horizontal) in isometric drawings."}
        ]
    },
    {
        "id": "contractor-prep",
        "silo": "master-contractor",
        "name": "Plumbing Contractor Exam Prep",
        "title": "Plumbing Contractor License Practice Test & Business Guide",
        "desc": "Prepare for the Plumbing Contractor Licensing Exam. Features mock exams, project estimation, and contract law questions.",
        "price": "$19.99",
        "keywords": ["plumbing contractor practice test"],
        "faqs": [
            {"q": "What is a Plumbing Contractor license?", "a": "A contractor license allows you to operate a plumbing company, bid on commercial projects, hire journeyman employees, and manage contracts."},
            {"q": "Is the contractor exam focused on coding or business?", "a": "It covers both. Usually, candidates must pass two separate parts: a technical plumbing code exam and a Business, Law, and Project Management exam."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Plumbing Contractor License Study Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Operating a contracting business requires business acumen and deep technical capabilities. The <a href="../../master-contractor/contractor-prep/index.html" title="Plumbing Contractor Exam Prep">plumbing contractor practice test</a> prepares you to take charge of contracts and manage project execution.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">1. Contract Management & Law</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Plumbing contractors must write valid contracts, submit mechanic's liens, and comply with labor laws. Sizing contracts and managing cash flows are crucial to maintaining solvency during commercial building phases.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">2. Estimating & Bidding</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Estimating requires calculating labor hours, overhead, materials costs, and profit margins. A single mathematical error in bidding can lead to thousands of dollars in losses.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Practice advanced design sizing questions using the <a href="../../master-contractor/master-prep/index.html" title="Master Plumbing Practice Test">master plumbing practice test</a> to ensure your technical skills match your business skills.</p>
        """,
        "questions": [
            {"Category": "Contracts", "Question": "Which legal document allows a contractor to secure a claim against a property for unpaid plumbing services?", "OptionA": "Mechanic's Lien", "OptionB": "Performance Bond", "OptionC": "Promissory Note", "OptionD": "Purchase Order", "CorrectOption": "OptionA", "Explanation": "A mechanic's lien is a legal claim filed against a property by contractors or subcontractors to secure payment for work performed."},
            {"Category": "Estimation", "Question": "If a commercial project requires 120 man-hours to complete, how many days will it take a crew of 3 plumbers working 8-hour days?", "OptionA": "3 days", "OptionB": "5 days", "OptionC": "8 days", "OptionD": "10 days", "CorrectOption": "OptionB", "Explanation": "A crew of 3 plumbers working 8 hours provides 24 man-hours per day. 120 / 24 = 5 days."},
            {"Category": "Estimation", "Question": "Which of the following is considered an indirect overhead cost for a plumbing contractor?", "OptionA": "Copper pipe fittings", "OptionB": "Job site permit fees", "OptionC": "Office rent", "OptionD": "Subcontractor labor", "CorrectOption": "OptionC", "Explanation": "Office rent is an indirect overhead expense that cannot be billed directly to a specific project but is necessary to run the business."},
            {"Category": "Codes", "Question": "What is the maximum allowed pressure in residential water lines under standard safety codes?", "OptionA": "50 psi", "OptionB": "80 psi", "OptionC": "100 psi", "OptionD": "120 psi", "CorrectOption": "OptionB", "Explanation": "Standard residential plumbing codes require water pressure to be regulated to not exceed 80 psi to protect fixtures and piping."},
            {"Category": "Safety", "Question": "Under OSHA rules, trench excavations must be inspected by a competent person at least how often?", "OptionA": "Daily", "OptionB": "Weekly", "OptionC": "Every 2 hours", "OptionD": "Only after rainfall", "CorrectOption": "OptionA", "Explanation": "OSHA requires trench excavations to be inspected daily, prior to worker entry, and after any hazard-increasing event like rain."},
            {"Category": "Contracts", "Question": "What type of bond guarantees that a contractor will complete the project according to contract terms?", "OptionA": "Bid Bond", "OptionB": "Payment Bond", "OptionC": "Performance Bond", "OptionD": "Maintenance Bond", "CorrectOption": "OptionC", "Explanation": "A Performance Bond guarantees the owner that the project will be finished according to contract plans and specifications."},
            {"Category": "Taxation", "Question": "Which tax form must a contractor issue to self-employed subcontractors who earn over $600 in a year?", "OptionA": "W-2", "OptionB": "1099-NEC", "OptionC": "Form 940", "OptionD": "W-4", "CorrectOption": "OptionB", "Explanation": "Form 1099-NEC is used to report nonemployee compensation paid to independent subcontractors."},
            {"Category": "Sizing", "Question": "What is the minimum diameter of a building drain in a commercial building with 20 public water closets?", "OptionA": "3 inches", "OptionB": "4 inches", "OptionC": "6 inches", "OptionD": "8 inches", "CorrectOption": "OptionB", "Explanation": "A 4-inch building drain is required to carry the load of multiple water closets (up to 180 DFUs under standard tables)."},
            {"Category": "Codes", "Question": "What is the minimum sizing for a commercial food-service grease interceptor connected to a commercial pot sink?", "OptionA": "5 gallons per minute (GPM)", "OptionB": "10 GPM", "OptionC": "20 GPM", "OptionD": "50 GPM", "CorrectOption": "OptionC", "Explanation": "Commercial three-compartment pot sinks typically require a minimum 20 GPM flow-rated grease trap."},
            {"Category": "Safety", "Question": "At what depth does a trench require a protective shoring, shielding, or sloping system under OSHA rules?", "OptionA": "3 feet", "OptionB": "4 feet", "OptionC": "5 feet", "OptionD": "8 feet", "CorrectOption": "OptionC", "Explanation": "OSHA requires shoring, shielding, or sloping for trenches 5 feet or deeper, or shallower if cave-in hazards exist."}
        ]
    },
    {
        "id": "tradesman-prep",
        "silo": "tradesman-other",
        "name": "Tradesman Plumber Exam Prep",
        "title": "Tradesman Plumber Practice Test - Interactive Licensing Simulator",
        "desc": "Study for your Tradesman Plumber Exam. Online practice tests, standard tool identification, and safety prep.",
        "price": "$19.99",
        "keywords": ["tradesman plumber practice test", "tradesman plumber test"],
        "faqs": [
            {"q": "What is a Tradesman Plumber license?", "a": "A tradesman license is a mid-tier plumbing license (often in Texas or Virginia) that allows the holder to work on residential one- and two-family dwellings without direct supervision."},
            {"q": "How is a tradesman exam different from a journeyman exam?", "a": "The tradesman plumber test focuses mostly on residential single-family building codes, tool usage, safety, and basic materials, while excluding commercial drainage sizing."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Tradesman Plumber Licensing Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Becoming a <a href="../../tradesman-other/tradesman-prep/index.html" title="Tradesman Plumber Exam Prep">tradesman plumber</a> is the first major step to working independently on residential projects. The <a href="../../tradesman-other/tradesman-prep/practice.html" title="Tradesman Plumber Practice Test">tradesman plumber practice test</a> covers all residential regulations.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">1. Residential Drainage & Venting</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Tradesman exams focus heavily on the International Residential Code (IRC) plumbing chapters. You must learn trap weir clearances, residential water closet spacing (15 inches from centerline to side walls), and basic venting offsets.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">2. Basic Materials & Safety</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Understanding joining methods for PEX, Copper, ABS, and PVC, alongside OSHA trench safety rules, represents a critical part of the written exam. Our practice engine helps you master these definitions.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Once you pass this, you can aim for the next level: check out our <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber License Test">journeyman plumber license test</a> simulator to prepare for commercial work.</p>
        """,
        "questions": [
            {"Category": "Residential Code", "Question": "What is the minimum clearance from the center of a residential water closet to any side wall or partition?", "OptionA": "12 inches", "OptionB": "15 inches", "OptionC": "18 inches", "OptionD": "21 inches", "CorrectOption": "OptionB", "Explanation": "Plumbing codes require at least 15 inches of clear space from the centerline of a toilet to any side wall or obstruction."},
            {"Category": "Residential Code", "Question": "What is the minimum clearance in front of a residential toilet to the opposite wall or fixture?", "OptionA": "18 inches", "OptionB": "21 inches", "OptionC": "24 inches", "OptionD": "30 inches", "CorrectOption": "OptionD", "Explanation": "A minimum of 21 inches of clear space is required in front of the toilet, although 30 inches is highly recommended for accessibility."},
            {"Category": "Materials", "Question": "What is the proper tool used to cut copper tubing to ensure a clean, square end?", "OptionA": "Hacksaw", "OptionB": "Tubing cutter", "OptionC": "Reciprocating saw", "OptionD": "Miter saw", "CorrectOption": "OptionB", "Explanation": "A tubing cutter (wheel cutter) is the standard tool used to make clean, square cuts on copper pipe."},
            {"Category": "Safety", "Question": "What is the primary danger when working inside deep trenches without shoring?", "OptionA": "Tripping", "OptionB": "Sewer gas inhalation", "OptionC": "Cave-in and burial", "OptionD": "Water accumulation", "CorrectOption": "OptionC", "Explanation": "Cave-ins represent the single most dangerous hazard when excavating trenches without protective shoring or shielding."},
            {"Category": "Venting", "Question": "What is the minimum size of a residential kitchen sink drain line?", "OptionA": "1-1/4 inches", "OptionB": "1-1/2 inches", "OptionC": "2 inches", "OptionD": "3 inches", "CorrectOption": "OptionB", "Explanation": "A residential kitchen sink requires a minimum 1-1/2 inch waste line under standard residential plumbing codes."},
            {"Category": "Residential Code", "Question": "What is the minimum size of a residential shower drain?", "OptionA": "1-1/4 inches", "OptionB": "1-1/2 inches", "OptionC": "2 inches", "OptionD": "3 inches", "CorrectOption": "OptionC", "Explanation": "Standard residential codes require a shower drain to be at least 2 inches in diameter (although some local jurisdictions allow 1-1/2 inches for prefabricated pans)."},
            {"Category": "Materials", "Question": "What chemical cement is used to weld ABS piping?", "OptionA": "Purple primer and clear PVC cement", "OptionB": "Yellow ABS cement only", "OptionC": "Transition cement", "OptionD": "Solder flux", "CorrectOption": "OptionB", "Explanation": "ABS pipe is joined using a single-step yellow ABS cement without primer."},
            {"Category": "Venting", "Question": "Which type of vent uses the drainage pipe of one fixture as the vent for another?", "OptionA": "Common vent", "OptionB": "Wet vent", "OptionC": "Loop vent", "OptionD": "Yoke vent", "CorrectOption": "OptionB", "Explanation": "A wet vent is a vent pipe that also serves as a drain for one or more fixtures in the same group."},
            {"Category": "Safety", "Question": "Under OSHA guidelines, how close to the edge of an excavation can the spoil pile be placed?", "OptionA": "At the very edge", "OptionB": "At least 1 foot", "OptionC": "At least 2 feet", "OptionD": "At least 5 feet", "CorrectOption": "OptionC", "Explanation": "OSHA requires the spoil pile (excavated dirt) to be kept at least 2 feet back from the edge of the trench to prevent cave-ins."},
            {"Category": "Traps", "Question": "What is the maximum allowed distance between a plumbing fixture and its trap?", "OptionA": "12 inches", "OptionB": "24 inches", "OptionC": "30 inches", "OptionD": "36 inches", "CorrectOption": "OptionB", "Explanation": "The vertical distance from a fixture's outlet to its trap weir must not exceed 24 inches to limit waste decomposition odor."}
        ]
    },
    {
        "id": "inspector-prep",
        "silo": "tradesman-other",
        "name": "Plumbing Inspector Practice Test",
        "title": "Plumbing Inspector Practice Test & Code Compliance Guide",
        "desc": "Prepare for the ICC Plumbing Inspector Certification Exam. Study code violations, testing protocols, and compliance criteria.",
        "price": "$19.99",
        "keywords": ["plumbing inspector practice test"],
        "faqs": [
            {"q": "What certification is required to become a Plumbing Inspector?", "a": "Most municipalities require passing the ICC (International Code Council) P1 or P2 Plumbing Inspector exams."},
            {"q": "What is the focus of the inspector exam?", "a": "The exam focuses heavily on code compliance, identifying violations, testing procedures (water/air pressure tests), plan reading, and public health protection."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Plumbing Inspector Compliance Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Plumbing inspectors play a vital role in public health by ensuring installations adhere strictly to safety codes. The <a href="../../tradesman-other/inspector-prep/index.html" title="Plumbing Inspector Practice Test">plumbing inspector practice test</a> covers plan reviews, structural support codes, and code violation detection.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">1. Inspecting Testing & Testing Standards</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Inspectors must verify that DWV systems hold water (10-foot head) or air pressure (5 psi) during rough-in inspections. Potable water lines must be inspected at pressure ratings exceeding working loads.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">2. Identifying Common Violations</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Common inspection failures include lack of thermal expansion tanks on closed water loops, inadequate spacing between fixtures, illegal S-traps, and unvented laundry standpipes.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Brush up on code regulations using our <a href="../../general/code-cert-prep/index.html" title="Plumbing Code Practice Test">plumbing code practice test</a> to master advanced code books.</p>
        """,
        "questions": [
            {"Category": "Testing", "Question": "What is the minimum required duration for a water test on a completed DWV system rough-in?", "OptionA": "5 minutes", "OptionB": "15 minutes", "OptionC": "30 minutes", "OptionD": "60 minutes", "CorrectOption": "OptionB", "Explanation": "Standard codes require water tests on drainage rough-ins to hold pressure for at least 15 minutes without leaking."},
            {"Category": "Compliance", "Question": "What backflow prevention method is universally considered the most reliable and fail-safe?", "OptionA": "Double check valve", "OptionB": "Potable vacuum breaker", "OptionC": "Reduced pressure zone (RPZ) preventer", "OptionD": "Air gap", "CorrectOption": "OptionD", "Explanation": "An physical air gap is the most reliable backflow protection method because it has no moving parts to fail."},
            {"Category": "Violations", "Question": "Which trap style is an inspector required to reject on a sanitary drainage system?", "OptionA": "P-trap", "OptionB": "S-trap", "OptionC": "Deep seal trap", "OptionD": "Anti-siphon trap", "CorrectOption": "OptionB", "Explanation": "S-traps are code violations because they lack venting and can siphon themselves empty during drainage flow."},
            {"Category": "Safety", "Question": "What device must be installed on a domestic water heater system to control pressure increase due to thermal expansion?", "OptionA": "Pressure regulator", "OptionB": "Thermal expansion tank", "OptionC": "Backflow preventer", "OptionD": "Vacuum breaker", "CorrectOption": "OptionB", "Explanation": "Thermal expansion tanks are required on closed water distribution systems to absorb expansion and prevent water heater rupture."},
            {"Category": "Compliance", "Question": "What is the minimum distance between a water service pipe and a building sewer pipe in the same trench?", "OptionA": "2 feet", "OptionB": "5 feet", "OptionC": "10 feet", "OptionD": "Water and sewer cannot share a trench unless sewer is rated as water pipe", "CorrectOption": "OptionD", "Explanation": "Water and sewer lines must be separated horizontally by 10 feet of undisturbed earth unless the sewer pipe is rated for water service."},
            {"Category": "Venting", "Question": "What is the minimum height that a vent terminal must extend above the flood level rim of a fixture before turning horizontally?", "OptionA": "2 inches", "OptionB": "6 inches", "OptionC": "12 inches", "OptionD": "At least 6 inches above flood rim", "CorrectOption": "OptionD", "Explanation": "Vents must rise at least 6 inches above the flood rim of the highest fixture served before offsetting horizontally to prevent backing up."},
            {"Category": "Violations", "Question": "Which fixture is an inspector guaranteed to reject if it lacks an air gap on its waste line?", "OptionA": "Commercial dishwasher", "OptionB": "Residential kitchen sink", "OptionC": "Bidet", "OptionD": "Residential bathtub", "CorrectOption": "OptionA", "Explanation": "Commercial dishwashers must drain indirectly through an air gap to prevent wastewater backflow into food equipment."},
            {"Category": "Sizing", "Question": "What is the fixture unit rating (DFU) of a standard commercial water closet (flush valve)?", "OptionA": "3 DFUs", "OptionB": "4 DFUs", "OptionC": "6 DFUs", "OptionD": "10 DFUs", "CorrectOption": "OptionC", "Explanation": "A flush valve commercial water closet is rated at 6 drainage fixture units (DFUs)."},
            {"Category": "Hangers", "Question": "What is the maximum horizontal support spacing for 3-inch PVC pipe under IPC?", "OptionA": "4 feet", "OptionB": "6 feet", "OptionC": "8 feet", "OptionD": "10 feet", "CorrectOption": "OptionA", "Explanation": "Horizontal PVC piping of all sizes must be supported at maximum intervals of 4 feet to maintain grade alignment."},
            {"Category": "Testing", "Question": "When performing an air test on a DWV system, what pressure must the system hold for 15 minutes?", "OptionA": "2 psi", "OptionB": "5 psi", "OptionC": "10 psi", "OptionD": "30 psi", "CorrectOption": "OptionB", "Explanation": "An air test on drainage rough-in piping requires holding a constant pressure of 5 psi (or 10 inches of mercury) for 15 minutes."}
        ]
    },
    {
        "id": "residential-prep",
        "silo": "general",
        "name": "Residential Plumbing Practice Test",
        "title": "Residential Plumbing Practice Test & Study Guide",
        "desc": "Pass your residential plumbing exams. Covers single-family home code regulations, sizing charts, and venting.",
        "price": "$19.99",
        "keywords": ["residential plumbing practice test"],
        "faqs": [
            {"q": "What code regulates residential plumbing?", "a": "Residential plumbing is regulated by the International Residential Code (IRC) (specifically Chapters 25-32 in the IRC) or the local plumbing code."},
            {"q": "How is a residential test different from a commercial test?", "a": "Residential tests exclude heavy commercial requirements (like grease interceptors, medical gas piping, complex backflow systems) and focus strictly on single-family home systems."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Residential Plumbing Code Study Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">To pass residential examinations, you must master the plumbing chapters of the IRC. The <a href="../../general/residential-prep/index.html" title="Residential Plumbing Practice Test">residential plumbing practice test</a> targets typical residential sizing scenarios.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">1. Sizing Residential Water Lines</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Potable water piping must be sized based on total Fixture Unit values (WSFU). You must calculate fixture counts for showers, bidets, sinks, and toilets, and use sizing charts to define supply pipe diameters.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">2. Water Heater Installations</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Sizing vents for gas water heaters, installing pressure relief valves (T&P), and adding thermal expansion tanks are critical elements of residential building code compliance.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">If you are preparing for a general license, try our <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber Test Prep">journeyman plumber test prep</a> which covers both residential and commercial exams.</p>
        """,
        "questions": [
            {"Category": "Residential Sizing", "Question": "What is the water supply fixture unit (WSFU) value of a standard residential lavatory faucet?", "OptionA": "0.5 WSFU", "OptionB": "1 WSFU", "OptionC": "2 WSFU", "OptionD": "2.5 WSFU", "CorrectOption": "OptionB", "Explanation": "Under residential water supply tables, a lavatory faucet is rated at 1 WSFU for private use."},
            {"Category": "Residential Sizing", "Question": "What is the minimum diameter of a residential main building drain?", "OptionA": "2 inches", "OptionB": "3 inches", "OptionC": "4 inches", "OptionD": "1-1/2 inches", "CorrectOption": "OptionB", "Explanation": "The building drain for a single-family home must be at least 3 inches in diameter to allow toilet waste flows."},
            {"Category": "Venting", "Question": "What is the maximum distance a 2-inch fixture trap can be from its vent?", "OptionA": "5 feet", "OptionB": "6 feet", "OptionC": "8 feet", "OptionD": "10 feet", "CorrectOption": "OptionC", "Explanation": "Standard residential plumbing codes allow a maximum horizontal distance of 8 feet between a 2-inch trap and its vent line."},
            {"Category": "Water Heaters", "Question": "The discharge pipe from a T&P relief valve must terminate how far above the floor or waste receptor?", "OptionA": "No more than 6 inches", "OptionB": "No more than 12 inches", "OptionC": "Exactly 1 inch", "OptionD": "Flush with the floor", "CorrectOption": "OptionA", "Explanation": "T&P relief discharge pipes must terminate indirectly, pointing down, between 1 inch and 6 inches above the floor or pan to prevent safety hazards."},
            {"Category": "Sizing", "Question": "What is the minimum size of a residential bathtub drain line?", "OptionA": "1-1/4 inches", "OptionB": "1-1/2 inches", "OptionC": "2 inches", "OptionD": "3 inches", "CorrectOption": "OptionB", "Explanation": "Residential tub drains must be at least 1-1/2 inches in diameter under standard IRC codes."},
            {"Category": "Materials", "Question": "Which piping material is approved for underground domestic water service lines inside a residential building lot?", "OptionA": "PVC Schedule 40", "OptionB": "PEX", "OptionC": "Galvanized steel", "OptionD": "Copper Type M", "CorrectOption": "OptionB", "Explanation": "PEX tubing is highly approved for underground water service lines and provides durability without corrosion issues."},
            {"Category": "Compliance", "Question": "What is the minimum clearance in front of a residential kitchen sink?", "OptionA": "18 inches", "OptionB": "21 inches", "OptionC": "24 inches", "OptionD": "30 inches", "CorrectOption": "OptionB", "Explanation": "Codes require at least 21 inches of clear work space in front of residential fixtures including kitchen sinks."},
            {"Category": "Venting", "Question": "What type of vent system uses a single vertical stack serving as the vent and drain for multiple residential fixtures?", "OptionA": "Circuit vent", "OptionB": "Common vent", "OptionC": "Wet vent", "OptionD": "Waste stack vent", "CorrectOption": "OptionC", "Explanation": "Wet venting uses a single pipe section as both a drain and a vent for fixtures within the same bathroom group."},
            {"Category": "Traps", "Question": "What is the maximum allowed horizontal offset for a residential laundry standpipe?", "OptionA": "No offset allowed", "OptionB": "12 inches", "OptionC": "24 inches", "OptionD": "36 inches", "CorrectOption": "OptionA", "Explanation": "A laundry standpipe must be a straight vertical line without offsets to ensure fast pumping drainage from washer pumps."},
            {"Category": "Materials", "Question": "What joint type is prohibited for joining PEX tubing under standard building codes?", "OptionA": "Crimp ring joints", "OptionB": "Expansion joints", "OptionC": "Threaded compression joints", "OptionD": "Solvent welding joints", "CorrectOption": "OptionD", "Explanation": "PEX cannot be solvent welded (glued); it must be joined using mechanical fittings, crimps, or expansion sleeves."}
        ]
    },
    {
        "id": "code-cert-prep",
        "silo": "general",
        "name": "Plumbing Code & Certification Prep",
        "title": "Plumbing Code & Certification Practice Test - Interactive Prep",
        "desc": "Master code standards. IPC and UPC multiple-choice tests, code lookup exercises, and certification study guides.",
        "price": "$19.99",
        "keywords": ["plumbing code practice test", "plumbing certification practice test", "plumbing exam practice test"],
        "faqs": [
            {"q": "What code books are tested on plumbing certification exams?", "a": "Exams generally reference either the International Plumbing Code (IPC) published by the ICC, or the Uniform Plumbing Code (UPC) published by IAPMO."},
            {"q": "How can I master code book lookups?", "a": "Learn to navigate the indexes and table of contents. Focus on drainage sizing tables, vent sizing limits, and water supply fixture values."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Plumbing Code & Compliance Study Guide</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">National plumbing certifications require passing a comprehensive closed-book or open-book written code exam. The <a href="../../general/code-cert-prep/index.html" title="Plumbing Code Practice Test">plumbing code practice test</a> is the ideal simulator to master the IPC and UPC tables.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">1. Sizing Drainage & Venting Stacks</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Sizing calculations represent a massive portion of the certification exam. You must know how to size horizontal fixtures branch lines, soil stacks, vent stacks, and building sewers using code tables.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">2. potability Protection</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Backflow prevention codes define exactly where check valves, vacuum breakers, and air gaps are required. Potable water must be protected against back-siphonage and backpressure.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Check out our <a href="../../general/free-prep/index.html" title="Free Plumbing Practice Test">plumbing practice test free</a> to run basic tests before purchasing our premium timed mock simulator.</p>
        """,
        "questions": [
            {"Category": "IPC Codes", "Question": "Under International Plumbing Code rules, what is the maximum number of drainage fixture units allowed on a 4-inch horizontal drain pipe at 1/4 inch slope?", "OptionA": "160 DFUs", "OptionB": "216 DFUs", "OptionC": "250 DFUs", "OptionD": "500 DFUs", "CorrectOption": "OptionB", "Explanation": "IPC drainage sizing tables limit a 4-inch horizontal branch drain at a 1/4 inch slope to a maximum load of 216 DFUs."},
            {"Category": "UPC Codes", "Question": "Under Uniform Plumbing Code (UPC) rules, what is the maximum length of a 2-inch vent pipe?", "OptionA": "60 feet", "OptionB": "120 feet", "OptionC": "150 feet", "OptionD": "200 feet", "CorrectOption": "OptionB", "Explanation": "The UPC restricts the length of a 2-inch vent serving standard loads to a maximum of 120 feet."},
            {"Category": "Backflow", "Question": "Which device is suitable for backflow protection where backpressure and high health hazards exist?", "OptionA": "Atmospheric vacuum breaker", "OptionB": "Double check valve assembly", "OptionC": "Reduced pressure zone (RPZ) backflow preventer", "OptionD": "Pressure vacuum breaker", "CorrectOption": "OptionC", "Explanation": "RPZ backflow preventers are the only mechanical assemblies rated for high health hazards involving backpressure."},
            {"Category": "Venting", "Question": "What is the maximum distance between a vent connection and the fixture trap for a 1-1/4 inch drain pipe under IPC?", "OptionA": "3.5 feet", "OptionB": "5 feet", "OptionC": "6 feet", "OptionD": "8 feet", "CorrectOption": "OptionB", "Explanation": "The maximum horizontal distance between a 1-1/4 inch trap and its vent connection is 5 feet."},
            {"Category": "Materials", "Question": "What is the required color marking for underground copper water lines carrying potable water?", "OptionA": "Blue stripe", "OptionB": "Red stripe", "OptionC": "Green stripe", "OptionD": "Yellow stripe", "CorrectOption": "OptionA", "Explanation": "potable water service piping is marked with blue color indicators or stripes to distinguish it from other lines."},
            {"Category": "Cleanouts", "Question": "What is the minimum required size of a cleanout serving a 4-inch sewer pipe?", "OptionA": "3 inches", "OptionB": "3-1/2 inches", "OptionC": "4 inches", "OptionD": "6 inches", "CorrectOption": "OptionC", "Explanation": "Cleanouts must be the same size as the piping they serve up to 4 inches; therefore, a 4-inch sewer requires a 4-inch cleanout."},
            {"Category": "Venting", "Question": "A vent stack must terminate at least how far horizontally from any building window or air intake?", "OptionA": "3 feet", "OptionB": "5 feet", "OptionC": "10 feet", "OptionD": "15 feet", "CorrectOption": "OptionC", "Explanation": "Vent terminals must be at least 10 feet away horizontally from any openable window, door, or ventilation intake."},
            {"Category": "Sizing", "Question": "What is the fixture unit value of a residential water closet (gravity tank)?", "OptionA": "3 DFUs", "OptionB": "4 DFUs", "OptionC": "6 DFUs", "OptionD": "8 DFUs", "CorrectOption": "OptionA", "Explanation": "Under modern codes, a residential water closet is rated at 3 drainage fixture units (DFUs)."},
            {"Category": "Hangers", "Question": "What is the maximum horizontal support spacing for threaded black iron pipe of 1-1/2 inches?", "OptionA": "10 feet", "OptionB": "12 feet", "OptionC": "15 feet", "OptionD": "20 feet", "CorrectOption": "OptionB", "Explanation": "Threaded steel piping of 1-1/2 inches must be supported horizontally at intervals not exceeding 12 feet."},
            {"Category": "Compliance", "Question": "What is the minimum vertical air gap between a faucet outlet and the flood rim of a bathroom lavatory?", "OptionA": "1 inch", "OptionB": "1.5 inches", "OptionC": "2 inches", "OptionD": "2.5 inches", "CorrectOption": "OptionA", "Explanation": "Bathroom lavatories require a minimum air gap of 1 inch (or twice the effective opening diameter of the faucet outlet)."}
        ]
    },
    {
        "id": "free-prep",
        "silo": "general",
        "name": "Free Plumbing Practice Test",
        "title": "Free Journeyman Plumber Practice Test - Full Interactive Quiz",
        "desc": "Access our free plumbing license practice test. Dynamic questions, score widgets, and answers explained.",
        "price": "Free",
        "keywords": ["free journeyman plumber practice test", "journeyman plumber practice test free", "plumbing practice test free", "plumbing license practice test"],
        "faqs": [
            {"q": "Is this practice test 100% free?", "a": "Yes, our general practice simulator is free. We also offer a premium upgrade ($19.99) that includes PDF study guides and an expanded question bank of 500+ questions."},
            {"q": "Do I need to register to take this free plumbing exam?", "a": "No registration is required. You can load the interactive simulator directly in your browser."}
        ],
        "article": """
            <h2 style="font-size: 1.8rem; color: white; margin-bottom: 1.5rem; font-weight: 800; border-bottom: 1px solid var(--bg-card-border); padding-bottom: 0.75rem;">Free Plumbing License Practice Test Portal</h2>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Preparing for a licensing exam does not have to be expensive. Our <a href="../../general/free-prep/index.html" title="Free Journeyman Plumber Practice Test">free journeyman plumber practice test</a> gives you instant access to typical licensing questions to check your knowledge.</p>
            
            <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 700;">No Registration Required</h3>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Unlike other study sites, we do not require email sign-ups. Simply load the simulator and begin answering questions. Vents, drains, gas sizing, and safety protocols are covered.</p>
            <p style="color: var(--text-secondary); margin-bottom: 1.5rem;">Ready to upgrade to timed mock exams? Check out our premium <a href="../../journeyman/general-prep/index.html" title="Journeyman Plumber License Exam Prep">journeyman plumber exam prep</a> containing complete 100-question timed exams.</p>
        """,
        "questions": [
            {"Category": "General Codes", "Question": "What is the minimum size of a building sewer pipe?", "OptionA": "2 inches", "OptionB": "3 inches", "OptionC": "4 inches", "OptionD": "6 inches", "CorrectOption": "OptionB", "Explanation": "Standard codes require building sewers to be a minimum of 3 inches in diameter to avoid blockages from solids."},
            {"Category": "General Codes", "Question": "Which vent terminal parameter prevents sewer gas from entering windows?", "OptionA": "Must terminate 10 feet away horizontally", "OptionB": "Must terminate 3 feet away horizontally", "OptionC": "Must terminate 5 feet away horizontally", "OptionD": "No horizontal distance is specified", "CorrectOption": "OptionA", "Explanation": "Vents must terminate at least 10 feet horizontally from any building opening (windows, doors, vents) to protect indoor air quality."},
            {"Category": "Traps", "Question": "What is the maximum allowed seal depth for a standard plumbing trap?", "OptionA": "2 inches", "OptionB": "3 inches", "OptionC": "4 inches", "OptionD": "6 inches", "CorrectOption": "OptionC", "Explanation": "Plumbing traps must have a liquid seal depth of at least 2 inches and no more than 4 inches under standard codes."},
            {"Category": "Materials", "Question": "Which pipe joining method is suitable for underground copper tubing?", "OptionA": "Solvent welding", "OptionB": "Soldering or brazing", "OptionC": "Threaded couplings", "OptionD": "Push-fit connectors", "CorrectOption": "OptionB", "Explanation": "Underground copper joints must be soldered or brazed using lead-free alloy for maximum mechanical strength."},
            {"Category": "Sizing", "Question": "What is the drainage fixture unit (DFU) value of a domestic bidet?", "OptionA": "1 DFU", "OptionB": "2 DFUs", "OptionC": "3 DFUs", "OptionD": "4 DFUs", "CorrectOption": "OptionA", "Explanation": "A residential bidet is rated at 1 DFU under drainage piping tables."},
            {"Category": "Venting", "Question": "What is the primary purpose of venting a plumbing fixture?", "OptionA": "To allow water to drain faster", "OptionB": "To supply oxygen to aerobic sewer bacteria", "OptionC": "To maintain atmospheric pressure and protect trap seals", "OptionD": "To prevent pipe corrosion", "CorrectOption": "OptionC", "Explanation": "Venting prevents pressure drops or spikes that would siphon trap seals and allow sewer gases to enter living spaces."},
            {"Category": "Valves", "Question": "What valve is designed to prevent water flow in the reverse direction?", "OptionA": "Gate valve", "OptionB": "Check valve", "OptionC": "Globe valve", "OptionD": "Ball valve", "CorrectOption": "OptionB", "Explanation": "A check valve allows water to flow in one direction only, blocking any reverse flow (backflow)."},
            {"Category": "Cleanouts", "Question": "A cleanout is required at what maximum angle of change in direction for drainage piping?", "OptionA": "Greater than 45 degrees", "OptionB": "Greater than 90 degrees", "OptionC": "Greater than 135 degrees", "OptionD": "No angle requirement", "CorrectOption": "OptionA", "Explanation": "A cleanout is required for any aggregate change in direction of horizontal piping exceeding 45 degrees."},
            {"Category": "Safety", "Question": "What is the minimum width of an OSHA-compliant exit path from an excavation trench?", "OptionA": "12 inches", "OptionB": "18 inches", "OptionC": "20 inches", "OptionD": "24 inches", "CorrectOption": "OptionC", "Explanation": "OSHA egress ladders or ramps must provide a clear width of at least 20 inches."},
            {"Category": "Sizing", "Question": "What is the minimum required drainage pipe size for a toilet?", "OptionA": "2 inches", "OptionB": "3 inches", "OptionC": "4 inches", "OptionD": "1-1/2 inches", "CorrectOption": "OptionB", "Explanation": "Toilets require a minimum waste outlet and drain pipe of 3 inches to prevent clogging."}
        ]
    }
]

# Write Category Main Hub Index
category_hub_content = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Prepare for plumbing licensing exams with our structured study guides and practice tests. Study Journeyman, Master, Contractor, and Tradesman plumbing preps.">
    <title>Plumbing License Exam Prep Portal - Silo Categories</title>
    <link rel="stylesheet" href="../../style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo">
                🔧 PlumbingLicense <span>Prep</span>
            </div>
            <nav aria-label="Main Navigation">
                <ul style="display: flex; gap: 1.5rem; list-style: none;">
                    <li><a href="../../index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Home</a></li>
                    <li><a href="#categories" style="color: var(--primary); text-decoration: none; font-weight: 600;">Silo Hubs</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <!-- SEO Breadcrumbs -->
        <nav aria-label="Breadcrumb" class="breadcrumbs" style="margin-bottom: 2rem; font-size: 0.9rem; color: var(--text-secondary);">
            <a href="../../index.html" style="color: var(--primary); text-decoration: none;">Home</a> &gt; 
            <span style="color: var(--text-primary);">Plumbing License Prep</span>
        </nav>

        <section class="hero" id="home">
            <h1>Plumbing License Exam Preparation Silos</h1>
            <p>Select your license silo to access targeted study guides, practice tests, and interactive simulator tools.</p>
        </section>

        <section id="categories" style="margin-top: 3rem;">
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem;">
                
                <!-- Journeyman Silo Card -->
                <article class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                    <div>
                        <h3 style="font-size: 1.4rem; font-weight: 700; margin-bottom: 0.75rem; color: white;">Journeyman Plumber Silo</h3>
                        <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 1.5rem;">Sizing charts, drainage calculations, and state board exams (TX, VA, KS, MA, WSSC).</p>
                    </div>
                    <a href="journeyman/index.html" class="btn-primary" style="text-align: center; text-decoration: none; padding: 0.8rem;">
                        Explore Journeyman Preps
                    </a>
                </article>

                <!-- Master & Contractor Silo Card -->
                <article class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                    <div>
                        <h3 style="font-size: 1.4rem; font-weight: 700; margin-bottom: 0.75rem; color: white;">Master &amp; Contractor Silo</h3>
                        <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 1.5rem;">Advanced engineering, estimating, law and project management licensing exams.</p>
                    </div>
                    <a href="master-contractor/index.html" class="btn-primary" style="text-align: center; text-decoration: none; padding: 0.8rem;">
                        Explore Advanced Preps
                    </a>
                </article>

                <!-- Tradesman & Other Silo Card -->
                <article class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                    <div>
                        <h3 style="font-size: 1.4rem; font-weight: 700; margin-bottom: 0.75rem; color: white;">Tradesman &amp; Inspector Silo</h3>
                        <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 1.5rem;">Residential codes, building inspector certifications, and compliance preps.</p>
                    </div>
                    <a href="tradesman-other/index.html" class="btn-primary" style="text-align: center; text-decoration: none; padding: 0.8rem;">
                        Explore Residential Preps
                    </a>
                </article>

                <!-- General & Free Practice Silo Card -->
                <article class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
                    <div>
                        <h3 style="font-size: 1.4rem; font-weight: 700; margin-bottom: 0.75rem; color: white;">General &amp; Free Silo</h3>
                        <p style="color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 1.5rem;">Free practice questions, plumbing codes tables, and residential codes ref.</p>
                    </div>
                    <a href="general/index.html" class="btn-primary" style="text-align: center; text-decoration: none; padding: 0.8rem;">
                        Explore Free Preps
                    </a>
                </article>

            </div>
        </section>
    </main>

    <footer>
        <div class="footer-content">
            <div>© 2026 Plumbing License Prep.</div>
            <div><a href="../../index.html" style="color: var(--text-secondary); text-decoration: none;">Main Portal Home</a></div>
        </div>
    </footer>
</body>
</html>
"""

with open(os.path.join(base_dir, "index.html"), "w", encoding="utf-8") as f:
    f.write(category_hub_content)

# Sub-silo Hub Template Generator
def make_silo_hub(silo_name, title, desc, items_list):
    links_html = ""
    for item in items_list:
        links_html += f"""
        <article class="glass-card" style="display: flex; flex-direction: column; justify-content: space-between;">
            <div>
                <h3 style="font-size: 1.3rem; font-weight: 700; margin-bottom: 0.5rem; color: white;">{item['name']}</h3>
                <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 1.5rem;">{item['desc']}</p>
            </div>
            <div style="display: flex; gap: 0.5rem;">
                <a href="{item['id']}/index.html" class="btn-primary" style="flex-grow: 1; text-align: center; text-decoration: none; padding: 0.7rem; font-size: 0.9rem;">Details</a>
                <a href="{item['id']}/practice.html" class="btn-primary" style="background: rgba(255,255,255,0.05); border: 1px solid var(--bg-card-border); color: white; box-shadow: none; padding: 0.7rem; text-decoration: none; text-align: center; font-size: 0.9rem;">Practice</a>
            </div>
        </article>
        """
    
    content = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{desc}">
    <title>{title}</title>
    <link rel="stylesheet" href="../../../style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo">
                🔧 PlumbingLicense <span>Prep</span>
            </div>
            <nav aria-label="Main Navigation">
                <ul style="display: flex; gap: 1.5rem; list-style: none;">
                    <li><a href="../../../index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Home</a></li>
                    <li><a href="../index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Plumbing Hub</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <!-- SEO Breadcrumbs -->
        <nav aria-label="Breadcrumb" class="breadcrumbs" style="margin-bottom: 2rem; font-size: 0.9rem; color: var(--text-secondary);">
            <a href="../../../index.html" style="color: var(--primary); text-decoration: none;">Home</a> &gt; 
            <a href="../index.html" style="color: var(--primary); text-decoration: none;">Plumbing License Prep</a> &gt; 
            <span style="color: var(--text-primary);">{silo_name.capitalize()} Silo</span>
        </nav>

        <section class="hero" id="home">
            <h1>{silo_name.capitalize()} Exam Packages</h1>
            <p>{desc}</p>
        </section>

        <section style="margin-top: 3rem;">
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                {links_html}
            </div>
        </section>
    </main>

    <footer>
        <div class="footer-content">
            <div>© 2026 Plumbing License Prep.</div>
            <div><a href="../index.html" style="color: var(--text-secondary); text-decoration: none;">Back to Plumbing Hub</a></div>
        </div>
    </footer>
</body>
</html>
"""
    return content

# Generate the 4 Sub-silo Hub index.html pages
for name, path in silos.items():
    items = [p for p in products if p['silo'] == name]
    title = f"{name.replace('-', ' ').title()} plumbing License Exams"
    desc = f"Access specialized mock tests and guides inside our {name} category silo. Start preparing today."
    hub_html = make_silo_hub(name, title, desc, items)
    with open(os.path.join(path, "index.html"), "w", encoding="utf-8") as f:
        f.write(hub_html)

# Product Detail index.html Generator
def make_product_index(p):
    faq_schema = {
        "@context": "https://schema.org",
        "@type": "FAQPage",
        "mainEntity": []
    }
    faq_html = ""
    for faq in p['faqs']:
        faq_schema["mainEntity"].append({
            "@type": "Question",
            "name": faq['q'],
            "acceptedAnswer": {
                "@type": "Answer",
                "text": faq['a']
            }
        })
        faq_html += f"""
        <div style="border-top: 1px solid rgba(255,255,255,0.04); padding-top: 1.5rem;">
            <h3 style="font-size: 1.1rem; color: var(--primary); margin-bottom: 0.5rem; font-weight: 600;">{faq['q']}</h3>
            <p style="color: var(--text-secondary); font-size: 0.95rem; line-height: 1.6;">{faq['a']}</p>
        </div>
        """
        
    course_schema = {
        "@context": "https://schema.org",
        "@type": "Course",
        "name": p['name'],
        "description": p['desc'],
        "provider": {
            "@type": "Organization",
            "name": "Plumbing License Prep",
            "sameAs": "https://eduprosuite-org.github.io/study/"
        }
    }
    
    price_tag_html = f"""<div style="font-size: 2.5rem; font-weight: 800; color: white; margin: 1rem 0 0.5rem;">{p['price']}</div>"""
    paypal_section = ""
    if p['price'] != "Free":
        paypal_section = f"""
        <div style="border-top: 1px solid var(--bg-card-border); padding-top: 1.5rem; margin-bottom: 1.5rem;">
            <p style="color: var(--text-primary); font-size: 0.95rem; font-weight: 600; margin-bottom: 1rem; text-align: center;">Unlock Full Premium Bank via PayPal</p>
            <div id="paypal-button-container" style="min-height: 150px;"></div>
            <div id="payment-success-msg" style="display: none; background: var(--success-glow); border: 1px solid var(--success); color: #34d399; padding: 1rem; border-radius: 12px; text-align: center; margin-top: 1rem;">
                <h4>🎉 Payment Successful!</h4>
                <p style="font-size: 0.85rem; margin-top: 0.5rem; color: var(--text-secondary);">Your premium download link: <a href="#" style="color: white; text-decoration: underline; font-weight: bold;">Download Plumbing Study Guide PDF</a></p>
            </div>
        </div>
        """
    else:
        paypal_section = """
        <div style="border-top: 1px solid var(--bg-card-border); padding-top: 1.5rem; margin-bottom: 1.5rem; text-align: center;">
            <p style="color: var(--success); font-size: 1.1rem; font-weight: 700; margin-bottom: 1rem;">100% Free Practice Engine</p>
            <p style="color: var(--text-secondary); font-size: 0.9rem;">No credit card or registration required. Start taking free exams instantly.</p>
        </div>
        """

    content = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="{p['desc']}">
    <title>{p['title']}</title>
    <link rel="stylesheet" href="../../../../style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <script src="https://www.paypal.com/sdk/js?client-id=test&currency=USD"></script>
    
    <script type="application/ld-json">
    {json.dumps(course_schema, indent=2)}
    </script>
    <script type="application/ld-json">
    {json.dumps(faq_schema, indent=2)}
    </script>
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo">
                🔧 PlumbingLicense <span>Prep</span>
            </div>
            <nav aria-label="Course Navigation">
                <ul style="display: flex; gap: 1.5rem; list-style: none;">
                    <li><a href="../../../../index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Home</a></li>
                    <li><a href="../../index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Plumbing Hub</a></li>
                    <li><a href="practice.html" style="color: var(--primary); text-decoration: none; font-weight: 600;">Practice Simulator</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <!-- SEO Breadcrumbs -->
        <nav aria-label="Breadcrumb" class="breadcrumbs" style="margin-bottom: 2rem; font-size: 0.9rem; color: var(--text-secondary);">
            <a href="../../../../index.html" style="color: var(--primary); text-decoration: none;">Home</a> &gt; 
            <a href="../../index.html" style="color: var(--primary); text-decoration: none;">Plumbing Hub</a> &gt; 
            <a href="../index.html" style="color: var(--primary); text-decoration: none;">{p['silo'].capitalize()}</a> &gt; 
            <span style="color: var(--text-primary);">{p['name']}</span>
        </nav>

        <div class="dashboard-grid">
            <div>
                <section class="glass-card">
                    <h1 style="font-size: 2.2rem; font-weight: 800; margin-bottom: 1rem; color: white;">{p['name']}</h1>
                    <p style="color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 2rem;">{p['desc']}</p>
                    
                    <h2 style="font-size: 1.4rem; color: white; margin-bottom: 1rem; font-weight: 700;">What's Included:</h2>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; color: var(--text-secondary); font-size: 0.95rem; margin-bottom: 2rem;">
                        <div>✔️ 10 Custom Mock Tests</div>
                        <div>✔️ Multi-choice Simulator</div>
                        <div>✔️ Step-by-step Explanations</div>
                        <div>✔️ Built-in Exam Calculator</div>
                    </div>

                    <div style="display: flex; gap: 1rem; align-items: center; border-top: 1px solid var(--bg-card-border); padding-top: 1.5rem;">
                        <a href="practice.html" class="btn-primary" style="text-decoration: none; padding: 0.9rem 2rem;">
                            Start Practice Test Now
                        </a>
                    </div>
                </section>

                <section class="glass-card" style="line-height: 1.8;">
                    {p['article']}
                </section>

                <section class="glass-card">
                    <h2 style="font-size: 1.6rem; color: white; margin-bottom: 1.5rem; font-weight: 700;">Frequently Asked Questions (FAQs)</h2>
                    <div style="display: flex; flex-direction: column; gap: 1.5rem;">
                        {faq_html}
                    </div>
                </section>
            </div>

            <div class="stats-panel">
                <div class="glass-card" style="position: sticky; top: 120px;">
                    <div style="text-align: center; margin-bottom: 1.5rem;">
                        <span style="font-size: 0.9rem; color: var(--secondary); font-weight: 700; background: var(--secondary-glow); padding: 0.25rem 0.8rem; border-radius: 50px; text-transform: uppercase;">License Prep</span>
                        {price_tag_html}
                        <p style="color: var(--text-secondary); font-size: 0.9rem;">One-time purchase. Lifetime access. 30-day money-back guarantee.</p>
                    </div>
                    {paypal_section}
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div>© 2026 Plumbing License Prep.</div>
            <div><a href="../../index.html" style="color: var(--text-secondary); text-decoration: none;">Back to Silo</a></div>
        </div>
    </footer>

    <script>
        if (document.getElementById('paypal-button-container')) {{
            paypal.Buttons({{
                createOrder: function(data, actions) {{
                    return actions.order.create({{
                        purchase_units: [{{
                            amount: {{
                                value: '19.99'
                            }},
                            description: '{p['name']} Course Details Purchase'
                        }}]
                    }});
                }},
                onApprove: function(data, actions) {{
                    return actions.order.capture().then(function(details) {{
                        document.getElementById('paypal-button-container').style.display = 'none';
                        document.getElementById('payment-success-msg').style.display = 'block';
                    }});
                }}
            }}).render('#paypal-button-container');
        }}
    </script>
</body>
</html>
"""
    return content

# Product Practice simulator page generator
def make_product_practice(p):
    content = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Free Interactive Quiz Simulator for {p['name']}. Practice Mock Tests and use the built-in non-programmable calculator.">
    <title>{p['name']} Practice Simulator - Interactive Exam Prep</title>
    <link rel="stylesheet" href="../../../../style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <header>
        <div class="nav-container">
            <div class="logo">
                🔧 PlumbingLicense <span>Prep</span>
            </div>
            <nav aria-label="Course Navigation">
                <ul style="display: flex; gap: 1.5rem; list-style: none;">
                    <li><a href="../../../../index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Home</a></li>
                    <li><a href="index.html" style="color: var(--text-secondary); text-decoration: none; font-weight: 500;">Course Details</a></li>
                    <li><a href="practice.html" class="active" style="color: var(--primary); text-decoration: none; font-weight: 600;">Practice Simulator</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <main>
        <!-- SEO Breadcrumbs -->
        <nav aria-label="Breadcrumb" class="breadcrumbs" style="margin-bottom: 2rem; font-size: 0.9rem; color: var(--text-secondary);">
            <a href="../../../../index.html" style="color: var(--primary); text-decoration: none;">Home</a> &gt; 
            <a href="../../index.html" style="color: var(--primary); text-decoration: none;">Plumbing Hub</a> &gt; 
            <a href="index.html" style="color: var(--primary); text-decoration: none;">{p['name']}</a> &gt; 
            <span style="color: var(--text-primary);">Practice Simulator</span>
        </nav>

        <div class="dashboard-grid">
            <div>
                <div class="glass-card" style="padding: 1.5rem; margin-bottom: 1.5rem;">
                    <h3 class="filter-title">Select Mode</h3>
                    <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                        <button class="filter-btn active" id="mode-practice" onclick="setMode('practice')">Infinite Practice Mode</button>
                        <button class="filter-btn" id="mode-mock" onclick="setMode('mock')">10-Question Mock Test</button>
                    </div>
                </div>

                <div class="glass-card" id="quiz-board">
                    <div class="quiz-header">
                        <span class="category-tag" id="question-category">Category</span>
                        <span class="progress-text" id="progress-count">Completed: 0</span>
                    </div>

                    <div class="question-text" id="question-box">
                        Loading questions from CSV database...
                    </div>

                    <div class="options-container" id="options-container">
                        <!-- Options will be generated dynamically -->
                    </div>

                    <div class="explanation-card" id="explanation-wrapper" style="display: none;">
                        <div class="explanation-title">
                            💡 Step-by-Step Explanation
                        </div>
                        <div class="explanation-text" id="explanation-text">
                            Explanation content.
                        </div>
                    </div>

                    <div class="actions-row" id="next-btn-container" style="display: none;">
                        <button class="btn-primary" id="next-btn" onclick="nextQuestion()">
                            Next Question ➜
                        </button>
                    </div>
                </div>
            </div>

            <div class="stats-panel">
                <div class="glass-card" style="padding: 1.5rem;">
                    <h3 class="filter-title">My Progress</h3>
                    <div style="display: flex; flex-direction: column; gap: 0.8rem;">
                        <div class="stat-item">
                            <div class="stat-icon">📝</div>
                            <div class="stat-details">
                                <h4>Answered</h4>
                                <p id="stat-total">0</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon success">✓</div>
                            <div class="stat-details">
                                <h4>Correct</h4>
                                <p id="stat-correct">0</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-icon">🎯</div>
                            <div class="stat-details">
                                <h4>Accuracy</h4>
                                <p id="stat-accuracy">0%</p>
                            </div>
                        </div>
                    </div>
                    <button class="btn-primary" id="reset-stats-btn" onclick="resetStats()" style="width: 100%; margin-top: 1.5rem; background: rgba(255,255,255,0.05); border: 1px solid var(--bg-card-border); box-shadow: none; padding: 0.8rem;">
                        Reset Progress
                    </button>
                </div>

                <div class="glass-card" style="padding: 1.5rem;">
                    <h3 class="filter-title" style="text-align: center; margin-bottom: 1rem;">Exam Calculator</h3>
                    <div class="calculator-container" style="margin: 0 auto; max-width: 100%; box-shadow: none; border: none; padding: 0;">
                        <div class="calculator-screen" style="padding: 1rem; margin-bottom: 1rem;">
                            <div class="calc-prev-operand" style="font-size: 0.8rem; min-height: 1.2rem;"></div>
                            <div class="calc-curr-operand" style="font-size: 1.5rem; min-height: 2.2rem;">0</div>
                        </div>
                        <div class="calculator-grid" style="gap: 0.5rem;">
                            <button class="calc-btn action" onclick="calcAction('clear')">AC</button>
                            <button class="calc-btn action" onclick="calcAction('delete')">DEL</button>
                            <button class="calc-btn operator" onclick="calcOp('÷')">÷</button>
                            <button class="calc-btn operator" onclick="calcOp('×')">×</button>
                            
                            <button class="calc-btn" onclick="calcNum('7')">7</button>
                            <button class="calc-btn" onclick="calcNum('8')">8</button>
                            <button class="calc-btn" onclick="calcNum('9')">9</button>
                            <button class="calc-btn operator" onclick="calcOp('-')">-</button>
                            
                            <button class="calc-btn" onclick="calcNum('4')">4</button>
                            <button class="calc-btn" onclick="calcNum('5')">5</button>
                            <button class="calc-btn" onclick="calcNum('6')">6</button>
                            <button class="calc-btn operator" onclick="calcOp('+')">+</button>
                            
                            <button class="calc-btn" onclick="calcNum('1')">1</button>
                            <button class="calc-btn" onclick="calcNum('2')">2</button>
                            <button class="calc-btn" onclick="calcNum('3')">3</button>
                            <button class="calc-btn equals" onclick="calcAction('equals')">=</button>
                            
                            <button class="calc-btn" style="grid-column: span 2; aspect-ratio: auto;" onclick="calcNum('0')">0</button>
                            <button class="calc-btn" onclick="calcNum('.')">.</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <div>© 2026 Plumbing License Prep.</div>
            <div><a href="index.html" style="color: var(--text-secondary); text-decoration: none;">Course Details</a></div>
        </div>
    </footer>

    <script src="../../../../quiz-engine.js"></script>
</body>
</html>
"""
    return content

# Generate all 13 products
for p in products:
    # Setup subfolder path
    folder_path = os.path.join(silos[p['silo']], p['id'])
    os.makedirs(folder_path, exist_ok=True)
    
    # Write details (index.html)
    index_html = make_product_index(p)
    with open(os.path.join(folder_path, "index.html"), "w", encoding="utf-8") as f:
        f.write(index_html)
        
    # Write practice simulator (practice.html)
    practice_html = make_product_practice(p)
    with open(os.path.join(folder_path, "practice.html"), "w", encoding="utf-8") as f:
        f.write(practice_html)
        
    # Write CSV database (questions.csv)
    csv_path = os.path.join(folder_path, "questions.csv")
    with open(csv_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["Category", "Question", "OptionA", "OptionB", "OptionC", "OptionD", "CorrectOption", "Explanation"])
        for q in p['questions']:
            writer.writerow([
                q['Category'],
                q['Question'],
                q['OptionA'],
                q['OptionB'],
                q['OptionC'],
                q['OptionD'],
                q['CorrectOption'],
                q['Explanation']
            ])

print("Programmatic generation of 31-page silo structure complete!")
