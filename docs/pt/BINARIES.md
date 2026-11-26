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

> **Languages:** [English](../BINARIES.md) · [العربية](../ar/BINARIES.md) · [Čeština](../cs/BINARIES.md) · [Deutsch](../de/BINARIES.md) · [Español](../es/BINARIES.md) · [فارسی](../fa/BINARIES.md) · [Français](../fr/BINARIES.md) · [हिन्दी](../hi/BINARIES.md) · [Bahasa Indonesia](../id/BINARIES.md) · [Italiano](../it/BINARIES.md) · [日本語](../ja/BINARIES.md) · [한국어](../ko/BINARIES.md) · [Nederlands](../nl/BINARIES.md) · [Polski](../pl/BINARIES.md) · Português · [Русский](../ru/BINARIES.md) · [Svenska](../sv/BINARIES.md) · [ไทย](../th/BINARIES.md) · [Türkçe](../tr/BINARIES.md) · [Українська](../uk/BINARIES.md) · [Tiếng Việt](../vi/BINARIES.md) · [中文](../zh/BINARIES.md)

---

# Binários embutidos: procedência e auditoria

## Princípios

- Nada opaco é distribuído. Todo binário embutido é obtido em **tempo de build de seu upstream oficial**,
  nunca extraído de um dispositivo, e cada arquivo carrega um sha256 para que o payload possa ser
  reproduzido.
- Os binários são embutidos para **todas as quatro ABIs** (`arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64`), o
  instalador de flash reduz para a única ABI do dispositivo.
- Eles rodam de forma autônoma: o fecho de bibliotecas compartilhadas de cada binário é distribuído junto e
  o motor define `LD_LIBRARY_PATH` para o `lib/` embutido, então não há dependência de o Termux estar
  instalado.

## O que é distribuído, e de onde

| Binário | De | Por quê |
|---|---|---|
| `jq` (+ `lib/`) | o repositório de pacotes do Termux (`packages.termux.dev/apt`), `.deb` oficial | o motor fala JSON; `jq` analisa argumentos e constrói respostas. |
| `abx2xml` / `xml2abx` | release do [rhythmcache/android-xml-converter](https://github.com/rhythmcache/android-xml-converter) | decodifica/codifica o XML binário do Android (ABX) para a falsificação da origem de instalação em `packages.xml`, onde o dispositivo não tem `/system/bin/abx2xml` (pré-A12). O conversor próprio do dispositivo é preferido quando presente. |
| `vdlu/verify/<abi>/ed25519-mini` | o motor canônico [VDLiveUpdate](https://github.com/VD171/VDLiveUpdate) | verifica a assinatura ed25519 em atualizações sem flash (VDLU), sem OpenSSL. |

O passo de build é `.github/scripts/build_bin.sh`: ele resolve o pacote do Termux mais suas dependências
transitivas, extrai os `.deb`s, copia os binários desejados e o fecho de bibliotecas compartilhadas que
cada um precisa (resolvido com `readelf`), e então obtém o conversor ABX autônomo.

## O manifesto no dispositivo: `PROVENANCE.json`

Cada `bin/<abi>/` carrega um `PROVENANCE.json` que lista todo arquivo distribuído (caminho, tamanho,
sha256) e a origem upstream de cada um (pacote, versão, URL, sha256 do arquivo). Ele sobrevive à redução
de ABI no dispositivo, então a trilha de auditoria é distribuída com o próprio módulo.

## Como verificar

1. Abra `bin/<abi>/PROVENANCE.json` no dispositivo ou no zip flasheável.
2. Obtenha novamente cada fonte fixada a partir da URL que ele registra.
3. Extraia e compare o sha256 de cada arquivo com o manifesto.

O zip flasheável adicionalmente carrega um arquivo companheiro `.sha256` ao lado de cada arquivo
distribuído, `customize.sh` os verifica no momento do flash e **aborta** em qualquer divergência (um zip
corrompido ou truncado).

## Reportando

Encontrou uma divergência ou uma preocupação de procedência? Reporte em privado - veja
[SECURITY.md](../SECURITY.md).

<!-- doc-footer -->

---

> _Esta documentação foi gerada com o Claude (Anthropic) e é mantida por VD171. Correções e melhorias são bem-vindas, veja [CONTRIBUTING.md](CONTRIBUTING.md)._
