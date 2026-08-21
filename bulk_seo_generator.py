import os
import sys
import json
import re

# Verify Google GenAI SDK is installed
try:
    from google import genai
except ImportError:
    print("Error: The 'google-genai' SDK is not installed.")
    print("Please run: pip install google-genai")
    sys.exit(1)

# Check for Gemini API Key
api_key = os.environ.get("GEMINI_API_KEY")
if not api_key:
    print("Error: GEMINI_API_KEY environment variable is not set.")
    print("To run this script, set the environment variable:")
    print("  PowerShell: $env:GEMINI_API_KEY='your_api_key'")
    print("  CMD:        set GEMINI_API_KEY=your_api_key")
    print("  Linux/Mac:  export GEMINI_API_KEY='your_api_key'")
    sys.exit(1)

# Initialize the Google GenAI Client
client = genai.Client()

# Paths to consolidated rule files
RULES_DIR = os.path.join(".agents", "rules")
SILO_RULES = os.path.join(RULES_DIR, "seo_silo_structure.md")
TECH_RULES = os.path.join(RULES_DIR, "1-technical-seo.md")
ONPAGE_RULES = os.path.join(RULES_DIR, "2-onpage-content.md")
SCHEMA_RULES = os.path.join(RULES_DIR, "3-schema-rules.md")

def read_rule_file(filepath):
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            return f.read()
    return ""

silo_content = read_rule_file(SILO_RULES)
tech_content = read_rule_file(TECH_RULES)
onpage_content = read_rule_file(ONPAGE_RULES)
schema_content = read_rule_file(SCHEMA_RULES)

# Setup system instruction from the strict rule files
SYSTEM_INSTRUCTION = f"""
You are an expert SEO Content Writer and Auditor.
You MUST write high-quality, professional, helpful, people-first HTML content that strictly complies with the following guidelines.

--- RULES: SILO DIRECTORY STRUCTURE ---
{silo_content}

--- RULES: TECHNICAL SEO ---
{tech_content}

--- RULES: ON-PAGE CONTENT ---
{onpage_content}

--- RULES: STRUCTURED DATA & SCHEMAS ---
{schema_content}

IMPORTANT OUTPUT FORMAT:
You MUST output ONLY the final raw HTML code. Do NOT enclose the code in Markdown blocks (like ```html ... ```) or explain your code. Just start directly with '<!DOCTYPE html>' or '<html>'.
"""

def generate_page(topic_info):
    topic = topic_info.get("topic")
    category = topic_info.get("category")
    niche_folder = topic_info.get("niche_folder", category)
    page_type = topic_info.get("page_type", "wiki")  # 'wiki' or 'exams'
    subpage = topic_info.get("subpage", "")

    print(f"\n[Generation Started] Topic: '{topic}' | Type: '{page_type}'")

    prompt = f"""
Write an HTML page for:
Topic: "{topic}"
Category: "{category}"
Page Type: "{page_type}"
Subpage: "{subpage}"

Instructions:
1. Generate a complete, valid HTML5 document.
2. In the <head>, include a unique <title> (<60 characters) and unique <meta name="description"> (<160 characters).
3. Structure the page body semantically using <header>, <nav>, <main>, <article> (for wiki articles), <section>, and <footer> tags.
4. If this is an 'exams' page:
   - Ensure the left sidebar lists all 5 niche exam silos, NOT the plumbing hub navigation.
   - Include the full-width "Explore Licensing & Compliance Resources" tags section (with class '.niche-tags-container') before the footer, linking to all other niche silos.
   - Crucial: Use appropriate relative paths ('../' or '../../' depending on file depth) for all links.
5. Inject the corresponding valid JSON-LD structured data block in the <head>:
   - If 'wiki', include Article (NewsArticle/BlogPosting) and BreadcrumbList schemas.
   - If 'exams', include WebSite and BreadcrumbList schemas (or other relevant schemas).
6. Ensure a single H1 tag, a logical heading hierarchy, and descriptive, natural anchor text for all links.
7. Return ONLY the raw HTML string, starting with '<!DOCTYPE html>' and ending with '</html>'.
"""

    try:
        response = client.interactions.create(
            model="gemini-3.6-flash",
            input=prompt,
            system_instruction=SYSTEM_INSTRUCTION,
            generation_config={"temperature": 0.2}
        )
        
        html_code = response.output_text
        if not html_code:
            raise ValueError("Empty response received from the model.")

        # Clean code block wrappers if any
        html_code = html_code.strip()
        if html_code.startswith("```html"):
            html_code = html_code[7:]
        elif html_code.startswith("```"):
            html_code = html_code[3:]
        if html_code.endswith("```"):
            html_code = html_code[:-3]
        html_code = html_code.strip()

        # Determine target directory
        slug = re.sub(r'[^a-zA-Z0-9\-]', '', topic.lower().replace(' ', '-'))
        
        if page_type == "wiki":
            # wiki/[category]/[slug]/index.html
            target_dir = os.path.join("wiki", category, slug)
        elif page_type == "exams":
            # exams/[niche-folder]/index.html or subpages
            if subpage:
                target_dir = os.path.join("exams", niche_folder, subpage)
            else:
                target_dir = os.path.join("exams", niche_folder)
        else:
            target_dir = os.path.join(category, slug)

        os.makedirs(target_dir, exist_ok=True)
        target_file = os.path.join(target_dir, "index.html")

        # Save HTML
        with open(target_file, "w", encoding="utf-8") as f:
            f.write(html_code)

        print(f"[Success] Generated and wrote page: {target_file}")

    except Exception as e:
        print(f"[Error] Failed to generate page for topic '{topic}': {e}")

def main():
    config_path = "seo_topics.json"
    if not os.path.exists(config_path):
        print(f"Error: Config file '{config_path}' not found in the current directory.")
        sys.exit(1)

    with open(config_path, "r", encoding="utf-8") as f:
        try:
            topics = json.load(f)
        except json.JSONDecodeError as e:
            print(f"Error: Failed to parse '{config_path}': {e}")
            sys.exit(1)

    if not isinstance(topics, list):
        print(f"Error: '{config_path}' must contain a list of objects.")
        sys.exit(1)

    print(f"Loaded {len(topics)} topics for generation.")
    for idx, topic_info in enumerate(topics, 1):
        print(f"\nProcessing {idx}/{len(topics)}...")
        generate_page(topic_info)

    print("\nBulk generation completed!")

if __name__ == "__main__":
    main()
