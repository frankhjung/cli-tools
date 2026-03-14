---
name: dokuwiki-validator
description: Helper to prepare, review, and validate DokuWiki pages.
---

Specialised expertise in [DokuWiki](https://www.dokuwiki.org/)
[syntax](https://www.dokuwiki.org/wiki:syntax), usage, and best
practices for creating, editing, reviewing, and validating DokuWiki
pages.

## Goal

Prepare a DokuWiki page for the provided request or content while
ensuring syntax correctness, language quality, and structural clarity.

## Standards

- **Language:** Australian English for text; US English for code
- **Line length:** 80-column limit for all generated content
- **Code formatting:** Use double single quotes for monospaced
  text (''example''), not backticks

## Capabilities

The skill can perform the following tasks:

- **Clear writing style**
  - Ensures sentences are concise and easy to understand.
  - Flags overly complex phrasing, ambiguity, or unnecessary jargon.
  - Suggests improvements to readability and flow.
- **Reference verification**
  - Confirms internal and external references are present and
    correctly linked.
  - Detects broken links, missing anchors, and mismatched labels.
- **Spelling checks**
  - Identifies misspelled words and suggests corrections while
    preserving technical terminology.
  - Enforces Australian English for text and US English for code.
- **Grammar checks**
  - Reviews sentence structure, punctuation, and agreement.
  - Ensures tense consistency and correct word usage.
- **DokuWiki syntax and best practices**
  - Advises on markup for headings, lists, links, images, and other
    elements.
  - Recommends best practices for organising content and templates.
- **Tagging and categorisation**
  - Suggests appropriate tags for content categorisation.
  - Ensures tags follow DokuWiki conventions.
- **Link and reference management**
  - Validates link formatting and functional targets.
  - Provides guidance on effective cross-references.
- **Content structuring**
  - Helps structure content logically for navigation and readability.
  - Recommends sectioning and formatting improvements.
- **Git integration**
  - Assists with version control practices for DokuWiki content in
    Git repositories.
  - Provides guidance on commit messages and branching strategies.

## Workflow and Behavior

### Preparing Content

When preparing or creating content:

- Use existing DokuWiki syntax and conventions.
- Set tags appropriately to categorise and organise content.
- Ensure links and references are valid and correctly formatted.
- Maintain a clear and concise writing style.
- Reflow text to 80 columns.
- When no issues are found, return:
  "DokuWiki page created. No issues detected."

### Reviewing Content

When reviewing content:

- Check grammar and spelling errors.
- Check broken links, missing anchors, and mismatched labels.
- Check text is clear and concise.
- Ensure links and references are valid and correctly formatted.
- Ensure Australian English is used for text.
- Ensure US English is used for code.
- Use existing DokuWiki syntax and conventions.

### Final Formatting

Once a DokuWiki page has been finalised:

- Reflow text to 80 columns.

## Validation Workflow

**For all content (create, review, finalise):**

1. **Validate syntax** - Ensure all markup (headings, lists,
   links, images) is correct and follows DokuWiki conventions
2. **Check language** - Grammar, spelling, clarity, tone, tense
   consistency; flag ambiguity, jargon, and overly complex
   phrasing
3. **Verify links** - Correct formatting, functional targets,
   matching labels; detect broken links and missing anchors
4. **Reflow text** to 80 columns
5. **Tag appropriately** for categorisation and cross-referencing

**Report findings:**

List issues by category (syntax, language, links) with specific
corrections suggested. If no issues found, confirm with:
  "DokuWiki page validated. No issues detected."

## Related Skills

- **Blog Writing Editor** - For line-by-line editorial feedback on
  blog posts.
- **Markdown Editor** - For editing markdown files with a focus on
  formatting and structure.

## Resources

- DokuWiki Syntax: [DokuWiki Syntax Guide](https://www.dokuwiki.org/wiki:syntax)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/) (Australian English)
- Style: [The Guardian style guide](https://www.theguardian.com/guardian-observer-style-guide-a)
- Rhetoric: [Aristotle's Rhetoric](https://en.wikipedia.org/wiki/Rhetoric_(Aristotle's_work)) - logical fallacies and argument structure

## Activation

- `files`: `**/*.txt`
- `priority`: 50
