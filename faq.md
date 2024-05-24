### Frequently Asked Questions

- _Is a BusyBox required_

> **No.** The app has its own built-in BusyBox. Having an additional BusyBox app or module won't
> cause any conflicts.

- _Is FDE.AI compatible with custom kernels?_

> **Yes**, in most cases. FDE.AI optimizes any kernel, but it's best to use the stock kernel to
> avoid potential conflicts.

- _Why does the AI set my device to performance mode when I choose power saving_

> The AI sets the device to performance mode while charging. Once unplugged, it reverts to the
> previous mode. This is safe and only adjusts VM parameters, not frequency or thermal settings.

- _The app worked fine, but the log isn't updating. Is that OK?_

> **Yes**, FDE.AI runs background activities only when necessary based on your device usage. If you
> think it's stuck, restart FDE.AI from the settings or reboot your device.

- _Can I use FDE.AI with other tweaker apps?_

> **Not recommended**. Unexpected problems or conflicts may occur. If you know what you're doing and
> understand potential conflicts, you can use other tweakers with FDE.AI, but this is at your own
> risk.

- _Can I safely close the app by swiping it away from recents?_

> **Yes**. A background service handles all processes. The app is just a wrapper for that service.

- _Does the background service drain my battery?_

> **No**.

- _How do I uninstall FDE.AI correctly?_

> Uninstall the app as usual and reboot your device. All settings will return to default. Consider
> reporting your reasons for uninstalling in the support group, especially if there were bugs or
> unexpected behavior.

- _Which root methods are supported by app?_

> Any method, but Magisk or KernelSU is recommended.

- _Why does the AI sometimes falsely report its mode?_

> It's not false reporting; it updates its state slowly, usually taking about 30 seconds.

- _Why does my system lag after running FDE.AI?_

> This shouldn't happen. Try disabling **all** build.prop tweaks in the settings, then reboot your
> device. This usually fixes the problem.

- _I have a question not covered in this FAQ. Where can I find an answer?_

> Check the "About AI" section or join our [Telegram support group](https://t.me/feralab_eng) for
> help.

- _I found a bug or have suggestions. Where can I report them?_

> Report them in our Telegram support group.
