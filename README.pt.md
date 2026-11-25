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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · Português · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · [Українська](README.uk.md) · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Instalador root de sideload sem fricção - WebUI de KernelSU / APatch / Magisk.

## Por que

Instalar um APK via sideload num celular com root faz mais barulho do que deveria: o verificador de
pacotes do Play Protect pode cuspir `INSTALL_FAILED_VERIFICATION_FAILURE`, apps split (`.xapk` /
`.apkm` / `.apks`) exigem a API de sessão na mão, e um app recém-instalado se anuncia como
"sideloaded" para todo app que lê a fonte de instalação. O VDInstaller faz tudo isso por você, já
como root, sem o prompt de "conceder su" e sem terminal.

## Recursos

- **Todo formato de APK** - um `.apk` único, uma pasta inteira de APKs independentes (lote), um
  arquivo split agrupado (`.xapk` / `.apkm` / `.apks` / `.zip`), ou uma pasta de APKs split soltos.
- **Sem a parede de verificação** - um botão de 3 estados para o verificador de pacotes do Play
  Protect: manter como estava (desligado só durante a instalação, restaurado exatamente), sempre
  ligado, ou sempre desligado.
- **Honesto sobre a Developer Verification** - uma instalação root já é isenta da Android Developer
  Verification de 2026; o botão é best-effort e diz isso, nunca um interruptor falso.
- **Nada de "sideloaded"** - opcionalmente apresenta a fonte de instalação como a Play Store, tanto o
  instalador (na hora da instalação) quanto o iniciador (via uma edição do `packages.xml` ciente de ABX).
- **Destacado e retomável** - instalações rodam como processo root destacado; fechar a WebUI nunca as
  interrompe, e a UI reata pelo id da operação.
- **Você no controle** - pacotes de teste, conceder todas as permissões de runtime, usuário
  alvo, ignorar o bloqueio de target SDK baixo: tudo opcional.
- **Offline, autossuficiente, sem reboot** - um módulo WebUI com os binários embarcados; usável assim
  que é flashado.

## Agentes de IA

Este projeto acolhe contribuições de IA e agentes. O motor fala JSON por um pequeno contrato headless
(`scripts/helper.sh <verb> <base64(JSON)>`), documentado em [docs/AI-AGENTS.md](docs/AI-AGENTS.md), para
que um agente conduza toda ação que a WebUI conduz - não raspe a WebUI. Patches de IA seguem o mesmo
critério de revisão de qualquer outro.

## Instalação

Flashe o zip no KernelSU, APatch ou Magisk e abra a WebUI do VDInstaller pelo seu gerenciador root. O
instalador mantém só o ABI do seu aparelho e roda o gate de integridade `.sha256` obrigatório (aborta
num zip corrompido ou truncado). Android 8.0 (API 26) ou mais novo.

## Segurança

O VDInstaller roda como root e instala os APKs que você escolhe; desligar o verificador de pacotes para
uma instalação desliga um scan de malware, então instale só APKs em que você confia. Ele nunca enfraquece
a segurança do aparelho em silêncio: o verificador é restaurado ao seu exato estado anterior por padrão, e
ele nunca mexe na sua configuração do HMA-OSS. Reporte problemas conforme o [SECURITY.md](SECURITY.md).

## Build

Sempre release, nunca debug. O `.github/scripts/build_bin.sh` busca o `jq` no repositório apt do Termux
(com o fechamento de bibliotecas compartilhadas) e os conversores standalone `abx2xml` / `xml2abx`, para
os quatro ABIs, cada um com um `PROVENANCE.json`. O workflow de release monta os zips flasháveis, escreve
os companheiros `.sha256`, preenche o `update.json` e publica como `github-actions[bot]`.

## Documentação

Os guias ficam em [docs/](docs/) e espelham para o wiki do GitHub. Veja
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) para o contrato headless.

## Veja também

- **[COPG-VD](https://github.com/VD171/COPG-VD)**: spoofing global de fingerprint do dispositivo / Play Integrity, no aparelho inteiro com escopo por app e uma WebUI.
- **[VDBackup](https://github.com/VD171/VD-Backup)**: backup e restauração completos de apps e dados como root, operados inteiramente por uma WebUI.
- **[VD-dropbear](https://github.com/VD171/VD-dropbear)**: um daemon SSH standalone com root (Dropbear).
- **[VDGoogle](https://github.com/VD171/VD-Google)**: seus serviços Google (RCS, Wallet, atestações do Play Integrity), lidos no seu aparelho sem internet.
- **[VDInfos](https://github.com/VD171/VD-Infos)**: um debugger de métodos de dispositivo que lê cada item por todos os métodos capazes de lê-lo e os compara lado a lado.
- **[VDLiveUpdate](https://github.com/VD171/VDLiveUpdate)**: um motor de autoatualização incremental e sem flash, embarcado em módulos KernelSU/APatch/Magisk.
- **[VD-Modules](https://github.com/VD171/VD-Modules)**: nosso repositório de módulos MMRL/WebUI-X (instale todos eles pelo seu gerenciador root).
- **[@VictorGabriel7Dev/build.prop](https://github.com/VictorGabriel7Dev/build.prop)**: um conjunto de dados de fingerprints `build.prop` de Pixel (fork de @T3SL4).
- **[@VictorGabriel7Dev/mtproto-store](https://github.com/VictorGabriel7Dev/mtproto-store)**: use o Telegram como object store a partir de uma CLI Go minúscula.

## Contatos

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/VD-Installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Licença

O VDInstaller é licenciado sob a GNU AGPL-3.0-or-later. Veja o [LICENSE](LICENSE). NETWORK COPYLEFT: rode
uma versão modificada, mesmo como serviço, e você deve oferecer o código-fonte dela.

## Marcas

Android, KernelSU, APatch, Magisk, Google Play e Play Protect pertencem aos seus respectivos donos. Este
projeto é independente e não é afiliado nem endossado por eles.

## Tags

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Join the channel: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
