---
question: Why is my diagram cut off?
category: using-the-tool
order: 3
---

Two common causes:

1. **Very wide diagrams** — switch the direction. `flowchart LR` produces left-to-right output that often fits a desktop screen better than `flowchart TD`.
2. **Very tall diagrams** — the preview pane scrolls, so the bottom of the SVG should be reachable. If it is not, try the **SVG download** button and open the file directly; the file is the full diagram.

If the rendered SVG itself is missing pieces (for example, edges that should connect two nodes are missing), check that the source has no typos around node names. Mermaid silently drops references to nodes it never saw declared.
