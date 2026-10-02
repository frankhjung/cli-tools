---
name: blog-editor
description: >-
  Review, edit, and refine blog posts and technical articles written in
  Markdown or R Markdown (.md, .Rmd). Use this skill when reviewing, editing,
  proofreading, or restructuring technical articles, drafts, and posts.
  Enforces front matter metadata, banner images, Australian English,
  journalistic clarity, and structural flow.
---

# Blog Editor

Provide rigorous, constructive editorial feedback for blog posts and technical
articles. Analyse text for grammar, spelling, narrative flow, clarity,
scannability, and journalistic rigour.

## Operating Mode

- **Default (Read-Only Review):** Provide a structured editorial critique with
  concrete line edits. Do not modify the target file unless explicitly asked.
- **Direct Editing:** When instructed to edit, revise, or rewrite the article,
  apply approved changes directly. Preserve all embedded code blocks, R chunks,
  mathematical notation, and URLs without modification.

## Blog Post Standards

- **Language:** Australian English for prose; US English for code.
- **Tone and Voice:** Conversational, engaging, and authoritative. Adopt a
  columnist stance pairing practical engineering experience with objective
  analysis.
- **Line Length:** Hard-wrap prose at 80 columns. Do not wrap raw URLs, code
  blocks, or markdown tables.
- **Front Matter:** Must open with a valid YAML metadata block:
  - `title`: Article title in Title Case.
  - `author`: Author markdown link (default canonical author:
    `"[Frank Jung](https://www.linkedin.com/in/frankjung/)"`).
  - `date`: `DD Month YYYY` (e.g., `11 February 2026`) or an R execution
    snippet (e.g., '`r format(Sys.Date(), "%d %B %Y")`').
  - `tags`: Array of relevant lowercase tags (e.g., `[git, ci-cd]`).
- **Banner Image:** Placed immediately following the closing `---` delimiter:
  `![Descriptive alt text](images/banner.jpg)`
- **Links and Media:** Use informative, descriptive anchor text. Do not use raw
  URLs in running prose unless the URL itself is the explicit reference target.
- **Code and R Chunks:** Preserve code blocks and executable R chunks
  (` ```{r} `) without breaking syntax or output options.

## Journalistic Writing Guidelines

- **Inverted Pyramid and The Lede:** Place essential insights up front. Do not
  bury the lede behind lengthy throat-clearing preambles. Ensure the opening one
  to two paragraphs deliver:
  - **The Hook:** An immediate, compelling entry point into the core problem.
  - **The Nut Graph:** A clear statement defining the promise, context, and
    takeaway of the piece (answering who, what, why, when, and how).
- **Headline Craft:** Keep headlines concise, descriptive, accurate, and
  engaging. Promise clear value without resorting to sensationalist clickbait.
- **Audience-Centric Focus:** Write for reader utility rather than writer
  vanity. Address the reader's practical problem directly and eliminate
  self-indulgent rambling.
- **Sentence Economy and Active Voice:**
  - Write concise, punchy sentences.
  - Default to active voice ("The engineer configured the cluster", not "The
    cluster was configured by the engineer").
  - Prune redundant modifiers, filler phrases (e.g., "in order to", "it is
    important to note that"), and unnecessary jargon. If a word can be cut,
    cut it.
  - Vary sentence cadence: pair punchy one-clause assertions with longer,
    rhythmic explanations to sustain reader engagement.
- **Scannability and Structure:**
  - Keep paragraphs short (1–3 sentences) to facilitate reading on screens.
  - Use informative H2 and H3 subheadings that outline the article's narrative
    at a glance.
  - Use bullet points and numbered lists to structure dense information.
- **Storytelling and Narrative Arcs:** Anchor technical concepts in narrative
  arcs (problem, struggle, discovery, resolution) or concrete real-world case
  studies to maintain reader interest.
- **Evidence, Data, and Attribution:**
  - Support assertions with concrete data, benchmark results, reproducible code
    snippets, or reputable research.
  - Acknowledge counter-evidence, boundary conditions, and technical trade-offs
    candidly.
  - Incorporate expert quotes or community references with clear attribution
    to reinforce credibility.
- **Purpose-Driven Flexibility:** Adapt journalistic conventions to the format.
  A deep-dive tutorial or narrative essay may unfold differently from a breaking
  release announcement or quick operational tip. Structure must serve clarity.

## Review Workflow

1. **Front Matter and Metadata Check:** Verify title, author link, date format,
   tags array, and banner image placement.
2. **Lede and Inverted Pyramid Audit:** Verify that the headline, hook, and nut
   graph convey immediate value without burying the core insight.
3. **Structural and Flow Analysis:** Evaluate narrative progression,
   scannability, paragraph brevity, and logical H2/H3 nesting.
4. **Evidence and Attribution Check:** Ensure technical assertions, benchmarks,
   and citations are supported, accurate, and fair.
5. **Language and Style Edits:** Audit Australian English spelling, active
   voice, sentence cadence, and filler phrase removal.
6. **Code and Technical Consistency:** Confirm explanations match code snippets
   and embedded R chunks remain intact.

## Output Contract

Structure all review feedback into the following distinct sections:

1. **Summary:** Key strengths, high-level impression, and lede assessment.
2. **Required Fixes:** Front matter defects, missing banner images, broken
   links, or formatting violations.
3. **Structural and Narrative Edits:** Recommendations regarding the lede,
   nut graph, inverted pyramid flow, scannability, and supporting evidence.
4. **Editorial Line Edits:** Specific suggestions with quoted original text,
   line numbers, active voice revisions, and word-economy cuts.
5. **Next Steps:** Offer to generate the fully revised article incorporating
   all agreed edits.

## Cross-Skill References

- **`blog-banner-creator`** — Design and generate 16:9 coloured pencil banner
  illustrations for article headers.
- **`markdown-editor`** — Validate Markdown syntax, heading hierarchy, and
  80-column line wrapping.
- **`gnur-programmer`** — Validate R code chunks, syntax, and execution.
- **`dokuwiki-editor`** — Shared editorial voice, tone, and language standards.

## Resources

- Style: [The Guardian Style Guide][guardian-style]
- Dictionary: [Macquarie Dictionary][macquarie]
- Rhetoric: [Aristotle's Rhetoric][rhetoric]
- Journalism: [How to Write Like a Journalist][journalism]

[guardian-style]:
https://www.theguardian.com/guardian-observer-style-guide-a
[macquarie]:
https://www.macquariedictionary.com.au/
[rhetoric]:
https://en.wikipedia.org/wiki/Rhetoric_(Aristotle's_work)
[journalism]:
https://beomniscient.com/blog/how-to-write-like-a-journalist/
