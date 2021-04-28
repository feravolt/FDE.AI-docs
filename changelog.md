### Changelog

## **v12.3.2**
### App:
— Various UI and UX improvements and optimizations (thx to Dmitry)\
— Added FPS meter quick tile\
— Spiltted build.prop tweaks\
— Added donation variants via Google Play\
— Added current FDE.AI settings info\
— Updated AI info section (thx to Dmitry)\
— Optimized FPS meter service\
— Support 12h format in AI chat

### Core:
— Introduced `/extraopt everything` command to compile ART cache with max optimization\
— Renamed most chat commands for better understanding\
— Fixed FPS meter not measuring first app\
— Fixed AI talk not working in rare cases\
— Restart radio modem when applying network build.prop tweaks for better compatibility\
— Fixed extraopt auto + greenbattery not working\
— misc.



## **v12.2.2**
### App:
— Minor UI and UX improvements and optimizations (thx to Dmitry)\
— Fixed rare app crash cases

### Core:
— Introduced `/extraopt revert` to revert ART/Dalvik cache optimization (clears cache & reboots device)\
— Fixed extraopt auto double execution\
— Fixed autorefreshrate acting wrong\
— misc.



## **v12.1.1**
### App:
— UI improvements and optimizations (thx to Dmitry)\
— Android 12 related fixes\
— Fixed FPS meter crash in rare cases\
— Customizable FPS overlay and additional info in it

### Core:
— Downscale function enables 4xMSAA when active to enhance UX\
— Introduced `/resetscale full` command to reset any scaling to HW defaults (use if the regular `/resetscale` is not helping)\
— Introduced `/ignorethrottling on/off` command to be able to keep throttling OFF while charging device (dangerous)\
— Introduced `/autorefreshrate on/off` commands. This toggles automatic refresh rate changing on supported displays\
— Extraopt auto function trigger time now can be configured with command `/extraopt auto HH` where HH is the desired hour in 24h format\
— Improved FPS meter logic\
— Enhanced Exynos CPUs support\
— Enhanced MIUI support\
— Enhanced GPU shader cache cleaner\
— Fixed auto throttling behavior\
— misc.



## **v12.0**
### App:
— New adaptive UI featuring simplified navigation, updated info bottom sheets and more (thx to Dmitry)\
— Red dot on the main screen if aggressive AI mode is enabled
— Improvements and optimizations (thx to Dmitry)

### Core:
— Updated log strings\
— Dropped support for x86/x86-64 arch\
— Added support for GPU bus frequency boost for Adreno GPU (while GPU turbo)\
— Auto-disable throttling for heavy games (if heavy games boost option is enabled) (more in AI info txt)\
— Auto-enable throttling, overriding any FDE.AI settings, while device is charging or overheating too much\
— Updated machine learning rates\
— Added detection of Android OS power-saver & if enabled - put AI in powersave mode. Works in aggressive AI mode only.\
— misc.



## **v11.5**
### App:
— UI/code improvements and optimizations (thx to Dmitry)\
— Added screen state listener\
— Fixed too frequent "rate me" window

### Core:
— Updated thermal throttling control nodes\
— New accurate FPS meter logic\
— New "aggressive AI" option (read AI info for details)\
— Improved AI state reports\
— Fixed module work on Intel CPUs\
— misc.



## **v11.4**
### App:
— UI/code improvements and optimizations (thx to Dmitry)

### Core:
— Fixed Qcomm post boot script bugs\
— Improved FPS meter for Android 9+\
— Fixed downscale option breaking gestures navigation\
— misc.



## **v11.3**
### App:
— Various code improvements and optimizations/simplifications (thx to Dmitry)\
— Better swipe-to-refresh library\
— App graphics optimization

### Core:
— Added Legacy GPU turbo support for some Broadcom VideoCore, PowerVR and Tegra GPUs\
— Fixed foreground app detection on Android 11\
— Fixed Legacy GPU turbo for some Mali GPUs\
— Fixed greenbattery default threshold\
— Improved GPU turbo logic\
— misc.



## **v11-11.2**
### App:
— Dropped Android 4.4 (KitKat) support (5.0+ only now)\
— Updated navigation bar look (thx to Dmitry)\
— Updated AI chat look & UX (thx to Dmitry)\
— Simplified transition animations (thx to Dmitry)\
— Haptic feedback on buttons press (thx to Dmitry)\
— Various code improvements and optimizations/simplifications (thx to Dmitry)\
— A LOT of various bugfixes & improvements in UI (thx to Dmitry)\
— Updated all info texts\
— Telegram bot-like chat experience (backslashes instead of hashtags, no regular text input)\
— AI state statuses\
— Non-interruptible operations block chat text input\
— AI custom avatar support (just for fun, user selectable, needs storage permission)\
— Added GIFs support\
— Added more detailed tweaks info text in AI info bottomsheet\
— Added ability to override app language to English/Russian

### Core:
— Full main code refactoring. Checked, updated/fixed every code string\
— Full tweaks revision. Removed/added/tuned various tweaks (that was not easy at all)\
— Full AI talk module refactoring with statuses support, unification and TG bot-like experience\
— Downscale test function support with auto revert (more info in AI info bottomsheet)\
— Enhanced manual AI modes effectiveness\
— Fixed & unified CPU cluster and frequency detection logic\
— Updated Qualcomm post boot universal script\
— misc.

