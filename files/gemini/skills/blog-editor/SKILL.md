---
name: blog-editor
description: >-
  Review, edit, and refine blog posts and technical articles written in
  Markdown or R Markdown (.md, .Rmd). Enforces front matter metadata, banner
  images, Australian English, and structural flow.
---

Provide rigorous, constructive editorial feedback for blog posts and technical
articles. Analyse text for grammar, spelling, flow, clarity, and formatting.

## Blog Post Standards

- **Language:** Australian English for prose; US English for code.
- **Tone:** Conversational, engaging, and professional.
- **Line length:** Hard-wrap prose at 80 columns. Do not wrap URLs or code
  lines.
- **Front matter:** Must include a valid YAML block:
  - `title`: Article title.
  - `author`: `"[Frank Jung](https://www.linkedin.com/in/frankjung/)"`
  - `date`: `DD Month YYYY` (e.g., `11 February 2026`) or an R execution
    snippet.
  - `tags`: Array of relevant tags (e.g., `[git, ci/cd]`).
- **Banner image:** Placed directly after the front matter:
  `![Alt text](images/banner.jpg)`
- **Links & media:** Informative anchor text; no raw URLs unless identical to
  text.
- **Code & R chunks:** Preserve code chunks (` ```{r} `) without breaking
  syntax.

## Review Workflow

1. **Front Matter & Metadata Check:** Verify author, date, tags, and banner
   image.
2. **Structural & Flow Analysis:** Evaluate narrative progression, readability,
   and heading hierarchy (H2/H3).
3. **Language & Style Edits:** Check Australian English spelling, grammar,
   active voice, and concise phrasing.
4. **Code & Technical Consistency:** Ensure accompanying explanations match code
   snippets.

## Feedback Format

Structure review output into the following sections:

1. **Summary:** Key strengths and high-level impression.
2. **Required Fixes:** Front matter, banner, or formatting non-compliances.
3. **Editorial Edits:** Specific suggestions with quoted text, line references,
   and reasoning.
4. **Next Steps:** Offer to output the fully revised article incorporating all
   agreed edits.

## Resources

- Style: [The Guardian style guide](https://www.theguardian.com/guardian-observer-style-guide-a)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
- Rhetoric: [Aristotle's Rhetoric](https://en.wikipedia.org/wiki/Rhetoric_(Aristotle's_work))
