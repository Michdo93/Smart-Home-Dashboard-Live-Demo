#!/usr/bin/env bash
# Macht aus dem Smart-Home-Dashboard die Live-Demo für GitHub Pages:
#   1. js-openhab-proxy-client statt js-openhab-rest-client
#   2. weitere Themes installieren (Auswahl unter Zahnrad → Design)
#   3. config.demo.js hinter config.js hängen
#
#   ./anpassen.sh <Dashboard> <Proxy-Client> [<Theme-Repo> …]
set -euo pipefail
SITE="$1"
CLIENT="$2"
shift 2
HIER="$(cd "$(dirname "$0")" && pwd)"

cp "$CLIENT/openhab-proxy.min.js" "$SITE/lib/"
rm -f "$SITE/lib/openhab.min.js"
sed -i 's|lib/openhab.min.js|lib/openhab-proxy.min.js|' "$SITE/index.html"
grep -q 'lib/openhab-proxy.min.js' "$SITE/index.html"    # Abbruch, falls nicht ersetzt

for THEME in "$@"; do                                    # z. B. glas, eink
  "$THEME/install.sh" "$SITE"
done

{ echo; cat "$HIER/config.demo.js"; } >> "$SITE/config.js"
if [ -n "${PROXY_URL:-}" ]; then                         # nur für lokale Tests
  sed -i "s|https://openhab-demo-proxy[^\"]*|$PROXY_URL|" "$SITE/config.js"
fi
rm -rf "$SITE/.git" "$SITE/.github"
echo "Live-Demo vorbereitet in $SITE"
