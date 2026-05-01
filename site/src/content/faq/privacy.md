---
question: Do you store my diagram on the server?
category: privacy
order: 2
---

No. Rendering happens in your browser using the bundled Mermaid library. The diagram source you paste is never sent to our server.

The "Copy share URL" feature uses the URL fragment (after `#`), which by web standards is **not** transmitted in HTTP requests. Even when someone follows the share link, our server does not see the diagram source — only the path `/preview/`.

For full details see the [Privacy Policy](/privacy/).
