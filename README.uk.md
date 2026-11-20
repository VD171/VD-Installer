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

> **Languages:** [English](README.md) · [العربية](README.ar.md) · [Čeština](README.cs.md) · [Deutsch](README.de.md) · [Español](README.es.md) · [فارسی](README.fa.md) · [Français](README.fr.md) · [हिन्दी](README.hi.md) · [Bahasa Indonesia](README.id.md) · [Italiano](README.it.md) · [日本語](README.ja.md) · [한국어](README.ko.md) · [Nederlands](README.nl.md) · [Polski](README.pl.md) · [Português](README.pt.md) · [Русский](README.ru.md) · [Svenska](README.sv.md) · [ไทย](README.th.md) · [Türkçe](README.tr.md) · Українська · [Tiếng Việt](README.vi.md) · [中文](README.zh.md)

# VDInstaller

> Безперешкодний root-інсталятор sideload - KernelSU / APatch / Magisk WebUI.

## Навіщо

Встановлення sideload-APK на root-телефоні створює більше шуму, ніж мало б: верифікатор пакунків
Play Protect може видати `INSTALL_FAILED_VERIFICATION_FAILURE`, split-застосунки (`.xapk` / `.apkm`
/ `.apks`) потребують ручного використання session API, а щойно встановлений застосунок оголошує
себе "sideload" кожному застосунку, що читає джерело його встановлення. VDInstaller робить усе це за
вас, уже як root, без запиту "надати su" і без термінала.

## Можливості

- **Будь-яка форма APK** - окремий `.apk`, ціла папка незалежних APK (пакетно), згрупований
  split-архів (`.xapk` / `.apkm` / `.apks` / `.zip`) або папка окремих split-APK.
- **Жодної стіни верифікації** - перемикач на 3 стани для верифікатора пакунків Play Protect:
  залишити як було (вимкнено лише під час встановлення, відновлюється точно), завжди увімкнено або
  завжди вимкнено.
- **Чесно щодо Developer Verification** - root-встановлення вже звільнене від Android Developer
  Verification 2026 року; перемикач працює за найкращих зусиль і каже про це, він ніколи не є
  фальшивим.
- **Не "sideload"** - за бажанням подає джерело встановлення як Play Store, як інсталятора (під час
  встановлення), так і ініціатора (через ABX-сумісне редагування `packages.xml`).
- **Відокремлене й відновлюване** - встановлення виконуються як відокремлений root-процес; закриття
  WebUI ніколи їх не перериває, а інтерфейс повторно під'єднується за ідентифікатором операції.
- **Ваше рішення** - тестові пакунки, надання всіх дозволів часу виконання,
  цільовий користувач, обхід блокування низького цільового SDK: усе необов'язкове.
- **Офлайн, самодостатній, без перезавантаження** - WebUI-модуль із вбудованими двійковими файлами;
  придатний до використання одразу після прошивки.

## Агенти ШІ

Цей проєкт вітає внески ШІ та агентів. Рушій спілкується у форматі JSON через невеликий
headless-контракт (`scripts/helper.sh <verb> <base64(JSON)>`), задокументований у
[docs/AI-AGENTS.md](docs/AI-AGENTS.md), тож агент може виконувати будь-яку дію, доступну WebUI - не
скрейпте WebUI. Патчі від ШІ проходять ту саму планку рецензування, що й будь-які інші.

## Встановлення

Прошийте zip у KernelSU, APatch або Magisk і відкрийте WebUI VDInstaller зі свого root-менеджера.
Інсталятор зберігає лише ABI вашого пристрою й виконує обов'язкову перевірку цілісності `.sha256`
(перериває роботу на пошкодженому чи обрізаному zip). Android 8.0 (API 26) або новіший.

## Безпека

VDInstaller працює як root і встановлює вибрані вами APK; вимкнення верифікатора пакунків для
встановлення вимикає сканування на шкідливе ПЗ, тож встановлюйте лише APK, яким довіряєте. Він
ніколи не послаблює безпеку пристрою потайки: за замовчуванням верифікатор відновлюється до точного
попереднього стану, і він ніколи не торкається вашого налаштування HMA-OSS. Повідомляйте про
проблеми згідно з [SECURITY.md](SECURITY.md).

## Збирання

Завжди release, ніколи debug. `.github/scripts/build_bin.sh` отримує `jq` зі сховища apt Termux
(разом із замиканням спільних бібліотек) і автономні конвертери `abx2xml` / `xml2abx` для всіх
чотирьох ABI, кожен із `PROVENANCE.json`. Робочий процес випуску збирає прошивані zip, записує
супутні `.sha256`, заповнює `update.json` і публікує як `github-actions[bot]`.

## Документація

Посібники розташовані в [docs/](docs/) і дзеркаляться до вікі GitHub. Див.
[docs/AI-AGENTS.md](docs/AI-AGENTS.md) щодо headless-контракту.

## Див. також

- [VDBackup](https://github.com/VD171/VD-Backup) - повне резервне копіювання й відновлення застосунків і даних, як root.
- [VDInfos](https://github.com/VD171/VD-Infos) - читайте кожну інформацію про пристрій кожним методом, а потім порівнюйте.
- [VDGoogle](https://github.com/VD171/VDGoogle) - читайте RCS, Wallet і атестації як root.
- [COPG-VD](https://github.com/VD171/COPG-VD) - модуль Pixel fingerprint і props.

## Contacts

- Site           : https://vd171.ru
- Site           : https://vd.priv8.ru
- Source         : https://github.com/VD171/VD-Installer
- GitHub         : [@VD171](https://github.com/VD171)
- XDA-Developers : [@VD171](https://xdaforums.com/m/vd171.4699873/)
- XDA thread     : [VD-Installer](https://xdaforums.com/t/root-webui-v1-00-vd-installer.4809504/)
- Telegram       : [@VD_Priv8](https://t.me/VD_Priv8)
- Channel        : [@Priv8_VD](https://t.me/Priv8_VD)
- Discord        : [@VD.Priv8](https://discord.com/users/1296831918989639721)
- E-mail         : vd.priv8@pm.me

## Ліцензія

VDInstaller ліцензовано за GNU AGPL-3.0-or-later. Див. [LICENSE](LICENSE). МЕРЕЖЕВИЙ COPYLEFT: якщо
ви запускаєте змінену версію, навіть як службу, ви повинні надати її джерельний код.

## Торгові марки

Android, KernelSU, APatch, Magisk, Google Play і Play Protect належать відповідним власникам. Цей
проєкт є незалежним і не пов'язаний з ними та не схвалений ними.

## Теги

`android` `root` `kernelsu` `magisk` `apatch` `webui` `apk-installer` `sideload` `split-apk` `xapk` `vdinstaller`

---

> Приєднуйтесь до каналу: [@Priv8_VD](https://t.me/Priv8_VD)

> _This documentation was generated with Claude (Anthropic) and is maintained by VD171. Corrections and improvements are welcome; see [CONTRIBUTING.md](CONTRIBUTING.md)._
