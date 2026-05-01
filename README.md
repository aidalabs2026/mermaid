# mermaid_preview

Online [Mermaid](https://mermaid.js.org/) diagram preview — paste text-based diagram syntax, get an SVG instantly. Privacy-first (rendering in the browser), AdSense-funded.

- **Site** — `https://mermaid.aidalabs.kr` (Phase 4: domain to be DNS-pointed at deploy time)
- **Stack** — Astro 5 SSG + Mermaid.js (dynamic import on the preview page) + lz-string for share URLs
- **Status** — Phase 0 scaffold complete; Phase 1 (live preview tool) in progress

## Folder map

| Path | Role |
|---|---|
| `PRD.md` | Product requirements (source of truth) |
| `docs/` | Korean planning docs (vision, roadmap, architecture, content plan, AdSense checklist, deployment, Claude playbook) |
| `site/` | Astro project — pages, content collections, components, styles |
| `deploy/` | Nginx config + idempotent bootstrap script for the OCI VM |
| `.github/workflows/` | GitHub Actions — `deploy-site.yml` builds Astro and rsyncs to the VM |

## Local development

```bash
cd site
npm install
npm run dev    # http://localhost:4321
npm run build  # produces site/dist/
```

## Deploy (operator action)

See `docs/06-deployment-and-domain.md`. Summary:

1. Add DNS A record `mermaid.aidalabs.kr → <OCI Public IP>`.
2. SSH to the VM, run `EMAIL=... sudo -E bash deploy/scripts/bootstrap.sh`.
3. Add GitHub Secrets (`OCI_HOST`, `OCI_SSH_USER`, `OCI_SSH_KEY`).
4. Trigger the workflow.

## Portfolio context

This project lives in the [`2026_google_ads`](../) portfolio. It shares the
OCI Always Free VM, the `aidalabs.kr` domain, and the Astro SSG +
GitHub Actions stack with `bidMaster`, `json-beautifier`, and
`markdown_preview`. Internal port `8002` is reserved for the future
`mermaid-api.aidalabs.kr` service.
