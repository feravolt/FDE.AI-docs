## Information about applied core tweaks

Here will be a rough "what & why" description for most of the tweaks applied by FDE.AI. All of these tweaks are applied systemlessly, thus are fully revertible. Note that many of the tweaks are dynamically changed via ML while FDE.AI is working in background, depending on device usage scenario. This is only the main part of tunables, there are many more that manipulate low-level hardware stuff and are not described here.<br>
Last updated: 27/11/2020. Valid for FDE.AI v11+.



<br>**FS tweaks**:
 - _noatime_ flag (EXT4/F2FS) - to disable inode & directory last update time which increases FS performance
 - _commit_ flag (EXT4) - the sync/flush data to disk period - increased in order to improve performance by caching
 - _max_batch_time_ flag (EXT4) - the period of batch sync operations to disk - increased in order to improve performance by utilizing higher throughput of recent storage chips and better caching utilization
 - _init_itable_ flag (EXT4) - the time to zero out the previous block group's inode table. Increased to minimize the impact on the system performance while file system's inode table is being initialized
 - _/sys/module/ext4/parameters/mballoc_debug_ (EXT4) - disabled (just in case it was ON) to reduce FS debugging overhead & increase performance
 - _ram_thresh_ (F2FS) - controls the memory footprint used by free nids and cached nat entries, increased for better performance
 - _cp_interval_ (F2FS) - controls the checkpoint timing, increased for better performance
 - _/proc/sys/fs/dir-notify-enable_ - used to notify a process about file/directory changes, disabled for better performance
 - _/proc/sys/fs/leases-enable;lease-break-time_ - used to enable or disable file leases on a system-wide basis, enabled/tuned for better performance



 <br>**IO tweaks**:
 - _read_ahead_kb_ - sets the maximum amount of data that the kernel reads ahead for a single file, adaptively tuned to provide better IO performance
 - _add_random_ - the disk entropy contribution, disabled since mobile devices are not using spinning disks
 - _iostats_ - various IO stats, disabled to reduce it's overhead for better performance
 - _nomerges_ - option to disable the lookup logic involved with IO merging requests in the block layer, disabled to reduce it's overhead for better performance
 - _rotational_ - used to stat if the device is of rotational type, obviously disabled
 - _rq_affinity_ - option to change CPU IO task completion behaviour, tuned to utilize CPU caching effects & provide better performance and power saving
 - _back_seek_penalty_ - used by HDDs, reduced since mobile devices are not using spinning disks



<br>**Network tweaks**:
 - _tcp_tw_reuse_ - the reuse of TIME-WAIT sockets for new connections - enabled
 - _tcp_tw_recycle_ - enables fast recycling of TIME_WAIT sockets, but is known to cause problems when using load balancers - disabled
 - _tcp_timestamps_ - enables TCP packets timestamps - enabled for better unstable connections handling
 - _tcp_window_scaling_ - allows receiving TCP packets larger than defined maximum - enabled for better throughput utilization
 - _tcp_slow_start_after_idle_ - causes communication to start or resume gradually - disabled for possibly faster connection establishment/ping
 - _tcp_synack_retries_ - number of times SYNACKs for a passive TCP connection attempt will be retransmitted - reduced
 - _tcp_keepalive_intvl_ - how frequently the keep-alive connection probes are send out - reduced
 - _tcp_keepalive_probes_ - how many keepalive probes TCP sends out, until it decides that the connection is broken - reduced
 - _tcp_fin_timeout_ - the length of time an orphaned (no longer referenced by any application) connection will remain in the FIN_WAIT_2 state - reduced
 - _tcp_challenge_ack_limit_ - number of challenge ACK sent per second - increased to fix CVE-2016-5696 vulnerability
 - _tcp_fastopen_ - enables TCP Fast Open to send and accept data in the opening SYN packet - enabled to speed up connection with supported servers
 - _tcp_default_init_rwnd_ - set Google's recommended value, which is not set on some older devices



