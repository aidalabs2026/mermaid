---
question: What's the maximum diagram size?
category: limits
order: 6
---

There is no hard upper bound. The practical limits are set by your browser:

- **Up to ~500 nodes** renders fast (under one second on a modern laptop).
- **500–2,000 nodes** noticeably slows down — the main thread blocks for a fraction of a second on each render. Usable, but consider whether the diagram is communicating one thing or trying to communicate ten.
- **Beyond ~5,000 nodes** the browser may stutter or run out of memory.

If your diagram is genuinely that large, the more honest fix is splitting it. A 2,000-node diagram is rarely readable as a single image; it is almost always two or three smaller diagrams stacked together.

For the rare case where the diagram is genuinely needed in one piece — large org charts, generated dependency graphs — we are tracking server-side rendering as a future feature. It will lift the browser-memory ceiling at the cost of needing to send the diagram to a server (with explicit consent).
