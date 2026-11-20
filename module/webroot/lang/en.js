/*
 * ======================================================================
 *  VD INSTALLER  ::  frictionless root sideload installer
 *  Install sideload APKs as root (single/batch/split), no friction: KernelSU/APatch/Magisk WebUI.
 *
 *  Copyright (C) 2026  VD171
 *  SPDX-License-Identifier: AGPL-3.0-or-later
 *
 *  Free software under the GNU AGPL v3 or later. NETWORK COPYLEFT: run a
 *  modified version, even as a service, and you MUST offer its source.
 *
 *  Site           : https://vd171.ru
 *  Site           : https://vd.priv8.ru
 *  Source         : https://github.com/VD171/VD-Installer
 *  GitHub         : @VD171 https://github.com/VD171
 *  XDA-Developers : @VD171 https://xdaforums.com/m/vd171.4699873/
 *  XDA thread     : https://xdaforums.com/t/VD-Installer.4809504/
 *  Telegram       : @VD_Priv8 https://t.me/VD_Priv8
 *  Channel        : @Priv8_VD https://t.me/Priv8_VD
 *  Discord        : @VD.Priv8 https://discord.com/users/1296831918989639721
 *  E-mail         : vd.priv8@pm.me
 * ======================================================================
 */
window.__I18N_EN = {
  app_title: "VDInstaller",
  app_tagline: "Frictionless root sideload installer",

  nav_install: "Install",
  nav_options: "Options",
  nav_about: "About",

  mode_label: "What are you installing?",
  mode_single: "Single APK",
  mode_single_hint: "One .apk file.",
  mode_batch: "Folder of APKs",
  mode_batch_hint: "A folder of independent .apk files, installed one by one.",
  mode_archive: "Split archive",
  mode_archive_hint: "A grouped bundle: .xapk, .apkm, .apks or .zip (base + splits).",
  mode_splitdir: "Split folder",
  mode_splitdir_hint: "A folder with the loose split .apk files of one app.",

  lbl_path_file: "APK path",
  lbl_path_folder: "Folder path",
  ph_path_file: "/sdcard/Download/app.apk",
  ph_path_folder: "/sdcard/Download/apks",
  btn_scan: "Scan",
  btn_install: "Install",
  btn_cancel: "Cancel",
  scan_empty: "No installable files found here.",
  scan_count: "${n} item(s) found",

  opt_source_head: "Install source",
  opt_spoof: "Show the Play Store as installer",
  opt_spoof_hint: "Sets installerPackageName so the app does not look sideloaded.",
  opt_spoof_pkg: "Installer package",
  opt_deepspoof: "Also spoof the initiator (packages.xml)",
  opt_deepspoof_hint: "Sets installInitiator and packageSource. Applies after the next reboot.",

  opt_verifier_head: "Play Protect verifier",
  opt_verifier: "Package verifier",
  verifier_restore: "Keep as it was (turn off only during install)",
  verifier_on: "Always on",
  verifier_off: "Always off",
  verifier_off_warn: "Leaving the verifier off is a stealth tell (a value where there was none). Use only if you know why.",
  opt_devverif: "Developer Verification",
  devverif_note: "Android Developer Verification is enforced by a separate service, not Play Protect. A root install is already exempt, so this toggle is best effort.",

  opt_flags_head: "Install flags",
  opt_grant: "Grant all runtime permissions",
  opt_downgrade: "Allow downgrade",
  opt_test: "Allow test packages",
  opt_lowsdk: "Bypass low target SDK block",
  opt_user: "Target user",

  hma_title: "Stay hidden",
  hma_text: "For stealth, consider hiding your root manager and sensitive apps with HMA-OSS. VDInstaller never touches your HMA-OSS setup - open HMA-OSS and make the change yourself when you want to.",

  phase_starting: "Starting",
  phase_extracting: "Extracting",
  phase_installing: "Installing",
  phase_uninstalling: "Uninstalling",
  phase_done: "Done",
  msg_installed_ok: "Installed: ${pkg}",
  msg_installed_fail: "Install failed: ${msg}",
  msg_batch_done: "${ok} of ${total} installed",
  msg_need_path: "Enter a path first.",
  msg_cancelled: "Cancelled.",

  about_version: "Version",
  about_what: "VDInstaller installs sideloaded APKs as root with no friction: single, batch and split APKs, with the Play Protect verifier handled for you and an optional Play install-source.",
  about_links: "Links",

  err_generic: "Something went wrong.",
  err_path: "File not found.",
  err_dir: "Folder not found.",
  err_no_apk: "No .apk found.",
  err_extract: "Could not extract the archive."
};