<br>**Kernel/VM tweaks**:
 - _/sys/kernel/debug/tracing/tracing_on_ - kernel tracing, disabled (just in case it was ON) to reduce it's overhead
 - _/proc/sys/kernel/sched_schedstats_ - kernel scheduler stats, disabled (just in case it was ON) to reduce it's overhead
 - _/proc/sys/kernel/perf_cpu_time_max_percent_ - how much CPU time it should be allowed to use to handle perf sampling events, applied value is automatically calculated depending on device's max CPU frequency
 - _/proc/sys/vm/stat_interval_ - time interval between which vm statistics are updated, increased to reduce it's overhead
 - _/proc/sys/kernel/random/..._ - the kernel entropy pool configuration, slightly tuned to provide better performance, still being powersave
 - _/proc/sys/vm/min_free_kbytes;extra_free_kbytes_ - used to force the VM to keep a minimum number of kilobytes free, tuned to provide better performance
 - _/proc/sys/vm/reap_mem_on_sigkill_ - enables or disables panic on out-of-memory feature, disabled for stability.
 - _/proc/sys/vm/block_dump_ - used for I/O debugging, disabled (just in case it was ON) for better performance
 - _/proc/sys/vm/oom_dump_tasks_ - enables a system-wide task dump on OOM, disabled to reduce it's overhead for better performance
 - _/proc/sys/vm/compact_memory_ - toggles memory compaction to keep more available RAM, enabled for better performance
 - _/proc/sys/vm/page-cluster_ - the swap counterpart to page cache readahead, tuned for better performance
 - _/proc/sys/vm/laptop_mode_ - the dirty cache utilisation logic, dynamically changed by ML to provide balanced powersave & performance UX
 - _/proc/sys/kernel/hung_task_timeout_secs_ - checks for hanged tasks, disabled to reduce it's overhead for better performance
 - _/sys/kernel/power_suspend/power_suspend_mode_ - kernel power suspend management, tuned for better powersaving
 - _/proc/sys/kernel/sched_walt_init_task_load_pct_ - EAS tunable, optimized to provide better performance, still being powersave
 - _/proc/sys/kernel/sched_enable_power_aware;sched_cfs_boost;sched_mc_power_savings;sched_smt_power_savings;power_aware_timer_migration;/sys/module/workqueue/parameters/power_efficient_ - nodes to toggle load balancing logic for multi-core CPUs, dynamically changed by ML to provide balanced powersave & performance UX
 - _/proc/sys/kernel/sched_ravg_hist_size_ - controls the number of samples for determination of its demand, tuned for better performance
 - _/dev/stune/..._ - EAS related tunables, dynamically changed by ML to provide balanced powersave & performance UX
 - _/sys/kernel/mm/ksm;uksm/..._ - a memory-saving de-duplication feature for low RAM devices, saves a bit of RAM but does extra CPU loads, enabled and tuned for better performance ol low RAM devices
 - _/proc/sys/vm/vfs_cache_pressure_ - controls the tendency of the kernel to reclaim the memory for caching of directory and inode objects, dynamically changed by ML to provide balanced powersave & performance UX
 - _/proc/sys/vm/dirty_writeback_centisecs_ - the kernel dirty data flusher interval, dynamically changed by ML to provide balanced powersave & performance UX
 - _/proc/sys/vm/dirty_expire_centisecs_ - period when dirty data is old enough to be eligible for writeout by the kernel flusher threads, dynamically changed by ML to provide balanced powersave & performance UX
 - _/proc/sys/vm/dirty_ratio;dirty_background_ratio_ - the dirty data RAM based ratio, optimized to provide better powersaving and performance



