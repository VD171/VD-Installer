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

> **Languages:** [English](../ARCHITECTURE.md) · [العربية](../ar/ARCHITECTURE.md) · [Čeština](../cs/ARCHITECTURE.md) · [Deutsch](../de/ARCHITECTURE.md) · [Español](../es/ARCHITECTURE.md) · [فارسی](../fa/ARCHITECTURE.md) · [Français](../fr/ARCHITECTURE.md) · [हिन्दी](../hi/ARCHITECTURE.md) · [Bahasa Indonesia](../id/ARCHITECTURE.md) · [Italiano](../it/ARCHITECTURE.md) · [日本語](../ja/ARCHITECTURE.md) · [한국어](../ko/ARCHITECTURE.md) · [Nederlands](../nl/ARCHITECTURE.md) · [Polski](../pl/ARCHITECTURE.md) · Português · [Русский](../ru/ARCHITECTURE.md) · [Svenska](../sv/ARCHITECTURE.md) · [ไทย](../th/ARCHITECTURE.md) · [Türkçe](../tr/ARCHITECTURE.md) · [Українська](../uk/ARCHITECTURE.md) · [Tiếng Việt](../vi/ARCHITECTURE.md) · [中文](../zh/ARCHITECTURE.md)

---

# Arquitetura

O VDInstaller é uma WebUI fina sobre um motor de shell root. Nada na interface tem privilégio, toda ação
privilegiada é uma única chamada de shell que retorna um único objeto JSON.

```
WebUI (webroot/)                scripts/                         Android
  index.html / scripts.js  -->  helper.sh  <verb> <b64(JSON)>
    ksu.exec(...)                  |  short verbs run inline
                                   |  long ops detach ->  worker.sh  -->  pm install-create
                                   |                        (session)        install-write
  progress polling  <-- progress-<opid>.json <----- set_prog                 install-commit
```

- **`webroot/`** - WebUI em JS puro (sem framework), claro/escuro, 22 idiomas. Chama o motor pela ponte
  WebUI do KernelSU (`ksu.exec`) e analisa a resposta JSON.
- **`scripts/common.sh`** - a biblioteca compartilhada carregada por ambos os scripts: resolução de
  ABI/PATH, os wrappers `pm`/`dumpsys`/`fw` (ambiente limpo para que as libs embutidas do Termux nunca
  encubram as do ART), os auxiliares de JSON e `jq`, e o `xml_edit` ciente de ABX.
- **`scripts/helper.sh`** - o contrato da WebUI: uma linha JSON por chamada. Verbos curtos (version,
  config, browse, scan) rodam inline, os longos (install, uninstall) destacam um worker e retornam um
  `opid`.
- **`scripts/worker.sh`** - o motor de instalação destacado: os quatro modos de instalação, o botão do
  verificador, a falsificação da origem de instalação e a API de sessão do gerenciador de pacotes. Ele
  escreve o progresso em um arquivo que a WebUI consulta e sobrevive ao fechamento da WebUI (`setsid`, e
  escapa do congelador de apps).

## Pontos-chave

- **Já root.** Sem prompt "conceder su" e sem alternar `sucompat`, o motor roda como root a partir do
  módulo e chama `pm` / `settings` diretamente.
- **Instalações por sessão.** Todos os modos usam `pm install-create` / `install-write` /
  `install-commit`, então apps divididos instalam corretamente e a origem de instalação (`-i`) é definida
  no momento da sessão.
- **Ciente de ABX.** A falsificação do iniciador em `packages.xml` verifica o magic de XML binário
  `ABX\0`, decodifica, edita, recodifica, faz a ida e volta para validar, cria backup byte a byte e troca
  atomicamente, o arquivo ativo nunca é tocado a menos que cada passo passe.
- **Sem reinicialização.** Um módulo WebUI autocontido sem nada para montar: `customize.sh` o copia para o
  diretório de módulos ativos, então funciona no momento em que é instalado por flash.
- **Atualizações sem flash.** O motor **VDLU** embutido atualiza o módulo baixando apenas os arquivos
  alterados, endereçados por conteúdo e assinados com ed25519 - sem reflash completo.
- **Destacado.** Operações longas rodam fora da webview, fechar a WebUI nunca as interrompe.

## Garantia de compatibilidade

- POSIX `sh` no dispositivo (`sh -n` passa, sem bashismos além de `local`, sem dependência de `awk`).
- `pm` / `dumpsys` / `settings` / `cmd` são as únicas ferramentas de framework usadas, todas via
  `/system/bin`.
- Binários embutidos (`jq`, `abx2xml`/`xml2abx`) são opcionais para o caminho comum e carregam
  procedência, o conversor ABX recorre ao próprio `/system/bin/abx2xml` do dispositivo quando presente.

<!-- doc-footer -->

---

> _Esta documentação foi gerada com o Claude (Anthropic) e é mantida por VD171. Correções e melhorias são bem-vindas, veja [CONTRIBUTING.md](CONTRIBUTING.md)._
