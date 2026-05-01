---
question: Why doesn't my diagram render?
category: using-the-tool
order: 7
---

The most common causes, in order:

1. **Wrong diagram-type keyword** on the first non-blank line. It must be one of `flowchart`, `sequenceDiagram`, `classDiagram`, `stateDiagram-v2`, `erDiagram`, `gantt`, `pie`, `mindmap`, `journey`, `gitGraph`, or `timeline`. A typo (`flowchat`) silently fails.
2. **Missing direction** after `flowchart`. `flowchart` alone errors; `flowchart TD` works.
3. **Smart quotes** from a copy-paste through a word processor. Replace `"` `"` `'` `'` with the plain ASCII versions.
4. **Special characters in node labels**. Wrap labels with parentheses, colons, brackets, or pipes in double quotes: `A["Step (1): more"]`.
5. **Wrong arrow grammar for the diagram type**. Sequence diagrams use `->>` and `-->>`; flowcharts use `-->` and `-.->`. Mixing them produces lexical errors.

The status bar below the editor shows the first line of the parser error. We have a longer [troubleshooting guide](/guides/common-parse-errors-and-fixes/) with the ten most common errors and their fixes.

If a diagram renders here but not in your destination tool (GitHub, Notion, etc.), the cause is usually a Mermaid version mismatch — see the FAQ on Mermaid version above.
