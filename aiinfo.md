## Information about AI
![aire](https://github.com/feravolt/FDE.AI-docs/blob/master/aire.png?raw=true)

FDE has an AI implementation, which works on any device just as FDE itself. AI is under heavy development yet. Its purpose is to check current usage scenario and adapt some system parameters real-time to give the best experience for every usage scenario. All boosts/turbos are automatically turned OFF when screen is OFF. All AI actions are logged. The best part all of this is that it will NOT consume battery.
What is implemented:

**GPU Turbo**:\
AI will detect if your GPU can run FDE GPU Turbo implementation & will inform you about it in the log. GPU Turbo will measure GPU load, and if it keeps high (under the heavy load) AI will push GPU frequencies to the max for ~30 secs until the next load check occurs. Once GPU load decreased, stock frequencies will be restored. This will not make your games run faster, but more stable, because governor will not jump from one frequency to another under heavy load, so it may provide a much more stable FPS. This is not package-name dependent - it directly monitors GPU's load for whatever reason (game, benchmark, etc.), making this thing universal. FDE's GPU Turbo will not conflict with Huawei's GPU Turbo implementation. It's thermal dependent - threshold values are dynamic and it will not boost things if device is overheating.
Active only when screen is ON. Supported on most Adreno and Mali GPUs.

**Legacy GPU Turbo**:\
This Turbo will be selected if your kernel's GPU driver doesn't provide real-time load info. The difference from regular GPU Turbo is that the Legacy one will boost relying on any 'heavy' process/game from `/gamelist` running without relying on real-time GPU load. That means you should enable heavy games boost option in the settings to make this mode work automatically. You can also enable constant Legacy GPU turbo by manually switching AI mode to performance.
Active only when screen is ON. Supported on some Mali & Vivante GPUs.

**Framebuffer boost**:\
AI will detect if your SoC can run FDE Framebuffer boost implementation & will inform you about it in the log. AI automatically increases framebuffer frequencies, when screen is ON and GPU load is greater than 30%. This will result in more stable framerate while rendering the screen.
Active only when screen is ON. Supported on some Qualcomm SoCs.

**CPU Turbo**:\
AI will detect if your CPU can run FDE CPU Turbo implementation & will inform you about it in the log. CPU Turbo will measure CPU load, and if it keeps high (under the heavy load) AI will make CPU governor more responsive and will make it keep CPU frequency above the 'high speed freq.' (~half of the max available frequency) for ~30 seconds until the next load check occurs. This is not package-name dependent - it directly monitors CPU's load for whatever reason (game, benchmark, etc.), making this universal. This is thermal dependent - threshold values are dynamic, and it will not boost things if device is overheating.
Active only when screen is ON. Compatible with interactive, ondemand, schedutil and other governors based on these.

**Machine learning**:\
Machine learning (ML) is used if your device does support CPU and/or GPU Turbo. ML will learn how you use your device and adapt some system parameters real-time. If you're gaming a lot, AI will gain more performance for you. If you're only chatting & watching videos, AI will gain power-saving. If you're doing both playing & chatting, AI will decide what to do itself - that's what machine learning is there for. In FDE app behavior of the choice done by the ML can be configured to always prefer power-saving or performance optimization.

**Dynamic VM tuner**:\
Checks RAM usage every ~30 seconds and tunes some VM parameters basing on this check. This will result in better RAM cache management. It will also inform if system is very low on free RAM.
Active only when screen is ON.

**Force Doze**:\
This option can be activated in settings for devices with OS 6.0 and newer (by default it's OFF). Forces deep sleep Doze mode that ignores some wakelocks. May decrease idle power consumption a lot.
Active only when screen is OFF.

**Throttling switch**:\
This option can be activated in settings (by default it's OFF). Option toggles CPU & GPU throttling. When disabling throttling - be aware, your phone may get very hot, but your performance will not decrease under prolonged heavy loads.

**The thermal controller**:\
AI checks device temperature and reports in the log if the device is overheating. CPU/GPU Turbo's thresholds are calculated basing on value read from thermal controller, so that if that your device heats up CPU/GPU Turbo will stop boosting your device and/or do it more rare.

**Charging state detector**:\
AI checks if device is being charged or not. If it's charging, AI configures VM for performance. Once you unplug your device, previous VM profile will be restored according to the learned AI profile. Force Doze mode (if enabled) also relies on this, preventing itself from running while the device is charging.
This feature doesn't boost any frequencies and only tunes VM settings, so this is not dangerous and will not make device overheat.

**Battery life cycle extender**:\
This option can be activated via AI chat command if it's supported by hardware (by default it's OFF). When enabled, AI will monitor device's battery level and stop charging battery when its level hits 90% (by default). The trigger value can be changed manually. Charging will be re-enabled if device is still being charged and battery level dropped by 5% from trigger value. Lithium-based batteries life can be prolonged by not charging them to 100%.

**Adaptive downscale:**\
This option can be activated via AI chat command. It downscales device's screen resolution to desired one (specified by user) in order to increase GPU performance. The adpativeness of this option is that while changing screen resolution, the screen ratio stays same and DPI changes accordingly, to keep original elements size. In the end the resulted image should be visually same as original.
To reset downscale use '/resetscale' AI chat command. Downscale test option is available via chat command (see list below). Just in case if things go very wrong, to reset manually use ```wm size reset && wm density reset``` command in terminal/cmd.
Option does not accept value higher than original screen width and lower than 360 pixels and calculated screen density cannot be lower than 160 DPI.

**AI chat**: (single-line 96-char text)
Starting from APP version 7 you can actually chat with AI. This can be treated as a method for customizing AI settings or just for fun. It works by searching keywords or hashtags from your text input. Option is under development. Most of the settings are the same as they are in the "Settings" tab in the app.
What can assistant do now:
- Print this message `/help`
- Set AI to performance, powersave or adaptive mode `/performance` | `/powersave` | `/adaptive`
- Set AI to constant game boost mode `/hardgaming`
- Show list of games considered as 'heavy' ones by AI `/gamelist`
- Add custom game package id into 'heavy' games list `/addgame 'game.package.id'` or clear the list `/purgeglist`
- Clear log `/clear chat`
- Clear background apps `/clear ram`
- Clear app's cache files `/clear cache`
- Clear GPU shader cache files `/clngpu`
- Do extra system optimization - optimize ART cache, check FS for errors & TRIM it, optimize databases `/extraopt)
- Do extra system optimization automatically in background every day at ~05:00 AM if device is charging & screen is off `/extraopt auto` | `/extraopt noauto`
- Toggle Qualcomm stock settings script execution on OS start `/dontqcom` | `/doqcom`
- Toggle build.prop tweaks activation on OS start `/dontbprop` | `/dobprop`
- Toggle background apps auto-kill when screen is OFF `/killbgapps` | `/dontkillbgapps`
- Toggle device sensors behaviour in Doze mode `/toodozed` | `/dozesensor`
- Toggle force Doze activation mode `/alternatedoze` | `/normaldoze`
- Copy current FDE.AI log as text file to internal memory `/dumplog`
- Toggle vibration on FDE.AI execution `/novibro` | `/vibrate`
- Toggle all main FDE.AI tweaks execution. You can leave AI/turbos mode only. `/donttweakmeplease` | `/dotweakmeplease`
- Change your screen resolution adaptively. If used smartly, can greatly improve gaming performance in sacrifice of image quality. `/downscale 'desired lowered screen width in pixels'`, for example `/downscale 720` - will downscale your screen to 720p | `/resetscale` (It is possible to test this function - it will revert all applied changes in 10 seconds via `/downscale (for ex.) 720 test` command)
- Toggle battery life cycle extender option `/greenbattery 'optional trigger value'` | `/fullbattery`

