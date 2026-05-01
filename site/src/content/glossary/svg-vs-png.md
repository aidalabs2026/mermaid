---
title: SVG vs PNG
description: Two image formats for exporting a Mermaid diagram. SVG is vector and infinitely scalable; PNG is raster and fixed-resolution. Most of the time, SVG is the right answer.
related: ['mermaid-theme']
lastUpdated: 2026-05-01
---

When you export a rendered Mermaid diagram, you have two choices: **SVG** (Scalable Vector Graphics) and **PNG** (Portable Network Graphics).

**SVG** is what Mermaid actually produces — an XML file that describes shapes, paths, and text. Browsers, GitHub, and most documentation tools render SVG natively. It scales without blurring, works with screen readers (text inside the diagram is selectable), and is small (a typical Mermaid SVG is 5–20 KB). The drawback: a few tools (older slide decks, certain email clients, some CMSes) do not accept SVG uploads.

**PNG** is a raster format — pixels, not paths. Mermaid Preview produces PNG by drawing the SVG onto a canvas at a chosen resolution and exporting the canvas. PNG is the universal fallback: it embeds anywhere, but it is fixed-resolution. Zoom in past 100% and edges blur. A 2× export looks fine on a Retina display; a 1× export looks soft.

The fast rule:

- **Default to SVG.** It is what every modern documentation tool wants.
- **Export PNG only when the destination requires it** — older slide decks, email signatures, certain bug-tracker attachments.
- **For high-DPI displays**, export PNG at 2× or 3× scale. Mermaid Preview defaults to 2× for the PNG download button.

Both formats lose the original Mermaid source. Always keep the source in version control — the export is a derivative, not the document.
