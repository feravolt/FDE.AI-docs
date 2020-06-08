## Changelog


*** **v9.2** ***
— [APP] Updated all dependency libs, SDK & compiler
— [APP] Many UI updates and fixes (thx a lot to Dmitry D.)
— [APP] Many code-style improvements & refactor (thx a lot to Dmitry D.)
— [APP] Updated documentation & misc text info
— [APP] Fixed crashes on pre-Lollipop OSes
— [APP] Fixed crashes on pre-Oreo OSes
— [APP] Added button link for PC optimizer
— Whole code refactoring & optimization
— Introduced AI battery life cycle extender (#greenbattery, #fullbattery)
— Changed battery life cycle extender range to 90<>84%
— Fix CPU turbo on devices with non-working battery temp sensor
— Enhanced manual AI powersave & performance profiles
— Fix GPU turbo not kinking in some rare cases
— Updated 'heavy' games list
— Various bugfixes & segfault fixes
— misc.



*** **v9.1** ***
— [APP] Updated all dependency libs & compiler
— [APP] Many UI updates and fixes (thx a lot to Dmitry D.)
— [APP] Long-press for settings info
— [APP] Haptic feedback in UI
— [APP] App name in spinner list instead of app package name
— [APP] Added FAQ section
— [APP] Changelog popup after update
— RAM stats fixes
— Lag fixes for SDM 660 CPU
— More Doze mode fixes for MIUI
— Better powersaving on EAS kernels
— Preload related fixes
— Kernel boost control module support
— Charging state detection
— More powersave AI
— Introduced Legacy GPUTurbo support for some Mali GPUs (will work only with constant heavy games boost option enabled)
— Niko's tweaks fixed
— Various tweaks tunings
— misc.



*** **v9.0** ***
— [APP] Updated all dependency libs & compiler
— [APP] Many UI updates and fixes (thx a lot to Dmitry D.)
— [APP] Whole code revised
— [APP] Introduced Preload option to preload the app's data into the RAM & execute/read it from there for speed & power saving
— [APP] Show real time RAM usage & preloaded data size
— [APP] Warn user if not enough RAM for preload
— [APP] Fixed app and UI crashes for pre-Lollipop OS
— [APP] FDE.AI app's data will be cleared on first launch after the update
— [APP] Moved auto bg apps kill option to AI chat
— [APP] Updated method of getting ROOT access
— [APP] AI lifetime on main info screen
— [APP] Adaptive app icon
— [APP] Bottom navigation menu
— [APP] App theme toggle
— [APP] Fixed delays after screen rotation
— [APP] Pull both up and down to refresh log
— [APP] Better UX in AI chat
— [APP] Per-second autostart delay selection
— [APP] A lot of grammar fixes
— [APP] Updated AI info text
— [APP] Updated popup window's design
— [APP] Double press BACK button to exit app
— Extended AI talker module with more customization options & features (full list in AI description)
— Fixed screen state detection for pre-Lollipop OS
— Fixed false GPU turbo support for new Mali GPUs
— Fixed L Speed detection
— Force Doze related fixes for heavily modified OSes
— Revised build.prop tweaks
— Updated built-in busybox with higher optimization
— Smarter fstrim (does trim on all supported partitions)
— Better power saving and performance mode
— Updated I/O tweaks
— Updated 'heavy' games list
— Refresh FS option (fsck + fstrim via #fsrefresh)
— Ability to switch Force Doze method if having troubles with regular Force Doze (#alternatedoze / #normaldoze)
— Ability to copy current FDE.AI log as text file to /sdcard/fde.txt (#dumplog)
— Ability to disable all build.prop tweaks on OS start (#dontbprop / #dobprop)
— Ability to toggle vibration on FDE.AI execution (#novibro / #vibrate)
— Various bug fixes
— misc.



*** **v8.4** ***
— [APP] Updated all dependency libs & compiler
— [APP] Reduced app size
— Code checked & revised
— Moved to 32-bit binaries only
— Updated own busybox
— Optimized processes detection
— Fixed Force Doze clock freeze issue on MIUI
— Added ability to disable sensors in Doze mode (#toodozed|#dozesensor)
— Various bugfixes
— misc.



*** **v8.3** ***
— [APP] Updated all dependency libs & compiler
— [APP] Various UI updates & fixes
— [APP] Enhanced ROOT access grant
— [APP] OS 10 related bugfix
— More powersave AI
— Updated heavy-games list
— Fixed AI not working on some CPUs
— Fixed screen state detection
— Fixed GPU turbo was too frequent on older MTK CPUs
— Extended AI talker module with #gamelist, #hardgaming, #skipnikogpu commands
— Input-boost tune-up
— Many under-the-hood fixes & improvements to raise the quality of FDE.AI
— Fixed camera mode switch long delay on MIUI
— EAS kernels related fixes
— Force Doze mode timing fixes
— Added ability to revert #dontqcom and #skipgputweak actions in AI chat via #doqcom and #gputweakback
— misc.



*** **v8.2** ***
— [APP] Updated all dependency libs & compiler
— [APP] EULA
— [APP] Changed support links
— [APP] Various bugfixes
— Updated compiler & compiler flags
— Whole code revised & optimized
— Reduced binary size
— Calculate more parameters based on HW
— Removed ART tweaks causing issues on rare devices
— FS mount options revised
— Screen state info fixes for old Samsung devices
— CPU governor tweaks fixes
— Niko's tweaks bug fix
— misc.



*** **v8.1** ***
— [APP] Updated all dependency libs
— [APP] Snow removed
— [APP] Qualcomm script switch removed
— [APP] Auto BG apps kill toggle added
— [APP] Added autostart toggle
— [APP] Added custom FDE autostart delay set
— Some important bugfixes
— Adreno idler disabled (causes UI lags)
— MPdesicion is toggled for Qualcomm SoCs only
— Updated I/O related tweaks
— Android OS 10 related bugfixes
— Do not touch net congestion controller
— Auto BG apps kill on heavy game detection & screen off support (off by default)
— AI talker fixes
— misc.



*** **v8.0** ***
— [APP] Updated all dependency libs
— [APP] New icon
— [APP] UI updates & bugfixes
— [APP] Fix security related issues
— [APP] Android TV related fixes
— [APP] Removed ART cache optimization toggle (option moved to AI chat)
— [APP] Added Qualcomm board default settings apply toggle
— [APP] Added constant heavy games boost toggle
— [APP] Improved ROOT access observation
— [APP] Enhanced settings page
— [APP] Beautified settings info
— Whole code revised & optimized
— Added micro-busybox for FDE.AI needs only (max optimization & speed)
— Removed potentially bad tweaks (causing device to not wake up)
— Enhanced machine learning logic (now takes CPU turbo state in account)
— Enhanced machine learning rates (speed)
— Extended machine learning tunables
— Extended AI dynamic VM tuner logic
— Improved CPU turbo logic
— Improved first run logic
— Tuned F2FS tweaks
— Tuned EXT4 FS tweaks
— Tuned Adreno GPU tweaks
— Added new machine learning 'neuron' for dynamic VM tuner
— Updated VM tweaks
— Updated network tweaks
— Tuned CPU governor tweaks
— Improved device info gathering
— More tweaks are calculated by formulas depending on the device's specs
— AI now detects some known heavy games & boost turbos immediately while playing (optional for apk | OFF by default)
— Removed auto I/O scheduler set
— Updated Niko's build.prop tweaks
— Restricted FDE.AI APK background activity (service will never die tho)
— ART cache optimization moved to AI talker module
— AI talker supports hashtags (#) (see AI info dialog)
— AI talker can joke
— AI talker got built-in commands/keywords info (help)
— Various bugfixes
— misc.



*** **v7.3** ***
— [APP] Updated all dependency libs
— [APP] MD2 design
— [APP] UI updates & performance improvement
— [APP] Should be compatible with Android TV
— [APP] New main info page
— [APP] New AI chat window
— [APP] Updated AI & settings info (thx to Dmitry D.)
— [APP] Moved to libsu (@topjohnwu)
— [APP] Updated navbar & icons
— Enhanced AI extra powersave mode
— AI talker module updates
— Extended AI talker features
— Extended stats
— Sony TA patch break fixed
— Improved VM tweaks
— Turbo's state report support
— Various bugfixes
— misc.



*** **v7.2** ***
— [APP] Updated all dependency libs
— [APP] UI bugfixes & updates
— [APP] Built-in text info updated
— [APP] Added FDE force restart button
— Whole code re-optimized
— More accurate GPU load info
— Improved FDE turbos time-in-state stats
— Improved device info get
— Fixed many potential segmentation faults
— AI Talker module improved
— Removed conflicting stuff from Qualcomm parameters script
— Improved ART cache optimization technique
— misc.



*** **v7.1** ***
— [APP] Updated all dependency libs
— [APP] Remove Vulkan UI rendering
— [APP] UI updates
— [APP] Reduced app's size
— [APP] Built-in changelog
— [APP] Built-in settings & AI info
— Improved FDE stats
— Improved FDE functions execution logic
— Improved AI performance & logic
— Improved CPU turbo mode
— Improved GPU turbo mode
— Improved extra power-saving mode
— FDE turbos time in state stats
— Talker module improved
— Updated I/O tweaks
— Updated EAS tweaks
— Updated processes priority tweaks
— The latest Linux foundation Qualcomm optimal parameters
— Various bugfixes
— misc.



*** **v7.0** ***
— [APP] Improved configuration logic
— [APP] UI updates & fixes
— [APP] Updated all dependency libs
— [APP] Ability to actually text with AI (a way to configure it)
— [APP] Real-time log
— Improved throttling control logic
— Enhanced machine learning
— Fixed dynamic VM tuner
— Improved configuration logic
— Enhanced build.prop tweaks apply
— Log enhancements
— AI logic improvements
— AI talker module
— misc.



*** **v6.3** ***
— [APP] Removed obsolete buttons
— [APP] UI bugfixes
— [APP] Fixed crash in some cases
— [APP] Enhanced security
— Updated Clang compiler flags
— Whole code heavily optimized
— Execution speed-up
— Fixed some rare crash cases
— Improved UFS memory detection
— Adreno throttling control fixed (true lagfree gaming)
— Various bugfixes
— misc.



*** **v6.2** ***
— [APP] UI bug-fixes
— [APP] Updated all dependency libs
— [APP] Vulkan UI rendering option for Android 10
— [APP] Experimental build.prop tweaks toggle
— [APP] Added AI info button
— [APP] Vulkan rendering option is available only if GPU driver supports GLES v3.2+
— Improved Force Doze mode
— Tuned VM tweaks
— Fixed time appearance in log
— I/O tweaks fixes
— AI dynamic VM tune-up
— Improved execution speed
— Optimized code
— Bugfixes
— misc.



*** **v6.1** ***
— [APP] Auto dark theme support for Android 9+
— [APP] Material Design UI
— [APP] UI bugfixes
— [APP] Updated all dependent libraries
— [APP] Better code optimization
— Improved AI extra power-saving mode.
— Improved AI extra performance mode.
— misc.



*** **v6.0** ***
— [APP] Whole code revised
— [APP] Fixed SELinux related issues
— [APP] UI bug-fixes & improvements
— [APP] Enhanced security
— [APP] Updated dependency libs
— [APP] "Rate" button
— [APP] Moved fully to java 1.8
— [APP] 9 sec delay after OS boot
— [APP] New AI extra power-saving option
— Whole code revised
— Improved execution speed & decreased RAM usage
— Fixed potential segmentation bugs.
— Enhanced security
— Enhanced AI GPU turbo logic
— Enhanced AI "performance" mode behavior
— Better Adreno GPU freqs optimization
— misc.
