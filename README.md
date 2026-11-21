# Smart-Home-Dashboard – Live-Demo

**→ <https://michdo93.github.io/Smart-Home-Dashboard-Live-Demo/>**

Öffentliche Live-Demo des [Smart-Home-Dashboards](https://github.com/Michdo93/Smart-Home-Dashboard). Begleit-Repo zum Buch *openHAB Online Demos*.

Die Demo ist mit einem openHAB 5 verbunden, auf dem das [virtuelle Haus](https://github.com/Michdo93/openHAB-Virtual-Smart-Home) läuft: Lampen, Heizung, Rollläden, Geräte – alles simuliert, nichts davon steht in einer echten Wohnung. Was Sie schalten, sehen andere Besucher live mit.

## Weitere Online-Demos

Diese Demo enthält die Themes `standard`, `glas` und `eink` (Zahnrad → Design). Jedes Design gibt es außerdem als eigene Demo:

| Design | Demo |
|---|---|
| standard | <https://michdo93.github.io/smart-home-dashboard-theme-standard-live-demo/> |
| glas | <https://michdo93.github.io/smart-home-dashboard-theme-glas-live-demo/> |
| eink | <https://michdo93.github.io/smart-home-dashboard-theme-eink-live-demo/> |
| Bootstrap 5 (Ansicht) | <https://michdo93.github.io/smart-home-dashboard-theme-bootstrap-live-demo/> |
| Material Design 3 (Ansicht) | <https://michdo93.github.io/smart-home-dashboard-theme-material-live-demo/> |

Alle nutzen denselben Proxy und dasselbe virtuelle Haus.

## Aufbau

```text
GitHub Pages (dieses Repo)      Cloudflare Worker              myopenHAB        Proxmox-VM
Dashboard + js-openhab-     →   cloudflare-openhab-rest-   →   Cloud       →    openHAB 5
proxy-client, ohne              proxy: Freigaben, Prüfung      Connector        virtuelles Haus
Zugangsdaten                    der Befehle, Ratenbegrenzung
```

## Was dieses Repo enthält

Nicht das Dashboard selbst, sondern nur die Anpassung an die Demo:

| Datei | Inhalt |
|---|---|
| `config.demo.js` | Adresse des Proxys und Titel; wird an `config.js` des Dashboards angehängt |
| `anpassen.sh` | tauscht `js-openhab-rest-client` gegen `js-openhab-proxy-client`, installiert die Themes glas und eink und hängt `config.demo.js` an |
| `.github/workflows/pages.yml` | holt Dashboard, Proxy-Client und die Theme-Repos, ruft `anpassen.sh` auf, veröffentlicht auf GitHub Pages |

Der Code des Dashboards bleibt unverändert – beide Bibliotheken haben dieselbe Schnittstelle. Die Demo übernimmt den Stand von `main` des Dashboards bei jedem Push hierher, von Hand (Actions → *Live-Demo veröffentlichen* → *Run workflow*) und montags automatisch.

## Eigene Demo

1. Repo forken oder als Vorlage nutzen.
2. Proxy einrichten: [cloudflare-openhab-rest-proxy](https://github.com/Michdo93/cloudflare-openhab-rest-proxy), mit `https://<name>.github.io` in den erlaubten Origins.
3. In `config.demo.js` die Adresse des eigenen Workers eintragen.
4. *Settings → Pages → Source:* **GitHub Actions** wählen.
5. Workflow starten.

Lokal ausprobieren, ohne zu veröffentlichen:

```bash
git clone https://github.com/Michdo93/Smart-Home-Dashboard site
git clone https://github.com/Michdo93/js-openhab-proxy-client proxy-client
./anpassen.sh site proxy-client theme-glas theme-eink
cd site && python3 -m http.server 5173      # http://localhost:5173
```

## Was Besucher dürfen

Der Proxy entscheidet, nicht diese Seite: alle Items des virtuellen Hauses lesen, Befehle nur an Bedienelemente der Sitemap und nur mit passenden Werten (z. B. Solltemperatur 16–26 °C), höchstens 20 Befehle pro Minute. Zugangsdaten stehen weder hier noch im Browser.

## Unterstützen

Wenn Ihnen dieses Projekt hilft, freue ich mich über einen Kaffee:

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?logo=buymeacoffee&logoColor=black)](https://buymeacoffee.com/Michdo93)

## Lizenz

MIT – siehe [LICENSE](LICENSE).
