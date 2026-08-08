---
description: Enforces mandatory directory-based silo structure for all content creation in this workspace.
trigger: always_on
---

# SEO Silo Directory Structure Rule

This rule enforces a strict directory-based silo structure for ALL content creation (blog articles, wiki pages, exam prep, checklists) in this workspace. Flat/direct HTML pages are strictly forbidden.

## Compulsory Silo Directory Structure

1. **Never create flat pages** — do NOT create `exams/some-topic.html` or `wiki/some-article.html` at the root level.
2. **Always group content into named subdirectory silos** using high-search-volume keywords as directory names.
3. **Standard silo layout for exam/course pages:**
   - `exams/[niche-folder]/index.html` → Main Landing / Hub Page (product page)
   - `exams/[niche-folder]/practice-test/index.html` → Interactive Practice Simulator
   - `exams/[niche-folder]/study-guide/index.html` → Definitions, formulas, informational guide

4. **Standard silo layout for blog/wiki articles:**
   - `wiki/[topic-category]/index.html` → Category hub
   - `wiki/[topic-category]/[article-slug]/index.html` → Individual article

## Internal Linking Rules

- All niche silo pages must include the full-width **"Explore Licensing & Compliance Resources"** tags section (`.niche-tags-container`) before the footer, linking to all other niche silos.
- Left sidebar on niche pages must list all 5 niche exam silos, NOT the plumbing hub navigation.
- Relative paths MUST be calculated based on file depth:
  - **Hub pages** (depth 2, e.g. `exams/folder/index.html`): use `../` to reach `exams/`, `../../` to reach site root.
  - **Sub-pages** (depth 3, e.g. `exams/folder/sub/index.html`): use `../../` to reach `exams/`, `../../../` to reach site root.

## Plumbing License Hub — CRITICAL PROTECTION

- **DO NOT** modify, edit, or touch ANY file under `exams/plumbing-license-prep/` or any of its subdirectories.
- This silo is already ranking well with 3 internal links and must remain completely unchanged.
- When running navigation scripts (`update_navigation.ps1`, `fix_niche_paths.ps1`, or similar), always include an explicit filter to skip `plumbing-license-prep`.
