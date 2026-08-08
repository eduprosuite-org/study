import urllib.parse
import json
import csv
import time
import random
import requests
from bs4 import BeautifulSoup

# Define user agents to avoid getting blocked by Google
USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/121.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.2.1 Safari/605.1.15",
]

# Seed keywords based on user request (math exam prep, books, high price digital products)
SEED_KEYWORDS = [
    # General & Exams
    "mathematics exam prep",
    "math test preparation",
    "math study guide pdf",
    "actuarial exam prep",
    "gre quantitative practice test",
    "gmat quant prep course",
    "clep college algebra study guide",
    "ap calculus bc study guide",
    # University/College Level Topics
    "linear algebra exam prep",
    "differential equations study guide",
    "real analysis test prep",
    "discrete mathematics cheat sheet",
    "engineering mathematics study guide",
    # High-ticket digital product intent keywords
    "best online calculus course",
    "university math prep bootcamp",
    "premium calculus study materials",
    "advanced mathematics course with certificate",
    "math textbook solutions guide",
]

# Modifiers to expand queries (high-ticket/intent + educational search terms)
MODIFIERS = [
    "best", "premium", "study guide for", "exam cheat sheet", 
    "online course", "practice test pdf", "solutions manual", "bootcamp"
]

def get_google_autocomplete(query):
    """
    Fetches autocomplete suggestions from Google.
    Google only shows keywords here that have active search volume (usually > 100 monthly searches).
    """
    url = f"http://suggestqueries.google.com/complete/search?client=firefox&q={urllib.parse.quote(query)}"
    headers = {"User-Agent": random.choice(USER_AGENTS)}
    try:
        response = requests.get(url, headers=headers, timeout=10)
        if response.status_code == 200:
            data = json.loads(response.text)
            # The JSON response contains the search query and the list of suggestions
            return data[1]
    except Exception as e:
        print(f"Error fetching autocomplete for '{query}': {e}")
    return []

def get_google_search_results_count(keyword):
    """
    Uses 'allintitle:"keyword"' to find the exact number of web pages targeting this keyword.
    Lower results count = Lower competition.
    """
    query = f'allintitle:"{keyword}"'
    url = f"https://www.google.com/search?q={urllib.parse.quote(query)}"
    headers = {"User-Agent": random.choice(USER_AGENTS)}
    
    try:
        # Add random delay to prevent Google from blocking requests
        delay = random.uniform(5.0, 10.0)
        print(f"Waiting {delay:.2f} seconds before checking Google for '{keyword}'...")
        time.sleep(delay)
        
        response = requests.get(url, headers=headers, timeout=15)
        if response.status_code == 200:
            soup = BeautifulSoup(response.text, "html.parser")
            result_stats = soup.find("div", id="result-stats")
            if result_stats:
                text = result_stats.text
                # Extract numbers from result-stats text, e.g., "About 12,500 results" -> 12500
                cleaned_num = "".join(filter(str.isdigit, text))
                if cleaned_num:
                    return int(cleaned_num)
            elif "did not match any documents" in response.text or "no results found" in response.text.lower():
                return 0
            
            # If no result-stats found but page loaded, we check if there are search results shown
            search_results = soup.find_all("div", class_="g")
            return len(search_results)
            
        elif response.status_code == 429:
            print("Google blocked the request (Status Code 429). Please wait before running again or use proxies.")
            return -1
    except Exception as e:
        print(f"Error checking SERP for '{keyword}': {e}")
    return -2

def main():
    print("=== Starting Google Content Gap Keyword Finder ===")
    
    # Step 1: Generate expanded keyword list
    all_suggestions = set()
    print("Generating keyword suggestions...")
    for seed in SEED_KEYWORDS:
        # Add the seed itself
        all_suggestions.add(seed)
        
        # Suggest queries with modifiers
        for mod in MODIFIERS:
            query = f"{mod} {seed}"
            suggestions = get_google_autocomplete(query)
            for sug in suggestions:
                # Filter only relevant keywords
                all_suggestions.add(sug.lower())
                
        # Also add seed + space + letter to trigger autocomplete
        for char in ['a', 'c', 'e', 'm', 'p', 's', 'u']:
            query = f"{seed} {char}"
            suggestions = get_google_autocomplete(query)
            for sug in suggestions:
                all_suggestions.add(sug.lower())

    print(f"Generated {len(all_suggestions)} unique keywords from Autocomplete (guaranteed to have search volume).")
    
    # We will test a subset of these to avoid getting blocked too quickly, 
    # and sort them to prioritize educational/digital product terms.
    priority_keywords = []
    product_keywords = ["course", "prep", "exam", "book", "pdf", "test", "guide", "cheat", "study", "bootcamp", "premium"]
    
    for kw in all_suggestions:
        score = sum(1 for word in product_keywords if word in kw)
        if score > 0:
            priority_keywords.append((score, kw))
            
    # Sort by priority score descending
    priority_keywords.sort(reverse=True, key=lambda x: x[0])
    # Keep top 30 to query Google carefully
    keywords_to_test = [kw for _, kw in priority_keywords[:30]]
    
    # Step 2: Check SERP Page count / Competition for the top priority keywords
    results = []
    
    for idx, kw in enumerate(keywords_to_test):
        print(f"\nChecking keyword [{idx+1}/{len(keywords_to_test)}]: '{kw}'")
        res_count = get_google_search_results_count(kw)
        
        if res_count == -1:
            print("Stopping to prevent further 429 block.")
            break
            
        status = "Unknown"
        if res_count >= 0:
            if res_count == 0:
                status = "Ultra Low Competition (Goldmine)"
            elif res_count <= 10:
                status = "Very Low Competition (Less than 1 page)"
            elif res_count <= 50:
                status = "Low Competition (3-5 pages)"
            else:
                status = "Medium/High Competition"
                
            results.append({
                "Keyword": kw,
                "AllInTitle Results Count": res_count,
                "Competition Status": status,
                "Search Volume Indication": "High (>100 searches/mo suggested by Autocomplete)"
            })
            print(f"-> Results: {res_count} pages. Status: {status}")
        else:
            print("-> Skipped (Request failed or rate-limited).")
            
    # Step 3: Write results to CSV file
    output_file = "keywords_daily_report.csv"
    with open(output_file, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=["Keyword", "AllInTitle Results Count", "Competition Status", "Search Volume Indication"])
        writer.writeheader()
        writer.writerows(results)
        
    print(f"\n=== Done! Daily Keyword Report saved to '{output_file}' ===")

if __name__ == "__main__":
    main()
