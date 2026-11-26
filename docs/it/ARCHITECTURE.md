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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · Italiano · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · [Português](../pt/ARCHITECTURE.md) · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Architettura

VDInstaller è una WebUI sottile sopra un motore shell root. Nulla nell'interfaccia ha privilegi, ogni azione
privilegiata è una singola chiamata shell che restituisce un singolo oggetto JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI in JavaScript puro (nessun framework), chiaro/scuro, 22 lingue. Chiama il motore
  attraverso il ponte WebUI di KernelSU (`ksu.exec`) e analizza la risposta JSON.
- **`scripts/common.sh`** - la libreria condivisa inclusa da entrambi gli script: risoluzione di ABI/PATH, i
  wrapper `pm`/`dumpsys`/`fw` (ambiente pulito, così le librerie Termux incluse non oscurano mai quelle di
  ART), gli helper JSON e `jq`, e l'`xml_edit` ABX-aware.
- **`scripts/helper.sh`** - il contratto della WebUI: una riga JSON per chiamata. I verbi corti (version,
  config, browse, scan) vengono eseguiti inline, quelli lunghi (install, uninstall) distaccano un worker e
  restituiscono un `opid`.
- **`scripts/worker.sh`** - il motore di installazione distaccato: le quattro modalità di installazione,
  l'interruttore del verificatore, la falsificazione dell'origine dell'installazione e l'API di sessione del
  gestore dei pacchetti. Scrive l'avanzamento su un file che la WebUI interroga, e sopravvive alla chiusura
  della WebUI (`setsid`, e sfugge al congelatore delle app).

## Punti chiave

- **Già root.** Nessuna richiesta di "concedi su" e nessun azionamento di `sucompat`, il motore gira come
  root dal modulo e chiama `pm` / `settings` direttamente.
- **Installazioni a sessione.** Tutte le modalità usano `pm install-create` / `install-write` /
  `install-commit`, così le app divise si installano correttamente e l'origine dell'installazione (`-i`)
  viene impostata al momento della sessione.
- **ABX-aware.** La falsificazione dell'iniziatore in `packages.xml` controlla la firma binaria XML `ABX\0`,
  decodifica, modifica, ricodifica, fa un round-trip per validare, esegue un backup byte per byte e scambia
  in modo atomico, il file dal vivo non viene mai toccato se ogni passo non va a buon fine.
- **Senza riavvio.** Un modulo WebUI autonomo senza nulla da montare: `customize.sh` lo copia nella
  directory dei moduli attivi così funziona nell'istante in cui viene installato.
- **Aggiornamenti senza flash.** Il motore **VDLU** incluso aggiorna il modulo scaricando solo i file
  modificati, indirizzati per contenuto e firmati con ed25519 - nessun reflash completo.
- **Distaccato.** Le operazioni lunghe girano al di fuori della webview, chiudere la WebUI non le interrompe
  mai.

## Garanzia di compatibilità

- `sh` POSIX sul dispositivo (`sh -n` passa, nessun bashism oltre `local`, nessuna dipendenza da `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` sono gli unici strumenti del framework usati, tutti via
  `/system/bin`.
- I binari inclusi (`jq`, `abx2xml`/`xml2abx`) sono opzionali per il percorso comune e portano la propria
  provenienza, il convertitore ABX ricade sull'`/system/bin/abx2xml` del dispositivo dove presente.

<!-- doc-footer -->

---

> _Questa documentazione è stata generata con Claude (Anthropic) ed è gestita da VD171. Correzioni e miglioramenti sono benvenuti, vedi [CONTRIBUTING.md](CONTRIBUTING.md)._
