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

> **Languages:** [English](../../CONTRIBUTING.md) · [العربية](../ar/CONTRIBUTING.md) · [Čeština](../cs/CONTRIBUTING.md) · [Deutsch](../de/CONTRIBUTING.md) · [Español](../es/CONTRIBUTING.md) · [فارسی](../fa/CONTRIBUTING.md) · [Français](../fr/CONTRIBUTING.md) · [हिन्दी](../hi/CONTRIBUTING.md) · [Bahasa Indonesia](../id/CONTRIBUTING.md) · [Italiano](../it/CONTRIBUTING.md) · [日本語](../ja/CONTRIBUTING.md) · [한국어](../ko/CONTRIBUTING.md) · [Nederlands](../nl/CONTRIBUTING.md) · [Polski](../pl/CONTRIBUTING.md) · Português · [Русский](../ru/CONTRIBUTING.md) · [Svenska](../sv/CONTRIBUTING.md) · [ไทย](../th/CONTRIBUTING.md) · [Türkçe](../tr/CONTRIBUTING.md) · [Українська](../uk/CONTRIBUTING.md) · [Tiếng Việt](../vi/CONTRIBUTING.md) · [中文](../zh/CONTRIBUTING.md)

---

# Contribuindo

Contribuições são bem-vindas - issues, pull requests, traduções e documentação. O projeto busca ser
fácil e convidativo para contribuir.

## Contribuidores de IA são bem-vindos

Contribuições de IA e agentes são bem-vindas com o mesmo nível de revisão aplicado a todos. O engine
fala JSON por meio de um contrato headless (`scripts/helper.sh <verb> <base64(JSON)>`); veja
[docs/AI-AGENTS.md](docs/AI-AGENTS.md). Use o contrato, não faça scraping da WebUI.

## Regras de código

- **Banner completo em cada arquivo** (SPDX + contatos) no topo de todo arquivo-fonte. Nunca um reduzido.
- Código, identificadores, logs e comentários em **inglês**. Comentários apenas quando acrescentam algo.
- O shell é **POSIX sh** para o dispositivo (`sh -n` deve passar; nada de bashisms além de `local`; nenhuma dependência de `jq` em caminhos de código que precisam rodar antes de o `jq` embarcado estar no PATH).
- A WebUI é **vanilla JS**, sem framework; modo claro e escuro em toda a interface.
- **Nunca** um em-dash ou en-dash; sempre um hífen `-`.
- O build é sempre **release**, nunca debug.
- **Nunca enfraqueça um comportamento real** para fazer algo passar, e nunca remova conteúdo.

## Traduções

As strings da WebUI ficam em `module/webroot/lang/<code>.json` (chaves planas, base em inglês em
`lang/en.js`); o README tem um `README.<code>.md` por idioma. Adicione ou corrija um idioma e abra um PR.

## Licença

Ao contribuir, você concorda que sua contribuição é licenciada sob a GNU AGPL-3.0-or-later.

<!-- doc-footer -->

---

> _Esta documentação foi gerada com o Claude (Anthropic) e é mantida por VD171. Correções e melhorias são bem-vindas; veja [CONTRIBUTING.md](CONTRIBUTING.md)._
