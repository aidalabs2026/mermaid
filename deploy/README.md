# deploy/ — mermaid_preview infrastructure scripts

This directory contains everything needed to provision the OCI VM for
`mermaid.aidalabs.kr`. It is run **on the VM**, not in CI.

## Files

| Path | Purpose |
|---|---|
| `nginx/mermaid.aidalabs.kr.conf` | Static-site Nginx config (port 80 only — certbot adds 443 block automatically) |
| `scripts/bootstrap.sh` | Idempotent + non-destructive setup script for the VM |

There is **no** `systemd/` directory yet because the MVP is fully client-side
(Mermaid.js renders in the browser). Phase 6+ will add a server-rendering API
on port 8002, at which point a `systemd/mermaid-api.service` will be added
here following the bidMaster pattern.

## Bootstrap procedure (operator)

> Read `../docs/06-deployment-and-domain.md` first. Bullet-point summary below.

1. **DNS** — at the registrar (가비아), add an A record:
   - `mermaid` → `<OCI Reserved Public IP>` (the same VM that runs bidMaster + beautifier)
2. **OCI Security List** — already open for 80/443 if other projects are running. Otherwise add ingress.
3. **SSH into the VM**, then:
   ```bash
   git clone https://github.com/<you>/mermaid_preview.git ~/mermaid-setup
   cd ~/mermaid-setup
   EMAIL=you@example.com sudo -E bash deploy/scripts/bootstrap.sh
   ```
4. **GitHub Secrets** — in the mermaid_preview repo Settings:
   - `OCI_HOST` = VM public IP
   - `OCI_SSH_USER` = `ubuntu`
   - `OCI_SSH_KEY` = private key (LF newlines, trailing blank line)
5. **First deploy** — Actions → "Deploy Static Site" → Run workflow → main.

## Non-destructive guarantees

`bootstrap.sh` is designed to coexist with `bidMaster` and `json-beautifier`
on the same VM:

- It never removes `/etc/nginx/sites-enabled/default` or any existing site
  symlink.
- It only installs its own `mermaid.aidalabs.kr.conf` and links it.
- It checks `dpkg -l iptables-persistent` before installing `ufw` to avoid
  the known UFW/iptables-persistent conflict on shared VMs.
- It uses `iptables -C ... || iptables -I ...` for idempotent firewall rules.
- The `sudoers` drop-in is scoped to `mermaid` and grants only
  `systemctl reload nginx`.

If you re-run the script later (after a Mermaid update, for example), it will
no-op on already-satisfied steps.

## Phase 6+ — server rendering API (future)

When we add the optional API:

1. Drop `nginx/mermaid-api.aidalabs.kr.conf` (template in `../../docs/01-common-infrastructure.md` §4-2) into this directory.
2. Drop `systemd/mermaid-api.service` here.
3. Update `bootstrap.sh` to copy both new files (idempotent — the existing
   bootstrap should remain re-runnable).
4. Re-run `certbot --nginx -d mermaid.aidalabs.kr -d mermaid-api.aidalabs.kr --keep-until-expiring`.

The internal port `8002` is reserved in the portfolio registry
(`../../CLAUDE.md` §5).
