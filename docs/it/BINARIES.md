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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · Italiano · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · [Português](../pt/BINARIES.md) · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Binari inclusi: provenienza e verifica

## Principi

- Nulla di opaco viene distribuito. Ogni binario incluso viene recuperato al **momento della build dalla sua
  fonte ufficiale a monte**, mai estratto da un dispositivo, e ogni file porta uno sha256 così il payload può
  essere riprodotto.
- I binari sono inclusi per **tutte e quattro le ABI** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`);
  l'installatore di flash li riduce a quello del dispositivo.
- Girano in modo autonomo: la chiusura delle librerie condivise di ogni binario viene distribuita insieme e
  il motore imposta `LD_LIBRARY_PATH` sulla cartella `lib/` inclusa, così non c'è alcuna dipendenza
  dall'avere Termux installato.

## Cosa viene distribuito, e da dove

| Binario | Da | Perché |
|---|---|---|
| `jq` (+ `lib/`) | il repository dei pacchetti Termux (`packages.termux.dev/apt`), `.deb` ufficiale | il motore parla JSON; `jq` analizza gli argomenti e costruisce le risposte. |
| `abx2xml` / `xml2abx` | release di [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | decodifica/codifica l'XML binario di Android (ABX) per la falsificazione dell'origine dell'installazione in `packages.xml`, dove il dispositivo non ha `/system/bin/abx2xml` (pre-A12). Il convertitore del dispositivo è preferito quando presente. |
| `vdlu/verify/<abi>/ed25519-mini` | il motore canonico di [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | verifica la firma ed25519 sugli aggiornamenti senza flash (VDLU), senza OpenSSL. |

Il passo di build è `.github/scripts/build_bin.sh`: risolve il pacchetto Termux più le sue dipendenze
transitive, estrae i `.deb`, copia i binari voluti e la chiusura delle librerie condivise di cui ciascuno ha
bisogno (risolta con `readelf`), poi recupera il convertitore ABX autonomo.

## Il manifesto sul dispositivo: `PROVENANCE.json`

Ogni `bin/<abi>/` porta un `PROVENANCE.json` che elenca ogni file distribuito (percorso, dimensione, sha256)
e la fonte a monte di ciascuno (pacchetto, versione, URL, sha256 dell'archivio). Sopravvive alla riduzione
di ABI sul dispositivo, così la traccia di verifica viene distribuita con il modulo stesso.

## Come verificare

1. Apri `bin/<abi>/PROVENANCE.json` sul dispositivo o nello zip flashabile.
2. Riscarica ogni fonte fissata dall'URL che registra.
3. Estrai e confronta lo sha256 di ogni file con il manifesto.

Lo zip flashabile porta inoltre un compagno `.sha256` accanto a ogni file distribuito; `customize.sh` li
verifica al momento del flash e **interrompe** su qualsiasi discordanza (uno zip corrotto o troncato).

## Segnalazione

Hai trovato una discordanza o un dubbio sulla provenienza? Segnalalo in privato - vedi
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Questa documentazione è stata generata con Claude (Anthropic) ed è gestita da VD171. Correzioni e miglioramenti sono benvenuti; vedi [CONTRIBUTING.md](CONTRIBUTING.md)._
