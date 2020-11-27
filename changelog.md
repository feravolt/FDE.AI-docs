## Changelog


*** **v11** ***\
— [APP] Dropped Android 4.4 (KitKat) support (5.0+ only now)\
— [APP] Updated navigation bar look (thx to Dmitry)\
— [APP] Updated AI chat look & UX (thx to Dmitry)\
— [APP] Simplified transition animations (thx to Dmitry)\
— [APP] Haptic feedback on buttons press (thx to Dmitry)\
— [APP] Various code improvements and optimizations/simplifications (thx to Dmitry)\
— [APP] A LOT of various bugfixes & improvements in UI (thx to Dmitry)\
— [APP] Updated all info texts\
— [APP] Telegram bot-like chat experience (backslashes instead of hashtags, no regular text input)\
— [APP] AI state statuses\
— [APP] Non-interruptible operations block chat text input\
— [APP] AI custom avatar support (just for fun, user selectable, needs storage permission)\
— [APP] Added GIFs support\
— [APP] Added more detailed tweaks info text in AI info bottomsheet\
— Full main code refactoring. Checked, updated/fixed every code string\
— Full tweaks revision. Removed/added/tuned various tweaks (that was not easy at all)\
— Full AI talk module refactoring with statuses support, unification and TG bot-like experience\
— Downscale test function support with auto revert (more info in AI info bottomsheet)\
— Enhanced manual AI modes effectiveness\
— Fixed & unified CPU cluster and frequency detection logic\
— Updated Qualcomm post boot universal script\
— misc.



*** **v10.4** ***\
— [APP] Added quick tile for fast AI mode change\
— [APP] Added quick shortcuts for app sections\
— [APP] Added session reset & stop buttons to FPS monitor notification\
— [APP] Added new build.prop tweaks spinner (thx to Dmitry)\
— [APP] Added better autocomplete list in AI chat (thx to Dmitry)\
— [APP] Added 'force English lang' button (thx to Dmitry & Dan)\
— [APP] New extra optimization process indicator in AI chat\
— [APP] Fixed crashes on Android 4.4\
— [APP] Moved core to libs\
— [APP] Fixed minor animation bugs\
— [APP] A LOT of various bugfixes & improvements (thx to Dmitry)\
— Added 64-bit modules\
— Removed #art & #fsrefresh AI chat command, and added #extraopt instead\
— Added sql databases optimization (if sql binary/module exists) with #extraopt command\
— Added an option in AI chat to auto-trigger #extraopt while device is idle & is charging once a day at ~05:00 AM via '#extraopt auto'/'#extraopt noauto'\
— Added #downscale/#resetscale AI chat command for adaptive screen resolution downscaling\
— Added #donttweakmeplease/#dotweakmeplease AI chat command to toggle activation of all main tweaks apply\
— Updated default heavy games list\
— More accurate operations time measurement\
— More safe compilation flags\
— FPS meter bug fixes\
— Added measured time for every FPS meter session\
— AI will warn if system is very low on free RAM\
— misc.



*** **v10.3** ***\
— [APP] Moved app base to Kotlin (BIG thx to Dmitry)\
— [APP] A LOT of minor layout improvements & optimizations (thx to Dmitry)\
— [APP] Various color palette updates for both themes (thx to Dmitry)\
— [APP] Improved buttons ripple effect & updated buttons group layout (thx to Dmitry)\
— [APP] Tap AI chat header to scroll to the top (thx to Dmitry)\
— [APP] Android 11 related updates/fixes\
— [APP] Added icons on main page\
— [APP] New transition animations\
— [APP] AI life time moved to 'circle'\
— [APP] Better keyboard visibility detection on all Android versions\
— [APP] Added in-app update and review mechanisms\
— [APP] Added paid subscription option (voluntarily, gives nothing, just a way to donate if you want to)\
— [APP] Various code bug-fixes, whole code refactoring & optimization\
— Fixed a bug when Doze time was 'n/a' in rare cases\
— Updated various modules detection\
— Added an option to manually add games to 'heavy' games list for constant boost via AI chat\
— Optimized foreground process detection\
— Android 11 optimizations & fixes\
— Auto restart FDE core when needed on applied settings via AI chat\
— Enhanced FPS meter. Optimized, more adaptive, shows extra useful info in log like junk frames, min/max FPS, etc.\
— Improved #greenbattery functional\
— Added an option to manually set trigger level for #greenbattery via AI chat\
— Updated throttling control for MTK devices\
— Various code optimizations & bugfixes\
— misc.
