### Frequently Asked Questions

> Is a BusyBox required?

— **No.** The app has its own one built-in. But having an additional BusyBox app/module installed
won't cause any conflicts.



> Why are some settings inactive (not toggleable)?

— FDE.AI checks if your device supports any of the listed settings. If a setting is not supported,
it will be disabled. This may also depend on selected AI mode & whether real-time system
optimization is enabled or not.



> Why does the AI set my device on performance mode while I set it on power saving?

— The AI tunes VM for performance if the device is charging. Once you unplug the device from the
charger, the AI will switch back to previous mode. This option is safe and will not make your device
overheat because it tunes VM parameters only (no frequency/thermal changes).



> The app worked fine, but the log is not getting updated for a long time. Is that OK?

— **Yes**, because FDE.AI does various background activity only if that is really necessary basing
on your device usage scenario. However if you think the app got actually stuck, try to restart
FDE.AI from the settings page or reboot your device.



> Will FDE.AI work with X, Y or Z tweaker app?

— Probably yes, but it is highly **NOT recommended**. Unexpected problems/conflicts may occur.
However if you know what you're doing and you know whether a setting will conflict or not, you can
use other tweakers alongside FDE.AI. However as previously stated this is NOT RECOMMENDED and to be
done ON YOUR OWN RISK.



> Why are/is the CPU and/or GPU Turbo not supported?

— Because the kernel you use doesn't provide a required info node for FDE.AI to use. However it
could also be your device's chipset/driver simply not supporting it. Additionally, some CPUs doesn't
provide required tunables to operate with. 'ondemand'/'interactive'/'schedutil' or based on these
governors should be supported by CPU Turbo. Anyhow, what you can try is changing the governor,
kernel or simply clear the apps data to ensure it's not just a random glitch. Additionally to that,
there is legacy GPU Turbo support for certain Mali and Vivante GPU's that otherwise don't support
the feature. It requires having constant game boost option active and works with supported games
automatically, or can be always enabled if AI mode is set to performance.



> How do I change my CPU/GPU governor?

— Download a kernel manager (we recommend SmartPack but literally any is fine) and change it from
there.



> Can I safely close the app by swiping it away from recents?

— Yes. There is a background service which handles all the processes. The app acts like a wrapper of
that background service.



> When you speak of a background service, does that mean the app will drain my battery?

— **No**. Just no.



> How to correctly uninstall FDE.AI?

— Uninstall the app as usual and reboot your device. All applied settings will go back to their
defaults. But please consider reporting your reasons for uninstalling in the support group.
Especially if it was because of bugs or the app was not behaving as you expected.



> Which root methods are supported by app?

— Literally any, but Magisk is recommended.



> What is the AI lifetime counter on the apps main page?

— It's just a simple indicator that shows how long the AI has been active. For example, it's gonna
reset if you hit "Restart FDE.AI" or when your device reboots.



> Why AI sometimes false-reports its mode?

— It's not falsely reporting, it just slowly (not realtime) updates its state which usually
requires ~40 seconds.



> What is the "PC Optimizer" button on the info page and why is it there?

— It's a link to the partnership (freeware) optimizer app for Windows OS. App is developed and
maintained by different developers (not the FDE.AI team).



> My system start to lag after FDE.AI execution. Why?

— That should not happen. But you may try to disable **all** build.prop tweaks in settings, reboot
device & see.



> I have a question which this FAQ doesn't cover. Where can I find an answer?

— Check the "Info about AI section". Also feel free to join our Telegram support group

- https://t.me/feralab_eng. We'll be happy to help 😉



> I found a bug/have suggestions, where can I report them?

— Same as above - in our Telegram support group.
