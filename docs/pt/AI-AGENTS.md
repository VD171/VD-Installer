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

> **Languages:** [English](../AI-AGENTS.md) · [العربية](../ar/AI-AGENTS.md) · [Čeština](../cs/AI-AGENTS.md) · [Deutsch](../de/AI-AGENTS.md) · [Español](../es/AI-AGENTS.md) · [فارسی](../fa/AI-AGENTS.md) · [Français](../fr/AI-AGENTS.md) · [हिन्दी](../hi/AI-AGENTS.md) · [Bahasa Indonesia](../id/AI-AGENTS.md) · [Italiano](../it/AI-AGENTS.md) · [日本語](../ja/AI-AGENTS.md) · [한국어](../ko/AI-AGENTS.md) · [Nederlands](../nl/AI-AGENTS.md) · [Polski](../pl/AI-AGENTS.md) · Português · [Русский](../ru/AI-AGENTS.md) · [Svenska](../sv/AI-AGENTS.md) · [ไทย](../th/AI-AGENTS.md) · [Türkçe](../tr/AI-AGENTS.md) · [Українська](../uk/AI-AGENTS.md) · [Tiếng Việt](../vi/AI-AGENTS.md) · [中文](../zh/AI-AGENTS.md)

---

# Agentes de IA: o contrato headless

O VDInstaller é comandado por um único contrato de shell. Um agente (rodando como root, como a WebUI faz)
chama:

```
sh /data/adb/modules/vdinstaller/scripts/helper.sh <verb> <base64(JSON-args)>
```

e lê exatamente um objeto JSON no stdout. Sucesso é `{"ok":true,...}`; falha é
`{"ok":false,"code":"ERR_...","message":"..."}`. Operações longas retornam um `opid` que você consulta.
Não raspe a WebUI; use este contrato.

## Verbos

| Verbo | Argumentos (JSON) | Retorna |
|---|---|---|
| `version` | - | `{version, versionCode}` |
| `config-get` | - | o objeto de configuração |
| `config-set` | quaisquer chaves de configuração para mesclar | `{saved:true}` |
| `scan` | `{dir}` | `{dir, items:[{name,type,size}]}` (type = apk \| archive) |
| `install` | `{mode, path \| dir, ...options}` | `{opid}` (destacado) |
| `uninstall` | `{pkg, keep_data?, target_user?}` | `{opid}` (destacado) |
| `progress` | base64 da string opid (não JSON) | o objeto de progresso ao vivo; `done:true` quando concluído |
| `cancel` | base64 da string opid | `{cancelled}` |
| `verifier-status` | - | as configurações atuais do verificador |
| `list-users` | - | `{users:[{id,name}]}` |
| `hma-hint` | - | `{recommend:true}` |
| `sanitize` | - | remove logs obsoletos |

## Modos de instalação

| `mode` | recebe | significado |
|---|---|---|
| `single` | `path` | um `.apk` |
| `batch` | `dir` | uma pasta de arquivos `.apk` independentes, uma instalação cada |
| `archive` | `path` | um arquivo split agrupado (`.xapk` / `.apkm` / `.apks` / `.zip`) |
| `splitdir` | `dir` | uma pasta com os arquivos `.apk` split soltos de um app |

## Opções (por operação nos argumentos, ou persistidas via `config-set`)

`spoof_installer` (bool), `spoof_installer_pkg` (string), `deep_spoof` (bool),
`verifier_mode` / `devverif_mode` (`restore` \| `always_on` \| `always_off`),
`grant_all_perms`, `allow_test`, `bypass_low_target_sdk` (bool), `target_user` (int).

## Progresso

Consulte `progress` com o `opid`. O objeto carrega `percent`, `phase`
(`starting` / `extracting` / `installing` / `uninstalling` / `done`), um `item` opcional, e na conclusão
`done:true` com um `result` (single/split), um array `results[]` (batch), ou um `error`.

## Proteções de segurança

- O botão do verificador e a edição de `packages.xml` são reversíveis e auditados (`logs/audit.jsonl`).
- `install`/`uninstall` mudam o estado do dispositivo; confirme a intenção antes de chamar, como a WebUI
  faz.
- Nunca raspe nem automatize a própria WebUI; este contrato é a superfície suportada.

<!-- doc-footer -->

---

> _Esta documentação foi gerada com o Claude (Anthropic) e é mantida por VD171. Correções e melhorias são bem-vindas; veja [CONTRIBUTING.md](CONTRIBUTING.md)._
