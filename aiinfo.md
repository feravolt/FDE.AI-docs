### AI info
![aire](https://github.com/feravolt/FDE.AI-docs/blob/master/aire.png?raw=true)

######

FDE includes an AI that adapts system settings based on device usage to enhance user experience. All
boosts/turbos are turned off when the screen is off. AI actions do not drain the battery and are
logged.

---

#### AI Functions:

######

**Battery life cycle extender**:\
Optional feature. Limits the max charging level to extend battery life. Charging stops at the user
set limit and resumes when the battery drops below 6% the chosen limit.

######

**Force Doze**:\
Optional feature. Improves battery life when the screen is off by forcing Doze mode immediately and
optionally activating power-saving and background apps killing.

######

**Process detection**:\
Analyzes foreground apps to boost performance for heavy apps and save power for light ones. Unlisted
apps are analyzed in real-time and decided if they are heavy or light. Users can customize app
lists.

######

**Charging bypass**:\
Optional feature. Extends battery life and reduces heat by directing charger power straight to the
device, bypassing the battery, when a heavy app/game is in use.

######

**Dynamic VM tuner**:\
Adjusts VM parameters in real time based on RAM usage for better RAM, cache, and battery management.

######

**Dynamic read ahead**:\
Active on devices with 8GB+ RAM. Dynamically tunes read-ahead parameters during heavy app/game usage
to improve memory read speed and reverts to optimized defaults when closed.

######

**Throttling control**:\
Optional feature. Disables OS throttling (frequencies lowering) to maintain performance during heavy
use of device, except when the device overheats too much or is charging. User can configure
temperature limits.

######

**Auto-tune frequencies**:\
Available for AI auto mode only. Reduces CPU/GPU frequencies for light apps to save power and
restores them for heavy or other apps in AI auto mode. Disables throttling during heavy app/game
use.

######

**CPU Turbo**:\
Boosts CPU performance by tuning governor when high load is detected in AI auto mode or during heavy
app use, based on device temperature.

######

**GPU Turbo**:\
Maximizes GPU performance under high load in AI auto mode or during heavy app use, reverting to
normal when the load decreases. Performance boosts depend on device temperature.

######

**Machine learning**:\
Learns user device usage scenario in AI auto mode to adjust system settings for gaming
(performance), chatting/browsing (power saving) or balancing as needed.
