---
title: ER diagram
description: An entity-relationship diagram for database schemas. Shows tables, columns, primary and foreign keys, and the cardinality of each relationship.
related: ['class-diagram']
lastUpdated: 2026-05-01
---

An **ER diagram** (entity-relationship diagram) is the canonical way to depict a relational database schema. Boxes represent tables; lines between them represent foreign-key relationships; small glyphs at each end of the line encode the cardinality (zero, one, or many).

In Mermaid, ER diagrams use the keyword `erDiagram` and a Crow's-Foot-inspired notation:

| Glyph | Meaning |
|---|---|
| `\|\|` | exactly one |
| `o\|` | zero or one |
| `\|{` | one or more |
| `o{` | zero or more |

A line written `USER ||--o{ POST` reads as "one user has zero or more posts". The syntax is terse but expressive once you internalise the four glyphs.

ER diagrams are most useful when the audience needs to understand **how tables connect**: a new engineer onboarding to a codebase, a designer looking at a feature that touches three tables, a DBA reviewing a migration. They are not a replacement for the actual schema — column names, types, and constraints belong in the migration file. The diagram captures shape, not specification.

For domain models in code (where types share inheritance), use a [class diagram](/glossary/class-diagram/) instead. The two look similar but answer different questions.
