<!--
  ======================================================================
   VD INSTALLER  ::  frictionless root sideload installer
   Install sideload APKs as root (single/batch/split), no friction: KernelSU/APatch/Magisk WebUI.

   Copyright (C) 2026  VD171
   SPDX-License-Identifier: AGPL-3.0-or-later

   Free software under the GNU AGPL v3 or later. NETWORK COPYLEFT: run a
   modified version, even as a service, and you MUST offer its source.

   Site           : https://vd171.ru
   Site           : https://vd.priv8.ru
   Source         : https://github.com/VD171/VD-Installer
   GitHub         : @VD171 https://github.com/VD171
   XDA-Developers : @VD171 https://xdaforums.com/m/vd171.4699873/
   XDA thread     : https://xdaforums.com/t/VD-Installer.4809504/
   Telegram       : @VD_Priv8 https://t.me/VD_Priv8
   Channel        : @Priv8_VD https://t.me/Priv8_VD
   Discord        : @VD.Priv8 https://discord.com/users/1296831918989639721
   E-mail         : vd.priv8@pm.me
  ======================================================================
-->

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · Italiano · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Installatore di sideload con permessi di root senza attriti - KernelSU / APatch / Magisk WebUI.

## Perché

Installare un APK sideloaded su un telefono con root è più rumoroso di quanto dovrebbe: il verificatore
di pacchetti di Play Protect può restituire `INSTALL_FAILED_VERIFICATION_FAILURE`, le app split
(`.xapk` / `.apkm` / `.apks`) richiedono l'uso manuale della session API, e un'app appena installata si
annuncia come "sideloaded" a ogni app che ne legge l'origine di installazione. VDInstaller fa tutto
questo al posto tuo, già con permessi di root, senza richieste di "concedi su" e senza terminale.

## Funzionalità

- **Ogni forma di APK** - un singolo `.apk`, un'intera cartella di APK indipendenti (batch), un archivio
  split raggruppato (`.xapk` / `.apkm` / `.apks` / `.zip`), o una cartella di APK split sciolti.
- **Nessun muro di verifica** - un selettore a 3 vie per il verificatore di pacchetti di Play Protect:
  lascialo com'era (spento solo durante l'installazione, ripristinato esattamente), sempre acceso, o
  sempre spento.
- **Onesto sulla Developer Verification** - un'installazione con root è già esente dalla Developer
  Verification di Android del 2026; il selettore è best-effort e lo dichiara, non è mai un interruttore
  finto.
- **Non "sideloaded"** - presenta facoltativamente l'origine di installazione come Play Store, sia come
  installatore (al momento dell'installazione) sia come iniziatore (tramite una modifica di
  `packages.xml` consapevole di ABX).
- **Distaccato e ripristinabile** - le installazioni girano come processo root distaccato; chiudere la
  WebUI non le interrompe mai, e l'interfaccia si riaggancia tramite l'id dell'operazione.
- **Scelta tua** - downgrade, pacchetti di test, concessione di tutti i permessi di runtime, utente di
  destinazione, aggirare il blocco per target SDK basso: tutto facoltativo.
- **Offline, autonomo, senza riavvio** - un modulo WebUI con i suoi binari inclusi; utilizzabile nel
  momento in cui viene flashato.

## Agenti AI

Questo progetto accoglie i contributori AI e agent. L'engine parla JSON tramite un piccolo contratto
headless (`scripts/helper.sh <verb> <base64(JSON)>`), documentato in
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), così un agent può pilotare ogni azione che la WebUI può
compiere - non fare scraping della WebUI. Le patch dall'AI sono soggette allo stesso livello di revisione
di qualsiasi altra.

## Installazione

Flasha lo zip in KernelSU, APatch o Magisk e apri la WebUI di VDInstaller dal tuo gestore root.
L'installatore mantiene solo l'ABI del tuo dispositivo ed esegue il gate di integrità obbligatorio
`.sha256` (si interrompe su uno zip corrotto o troncato). Android 8.0 (API 26) o più recente.

## Sicurezza

VDInstaller gira come root e installa gli APK che scegli; spegnere il verificatore di pacchetti per
un'installazione disabilita una scansione malware, quindi installa solo APK di cui ti fidi. Non indebolisce
mai la sicurezza del dispositivo in silenzio: per impostazione predefinita il verificatore viene ripristinato
al suo esatto stato precedente, e non tocca mai la tua configurazione di HMA-OSS. Segnala i problemi secondo
[SECURITY.md](SECURITY.md).

## Build

Sempre release, mai debug. `.github/scripts/build_bin.sh` scarica `jq` dal repository apt di Termux (con la
sua chiusura di librerie condivise) e i convertitori standalone `abx2xml` / `xml2abx`, per tutti e quattro
gli ABI, ciascuno con un `PROVENANCE.json`. Il workflow di release assembla gli zip flashabili, scrive i
companion `.sha256`, compila `update.json` e pubblica come `github-actions[bot]`.

## Documentazione

Le guide si trovano in [docs/](docs/) e si rispecchiano nella wiki di GitHub. Vedi
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) per il contratto headless.

## Vedi anche

- [VDBackup](https://github.com/VD171/VD-Backup) - backup e ripristino completi di app e dati, come root.
- [VDInfos](https://github.com/VD171/VD-Infos) - leggi ogni info del dispositivo con ogni metodo, poi confronta.
- [VDGoogle](https://github.com/VD171/VDGoogle) - leggi RCS, Wallet e attestazioni come root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - modulo di fingerprint e props Pixel.

## Contatti

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/root-webui-v1-00-vd-installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Licenza

VDInstaller è concesso in licenza secondo la GNU AGPL-3.0-or-later. Vedi [LICENSE](LICENSE). NETWORK
COPYLEFT: esegui una versione modificata, anche come servizio, e devi offrirne il sorgente.

## Marchi

Android, KernelSU, APatch, Magisk, Google Play e Play Protect appartengono ai rispettivi proprietari.
Questo progetto è indipendente e non è affiliato a loro né approvato da loro.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Unisciti al canale: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
