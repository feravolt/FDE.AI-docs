## Information about applied core tweaks

Here will be a rough "what & why" description for most of the tweaks applied by FDE.AI. All of these tweaks are applied systemlessly, thus are fully revertible. Note that many of the tweaks are dynamically changed via ML while FDE.AI is working in background, depending on device usage scenario. This is only the main part of tunables, there are many more that manipulate low-level hardware stuff and are not described here. (Copilot generated, used real code context)<br>
Last updated: 02/07/2025. Valid for FDE.AI v25+.<br>


---


#### 1. System Cleanup & Logging

* **Paths:** Various system properties and numerous file paths across `/data`, `/sdcard`, and `/sys/module`.
* **Change:**
  * System cache, log files, and temporary junk files are deleted.
  * Many system-wide logging features are disabled.
* **Purpose:** To free up storage space and reduce background I/O and CPU usage caused by excessive logging, which can improve performance and battery life.

---

#### 2. File System (FS)

* **Paths:**
  * `/proc/sys/vm/vfs_cache_pressure`
  * Mount options for `ext4` and `f2fs` partitions.
  * `/sys/module/ext4/parameters/mballoc_debug`
* **Change:**
  * The tendency of the kernel to reclaim memory used for caching directory and inode objects is decreased.
  * File systems are remounted with performance-oriented options (e.g., `noatime`).
  * Debugging for the `ext4` memory allocator is disabled.
* **Purpose:** To improve file system performance by reducing unnecessary disk writes and optimizing how the system caches file information.

---

#### 3. CPU & Scheduler

* **Paths:**
  * `/sys/module/msm_performance/parameters/touchboost` and others: Disables CPU frequency boost on simple screen touch.
  * `/sys/module/cpu_boost/parameters/wakeup_boost` and others: Enables/optimizes CPU boost when the device wakes up.
  * `/sys/module/cpu_boost/parameters/sched_boost_on_input`: Disables scheduler boost on general input.
  * `/sys/module/boost_control/parameters/app_launch_boost_ms`: Optimizes CPU boost when launching apps.
  * `/sys/kernel/sched_features`, `/proc/sys/kernel/sched_schedstats`, etc.: Various kernel scheduler parameters are optimized.
  * `/sys/module/msm_thermal/*`: Thermal management is temporarily disabled to apply settings, then re-enabled.
  * `/sys/devices/system/cpu/cpu*/cpufreq/*`: CPU governor parameters are optimized for a balance of performance and power saving.
  * `/dev/stune/*` & `/dev/cpuctl/*`: Task scheduling groups (Stune, Uclamp) are tuned to prioritize foreground apps over background tasks.
* **Purpose:** To make the system feel more responsive by intelligently managing CPU frequencies. It boosts performance for important events like waking the device or launching an app, while saving power during less demanding tasks.

---

#### 4. Virtual Memory (VM)

* **Paths:**
  * `/proc/sys/vm/min_free_kbytes` & `extra_free_kbytes`: Adjusted based on device RAM and screen resolution.
  * `/proc/sys/vm/reap_mem_on_sigkill`: Enabled.
  * `/proc/sys/vm/block_dump`, `oom_dump_tasks`: Disabled.
  * `/proc/sys/vm/compact_memory`: Enabled.
  * `/proc/sys/vm/page-cluster`: Disabled.
  * `/proc/sys/vm/laptop_mode`: Enabled.
  * `/proc/sys/vm/drop_caches` (on low RAM devices): Caches are cleared.
* **Purpose:** To optimize how Android manages RAM. This includes ensuring a minimum amount of free memory is always available, improving read/write speeds, and reducing memory-related overhead.

---

#### 5. GPU

* **Paths:**
  * Paths for Adreno, Mali, and Vivante GPUs (e.g., `/sys/class/kgsl/kgsl-3d0/*`, `/sys/module/mali/*`).
* **Change:**
  * Debugging features are disabled.
  * Power saving and frequency scaling settings are optimized.
  * The "Adreno Idler" is disabled to prevent potential stutters.
  * GPU touch boost is enabled on devices with larger batteries.
* **Purpose:** To improve graphics performance and efficiency, leading to smoother animations and better gaming experience while managing power consumption.

---

#### 6. Network

* **Paths:** `/proc/sys/net/ipv4/*`
* **Change:** Multiple TCP/IP stack parameters are tuned.
* **Purpose:** To potentially improve network speed, reduce latency, and make the internet connection more stable and efficient.

---

#### 7. I/O Scheduler

* **Paths:** `/sys/block/*/queue/*`
* **Change:** I/O scheduler settings for all block devices (storage) are optimized.
* **Purpose:** To improve storage performance by tuning how data read/write requests are handled, which can lead to faster app loading and file operations.
