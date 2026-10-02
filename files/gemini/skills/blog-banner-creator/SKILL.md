---
name: blog-banner-creator
description: >-
  Create distinctive 16:9 coloured pencil banner illustrations for blog posts.
  Use this skill when conceptualising, prompting, or generating header images
  and visual metaphors for technical articles, drafts, and blog posts.
  Enforces minimalist metaphors, pure white backgrounds, and coloured pencil
  textures.
---

# Blog Banner Creator

Generates editorial, coloured pencil banner illustrations for technical blog
posts. Converts architectural and narrative themes into restrained physical
metaphors with fine hand-drawn paper texture.

## Operating Mode

- **Drafting and Prompt Formulation:** Analyse post text, formulate a physical
  metaphor, and generate the exact diffusion prompt formatted for Imagen 3.
- **Autonomous Image Generation:** Delegate to the `image-generator` subagent
  using the validated 16:9 prompt template.

## Visual Invariants

- **Aspect Ratio:** 16:9 widescreen landscape.
- **Background:** Solid 100% pure white (#FFFFFF) with zero gradients,
  vignettes, or drop shadows.
- **Medium:** Pure coloured pencil on cold-press paper grain with fine graphite
  cross-hatching. Use US English tokens for diffusion prompts: `colored pencil`,
  `centered`, `subtle shading`.
- **Signature:** Small, neat typography in the bottom-right corner:
  `'Frankly Speaking ...'`.
- **Negative Constraints:** Never include screens, code, binary digits, glowing
  neon nodes, interlocking gears, jigsaw puzzles, or diagram labels.

## Prompt Template

Construct the final generation prompt using this exact US English template:

"A minimalist colored pencil illustration of [DETAILED_SUBJECT], centered on a
solid pure white background. Rendered with fine colored pencil strokes, subtle
graphite cross-hatching, soft layered shading, and visible hand-drawn paper
grain texture. Wide 16:9 widescreen landscape composition with expansive clean
white negative space surrounding the central subject. In small, neat,
understated typography in the bottom-right corner:
'Frankly Speaking ...'. Clean editorial magazine style, completely
unlabelled, no other text or watermark."

## Output Contract

1. **Metaphor Rationale:** 2–3 sentences defining the symbol and colour harmony.
2. **Prompt Code Block:** The exact prompt string in a fenced code block ready
   for execution or manual copy.
3. **Execution / File Path:** Generated image path (e.g., `images/banner.jpg`)
   or delegation report to `image-generator`.
4. **Refinement Angles:** Offer two alternative metaphorical directions.

## Cross-Skill References

- **`blog-editor`** — Integrate banner images into article front matter.
- **`markdown-editor`** — Format and validate image markdown links.

## Resources

- Style: [The Guardian Style Guide][guardian-style]
- Dictionary: [Macquarie Dictionary][macquarie]
- Rhetoric: [Aristotle's Rhetoric][rhetoric]

[guardian-style]:
https://www.theguardian.com/guardian-observer-style-guide-a
[macquarie]:
https://www.macquariedictionary.com.au/
[rhetoric]:
https://en.wikipedia.org/wiki/Rhetoric_(Aristotle's_work)
