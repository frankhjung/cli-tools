# Project Mandates

## 80-Column Limit

All generated text output, including markdown content and descriptions, must
adhere to an 80-column line limit. This applies to all content, not just code.

## Spelling

- Use Australian English for all documentation text.
- Use US English for code.

## Expert Routing

- When working on Ansible roles (`roles/*`) or tasks (`main.yaml`), prioritise
  the `ansible-expert` skill.
- When working on `*.hs` or `*.lhs` files, prioritise the `haskell-programmer`
  skill.
- When working on `*.py`, prioritise the `python-programmer` skill.
- For dokuwiki pages (`*.txt`), use prioritise the `dokuwiki-validator` skill.
- For markdown documentation (`*.md`, `*.Rmd`), use `markdown-validator`.
- For shell scripts (`.sh`), use the `shell-programmer` skill

## Documentation Review

- For exhaustive document reviews, the user should prefer activating the
  `document-critique` or `markdown-validator` or `dokuwiki-validator` skills.

## Resources

- Style:
  [The Guardian style guide](https://www.theguardian.com/guardian-observer-style-guide-a)
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)
  (Australian English)
- Rhetoric:
  [Aristotle's Rhetoric](https://en.wikipedia.org/wiki/Rhetoric_(Aristotle's_work))
  — logical fallacies and argument structure