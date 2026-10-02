---
name: dokuwiki-editor
description: >-
  Create, edit, review, and validate DokuWiki pages and wiki documents (.txt).
  Use this skill when creating, editing, formatting, reviewing, or validating
  DokuWiki documents (.txt). Enforces DokuWiki markup syntax, Australian
  English, 80-column line wrapping, and structured validation reporting.
---

# DokuWiki Editor

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
    Do *not* wrap lines for list items.
    Indent list items with two spaces (not tabs) per level:
  - Unordered: `  * Item`
  - Ordered: `  - Item`
- **Links:** `[[page|Link Text]]`, `[[namespace:page|Link Text]]`, or
  `[[https://example.com|Link Text]]`. Do not style text inside link brackets.
- **Tables:** Header rows start with `^`; data rows start with `|`:

  ```text
  ^ Heading 1 ^ Heading 2 ^
  | Cell 1    | Cell 2    |
  ```

- **Media & Images:** `{{image.png|Caption}}` or `{{:namespace:image.png}}`.
  Control alignment with whitespace: `{{ image.png}}` (right),
  `{{image.png }}` (left), `{{ image.png }}` (centre).
- **Footnotes:** `((This is a footnote))`.
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

## Cross-Skill References

- **`markdown-editor`** — Translate between Markdown and DokuWiki syntax.
- **`blog-editor`** — Share editorial voice, structure, and language standards.

## Resources

- Syntax Guide: [DokuWiki Syntax Guide](https://www.dokuwiki.org/wiki:syntax)
- Style: [The Guardian Style Guide][guardian-style]
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)

[guardian-style]:
https://www.theguardian.com/guardian-observer-style-guide-a
