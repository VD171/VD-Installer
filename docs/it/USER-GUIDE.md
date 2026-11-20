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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · Italiano · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Guida utente di VDInstaller

## Indice

1. [Cos'è VDInstaller](#1-cosè-vdinstaller)
2. [Requisiti](#2-requisiti)
3. [Installazione e primo avvio](#3-installazione-e-primo-avvio)
4. [Panoramica della WebUI](#4-panoramica-della-webui)
5. [Installare gli APK](#5-installare-gli-apk)
6. [Opzioni](#6-opzioni)
7. [Pilotare VDInstaller da un assistente IA](#7-pilotare-vdinstaller-da-un-assistente-ia)
8. [Risoluzione dei problemi e FAQ](#8-risoluzione-dei-problemi-e-faq)

## 1. Cos'è VDInstaller

VDInstaller è un **modulo WebUI** per KernelSU / APatch / Magisk che installa come root gli APK caricati
manualmente senza alcun attrito: nessuna richiesta di "concedi su", nessun terminale e nessuna lotta con il
verificatore di Play Protect. Gestisce singoli APK, un'intera cartella in una volta sola e le app divise
(`.xapk` / `.apkm` / `.apks` / `.zip` o file di split sciolti), e può presentare l'origine
dell'installazione come il Play Store, così un'app non sembra caricata manualmente.

## 2. Requisiti

- Android 8.0 o più recente (API 26+).
- Una soluzione root con supporto WebUI: **KernelSU**, **APatch** o **Magisk**.

## 3. Installazione e primo avvio

1. Scarica l'ultimo `VD-Installer-vX.XX-universal.zip` dalla pagina
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Installalo come modulo nel tuo gestore root (*Moduli -> Installa da storage*).
3. VDInstaller si attiva **senza riavvio** - è autonomo (WebUI + binari inclusi), quindi non c'è nulla da
   montare.
4. Apri la WebUI di **VDInstaller** dall'elenco dei moduli del tuo gestore root.

All'installazione il programma conserva solo l'ABI del tuo dispositivo ed esegue un controllo di integrità
`.sha256` obbligatorio che **interrompe** l'operazione se lo zip è corrotto o troncato. Le impostazioni
risiedono in `/data/adb/vdinstaller` e sopravvivono agli aggiornamenti.

## 4. Panoramica della WebUI

Tre schede:

- **Installa** - scegli una modalità, seleziona l'APK o la cartella, installa, osserva l'avanzamento dal
  vivo.
- **Opzioni** - origine dell'installazione, l'interruttore del verificatore di Play Protect e i flag di
  installazione. Tutto viene salvato automaticamente.
- **Informazioni** - versione, cosa fa, requisiti, link e licenza.

## 5. Installare gli APK

Scegli la modalità nella scheda **Installa**; VDInstaller non indovina mai.

| Modalità | Cosa fornisci | Cosa succede |
|---|---|---|
| **APK singolo** | un file `.apk` | una sessione di installazione, una app. |
| **Cartella di APK** (batch) | una cartella di file `.apk` indipendenti | ogni APK viene installato per conto suo, uno dopo l'altro; un batch parziale riferisce quali hanno fallito e perché. |
| **Archivio diviso** | un `.xapk` / `.apkm` / `.apks` / `.zip` | estratto, poi `base.apk` + split installati come un'unica app in una singola sessione (viene collocato anche l'OBB dell'XAPK, quando presente). |
| **Cartella di split** | una cartella con i file `.apk` di split sciolti di una stessa app | gli split vengono installati come un'unica app in una singola sessione. |

Un'app "divisa" è un APK suddiviso in una base più APK di configurazione per densità / per ABI / per lingua;
devono essere installati **insieme** in un'unica sessione, cosa che le modalità di split fanno per te.

### 5.1 La finestra Sfoglia

**Sfoglia** apre un selettore di file che elenca cartelle e file installabili di un percorso:

- Tocca una **cartella** per entrarci; **Su** risale alla cartella superiore.
- In una modalità file (APK singolo / Archivio diviso), tocca un **file** per selezionarlo.
- In una modalità cartella (Cartella di APK / Cartella di split), entra nella cartella e tocca **Usa questa cartella**.

Puoi anche digitare o incollare direttamente un percorso (ad esempio `/sdcard/Download/app.apk`).

### 5.2 Avanzamento, annulla, riprendi

Le installazioni vengono eseguite come **processo root distaccato**. Una scheda di avanzamento mostra la
fase; **Annulla** la ferma. Se chiudi la WebUI a installazione in corso, l'installazione continua e
l'interfaccia si riaggancia tramite id di operazione quando la riapri.

## 6. Opzioni

Tutto qui viene salvato automaticamente e si applica alla prossima installazione.

### 6.1 Origine dell'installazione

Un'app appena caricata manualmente annuncia a ogni app che la legge (e all'attestazione) di essere stata
caricata manualmente. VDInstaller può invece presentare l'origine come il Play Store.

- **Mostra il Play Store come installatore** (attivo di default) - imposta `installerPackageName` tramite
  `pm install-create -i com.android.vending`. Si applica immediatamente.
- **Falsifica anche l'iniziatore** (attivo di default) - imposta `installInitiator` e `packageSource`
  modificando `/data/system/packages.xml`. È **ABX-aware** (decodifica -> modifica -> ricodifica, con un
  backup byte per byte e uno scambio atomico) e si applica **dopo il prossimo riavvio**, perché il gestore
  dei pacchetti mette in cache `packages.xml`.

### 6.2 Verificatore di pacchetti di Play Protect

Un'installazione caricata manualmente può essere respinta con `INSTALL_FAILED_VERIFICATION_FAILURE` dal
verificatore di pacchetti di Play Protect. Un interruttore a 3 stati:

- **Lascia com'era** (default) - disattivato solo per l'installazione, poi ripristinato al suo stato
  precedente **esatto** (nuovamente eliminato se non c'era alcun valore esplicito, poiché uno `0`/`1` dove
  non ce n'era è di per sé una spia su un dispositivo stealth).
- **Sempre attivo** - forzalo attivo e mantienilo.
- **Sempre disattivo** - forzalo disattivo e mantienilo. La WebUI avvisa: lasciarlo disattivato è una spia
  di stealth e disabilita una scansione malware per ogni installazione.

### 6.3 Developer Verification

La Developer Verification di Android del 2026 impedisce l'installazione di app da sviluppatori non
registrati sui dispositivi certificati, ma è applicata da un **servizio separato**, non da Play Protect, e
un'**installazione come root ne è già esente** (la stessa esenzione che ottengono le installazioni ADB).
VDInstaller installa comunque i tuoi APK, quindi questo interruttore è **al meglio delle possibilità e
onesto**: applica una vera manopola solo se ne esiste una e non finge mai di azionare un interruttore che
non fa nulla.

### 6.4 Flag di installazione

| Flag | Effetto |
|---|---|
| **Concedi tutte le autorizzazioni di runtime** | concede ogni autorizzazione di runtime all'installazione (`-g`). |
| **Consenti pacchetti di test** | installa pacchetti contrassegnati come solo test (`-t`). |
| **Ignora il blocco per target SDK basso** | installa app con un `targetSdk` molto vecchio. |
| **Utente di destinazione** | l'id utente di Android per cui installare (default `0`). |

### 6.5 Restare nascosti

Per la stealth, valuta di nascondere il tuo gestore root e le app sensibili con HMA-OSS. VDInstaller **non
tocca mai la tua configurazione di HMA-OSS** - il suggerimento è solo un promemoria; la modifica la fai tu
stesso in HMA-OSS.

## 7. Pilotare VDInstaller da un assistente IA

Il motore parla un piccolo contratto JSON tramite `scripts/helper.sh`, così un agente può pilotare ogni
azione che la WebUI può compiere. Vedi [AI-AGENTS](AI-AGENTS). Pilota il contratto, non fare scraping della
WebUI.

## 8. Risoluzione dei problemi e FAQ

**Ottengo `INSTALL_FAILED_VERIFICATION_FAILURE`.** È il verificatore di pacchetti di Play Protect. Con
l'interruttore del verificatore lasciato su **Lascia com'era** (il default), VDInstaller lo disattiva per
l'installazione e lo ripristina, così non succede.

**Ho attivato l'origine Play Store ma l'app sembra ancora caricata manualmente.** La parte relativa
all'installatore si applica immediatamente; la parte dell'iniziatore (`packages.xml`) si applica **dopo il
prossimo riavvio**.

**Aggira la Developer Verification di Google?** Non ne ha bisogno - un'installazione come root ne è esente
(vedi 6.3). Non c'è alcun interruttore finto per questo.

**Serve un riavvio?** No, tranne la falsificazione opzionale dell'iniziatore.

**Disinstallare VDInstaller rimuoverà le app che ho installato?** No - quelle sono installazioni reali di
proprietà del sistema; rimuovere il modulo ripulisce solo lo stato interno di VDInstaller.

**È sicuro?** Installa gli APK che scegli tu e, con il verificatore disattivato, salta una scansione
malware - installa solo APK di cui ti fidi. Non indebolisce mai nulla in silenzio.

<!-- doc-footer -->

---

> _Questa documentazione è stata generata con Claude (Anthropic) ed è gestita da VD171. Correzioni e miglioramenti sono benvenuti; vedi [CONTRIBUTING.md](CONTRIBUTING.md)._
