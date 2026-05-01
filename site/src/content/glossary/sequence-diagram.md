---
title: Sequence diagram
description: A diagram that shows messages exchanged between actors over time, drawn with vertical lifelines and horizontal arrows.
related: ['flowchart', 'class-diagram']
lastUpdated: 2026-05-01
---

A **sequence diagram** plots time on the vertical axis and actors on the horizontal axis. Each actor (a person, a service, a database) gets a vertical "lifeline" running down the page. Arrows between lifelines represent messages — synchronous calls, asynchronous responses, returns. The order top-to-bottom is the order in which messages are sent.

In Mermaid, a sequence diagram starts with the keyword `sequenceDiagram` and uses a small grammar of arrows: `->>` for synchronous send, `-->>` for response, `-x` for failed message, `--)` for asynchronous send. Actors are introduced with `participant` (boxes) or `actor` (stick figures).

Sequence diagrams excel at **API request flows**, **OAuth handshakes**, **webhook retry policies**, and any scenario where the order of messages between named services matters. They are the wrong tool when the diagram has a single participant — that's a [flowchart](/diagrams/flowchart/) — or when timing is irrelevant.

See the dedicated [sequence diagram guide](/diagrams/sequence/) for syntax details and worked examples.
