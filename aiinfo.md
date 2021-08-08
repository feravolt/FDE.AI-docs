### AI Info
![aire](https://github.com/feravolt/FDE.AI-docs/blob/master/aire.png?raw=true)

FDE has an AI implementation, which works on any device just as FDE itself. Its purpose is to check current usage scenario and adapt some system parameters on the fly to give the best experience for every usage scenario. All boosts/turbos are automatically turned OFF when screen is OFF. All AI actions are logged. The best part all of this is that it will NOT consume battery.

#### What you can activate in the settings:
**Force Doze**:\
This option is OFF by default. It can be activated on devices with Android 6.0 or newer. Forces deep sleep Doze mode that ignores some wakelocks. May decrease idle power consumption a lot.
Active only when screen is OFF.

**Throttling switch**:\
This option is OFF by default. It toggles CPU & GPU throttling. When disabling throttling keep in mind that your phone may get very hot, but your performance will not decrease under prolonged heavy loads. This also may slow down camera/quick charging speed on some ROMs. Throttling will be automatically re-enabled for a while when device is charging or device temperature is too high.

**Constant heavy games/apps boost:**\
This option is OFF by default. It toggles AI turbos behavior. When it's active, AI will constantly boost GPU & CPU for some known heavy apps/games from `/gamelist` while they are running, increases process priority and disables throttling for a while (if it was not disabled by user, still following charging detector and thermal controller rules first). Use `/gamelistadd packagename` command to add your games to the gamelist.

#### What is activated automatically when possible:
**GPU Turbo**:\
AI will detect if your GPU can run FDE GPU Turbo implementation & will let you know in the log. GPU Turbo will measure GPU load, and if it keeps high (under the heavy load) AI will push GPU frequencies to the max for ~30 secs until the next load check occurs. Once GPU load decreased, stock frequencies will be restored. This will not make your games run faster, but should make them more stable, because governor will not jump from one frequency to another under heavy load. This is not package-name dependent - it directly monitors GPU load for whatever reason (game, benchmark, etc.), making this thing universal. FDE's GPU Turbo will not conflict with Huawei's GPU Turbo implementation. It's also thermal dependent - threshold values are dynamic and it will not boost things if device is overheating.
Active only when screen is ON. Supported on most Adreno and Mali GPUs.

**Legacy GPU Turbo**:\
This Turbo will be selected if your kernel's GPU driver doesn't provide real-time load info. The difference from regular GPU Turbo is that the Legacy one will boost relying on any 'heavy' process/game from `/gamelist` running without relying on real-time GPU load. That means you should enable heavy games boost option in the settings to make this mode work automatically. You can also enable constant Legacy GPU turbo by manually switching AI mode to performance.
Active only when screen is ON. Supported on some Mali & Vivante GPUs.

**Framebuffer boost**:\
AI will detect if your SoC can run FDE Framebuffer boost implementation & will let you know in the log. AI automatically increases framebuffer frequencies, when screen is ON and GPU load is greater than 30%. This will result in more stable framerate while rendering the screen.
Active only when screen is ON. Supported on some Qualcomm SoCs.

**CPU Turbo**:\
AI will detect if your CPU can run FDE CPU Turbo implementation & will let you know in the log. CPU Turbo will measure CPU load, and if it keeps high (under the heavy load) AI will make CPU governor more responsive and will make it keep CPU frequency above the 'high speed freq.' (~half of the max available frequency) for ~30 seconds until the next load check occurs. This is not package-name dependent - it directly monitors CPU's load for whatever reason (game, benchmark, etc.), making this universal. This is thermal dependent - threshold values are dynamic, and it will not boost things if device is overheating.
Active only when screen is ON. Compatible with interactive, ondemand, schedutil and other governors based on these.

**Machine learning**:\
Machine learning (ML) is used if your device does support CPU and/or GPU Turbo. ML will learn how you use your device and adapt some system parameters on the fly. If you're gaming a lot, AI will gain more performance for you. If you're only chatting & watching videos, AI will gain power-saving. If you're doing both playing & chatting, AI will decide what to do itself - that's what machine learning is there for. In FDE.AI app behavior of the choice done by the ML can be configured to always prefer power-saving or performance optimization.

**Dynamic VM tuner**:\
Checks RAM usage every ~30 seconds and tunes some VM parameters basing on this check. This will result in better RAM cache management. It will also inform if system is very low on free RAM.
Active only when screen is ON.

**The thermal controller**:\
AI checks device temperature and reports in the log if the device is overheating. CPU/GPU Turbo's thresholds are calculated basing on value read from thermal controller, so that if that your device heats up CPU/GPU Turbo will stop boosting your device and/or do it more rare. If device's temperature goes too high, it will override any throttling settings & enable it until temperature goes down a little, after that it restores previous throttling parameters.

**Charging state detector**:\
AI checks if device is being charged or not. If it's charging, AI configures VM for optimal performance. Once you unplug your device, previous VM profile will be restored according to the learned AI profile. Force Doze mode (if enabled) also relies on this, preventing itself from running while the device is charging.
This feature doesn't boost any frequencies and only tunes VM settings, so this is not dangerous and will not make device overheat. If throttling was disabled by user or by AI (for heavy app/game) - it will be enabled back while device is charging.
Also while AI is in aggressive mode, Android OS powersaving state is monitored - if enabled, AI will be automatically set to powersave mode and will not activate performance mode.

#### What you can activate via AI chat:
**Adaptive downscale:**\
This option downscales device's screen resolution to desired one (specified by user) in order to increase GPU performance. The adpativeness of this option is that while changing screen resolution, the screen ratio stays same and DPI changes accordingly, to keep original elements size. In the end the resulted image should be visually same as original.
To reset downscale use `/resetscale` chat command. Downscale test option is available via chat command (see the list below). In case things go wrong, try `/resetscale full` chat command - it will reset scaling to HW defaults.
Option does not accept value higher than original screen width and lower than 360 pixels and calculated screen density can't be lower than 160 DPI. Option may be broken on some ROMs - use carefully.

**Battery life cycle extender**:\
This option is OFF by default. It can be enabled if it's supported by hardware. When enabled, AI will monitor device's battery level and stop charging battery when its level hits 90% (by default). The trigger value can be changed manually. Charging will be re-enabled if device is still being charged and battery level dropped by 5% from trigger value. Lithium-based batteries life can be prolonged by not charging them to 100%.

**Automatic screen refresh rate:**\
This option is OFF by default. It can control screen refresh rate to provide better performance or powersaving depending on usage scenario if supported by device's screen.
Supported screen refresh modes are checked first. For heavy apps/games max refresh rate is applied for better performance/smoothness. For not-so-performance-hungry apps (like social networks) min refresh rate is applied to save battery. For any other cases, if screen supports more than 2 refresh modes (for ex. 60 / 90 / 120 HZ), the middle refresh mode is applied (from prev. ex. 90 HZ). If screen only supports 2 modes, max refresh rate is applied.
Works only if screen supports several screen refresh modes.

**Aggressive AI mode:**\
This option is OFF by default. Extends real-time system optimization methods which may give better powersaving/performance in adaptive AI mode.
One of such methods is to auto-reduce max CPU frequency of BIG (only) cluster by ~20% when decided to switch to powersave mode (which will obviously reduce power consumption in cost of performance) and push max freq. back in other AI modes.
This option may hurt performance while it's in powersaving mode and may cause higher battery drain in performance mode - in that case just don't use this option.

**AI chat**: (single-line 96-char text)
Starting from APP version 7 you can actually chat with AI. This can be treated as a method for customizing AI settings or just for fun. It works by searching keywords from your text input. Most of the settings are the same as they are on the Settings page.
What can assistant do now:
- Print this message `/help`
- Show list of games considered as 'heavy' ones by AI `/gamelist`
- Add custom game package id into 'heavy' games list `/gamelistadd 'game.package.id'` or clear the list `/gamelistclear`
- Clear background apps `/clear ram`
- Clear app's cache files `/clear appscache`
- Do extra system optimization - optimize ART cache, check FS for errors & TRIM it `/extraopt`
- Optimize ART cache with max optimization filter `/extraopt everything`
- Do extra system optimization automatically in background every day if device is charging & screen is off. HH is desired hour of execution in 24h format - if leaved blank it'll be triggered at ~05:00 AM. `/extraopt auto HH` | `/extraopt noauto`
- Clear Dalvik/ART cache, cancel cache optimization `/extraopt revert`
- Toggle background apps auto-kill when screen is OFF `/killbgapps on` | `/killbgapps off`
- Toggle device sensors behavior in Doze mode `/disablesensorsondoze on` | `/disablesensorsondoze off`
- Toggle more deep real-time system optimization `/aggressiveai on` | `/aggressiveai off`
- Toggle automatic screen refresh rate changing if supported `/autorefreshrate on` | `/autorefreshrate off`
- Copy current FDE.AI log as text file to internal memory `/dumpfdelog`
- Toggle vibration on FDE.AI execution `/vibro off` | `/vibro on`
- Toggle all main FDE.AI tweaks execution. You can leave AI/turbos mode only. `/alltweaks off` | `/alltweaks on`
- Change your screen resolution adaptively. If used smartly, can greatly improve gaming performance in sacrifice of image quality. `/downscale 'desired lowered screen width in pixels'`, for example `/downscale 720` - will downscale your screen to 720p | `/resetscale (full)` (It is possible to test this function - it will revert all applied changes in 10 seconds via `/downscale (for ex.) 720 test` command)
- Toggle battery life cycle extender option `/greenbattery 'optional trigger value'` | `/greenbattery off`
- Change throttling behavior while charging device `/ignorethrottling on` | `/ignorethrottling off`

