---
title: Mermaid theme
description: One of four built-in colour palettes Mermaid uses to render diagrams — default, dark, forest, neutral.
related: ['security-level']
lastUpdated: 2026-05-01
---

A **Mermaid theme** is a named bundle of colours, fonts, and stroke widths that determines how a rendered diagram looks. Mermaid ships with four themes:

- **`default`** — light background, blue accents. The out-of-the-box pick.
- **`dark`** — dark background, lighter strokes. The right pick for dark documentation systems and slides shown in dim rooms.
- **`forest`** — green-tinted, lower contrast. Subtler — useful when you want diagrams to recede so the surrounding prose stands out.
- **`neutral`** — black-and-white only. The right pick for print, e-readers, and any context where colour might be lost.

Themes are selected by passing `theme: '...'` to `mermaid.initialize(...)`. To lock a theme into the diagram source itself (so the theme follows the diagram across renderers), prepend the source with a directive: `%%{init: {'theme': 'dark'}}%%`.

For finer control, theme variables (`primaryColor`, `lineColor`, `fontFamily`, etc.) can override individual values without redefining the whole theme. See our [theme customisation guide](/guides/mermaid-theme-customization/) for the variable list and patterns.

A theme should be picked once for a project and held consistent across all diagrams. Mixing themes in a single docs site looks unprofessional and forces readers to relearn the colour vocabulary each time.
