---
question: Does the preview work offline?
category: privacy
order: 10
---

Once the page has loaded once, the rendering itself works without an internet connection — the Mermaid library is bundled into the page, not fetched at runtime. If you load the preview while online and then go offline, you can keep typing and the diagram will keep rendering.

However, **the page itself is loaded over HTTPS from our server**, so the very first visit needs an internet connection. The site is a static Astro build with no service worker, so a hard reload while offline will fail.

If you want a fully-offline workflow:

- Use the **`mermaid` npm package** in a local Node project, or
- Use a tool like **Obsidian** or **VS Code with a Mermaid extension** that ships its own copy of the library.

Both approaches give you offline rendering at the cost of a setup step. For ad-hoc diagram drafting on a flight, opening this site once before takeoff and keeping the tab open works for most flights.
