---
title: Flowchart
description: A diagram that uses boxes and arrows to show the steps of a process and the decisions that branch it.
related: ['sequence-diagram', 'state-diagram']
lastUpdated: 2026-05-01
---

A **flowchart** is a diagram in which boxes represent steps or states and arrows represent the order in which a reader should follow them. Decision points (drawn as diamonds in classic flowcharting and as `{Diamond}` shapes in Mermaid) split the path along labelled branches.

In Mermaid, a flowchart begins with the keyword `flowchart` followed by a direction (`TD` for top-down, `LR` for left-to-right, etc.). The tool itself decides the layout — you provide nodes and edges, not coordinates.

Flowcharts are easy to over-use. If your diagram is mostly about *who sends what message to whom*, a sequence diagram is clearer. If it is about *how the same thing transitions through states*, a state diagram is clearer. Reach for a flowchart when the story is "first this happens, then that, with branches".

See the dedicated [flowchart guide and cheat sheet](/diagrams/flowchart/) for syntax details.
