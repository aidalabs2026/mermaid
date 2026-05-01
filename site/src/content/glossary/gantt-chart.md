---
title: Gantt chart
description: A schedule diagram with horizontal bars representing tasks over time, plus dependencies and milestones.
related: ['flowchart']
lastUpdated: 2026-05-01
---

A **Gantt chart** lays out tasks against a calendar. Each task is a horizontal bar whose left edge is the start date and whose width is the duration. Dependencies (`after a1`) anchor a task's start to the end of another. Milestones are zero-duration markers, drawn as diamonds, that flag fixed dates without filling time.

Gantt charts are the right tool when **timing matters** — product launches, conference timelines, multi-team plans where a delay in one section pushes others. They are the wrong tool when:

- The plan has only two or three tasks (a bullet list is shorter).
- The plan changes daily (any visualisation will be out of date by lunch; use a project-management tool instead).
- The audience cares about resource allocation, not calendar (use a different chart type).

In Mermaid, gantt charts begin with the keyword `gantt` and require a `dateFormat` declaration (`YYYY-MM-DD` is the safe default). Sections group related tasks visually. Modifiers `crit`, `done`, `active`, and `milestone` change the bar's style.

A common mistake is to use the wrong `dateFormat` and end up with charts that interpret `01-02-2026` differently in different locales. Always set `dateFormat YYYY-MM-DD` explicitly. See the [gantt diagram guide](/diagrams/gantt/) for the full syntax.
