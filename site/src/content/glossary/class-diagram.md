---
title: Class diagram
description: A diagram of object-oriented classes, their fields and methods, and the relationships between them.
related: ['er-diagram', 'sequence-diagram']
lastUpdated: 2026-05-01
---

A **class diagram** is a static view of a software system in terms of classes (or types), their members, and their relationships. Boxes represent classes; lines between them represent inheritance, association, composition, or aggregation. Mermaid uses a familiar UML-inspired syntax: `<|--` for inheritance, `*--` for composition (filled diamond), `o--` for aggregation (open diamond), and `-->` for plain association.

Class diagrams are useful for **domain models** ("here are the five core types in our codebase"), **library overviews** ("here is the public surface"), and **onboarding new engineers**. They are the wrong tool when the audience cares about *runtime behaviour* rather than *type structure* — for that, reach for a [sequence diagram](/glossary/sequence-diagram/) or a [state diagram](/glossary/state-diagram/).

The class diagram is **not** the same as an [ER diagram](/glossary/er-diagram/). Class diagrams describe code; ER diagrams describe database schemas. They look superficially similar but answer different questions, and the wrong choice makes the diagram harder to read.

See the dedicated [class diagram guide](/diagrams/class/) for the full Mermaid grammar.
