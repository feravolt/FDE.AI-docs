### AI Info
![aire](https://github.com/feravolt/FDE.AI-docs/blob/master/aire.png?raw=true)

FDE has an AI implementation, which works on any device just as FDE itself. Its purpose is to check current usage scenario and adapt some system parameters on the fly to give the best experience for every usage scenario. All boosts/turbos are automatically turned OFF when screen is OFF. All AI actions are logged. The best part all of this is that it will NOT consume battery.

#### What is activated automatically when possible:

**GPU Turbo**:\
AI will detect if your GPU can run FDE GPU Turbo implementation & will let you know in the log. GPU Turbo will measure GPU load, and if it keeps high (under the heavy load) AI will push GPU frequencies to the max for ~30 secs until the next load check occurs. Once GPU load decreased, stock frequencies will be restored. This will not make your games run faster, but should make them more stable, because governor will not jump from one frequency to another under heavy load. This is not package-name dependent - it directly monitors GPU load for whatever reason (game, benchmark, etc.), making this thing universal. It's also thermal dependent - threshold values are dynamic and it will not boost things if device is overheating.
 Active only when screen is ON. Supported on most Adreno and Mali GPUs. Will not conflict with Huawei's GPU Turbo implementation.

**Legacy GPU Turbo**:\
This Turbo mode will be selected if your kernel's GPU driver doesn't provide real-time load info. The difference from regular GPU Turbo is that the Legacy one will boost only on any process/game from heavy app list running without relying on real-time GPU load. You can also enable constant Legacy GPU turbo by manually switching AI mode to performance.
Enable heavy games boost option in the settings to make this mode work automatically. Active only when screen is ON. Supported on some Mali & Vivante GPUs.

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
AI checks if device is being charged or not. If it's charging, AI configures VM for optimal performance. Once you unplug your device, previous VM profile will be restored according to the learned AI profile. Force Doze mode (if enabled) also relies on this, preventing itself from running while the device is charging. This feature doesn't boost any frequencies and only tunes VM settings, so this is not dangerous and will not make device overheat. If throttling was disabled by user or by AI (for heavy app/game) - it will be enabled back while device is charging. Also while AI is in advanced mode, Android OS powersaving state is monitored - if enabled, AI will be automatically set to powersave mode and will not activate performance mode.

