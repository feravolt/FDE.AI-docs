### Changelog

## **v23.04.1**

### New:

— EULA screen with presets\
— Premium functions description block\
— 3 separate customizable overlay windows\
— Advanced FPS meter overlay with graph & statistics\
— Disable OS logs and statistics option\
— Core: Disable MTE tweak

### Improved:

— App performance, UI and UX\
— Android 13-14 compatibility\
— Sting translations\
— Core: Device info log split

### Fixed:

— Overlay windows crash on A13+

---

## **v23.01.2**

### New:

— Automatic OS power-save mode when screen is OFF\
— Ability to separately use build.prop tweaks

### Improved:

— App and UI performance\
— Core: AI responsiveness\
— Core: CPU optimization for background processes

---

## **v22.12.2**

### New:

— PayPal & QIWI links in about screen for donations

### Improved:

— App and UI performance\
— EULA dialog\
— UI in landscape mode\
— Core: AI cycles calculation

### Fixed:

— AI log text & design\
— GPU load toggle in floating screen

---

## **v22.11.6**

### New:

— GPU load in floating window\
— Floating window quick tile\
— Floating window with top-5 CPU using processes\
— New log and info text design

### Improved:

— App performance\
— Reduced app size\
— Core: write files permission check

### Fixed:

— Magisk module variant online update\
— Core: AI not working on some devices

---

## **v22.11.5**

### New:

— AI and battery state notifications\
— Predictive back gesture support\
— Per-app screen refresh rate support\
— FPS-based screen refresh rate support\
— Сhinese simplified language (thx @Nya0003)\
— Extraopt process notification\
— Customizable thermal fuse for throttling\
— APK is a Magisk module, just rename it to .ZIP (just as Magisk does; online update is supported)\
— Core: customizable AI cycle periods

### Improved:

— App performance\
— Language selector\
— Android 13 support\
— Accessibility for disabled people\
— Core: throttling control\
— Core: execution performance

### Fixed:

— Launch crash on older Android versions\
— Core: screen off power consumption\
— Core: RAM tweaks for very low-end devices\
— Core: wrong AI status report

---

## **v22.06.5**

### App:

— Custom screen refresh rate option for shortcuts\
— Low power FPS option for shortcuts - target FPS based dynamic max CPU/GPU freq. set\
— Extraopt screen fixes & improvements\
— Downscale screen fixes & improvements\
— Fixed app update check toggle\
— Added very basic CPU arch and OS version stats\
— Added app rating block in about screen\
— Updated translations, added kyrgyz language, improved language overriding\
— Added stop button in FPS meter notification, updated overlay windows design\
— Various UI/UX and performance improvements (thx to Dmitry)\
— Fixed launch crash on some ROMs\
— Various minor bugfixes

### Core:

— Fixed charger controls\
— misc.

---

## **v22.06.3**

### App:

— Fixed autopreload from shortcut\
— Various minor bugfixes

### Core:

— Improved auto refresh rate mode\
— Fixed detection of OS powersave mode\
— Improved advanced AI mode\
— Increased execution speed\
— misc.

---

## **v22.06.2**

### App:

— Updated built-in busybox to v1.36\
— UI performance improvements\
— Raised minimal supported Android OS version to 6.0 (api 23)\
— Various minor bugfixes

### Core:

— Improved auto refresh rate mode\
— Removed GPU min freq. control\
— Updated apps auto preload method\
— misc.

---

## **v22.05.1**

### App:

— Minor design improvements (thx to Dmitry)\
— More new MD3 design elements\
— Auto-reset downscale on boot is optional\
— Improved root method checks\
— Android 12.1 related fixes\
— Various improvements and bugfixes

### Core:

— Removed disable sensors on Doze feature (was problematic)\
— FluidUI feature in advanced AI mode (controls min freq of CPU/GPU)\
— Low power gaming in advanced AI mode for multi HZ displays (adapts refresh rate basing on FPS of
heavy process)\
— Highly improved auto-refresh rate mode\
— Improved debug log\
— Various bugfixes & misc.

---

## **v22.04.1**

### App:

— New MD3 design elements\
— Auto-reset downscale on boot if applied\
— Current power consumption block in settings page\
— Added the extra disclaimer\
— Added floating overlay window with customizable stats (including FPS meter, for donators only)\
— Updated translations

### Core:

— Nothing new - all stable.

---

## **v22.03.5**

### App:

— Various bugfixes, code quality improvements & misc.

### Core:

— Minor bugfixes

---

## **v22.03.4**

### App:

— Completely reworked UI (thx to Dmitry, that's a lot of work)\
— New dynamic launcher icon (Android 13 monochrome support)\
— Android 12 dynamic colors support (Monet)\
— New transition animations\
— Removed chat functions - all moved to Settings, separate screen for tools\
— New app versioning (YY.MM.ver)\
— New FDE core execution method\
— Auto-grant required app permissions\
— Fixed built-in app updater\
— Introduced donation package in Google Play for support\
— Various info blocks in settings\
— Light and heavy apps' user list selection\
— Customizable shortcuts (for donators)\
— Added new languages\
— Various improvements, fixes and many more misc.

### Core:

— Updated compiler\
— Core FDE module 64 bit arch support\
— Increased start execution speed\
— Fixed issues on Huawei devices\
— Reworked device info section\
— Updated default heavy processes list\
— Added support for user 'light' processes list\
— Fixed language override support\
— Fixed 'ignore throttling on charge' function\
— Introduced device's HW score for use in tweaks formulas\
— New machine learning neuron - FPS based measurements for heavy games to boost\
— New machine learning neuron - process type based measurements for system optimization\
— Introduced Bypass Charging function on supported devices\
— Improved battery charge limit function\
— Automatic CPU bandwidth optimization on supported kernels\
— Improved junk files cleaner function\
— Various advanced AI mode fixes and improvements\
— Added support for audio alerts via soundpack modules (for donators)\
— Dynamic CPU/GPU load measure delays\
— Enhanced GPU load measure for all Mali GPUs\
— Improved screen state detection\
— LTPO displays detection\
— Added CPU Uclamp control support\
— Added Block IO optimization\
— Added MTK GPU Extension Device optimization\
— Improved throttling control\
— Enhanced processes priority optimization\
— Improved network tweaks\
— Improved kernel scheduler tweaks\
— Improved manual AI powersaving mode\
— Updated built-in custom busybox\
— Many more misc.

---

## **v12.6**

### App:

— A lot of code and UI refactoring and optimization (thx to Dmitry)\
— Improved app autostart logic\
— misc

### Core:

— Updated compiler\
— Renamed aggressive AI mode to 'advanced'\
— Extended advanced AI mode features & improved its logic\
— Autopreload for heavy apps/games support in advanced AI mode (readahead not locking mode, Preload
Pro app is required)\
— Enhanced AI talk module, log texts, commands\
— Enhanced active processes detection\
— Process OOM prioritization support for heavy apps/games in advanced AI mode\
— Improved CPU max frequency reduction logic in advanced powersaving AI mode\
— Fixed possible lags in advanced powersaving AI mode\
— misc
