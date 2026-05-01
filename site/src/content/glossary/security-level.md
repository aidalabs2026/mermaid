---
title: securityLevel
description: A Mermaid initialization option that controls how aggressively the library sanitises rendered output.
related: ['flowchart']
lastUpdated: 2026-05-01
---

`securityLevel` is an option you pass to `mermaid.initialize({ ... })`. It tells Mermaid how strictly to sanitise diagram output before injecting it into the page.

Mermaid supports four levels:

| Level | Behaviour |
|---|---|
| `strict` | Output is sanitised. Inline event handlers and `<script>` are stripped. Click bindings are disallowed. |
| `antiscript` | Sanitises `<script>` but leaves other HTML alone. |
| `loose` | No sanitisation. Click handlers and arbitrary HTML pass through. |
| `sandbox` | Renders inside a sandboxed iframe — the safest, but interactivity is limited. |

This site initialises Mermaid with `securityLevel: 'strict'`, hard-coded. The reason is straightforward: any time a website renders user-supplied input, an unsanitised path is a cross-site-scripting hazard waiting to happen. `strict` covers the vast majority of real diagrams without giving up rendering quality.

If you embed Mermaid in your own product and your users paste arbitrary diagrams, default to `strict` unless you have a specific reason not to.
