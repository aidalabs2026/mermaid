#!/usr/bin/env bash
#
# mermaid_preview OCI VM Bootstrap — Ubuntu 22.04 / 24.04
#
# Usage on the VM:
#   git clone https://github.com/<user>/mermaid_preview.git ~/mermaid-setup
#   cd ~/mermaid-setup
#   EMAIL=you@example.com sudo -E bash deploy/scripts/bootstrap.sh
#
# Idempotent + non-destructive: existing Nginx sites for other projects
# (bidMaster, beautifier, etc.) on the same VM are left alone.
#
set -euo pipefail

DOMAIN_SITE="mermaid.aidalabs.kr"
SITE_DIR="/var/www/mermaid"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEPLOY_DIR="$( cd "${SCRIPT_DIR}/.." && pwd )"

log()  { echo -e "\n\033[1;34m==> $*\033[0m"; }
warn() { echo -e "\033[1;33m!! $*\033[0m" >&2; }

if [[ $EUID -ne 0 ]]; then
    echo "root required: sudo -E bash $0" >&2
    exit 1
fi

EMAIL="${EMAIL:-}"
if [[ -z "$EMAIL" ]]; then
    read -r -p "Let's Encrypt contact email: " EMAIL
fi

# Shared-VM detection — keep existing site configs untouched
if [[ -d /etc/nginx/sites-enabled ]] && \
   [[ $(ls -1 /etc/nginx/sites-enabled/ 2>/dev/null | grep -v '^default$' | wc -l) -gt 0 ]]; then
    log "Existing Nginx sites detected — running in shared-VM mode (preserving existing configs)"
    ls -1 /etc/nginx/sites-enabled/ | sed 's/^/     /'
    echo
fi

export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a

log "Installing apt packages"
apt-get update
echo "iptables-persistent iptables-persistent/autosave_v4 boolean false" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean false" | debconf-set-selections

COMMON_PKGS=(
    nginx
    certbot python3-certbot-nginx
    rsync git curl fail2ban
    unattended-upgrades
)

# Avoid ufw / iptables-persistent conflict (Breaks: relationship)
if ! dpkg -l iptables-persistent 2>/dev/null | grep -q "^ii"; then
    COMMON_PKGS+=(iptables-persistent)
fi
if dpkg -l iptables-persistent 2>/dev/null | grep -q "^ii"; then
    echo "  iptables-persistent present — skipping UFW install"
else
    COMMON_PKGS+=(ufw)
fi

apt-get install -y "${COMMON_PKGS[@]}"

log "Firewall — ensuring 80/443 (idempotent)"
for port in 80 443; do
    if ! iptables -C INPUT -p tcp --dport "$port" -j ACCEPT 2>/dev/null; then
        iptables -I INPUT -p tcp --dport "$port" -j ACCEPT
        echo "  iptables: ${port} added"
    else
        echo "  iptables: ${port} already accepted"
    fi
done
if command -v netfilter-persistent >/dev/null 2>&1; then
    netfilter-persistent save >/dev/null 2>&1 \
        || warn "netfilter-persistent save failed — rules may not persist on reboot"
fi

if ufw status 2>/dev/null | grep -q "Status: active"; then
    ufw allow OpenSSH       >/dev/null 2>&1 || true
    ufw allow 'Nginx Full'  >/dev/null 2>&1 || true
    echo "  UFW: active, rules ensured"
else
    echo "  UFW: inactive — leaving as-is"
fi

log "Site directory + placeholder index.html"
install -d -o ubuntu -g ubuntu -m 755 "$SITE_DIR"
if [[ ! -f "$SITE_DIR/index.html" ]]; then
    cat > "$SITE_DIR/index.html" <<'HTML'
<!DOCTYPE html>
<html lang="en"><head><meta charset="UTF-8"><title>Mermaid Preview</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>body{font-family:system-ui,sans-serif;max-width:600px;margin:80px auto;padding:0 20px;color:#333}</style>
</head><body>
<h1>Mermaid Preview</h1>
<p>Site is provisioning. The first deploy will replace this placeholder.</p>
</body></html>
HTML
    chown ubuntu:ubuntu "$SITE_DIR/index.html"
fi

log "Nginx — installing site config (other sites untouched)"
cp "$DEPLOY_DIR/nginx/mermaid.aidalabs.kr.conf" /etc/nginx/sites-available/
ln -sf /etc/nginx/sites-available/mermaid.aidalabs.kr.conf /etc/nginx/sites-enabled/
# NOTE: never remove /etc/nginx/sites-enabled/default — other projects may rely on it.

echo "  enabled sites:"
ls -1 /etc/nginx/sites-enabled/ | sed 's/^/    /'

nginx -t
systemctl reload nginx

log "sudoers — allow GitHub Actions to reload nginx without a password"
cat > /etc/sudoers.d/mermaid <<'EOF'
ubuntu ALL=(ALL) NOPASSWD: /bin/systemctl reload nginx
EOF
chmod 440 /etc/sudoers.d/mermaid
visudo -cf /etc/sudoers.d/mermaid

log "DNS check"
RESOLVED=$(getent hosts "$DOMAIN_SITE" | awk '{print $1}' | head -n1 || true)
MY_IP=$(curl -s https://api.ipify.org || true)

echo "  $DOMAIN_SITE → ${RESOLVED:-(unset)}"
echo "  This VM public IP: ${MY_IP:-(lookup failed)}"

if [[ -n "$MY_IP" && "$RESOLVED" == "$MY_IP" ]]; then
    log "Let's Encrypt — issuing certificate"
    certbot --nginx \
        -d "$DOMAIN_SITE" \
        --agree-tos -m "$EMAIL" --redirect --non-interactive --keep-until-expiring \
        || warn "certbot failed. After DNS propagates, retry: sudo certbot --nginx -d $DOMAIN_SITE"
else
    warn "DNS does not point to this VM yet. Skipping certbot."
    warn "Once DNS is propagated, run:"
    warn "  sudo certbot --nginx -d $DOMAIN_SITE --agree-tos -m $EMAIL --redirect"
fi

log "Done"
echo
echo "====================================================="
echo "✅ mermaid_preview OCI bootstrap complete"
echo "   https://$DOMAIN_SITE  (static site)"
echo "====================================================="
echo
echo "Next steps:"
echo "  1. GitHub repo Settings → Secrets → Actions:"
echo "       OCI_HOST     = <this VM public IP>"
echo "       OCI_SSH_USER = ubuntu"
echo "       OCI_SSH_KEY  = GitHub Actions deploy private key"
echo "     (recommended: ssh-keygen -t ed25519 -f github-deploy -N '' -C github-actions)"
echo "     Copy the public key into ~ubuntu/.ssh/authorized_keys on this VM."
echo "  2. git push origin main triggers .github/workflows/deploy-site.yml"
