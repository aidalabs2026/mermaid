---
title: State diagram
description: A diagram that shows the discrete states an entity can be in and the events that move it between states.
related: ['flowchart', 'sequence-diagram']
lastUpdated: 2026-05-01
---

A **state diagram** (or state machine diagram) describes a single entity that moves through a finite set of states. Boxes represent states; arrows represent transitions, labelled with the event or condition that triggers them. Special markers `[*]` denote the initial and final states.

In Mermaid, state diagrams use the keyword `stateDiagram-v2`. The v2 keyword is the modern grammar; the older `stateDiagram` is deprecated but still recognised by most renderers.

State diagrams are the right tool when **the same noun has multiple states with rules about how to move between them** — an order moving Cart → Address → Payment → Placed, a deployment moving Pending → Running → Done → Failed, a UI screen toggling between Loading → Ready → Error. They are the wrong tool when the diagram describes a single linear path with no branching back; that's a [flowchart](/glossary/flowchart/).

A common refactor: developers start with a flowchart that has nodes named after states, and edges named after events. After three iterations the flowchart starts looking like a state machine — at which point switching to `stateDiagram-v2` yields a cleaner diagram.

See the [state diagram guide](/diagrams/state/) for the full grammar.
