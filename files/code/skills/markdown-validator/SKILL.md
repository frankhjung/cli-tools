---
name: markdown-validator
description: Validates markdown content against established standards for structure, formatting, and language quality.
applyTo: '**/*.md'
---

# Markdown Validator

Specialises in validating markdown content to ensure it adheres to established
documentation and content creation standards.

## Standards and Rules

**Structure (MUST):**

- Use heading levels H2 and H3 only (no H1; no H4 or deeper)
- Use logical heading hierarchy
- Use `-` for bullet points; `1.` for numbered lists with two-space indentation for nesting

**Code and Technical (MUST):**

- Use fenced code blocks with language specified: ` ```bash `
- Use Australian English for all text; US English for code
- Specify language after opening backticks for syntax highlighting

**Links and Images (MUST):**

- Use `[link text](URL)` syntax with descriptive link text
- Use `![alt text](image URL)` syntax with meaningful alt text
- Verify all links are valid and accessible
- Do not use bare URLs; if necessary, format as `<URL>`
- Add a blank line between text and lists
- Lint markdown files with a tool like `markdownlint` to enforce style consistency

**Tables (SHOULD):**

- Use `|` to create tables with proper column alignment and headers

**Formatting (SHOULD):**

- Break lines at 80 characters for readability
- Use blank lines to separate sections
- Avoid excessive whitespace

**Language Quality (MUST):**

- Correct spelling and grammar throughout
- Consistent tense and terminology
- Clear, concise phrasing without ambiguity or jargon

## Validation Process

1. **Check structure**: Verify headings (H2/H3 only), lists, and logical hierarchy
2. **Check code**: Verify fenced blocks with language specified, language consistency
3. **Check links and images**: Verify syntax, descriptive text, and link validity
4. **Check language**: Verify spelling, grammar, tense, Australian/US English usage
5. **Check formatting**: Verify 80-character line breaks and appropriate whitespace

**Report findings**: List issues by category with severity (MUST fix / SHOULD improve). Suggest corrections for each issue. Confirm "Markdown validated. No issues detected." when all standards met.
