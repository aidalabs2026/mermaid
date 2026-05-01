---
title: Mindmap
description: A hierarchical idea map. A tree of nodes radiating from a central root, used for brainstorms and scope outlines.
related: ['flowchart']
lastUpdated: 2026-05-01
---

A **mindmap** is a tree-shaped diagram with a single root in the middle (or at the top) and child nodes branching out. Indentation in the source defines hierarchy: each level of indentation is a level of nesting. Mindmaps capture the **shape** of an idea — categories, sub-categories, leaves — without committing to ordering or causality.

In Mermaid, mindmaps use the keyword `mindmap` and rely on indentation rather than explicit edges. The root can take a shape modifier: `root((Center))` for a circle, `root[Square]` for a rectangle, `root)Text(` for a "cloud" shape.

Mindmaps shine for **brainstorms**, **project scope summaries**, **feature breakdowns**, and any situation where the audience cares about how things group, not how they connect. They lose their punch beyond about three levels of depth — at that point, splitting the mindmap into multiple top-level diagrams keeps it readable.

The mindmap is **not** a flowchart. There is no implied order between siblings, and no edges between leaves under different parents. If your sketch has horizontal arrows between leaves, what you actually want is a [flowchart](/glossary/flowchart/) with `LR` direction.
