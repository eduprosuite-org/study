import urllib.parse
import json
import csv
import time
import random
import re
import requests

# Interactive Niche Keyword Opportunity Finder (Python Version)
# Run this script to find low-competition keywords (<5 pages of results) for any niche.

USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/121.0"
]

def get_google_autocomplete(query):
    url = f"http://suggestqueries.google.com/complete/search?client=firefox&q={urllib.parse.quote(query)}"
    headers = {"User-Agent": random.choice(USER_AGENTS)}
    try:
        response = requests.get(url, headers=headers, timeout=10)
        if response.status_code == 200:
            data = json.loads(response.text)
            return data[1]
    except:
        pass
    return []

def check_broad_results_count(keyword):
    # Queries Bing search broad to check the number of matching documents online
    url = f"https://www.bing.com/search?q={urllib.parse.quote(keyword)}"
    headers = {"User-Agent": random.choice(USER_AGENTS)}
    
    # Wait to avoid blocks
    time.sleep(random.uniform(4.0, 7.0))
    
    try:
        response = requests.get(url, headers=headers, timeout=10)
        if response.status_code == 200:
            content = response.text
            # Look for sb_count
            match = re.search(r'class="sb_count">About\s+([\d,]+)\s+results', content)
            if match:
                return int(match.group(1).replace(",", ""))
            match2 = re.search(r'class="sb_count">([\d,]+)\s+results', content)
            if match2:
                return int(match2.group(1).replace(",", ""))
                
            # Fallback check count of b_algo items
            matches_algo = re.findall(r'class="b_algo"', content)
            return len(matches_algo)
    except Exception as e:
        print(f"Error checking count for '{keyword}': {e}")
    return -1

def main():
    niche = input("Enter your niche or seed topic (e.g., 'electrician let prep', 'ca real estate math'): ").strip()
    if not niche:
        print("Niche cannot be empty. Exiting.")
        return
        
    safe_niche_name = re.sub(r'[^a-zA-Z0-9]', '_', niche)
    output_file = f"keywords_{safe_niche_name}.csv"
    
    modifiers = [
        "", "best", "premium", "practice test", "exam cheat sheet", 
        "study guide pdf", "course", "bootcamp", "solutions manual", 
        "prep book", "exam questions", "formula sheet"
    ]
    
    unique_keywords = set()
    print(f"\n[1/3] Generating suggestions from Autocomplete for '{niche}'...")
    
    for mod in modifiers:
        query = f"{mod} {niche}".strip()
        suggestions = get_google_autocomplete(query)
        for sug in suggestions:
            unique_keywords.add(sug.lower())
            
    print(f"✓ Generated {len(unique_keywords)} unique keywords.")
    
    if not unique_keywords:
        print("No suggestions generated. Try a broader term.")
        return
        
    product_keywords = ["course", "prep", "exam", "book", "pdf", "test", "guide", "cheat", "study", "bootcamp", "premium", "sheet"]
    prioritized = []
    
    for kw in unique_keywords:
        score = sum(1 for word in product_keywords if word in kw)
        if score > 0:
            prioritized.append((score, kw))
            
    prioritized.sort(reverse=True, key=lambda x: x[0])
    keywords_to_check = [kw for _, kw in prioritized[:15]]
    
    print("\n[2/3] Checking broad search result counts on Bing (to avoid Google block)...")
    results = []
    
    for idx, kw in enumerate(keywords_to_check):
        print(f"[{idx+1}/15] Checking: '{kw}'...")
        count = check_broad_results_count(kw)
        
        if count == -1:
            print("   -> Skip: Connection error or rate limit.")
            continue
            
        status = "High Competition"
        if count == 0:
            status = "Ultra Low Competition (Goldmine - Under 1 Page)"
        elif count <= 50:
            status = "Low Competition (Only 1-5 Pages)"
        elif count <= 500:
            status = "Medium-Low Competition (Under 50 Pages)"
            
        results.append({
            "Keyword": kw,
            "Broad Results Count": count,
            "Competition Status": status,
            "Volume Indication": "Google Autocomplete (Verify in Planner)"
        })
        print(f"   -> Count: {count} | Status: {status}")
        
    print("\n[3/3] Saving results to CSV...")
    with open(output_file, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=["Keyword", "Broad Results Count", "Competition Status", "Volume Indication"])
        writer.writeheader()
        writer.writerows(results)
        
    print(f"✓ Done! Report saved to: '{output_file}'")

if __name__ == "__main__":
    main()
