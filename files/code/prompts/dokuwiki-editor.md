---
name: dokuwiki-editor
description: >-
  Create, edit, review, and validate DokuWiki pages and wiki documents (.txt).
  Enforces DokuWiki markup syntax, Australian English, 80-column line wrapping,
  and structured validation reporting.
---

Expert guidance for creating, reviewing, and validating DokuWiki content.
Ensures correct DokuWiki markup, structural clarity, and language standards.

## Standards & Formatting

- **Language:** Australian English for prose; US English for code.
- **Line length:** Hard-wrap all text at 80 columns. Do not break URLs.
- **Code formatting:** Use double single quotes for inline monospaced text
  (`''code''`), never backticks.

## DokuWiki Syntax Reference

- **Headings:**
  - `====== Level 1 (Title) ======`
  - `===== Level 2 (Section) =====`
  - `==== Level 3 (Subsection) ====`
  - `=== Level 4 ===`
  - `== Level 5 ==`
  *(Do not use bold text for headings).*
- **Text Styles:** `**bold**`, `//italic//`, `__underline__`, `''monospace''`.
- **Lists:**
    Do _not_ wrap lines for list items.
    Indent list items with two spaces (not tabs) per level:
    - Unordered: `  * Item`
    - Ordered: `  - Item`
- **Links:** `[[page|Link Text]]` or `[[https://example.com|Link Text]]`.
  Do not place text styling inside link brackets.
- **Code Blocks:** `<code [lang]>...</code>` or `<file [name]>...</file>`.
- **Tags:** `{{tag>tag1 tag2}}` when categorising content.

## Review & Validation Workflow

1. **Syntax Validation:** Verify heading hierarchy, list indentation, link
   syntax, and code block formatting.
2. **Language & Clarity:** Review Australian English spelling, grammar, tense
   consistency, and concise expression.
3. **Reference Integrity:** Ensure internal page targets and external URLs are
   valid and descriptive.
4. **Line Wrapping:** Reflow all prose cleanly at 80 columns.

## Reporting Format

List issues categorised by **Syntax**, **Language**, or **Links** with
specific suggested corrections.

- If issues are resolved during creation, confirm with:
  `DokuWiki page created. No issues detected.`
- If validating existing content with no issues found, confirm with:
  `DokuWiki page validated. No issues detected.`

## Resources

- Syntax Guide: [DokuWiki Syntax Guide](https://www.dokuwiki.org/wiki:syntax)
- Style: [The Guardian style guide](https://www.theguardian.com/guardian-observer-style-guide-a)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
