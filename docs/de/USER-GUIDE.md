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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · Deutsch · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · [Português](../pt/USER-GUIDE.md) · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# VDInstaller Benutzerhandbuch

## Inhaltsverzeichnis

1. [Was VDInstaller ist](#1-was-vdinstaller-ist)
2. [Voraussetzungen](#2-voraussetzungen)
3. [Installation und erster Start](#3-installation-und-erster-start)
4. [Rundgang durch die WebUI](#4-rundgang-durch-die-webui)
5. [APKs installieren](#5-apks-installieren)
6. [Optionen](#6-optionen)
7. [VDInstaller über einen KI-Assistenten steuern](#7-vdinstaller-über-einen-ki-assistenten-steuern)
8. [Fehlerbehebung und FAQ](#8-fehlerbehebung-und-faq)

## 1. Was VDInstaller ist

VDInstaller ist ein KernelSU / APatch / Magisk **WebUI-Modul**, das per Sideload geladene APKs als root
ohne Reibung installiert: keine "grant su"-Abfrage, kein Terminal und kein Kampf gegen den Play Protect
Verifizierer. Es verarbeitet einzelne APKs, einen ganzen Ordner auf einmal und Split-Apps (`.xapk` /
`.apkm` / `.apks` / `.zip` oder lose Split-Dateien), und es kann die Installationsquelle als Play Store
ausgeben, damit eine App nicht per Sideload installiert aussieht.

## 2. Voraussetzungen

- Android 8.0 oder neuer (API 26+).
- Eine Root-Lösung mit WebUI-Unterstützung: **KernelSU**, **APatch** oder **Magisk**.

## 3. Installation und erster Start

1. Lade das neueste `VD-Installer-vX.XX-universal.zip` von der Seite
   [Releases](https://github.com/VD171/VD-Installer/releases) herunter.
2. Flashe es als Modul in deinem Root-Manager (*Module -> Aus Speicher installieren*).
3. VDInstaller wird **ohne Neustart** aktiv - es ist eigenständig (WebUI + mitgelieferte Binaries), es
   gibt also nichts zu mounten.
4. Öffne die **VDInstaller** WebUI aus der Modulliste deines Root-Managers.

Beim Flashen behält der Installer nur die ABI deines Geräts und führt eine verpflichtende
`.sha256`-Integritätsprüfung aus, die **abbricht**, wenn das Zip beschädigt oder abgeschnitten ist. Die
Einstellungen liegen in `/data/adb/vdinstaller` und überstehen Updates.

## 4. Rundgang durch die WebUI

Drei Tabs:

- **Install** - einen Modus wählen, die APK oder den Ordner auswählen, installieren, den Live-Fortschritt
  beobachten.
- **Options** - Installationsquelle, der Schalter für den Play Protect Verifizierer und die
  Installations-Flags. Alles wird automatisch gespeichert.
- **About** - Version, was es tut, Voraussetzungen, Links und Lizenz.

## 5. APKs installieren

Den Modus wählst du im Tab **Install**; VDInstaller rät nie.

| Modus | Du gibst an | Was passiert |
|---|---|---|
| **Single APK** | eine `.apk`-Datei | eine Installationssitzung, eine App. |
| **Folder of APKs** (Batch) | ein Ordner mit unabhängigen `.apk`-Dateien | jede APK wird für sich installiert, eine nach der anderen; ein unvollständiger Batch meldet, welche fehlgeschlagen sind und warum. |
| **Split archive** | ein `.xapk` / `.apkm` / `.apks` / `.zip` | wird entpackt, dann werden `base.apk` + Splits als eine App in einer einzigen Sitzung installiert (XAPK-OBB wird ebenfalls platziert, wenn vorhanden). |
| **Split folder** | ein Ordner mit den losen Split-`.apk`-Dateien einer App | die Splits werden als eine App in einer einzigen Sitzung installiert. |

Eine "Split"-App ist eine APK, die in eine Basis plus Konfigurations-APKs pro Dichte / pro ABI / pro
Sprache aufgeteilt ist; sie müssen **zusammen** in einer Sitzung installiert werden, was die Split-Modi
für dich erledigen.

### 5.1 Der Browse-Dialog

**Browse** öffnet einen Dateiauswähler, der Ordner und installierbare Dateien an einem Pfad auflistet:

- Tippe auf einen **Ordner**, um ihn zu öffnen; **Up** geht zum übergeordneten Ordner.
- In einem Dateimodus (Single APK / Split archive) tippe auf eine **Datei**, um sie auszuwählen.
- In einem Ordnermodus (Folder of APKs / Split folder) navigiere in den Ordner und tippe auf **Use this folder**.

Du kannst einen Pfad auch direkt eintippen oder einfügen (zum Beispiel `/sdcard/Download/app.apk`).

### 5.2 Fortschritt, Abbrechen, Fortsetzen

Installationen laufen als **abgekoppelter Root-Prozess**. Eine Fortschrittskarte zeigt die Phase;
**Cancel** stoppt sie. Wenn du die WebUI mitten in der Installation schließt, läuft die Installation
weiter, und die Oberfläche koppelt sich beim erneuten Öffnen über die Operations-ID wieder an.

## 6. Optionen

Alles hier wird automatisch gespeichert und gilt für die nächste Installation.

### 6.1 Installationsquelle

Eine frisch per Sideload installierte App teilt jeder App, die sie ausliest (und der Attestierung), mit,
dass sie per Sideload installiert wurde. VDInstaller kann die Quelle stattdessen als Play Store ausgeben.

- **Play Store als Installer anzeigen** (standardmäßig an) - setzt `installerPackageName` über
  `pm install-create -i com.android.vending`. Gilt sofort.
- **Auch den Initiator fälschen** (standardmäßig an) - setzt `installInitiator` und `packageSource` durch
  Bearbeiten von `/data/system/packages.xml`. Dies ist **ABX-bewusst** (dekodieren -> bearbeiten ->
  erneut kodieren, mit einem byte-genauen Backup und einem atomaren Austausch) und gilt **nach dem
  nächsten Neustart**, weil der Package-Manager `packages.xml` zwischenspeichert.

### 6.2 Play Protect Paket-Verifizierer

Eine per Sideload durchgeführte Installation kann mit `INSTALL_FAILED_VERIFICATION_FAILURE` vom
Paket-Verifizierer von Play Protect abgelehnt werden. Ein 3-Wege-Schalter:

- **So lassen, wie es war** (Standard) - nur für die Installation aus, danach in den **exakten**
  vorherigen Zustand zurückgesetzt (wieder gelöscht, wenn es keinen expliziten Wert gab, denn eine
  `0`/`1`, wo keine war, ist auf einem Stealth-Gerät selbst ein Verräter).
- **Immer an** - erzwinge an und behalte es bei.
- **Immer aus** - erzwinge aus und behalte es bei. Die WebUI warnt: es aus zu lassen ist ein
  Stealth-Verräter und deaktiviert einen Malware-Scan für jede Installation.

### 6.3 Developer Verification

Androids Developer Verification von 2026 blockiert die Installation von Apps nicht registrierter
Entwickler auf zertifizierten Geräten, aber sie wird von einem **separaten Dienst** durchgesetzt, nicht
von Play Protect, und eine **Root-Installation ist bereits davon ausgenommen** (dieselbe Ausnahme, die
ADB-Installationen erhalten). VDInstaller installiert deine APKs ungeachtet dessen, daher ist dieser
Schalter **bestmöglich und ehrlich**: Er betätigt einen echten Regler nur, wenn einer existiert, und
täuscht nie vor, einen Schalter umzulegen, der nichts bewirkt.

### 6.4 Installations-Flags

| Flag | Wirkung |
|---|---|
| **Alle Laufzeitberechtigungen gewähren** | gewähre jede Laufzeitberechtigung bei der Installation (`-g`). |
| **Testpakete erlauben** | installiere als nur-Test markierte Pakete (`-t`). |
| **Blockade bei niedrigem Target-SDK umgehen** | installiere Apps mit einem sehr alten `targetSdk`. |
| **Zielbenutzer** | die Android-Benutzer-ID, für die installiert wird (Standard `0`). |

### 6.5 Verborgen bleiben

Für Stealth kannst du in Betracht ziehen, deinen Root-Manager und sensible Apps mit HMA-OSS zu
verstecken. VDInstaller **rührt deine HMA-OSS-Einrichtung niemals an** - der Hinweis ist nur eine
Erinnerung; die Änderung nimmst du selbst in HMA-OSS vor.

## 7. VDInstaller über einen KI-Assistenten steuern

Die Engine spricht einen kleinen JSON-Vertrag über `scripts/helper.sh`, sodass ein Agent jede Aktion
ausführen kann, die auch die WebUI kann. Siehe [AI-AGENTS](AI-AGENTS). Steuere den Vertrag, scrape nicht
die WebUI.

## 8. Fehlerbehebung und FAQ

**Ich erhalte `INSTALL_FAILED_VERIFICATION_FAILURE`.** Das ist der Paket-Verifizierer von Play Protect.
Wenn der Verifizierer-Schalter auf **So lassen, wie es war** steht (der Standard), schaltet VDInstaller
ihn für die Installation aus und stellt ihn wieder her, sodass es nicht passiert.

**Ich habe die Play-Store-Quelle aktiviert, aber die App sieht immer noch nach Sideload aus.** Der
Installer-Teil gilt sofort; der Initiator-Teil (`packages.xml`) gilt **nach dem nächsten Neustart**.

**Umgeht es Googles Developer Verification?** Das muss es nicht - eine Root-Installation ist ausgenommen
(siehe 6.3). Es gibt keinen Fake-Schalter dafür.

**Braucht es einen Neustart?** Nein, außer bei der optionalen Initiator-Fälschung.

**Entfernt das Deinstallieren von VDInstaller die Apps, die ich installiert habe?** Nein - das sind echte
Installationen, die dem System gehören; das Entfernen des Moduls räumt nur VDInstallers eigenen Zustand
auf.

**Ist es sicher?** Es installiert APKs deiner Wahl und überspringt, mit ausgeschaltetem Verifizierer,
einen Malware-Scan - installiere nur APKs, denen du vertraust. Es schwächt niemals etwas im Stillen ab.

<!-- doc-footer -->

---

> _Diese Dokumentation wurde mit Claude (Anthropic) erstellt und wird von VD171 gepflegt. Korrekturen und Verbesserungen sind willkommen; siehe [CONTRIBUTING.md](CONTRIBUTING.md)._
