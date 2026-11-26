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

> **Languages:** [English](../USER-GUIDE.md) · [العربية](../ar/USER-GUIDE.md) · [Čeština](../cs/USER-GUIDE.md) · [Deutsch](../de/USER-GUIDE.md) · [Español](../es/USER-GUIDE.md) · [فارسی](../fa/USER-GUIDE.md) · [Français](../fr/USER-GUIDE.md) · [हिन्दी](../hi/USER-GUIDE.md) · [Bahasa Indonesia](../id/USER-GUIDE.md) · [Italiano](../it/USER-GUIDE.md) · [日本語](../ja/USER-GUIDE.md) · [한국어](../ko/USER-GUIDE.md) · [Nederlands](../nl/USER-GUIDE.md) · [Polski](../pl/USER-GUIDE.md) · Português · [Русский](../ru/USER-GUIDE.md) · [Svenska](../sv/USER-GUIDE.md) · [ไทย](../th/USER-GUIDE.md) · [Türkçe](../tr/USER-GUIDE.md) · [Українська](../uk/USER-GUIDE.md) · [Tiếng Việt](../vi/USER-GUIDE.md) · [中文](../zh/USER-GUIDE.md)

---

# Guia do usuário do VDInstaller

## Índice

1. [O que é o VDInstaller](#1-o-que-é-o-vdinstaller)
2. [Requisitos](#2-requisitos)
3. [Instalação e primeira execução](#3-instalação-e-primeira-execução)
4. [Tour pela WebUI](#4-tour-pela-webui)
5. [Instalando APKs](#5-instalando-apks)
6. [Opções](#6-opções)
7. [Controlando o VDInstaller a partir de um assistente de IA](#7-controlando-o-vdinstaller-a-partir-de-um-assistente-de-ia)
8. [Resolução de problemas e FAQ](#8-resolução-de-problemas-e-faq)

## 1. O que é o VDInstaller

O VDInstaller é um **módulo WebUI** de KernelSU / APatch / Magisk que instala APKs carregados por
sideload como root sem atrito: sem o prompt "conceder su", sem terminal e sem brigar com o verificador
do Play Protect. Ele lida com APKs individuais, com uma pasta inteira de uma vez e com apps divididos
(`.xapk` / `.apkm` / `.apks` / `.zip` ou arquivos split soltos), e pode apresentar a origem de instalação
como a Play Store para que um app não pareça ter vindo de sideload.

## 2. Requisitos

- Android 8.0 ou mais recente (API 26+).
- Uma solução de root com suporte a WebUI: **KernelSU**, **APatch** ou **Magisk**.

## 3. Instalação e primeira execução

1. Baixe o `VD-Installer-vX.XX-universal.zip` mais recente da página de
   [Releases](https://github.com/VD171/VD-Installer/releases).
2. Instale-o como módulo no seu gerenciador de root (*Módulos -> Instalar do armazenamento*).
3. O VDInstaller é ativado **sem reiniciar** - ele é autocontido (WebUI + binários embutidos), então não
   há nada para montar.
4. Abra a WebUI do **VDInstaller** na lista de módulos do seu gerenciador de root.

Na instalação por flash, o instalador mantém apenas a ABI do seu dispositivo e executa uma verificação de
integridade `.sha256` obrigatória que **aborta** se o zip estiver corrompido ou truncado. As
configurações ficam em `/data/adb/vdinstaller` e sobrevivem às atualizações.

## 4. Tour pela WebUI

Três abas:

- **Install** - escolha um modo, selecione o APK ou a pasta, instale e acompanhe o progresso ao vivo.
- **Options** - origem de instalação, o botão do verificador do Play Protect e as flags de instalação.
  Tudo é salvo automaticamente.
- **About** - versão, o que faz, requisitos, links e licença.

## 5. Instalando APKs

Você escolhe o modo na aba **Install**, o VDInstaller nunca adivinha.

| Modo | O que você fornece | O que acontece |
|---|---|---|
| **Single APK** | um arquivo `.apk` | uma sessão de instalação, um app. |
| **Folder of APKs** (lote) | uma pasta de arquivos `.apk` independentes | cada APK é instalado por conta própria, um após o outro; um lote parcial informa quais falharam e por quê. |
| **Split archive** | um `.xapk` / `.apkm` / `.apks` / `.zip` | extraído, depois `base.apk` + splits instalados como um app em uma única sessão (o OBB do XAPK também é colocado, quando presente). |
| **Split folder** | uma pasta com os arquivos `.apk` split soltos de um app | os splits instalados como um app em uma única sessão. |

Um app "split" é um APK dividido em uma base mais APKs de configuração por densidade / por ABI / por
idioma, eles precisam ser instalados **juntos** em uma sessão, o que os modos Split fazem por você.

### 5.1 O diálogo Browse

**Browse** abre um seletor de arquivos que lista pastas e arquivos instaláveis em um caminho:

- Toque em uma **pasta** para entrar nela, **Up** vai para a pasta pai.
- Em um modo de arquivo (Single APK / Split archive), toque em um **arquivo** para selecioná-lo.
- Em um modo de pasta (Folder of APKs / Split folder), navegue até a pasta e toque em **Use this folder**.

Você também pode digitar ou colar um caminho diretamente (por exemplo `/sdcard/Download/app.apk`).

### 5.2 Progresso, cancelar, retomar

As instalações rodam como um **processo root destacado**. Um cartão de progresso mostra a fase, **Cancel**
a interrompe. Se você fechar a WebUI no meio da instalação, a instalação continua e a interface se
reconecta pelo id da operação quando você a reabre.

## 6. Opções

Tudo aqui é salvo automaticamente e se aplica à próxima instalação.

### 6.1 Origem de instalação

Um app recém-instalado por sideload anuncia a todo app que o lê (e à atestação) que veio de sideload. O
VDInstaller pode apresentar a origem como a Play Store em vez disso.

- **Show the Play Store as installer** (ligado por padrão) - define `installerPackageName` via
  `pm install-create -i com.android.vending`. Aplica-se imediatamente.
- **Also spoof the initiator** (ligado por padrão) - define `installInitiator` e `packageSource` editando
  `/data/system/packages.xml`. Isso é **ciente de ABX** (decodifica -> edita -> recodifica, com um backup
  byte a byte e uma troca atômica) e aplica-se **após a próxima reinicialização**, porque o gerenciador de
  pacotes mantém `packages.xml` em cache.

### 6.2 Verificador de pacotes do Play Protect

Uma instalação por sideload pode ser rejeitada com `INSTALL_FAILED_VERIFICATION_FAILURE` pelo verificador
de pacotes do Play Protect. Um botão de 3 estados:

- **Keep as it was** (padrão) - desligado apenas durante a instalação, depois restaurado ao seu estado
  anterior **exato** (apagado de novo se não havia valor explícito, já que um `0`/`1` onde não havia nada
  é em si uma pista num dispositivo furtivo).
- **Always on** - força ligado e mantém.
- **Always off** - força desligado e mantém. A WebUI avisa: deixá-lo desligado é uma pista de furtividade
  e desabilita uma varredura de malware em toda instalação.

### 6.3 Verificação de Desenvolvedor

A Verificação de Desenvolvedor de 2026 do Android bloqueia a instalação de apps de desenvolvedores não
registrados em dispositivos certificados, mas é imposta por um **serviço separado**, não pelo Play
Protect, e uma **instalação por root já está isenta** dela (a mesma isenção que as instalações por ADB
recebem). O VDInstaller instala seus APKs de qualquer forma, então este botão é de **melhor esforço e
honesto**: ele aplica um controle real apenas se um existir e nunca finge acionar um interruptor que não
faz nada.

### 6.4 Flags de instalação

| Flag | Efeito |
|---|---|
| **Grant all runtime permissions** | concede toda permissão de runtime na instalação (`-g`). |
| **Allow test packages** | instala pacotes marcados como somente teste (`-t`). |
| **Bypass low target SDK block** | instala apps com um `targetSdk` muito antigo. |
| **Target user** | o id do usuário Android para o qual instalar (padrão `0`). |

### 6.5 Permanecendo oculto

Para furtividade, considere ocultar seu gerenciador de root e apps sensíveis com o HMA-OSS. O VDInstaller
**nunca mexe na sua configuração do HMA-OSS** - a dica é apenas um lembrete, você mesmo faz a mudança no
HMA-OSS.

## 7. Controlando o VDInstaller a partir de um assistente de IA

O motor fala um pequeno contrato JSON por `scripts/helper.sh`, então um agente pode comandar toda ação que
a WebUI pode. Veja [AI-AGENTS](AI-AGENTS). Comande o contrato, não raspe a WebUI.

## 8. Resolução de problemas e FAQ

**Recebo `INSTALL_FAILED_VERIFICATION_FAILURE`.** É o verificador de pacotes do Play Protect. Com o botão
do verificador deixado em **Keep as it was** (o padrão), o VDInstaller o desliga durante a instalação e o
restaura, então isso não acontece.

**Liguei a origem Play Store, mas o app ainda parece ter vindo de sideload.** A parte do instalador
aplica-se imediatamente, a parte do iniciador (`packages.xml`) aplica-se **após a próxima
reinicialização**.

**Ele contorna a Verificação de Desenvolvedor do Google?** Não precisa - uma instalação por root é isenta
(veja 6.3). Não há interruptor falso para ela.

**Precisa de reinicialização?** Não, exceto a falsificação opcional do iniciador.

**Desinstalar o VDInstaller removerá os apps que instalei?** Não - essas são instalações reais de
propriedade do sistema, remover o módulo apenas limpa o próprio estado do VDInstaller.

**É seguro?** Ele instala os APKs que você escolhe e, com o verificador desligado, pula uma varredura de
malware - instale apenas APKs em que você confia. Ele nunca enfraquece nada silenciosamente.

<!-- doc-footer -->

---

> _Esta documentação foi gerada com o Claude (Anthropic) e é mantida por VD171. Correções e melhorias são bem-vindas, veja [CONTRIBUTING.md](CONTRIBUTING.md)._