<br>**CPU governor tweaks**:
 - _sampling_rate_ - the frequency of lookup for CPU usage and decisions on what to do about the frequency, tuned for better performance
 - _sampling_down_factor_ - how much time to "think" before scaling down CPU frequency, dynamically changed by ML to provide balanced powersave & performance UX
 - _up_rate_us_ - the minimum amount of time to spend at a frequency before ramp up, tuned for better performance
 - _down_rate_us_ - the minimum amount of time to spend at a frequency before ramp down, tuned for better powersaving
 - _timer_slack_ - max additional time to defer handling the governor sampling timer, tuned for better performance
 - _boost_ - don't go below hispeed_freq, dynamically changed by ML to provide balanced powersave & performance UX
 - _use_migration_notif_ - take scheduler in account when calculating target frequency, enabled for better performance and powersaving
 - _timer_rate_ - sample rate for reevaluating CPU load when the CPU is not idle, dynamically changed by ML to provide balanced powersave & performance UX
 - _enable_prediction_ - desired frequency prediction basing on scheduler info, dynamically changed by ML to provide balanced powersave & performance UX
 - _/sys/devices/system/cpu/cpu0/cpufreq/busfreq_static_ - static bus frequency tunable, disabled to be adaptive for better powersaving


<br>**Rest tweaks**:
 - _/sys/module/msm_performance/parameters/touchboost;/sys/power/pnpmgr/touch_boost_ - disabled to save more CPU cycles for power saving
 - _/sys/module/cpu_boost/parameters/wakeup_boost;/sys/module/cpu_input_boost/parameters/wake_boost_duration_ - enabled & tuned for boosting CPU right after you wake your device for lagfree wakeup
 - _/sys/module/cpu_boost/parameters/powerkey_input_boost_ms;/sys/module/cpu_boost/parameters/sched_boost_on_powerkey_input_ - enabled & tuned for boosting CPU when you press power button to boost wakeup process
 - _/sys/module/cpu_boost/parameters/sched_boost_on_input_ - boosts CPU sched tasks on user input events, dynamically changed by ML to provide balanced powersave & performance UX
 - _/sys/module/boost_control/parameters/app_launch_boost_ms_ - boosts CPU on launching app, tuned to provide better performance, still being powersave
 - _/sys/kernel/fp_boost/enabled_ - boosts CPU on fingerprint event, enabled & tuned to boost wakeup process via FP touch
 - _/sys/module/boost_control/...;/sys/module/cpu_boost/...;_ - rest kernel CPU boosters, tuned to provide better performance, still being powersave
 - _/sys/module/cpu_boost/parameters/dynamic_stune_boost_ - EAS dynamic boost, automatically tuned to provide better performance, still being powersave
 - _/sys/class/lcd/panel/power_reduce_ - supported by very rare displays, enabled for better powersaving
 - _/sys/kernel/debug/msm_vidc/disable_thermal_mitigation_ - disables thermal mitigation of QCOM video core, enabled to disable any throttling effects
 - _/sys/kernel/debug/msm_vidc/fw_debug_mode_ - disabled to deactivate QCOM video core firmware debugging & reduce it's overhead for better performance
 - _/sys/devices/system/cpu/sched_mc_power_savings_ - when enabled, scheduler tries to schedule processes on as few cores as possible so that the others can go idle & save power. Dynamically changed to provide better power saving, not hurting performance
 - _/sys/devices/virtual/sec/sec_touchscreen/tsp_threshold;/sys/class/touch/switch/set_touchscreen_ - touchscreen sensitivity optimization on supported Samsung devices
 - _/sys/devices/platform/galcore/..._ - various configuration nodes for Vivante GPU, dynamically changed by ML to provide balanced powersave & performance UX
 - _/sys/class/kgsl/kgsl-3d0/..._ - various configuration nodes for Adreno GPU, dynamically changed by ML to provide balanced powersave & performance UX
 - _/sys/module/mali/...;/d/mali/...;/sys/class/misc/mali..._ - various configuration nodes for Mali GPU, dynamically changed by ML to provide balanced powersave & performance UX
 - _/sys/module/adreno_idler/..._ - if supported by kernel, is deactivated to reduce UI lags
 - _/sys/module/subsystem_restart/parameters/enable_ramdumps_ - disabled to deactivate RAM dumps & reduce it's overhead for better performance
 - _/sys/module/lowmemorykiller/parameters/debug_level_ - disabled to deactivate LMK debugging & reduce it's overhead for better performance
 - _log/debug_ - disabled a lot of various debugging/logging nodes in kernel modules to reduce overhead for better performance

