---
question: Which Mermaid version does this site use?
category: formats
order: 5
---

Mermaid Preview bundles **Mermaid version 11**, pinned in `package.json`. Each build of the site embeds the exact version, so what you render here matches what you would get from a fresh `npm install mermaid@11`.

GitHub's renderer currently tracks Mermaid v10, and tools like Notion and GitBook track somewhat older versions. Most syntax is identical across these versions, but a few v11-only features (notably newer diagram types and some directive options) will not render on platforms still on v10.

When you copy a diagram from this preview into another tool and the rendering differs, version skew is the most likely cause. We document the practical consequences in our [embed guides](/guides/) for GitHub, Notion, and the major static-site generators.
