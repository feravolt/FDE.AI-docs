#! /system/bin/sh
# Copyright (c) 2012-2013, 2016-2021, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# FeraVolt 2024
# Remove min/max freq & governor set for CPU/GPU, removed zram init, optimized & misc.
# shellcheck disable=SC2112
# shellcheck disable=SC2039
# shellcheck disable=SC2043
# shellcheck disable=SC2010
# shellcheck disable=SC2042
function 8953_sched_dcvs_eas() {
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "0" >/sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us
	echo "1401600" >/sys/devices/system/cpu/cpufreq/schedutil/hispeed_freq
	echo "85" >/sys/devices/system/cpu/cpufreq/schedutil/hispeed_load
}
function 8917_sched_dcvs_eas() {
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "0" >/sys/devices/system/cpu/cpufreq/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/schedutil/down_rate_limit_us
	echo "1094400" >/sys/devices/system/cpu/cpufreq/schedutil/hispeed_freq
	echo "85" >/sys/devices/system/cpu/cpufreq/schedutil/hispeed_load
}
function 8937_sched_dcvs_eas() {
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
	echo "1094400" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
	echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
	echo "1" >/sys/devices/system/cpu/cpu4/online
	echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
	echo "768000" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
	echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
}
function configure_sku_parameters() {
	# shellcheck disable=SC2002
	reg_val=$(cat /sys/devices/platform/soc/780130.qfprom/qfprom0/nvmem | od -An -t d4)
	feature_id=$(((reg_val >> 20) & 0xFF))
	log -t BOOT -p i "feature id '$feature_id'"
	if [ $feature_id == 6 ]; then
		echo "SKU Configured : SA6145"
		setprop vendor.sku_identified 1
		setprop vendor.sku_name "SA6145"
	elif [ $feature_id == 5 ]; then
		echo "SKU Configured : SA6150"
		setprop vendor.sku_identified 1
		setprop vendor.sku_name "SA6150"
	elif [ $feature_id == 4 ] || [ $feature_id == 3 ]; then
		echo "SKU Configured : SA6155"
		setprop vendor.sku_identified 1
		setprop vendor.sku_name "SA6155"
	else
		echo "SKU Configured : SA6155"
		setprop vendor.sku_identified 1
		setprop vendor.sku_name "SA6155"
	fi
}
function 8953_sched_dcvs_hmp() {
	echo "3" >/proc/sys/kernel/sched_window_stats_policy
	echo "3" >/proc/sys/kernel/sched_ravg_hist_size
	echo "0" >/sys/devices/system/cpu/cpu0/sched_static_cpu_pwr_cost
	echo "0" >/sys/devices/system/cpu/cpu1/sched_static_cpu_pwr_cost
	echo "0" >/sys/devices/system/cpu/cpu2/sched_static_cpu_pwr_cost
	echo "0" >/sys/devices/system/cpu/cpu3/sched_static_cpu_pwr_cost
	echo "0" >/sys/devices/system/cpu/cpu4/sched_static_cpu_pwr_cost
	echo "0" >/sys/devices/system/cpu/cpu5/sched_static_cpu_pwr_cost
	echo "0" >/sys/devices/system/cpu/cpu6/sched_static_cpu_pwr_cost
	echo "0" >/sys/devices/system/cpu/cpu7/sched_static_cpu_pwr_cost
	echo "3" >/proc/sys/kernel/sched_spill_nr_run
	echo "1" >/proc/sys/kernel/sched_restrict_cluster_spill
	echo "1" >/proc/sys/kernel/sched_prefer_sync_wakee_to_waker
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "19000 1401600:39000" >/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
	echo "85" >/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpufreq/interactive/timer_rate
	echo "1401600" >/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpufreq/interactive/io_is_busy
	echo "85 1401600:80" >/sys/devices/system/cpu/cpufreq/interactive/target_loads
	echo "39000" >/sys/devices/system/cpu/cpufreq/interactive/min_sample_time
	echo "40000" >/sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
	echo "19" >/proc/sys/kernel/sched_upmigrate_min_nice
	echo "1" >/sys/devices/system/cpu/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpufreq/interactive/use_migration_notif
	echo "200000" >/proc/sys/kernel/sched_freq_inc_notify
	echo "200000" >/proc/sys/kernel/sched_freq_dec_notify
}
function 8917_sched_dcvs_hmp() {
	echo "3" >/proc/sys/kernel/sched_window_stats_policy
	echo "3" >/proc/sys/kernel/sched_ravg_hist_size
	echo "1" >/proc/sys/kernel/sched_restrict_tasks_spread
	echo "20" >/proc/sys/kernel/sched_small_task
	echo "30" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_load
	echo "3" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
	echo "0" >/sys/devices/system/cpu/cpu0/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu1/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu2/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu3/sched_prefer_idle
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "19000 1094400:39000" >/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
	echo "85" >/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpufreq/interactive/timer_rate
	echo "1094400" >/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpufreq/interactive/io_is_busy
	echo "1 960000:85 1094400:90" >/sys/devices/system/cpu/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpufreq/interactive/min_sample_time
	echo "40000" >/sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
	echo "1" >/sys/devices/system/cpu/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpufreq/interactive/use_migration_notif
	echo "50000" >/proc/sys/kernel/sched_freq_inc_notify
	echo "50000" >/proc/sys/kernel/sched_freq_dec_notify
}
function 8937_sched_dcvs_hmp() {
	echo "3" >/proc/sys/kernel/sched_window_stats_policy
	echo "3" >/proc/sys/kernel/sched_ravg_hist_size
	echo "20" >/proc/sys/kernel/sched_small_task
	echo "30" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_load
	echo "3" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run
	echo "0" >/sys/devices/system/cpu/cpu0/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu1/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu2/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu3/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu4/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu5/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu6/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu7/sched_prefer_idle
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "19000 1094400:39000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
	echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
	echo "1094400" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
	echo "1 960000:85 1094400:90 1344000:80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
	echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor
	echo "1" >/sys/devices/system/cpu/cpu4/online
	echo "39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
	echo "768000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
	echo "1 768000:90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
	echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
	echo "50000" >/proc/sys/kernel/sched_freq_inc_notify
	echo "50000" >/proc/sys/kernel/sched_freq_dec_notify
}
function sdm660_sched_interactive_dcvs() {
	echo "0" >/proc/sys/kernel/sched_select_prev_cpu_us
	echo "400000" >/proc/sys/kernel/sched_freq_inc_notify
	echo "400000" >/proc/sys/kernel/sched_freq_dec_notify
	echo "5" >/proc/sys/kernel/sched_spill_nr_run
	echo "1" >/proc/sys/kernel/sched_restrict_cluster_spill
	echo "100000" >/proc/sys/kernel/sched_short_burst_ns
	echo "1" >/proc/sys/kernel/sched_prefer_sync_wakee_to_waker
	echo "20" >/proc/sys/kernel/sched_small_wakee_task_load
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
	echo "19000 1401600:39000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
	echo "1401600" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
	echo "85 1747200:95" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo "39000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down
	echo "1" >/sys/devices/system/cpu/cpu4/online
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
	echo "19000 1401600:39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
	echo "1401600" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
	echo "85 1401600:90 2150400:95" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
	echo "39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
	echo "59000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/fast_ramp_down
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	echo "1" >/sys/devices/system/cpu/cpu4/online
	echo "1" >/sys/devices/system/cpu/cpu5/online
	echo "1" >/sys/devices/system/cpu/cpu6/online
	echo "1" >/sys/devices/system/cpu/cpu7/online
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu0/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu1/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu2/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu3/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu4/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu5/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu6/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu7/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-ret/idle_enabled
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
		echo "bw_hwmon" >"$cpubw"/governor
		echo "50" >"$cpubw"/polling_interval
		echo "762" >"$cpubw"/min_freq
		echo "1525 3143 5859 7759 9887 10327 11863 13763" >"$cpubw"/bw_hwmon/mbps_zones
		echo "4" >"$cpubw"/bw_hwmon/sample_ms
		echo "85" >"$cpubw"/bw_hwmon/io_percent
		echo "100" >"$cpubw"/bw_hwmon/decay_rate
		echo "50" >"$cpubw"/bw_hwmon/bw_step
		echo "20" >"$cpubw"/bw_hwmon/hist_memory
		echo "0" >"$cpubw"/bw_hwmon/hyst_length
		echo "80" >"$cpubw"/bw_hwmon/down_thres
		echo "0" >"$cpubw"/bw_hwmon/low_power_ceil_mbps
		echo "34" >"$cpubw"/bw_hwmon/low_power_io_percent
		echo "20" >"$cpubw"/bw_hwmon/low_power_delay
		echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
		echo "250" >"$cpubw"/bw_hwmon/up_scale
		echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
	done
	for memlat in /sys/class/devfreq/*qcom,memlat-cpu*; do
		echo "mem_latency" >"$memlat"/governor
		echo "10" >"$memlat"/polling_interval
		echo "400" >"$memlat"/mem_latency/ratio_ceil
	done
	echo "cpufreq" >/sys/class/devfreq/soc:qcom,mincpubw/governor
}
function sdm660_sched_schedutil_dcvs() {
	if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -ge 19 ]; then
		echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
		echo "1401600" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
		echo "902400" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
		echo "1401600" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/pl
		echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/rtg_boost_freq
	else
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1401600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
		echo "1401600" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
	fi
	echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
	echo "0:1401600" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "-6" >/sys/devices/system/cpu/cpu0/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu1/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu2/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu3/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu4/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu5/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
	echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
	echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
	for device in /sys/devices/platform/soc; do
		for cpubw in "$device"/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "50" >"$cpubw"/polling_interval
			echo "762" >"$cpubw"/min_freq
			echo "1525 3143 5859 7759 9887 10327 11863 13763" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "85" >"$cpubw"/bw_hwmon/io_percent
			echo "100" >"$cpubw"/bw_hwmon/decay_rate
			echo "50" >"$cpubw"/bw_hwmon/bw_step
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "0" >"$cpubw"/bw_hwmon/hyst_length
			echo "80" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
		done
		if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -le 14 ]; then
			for memlat in "$device"/*cpu*-lat/devfreq/*cpu*-lat; do
				echo "mem_latency" >"$memlat"/governor
				echo "10" >"$memlat"/polling_interval
				echo "400" >"$memlat"/mem_latency/ratio_ceil
			done
			for latfloor in "$device"/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*; do
				echo "compute" >"$latfloor"/governor
				echo "10" >"$latfloor"/polling_interval
			done
		fi
	done
	if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -ge 19 ]; then
		setprop vendor.dcvs.prop 1
	fi
}
target=$(getprop ro.board.platform)
KernelVersionStr=$(cat /proc/sys/kernel/osrelease)
KernelVersionS=${KernelVersionStr:2:2}
KernelVersionA=${KernelVersionStr:0:1}
KernelVersionB=${KernelVersionS%.*}
function configure_read_ahead_kb_values() {
	MemTotalStr=$(grep MemTotal /proc/meminfo)
	MemTotal=${MemTotalStr:16:8}
	dmpts=$(ls /sys/block/*/queue/read_ahead_kb | grep -e dm -e mmc)
	if [ "$MemTotal" -le 3145728 ]; then
		echo "128" >/sys/block/mmcblk0/bdi/read_ahead_kb
		echo "128" >/sys/block/mmcblk0rpmb/bdi/read_ahead_kb
		for dm in $dmpts; do
			echo "128" >"$dm"
		done
	else
		echo "512" >/sys/block/mmcblk0/bdi/read_ahead_kb
		echo "512" >/sys/block/mmcblk0rpmb/bdi/read_ahead_kb
		for dm in $dmpts; do
			echo "512" >"$dm"
		done
	fi
}
function disable_core_ctl() {
	if [ -f /sys/devices/system/cpu/cpu0/core_ctl/enable ]; then
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/enable
	else
		echo "1" >/sys/devices/system/cpu/cpu0/core_ctl/disable
	fi
}
function configure_memory_parameters() {
	ProductName=$(getprop ro.product.name)
	low_ram=$(getprop ro.config.low_ram)
	if [ "$ProductName" == "msmnile" ] || [ "$ProductName" == "kona" ] || [ "$ProductName" == "sdmshrike_au" ]; then
		configure_read_ahead_kb_values
		echo "0" >/proc/sys/vm/page-cluster
		echo "100" >/proc/sys/vm/swappiness
	else
		arch_type=$(uname -m)
		if [ "$low_ram" == "true" ]; then
			echo "0" >/sys/module/lowmemorykiller/parameters/enable_lmk
			echo "0" >/sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
			echo "0" >/sys/module/process_reclaim/parameters/enable_process_reclaim
			disable_core_ctl
			if [ -f /proc/sys/vm/reap_mem_on_sigkill ]; then
				echo "1" >/proc/sys/vm/reap_mem_on_sigkill
			fi
		else
			adj_series=$(cat /sys/module/lowmemorykiller/parameters/adj)
			adj_1="${adj_series#*,}"
			set_almk_ppr_adj="${adj_1%%,*}"
			set_almk_ppr_adj=$(((set_almk_ppr_adj * 6) + 6))
			echo "$set_almk_ppr_adj" >/sys/module/lowmemorykiller/parameters/adj_max_shift
			if [ "$arch_type" == "aarch64" ]; then
				minfree_series=$(cat /sys/module/lowmemorykiller/parameters/minfree)
				minfree_1="${minfree_series#*,}"
				minfree_2="${minfree_1#*,}"
				minfree_3="${minfree_2#*,}"
				minfree_4="${minfree_3#*,}"
				rem_minfree_4="${minfree_4%%,*}"
				minfree_5="${minfree_4#*,}"
				vmpres_file_min=$((minfree_5 + (minfree_5 - rem_minfree_4)))
				echo "$vmpres_file_min" >/sys/module/lowmemorykiller/parameters/vmpressure_file_min
			else
				if [ "$ProductName" == "msm8909" ]; then
					disable_core_ctl
					echo "1" >/sys/module/lowmemorykiller/parameters/enable_lmk
				fi
				echo "15360,19200,23040,26880,34415,43737" >/sys/module/lowmemorykiller/parameters/minfree
				echo "53059" >/sys/module/lowmemorykiller/parameters/vmpressure_file_min
			fi
			echo "1" >/sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
			if [ -f /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
				echo "1" >/sys/module/lowmemorykiller/parameters/oom_reaper
			fi
			if [[ $ProductName != "bengal"* ]]; then
				if [ -f /sys/devices/soc0/soc_id ]; then
					soc_id=$(cat /sys/devices/soc0/soc_id)
				else
					soc_id=$(cat /sys/devices/system/soc/soc0/id)
				fi
				case "$soc_id" in
				"321" | "341" | "292" | "319" | "246" | "291" | "305" | "312") ;;
				*)
					echo "$set_almk_ppr_adj" >/sys/module/process_reclaim/parameters/min_score_adj
					echo "1" >/sys/module/process_reclaim/parameters/enable_process_reclaim
					echo "50" >/sys/module/process_reclaim/parameters/pressure_min
					echo "70" >/sys/module/process_reclaim/parameters/pressure_max
					echo "30" >/sys/module/process_reclaim/parameters/swap_opt_eff
					echo "512" >/sys/module/process_reclaim/parameters/per_swap_size
					;;
				esac
			fi
		fi
		if [[ $ProductName == "bengal"* ]]; then
			echo "1" >/sys/module/process_reclaim/parameters/enable_process_reclaim
			echo "50" >/sys/module/process_reclaim/parameters/pressure_min
			echo "70" >/sys/module/process_reclaim/parameters/pressure_max
			echo "30" >/sys/module/process_reclaim/parameters/swap_opt_eff
			echo "0" >/sys/module/process_reclaim/parameters/per_swap_size
			echo "7680" >/sys/module/process_reclaim/parameters/tsk_nomap_swap_sz
		fi
		echo "0" >/sys/module/vmpressure/parameters/allocstall_threshold
		echo "100" >/proc/sys/vm/swappiness
		echo "1" >/proc/sys/vm/watermark_scale_factor
		configure_read_ahead_kb_values
	fi
}
function enable_memory_features() {
	MemTotalStr=$(grep MemTotal /proc/meminfo)
	MemTotal=${MemTotalStr:16:8}
	if [ "$MemTotal" -le 2097152 ]; then
		setprop ro.vendor.qti.sys.fw.bservice_enable true
		setprop ro.vendor.qti.sys.fw.bservice_limit 5
		setprop ro.vendor.qti.sys.fw.bservice_age 5000
		setprop ro.vendor.qti.am.reschedule_service true
	fi
}
function start_hbtp() {
	bootmode=$(getprop ro.bootmode)
	if [ "charger" != "$bootmode" ]; then
		start vendor.hbtp
	fi
}
case "$target" in
"msm7201a_ffa" | "msm7201a_surf" | "msm7627_ffa" | "msm7627_6x" | "msm7627a" | "msm7627_surf" | \
	"qsd8250_surf" | "qsd8250_ffa" | "msm7630_surf" | "msm7630_1x" | "msm7630_fusion" | "qsd8650a_st1x")
	echo "90" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold
	;;
esac
case "$target" in
"msm7201a_ffa" | "msm7201a_surf")
	echo "500000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	;;
esac
case "$target" in
"msm7630_surf" | "msm7630_1x" | "msm7630_fusion")
	echo "75000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	echo "1" >/sys/module/pm2/parameters/idle_sleep_mode
	;;
esac
case "$target" in
"msm8660")
	echo "1" >/sys/module/rpm_resources/enable_low_power/L2_cache
	echo "1" >/sys/module/rpm_resources/enable_low_power/pxo
	echo "2" >/sys/module/rpm_resources/enable_low_power/vdd_dig
	echo "2" >/sys/module/rpm_resources/enable_low_power/vdd_mem
	echo "1" >/sys/module/rpm_resources/enable_low_power/rpm_cpu
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "50000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	echo "90" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold
	echo "1" >/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
	echo "4" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	chown -h system /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	chown -h root.system /sys/devices/system/cpu/mfreq
	chmod -h 220 /sys/devices/system/cpu/mfreq
	chown -h root.system /sys/devices/system/cpu/cpu1/online
	chmod -h 664 /sys/devices/system/cpu/cpu1/online
	;;
esac
case "$target" in
"msm8960")
	echo "1" >/sys/module/rpm_resources/enable_low_power/L2_cache
	echo "1" >/sys/module/rpm_resources/enable_low_power/pxo
	echo "1" >/sys/module/rpm_resources/enable_low_power/vdd_dig
	echo "1" >/sys/module/rpm_resources/enable_low_power/vdd_mem
	echo "1" >/sys/module/msm_pm/modes/cpu0/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	echo "50000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	echo "90" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold
	echo "1" >/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
	echo "4" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
	echo "10" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential
	echo "70" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
	echo "3" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
	echo "918000" >/sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
	echo "1026000" >/sys/devices/system/cpu/cpufreq/ondemand/sync_freq
	echo "80" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
	chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
	chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	chown -h system /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	chown -h system /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	chown -h system /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	chown -h root.system /sys/devices/system/cpu/mfreq
	chmod -h 220 /sys/devices/system/cpu/mfreq
	chown -h root.system /sys/devices/system/cpu/cpu1/online
	chown -h root.system /sys/devices/system/cpu/cpu2/online
	chown -h root.system /sys/devices/system/cpu/cpu3/online
	chmod -h 664 /sys/devices/system/cpu/cpu1/online
	chmod -h 664 /sys/devices/system/cpu/cpu2/online
	chmod -h 664 /sys/devices/system/cpu/cpu3/online
	echo "40000" >/sys/module/msm_dcvs/cores/cpu0/slack_time_max_us
	echo "40000" >/sys/module/msm_dcvs/cores/cpu0/slack_time_min_us
	echo "100000" >/sys/module/msm_dcvs/cores/cpu0/em_win_size_min_us
	echo "500000" >/sys/module/msm_dcvs/cores/cpu0/em_win_size_max_us
	echo "0" >/sys/module/msm_dcvs/cores/cpu0/slack_mode_dynamic
	echo "1000000" >/sys/module/msm_dcvs/cores/cpu0/disable_pc_threshold
	echo "25000" >/sys/module/msm_dcvs/cores/cpu1/slack_time_max_us
	echo "25000" >/sys/module/msm_dcvs/cores/cpu1/slack_time_min_us
	echo "100000" >/sys/module/msm_dcvs/cores/cpu1/em_win_size_min_us
	echo "500000" >/sys/module/msm_dcvs/cores/cpu1/em_win_size_max_us
	echo "0" >/sys/module/msm_dcvs/cores/cpu1/slack_mode_dynamic
	echo "1000000" >/sys/module/msm_dcvs/cores/cpu1/disable_pc_threshold
	echo "25000" >/sys/module/msm_dcvs/cores/cpu2/slack_time_max_us
	echo "25000" >/sys/module/msm_dcvs/cores/cpu2/slack_time_min_us
	echo "100000" >/sys/module/msm_dcvs/cores/cpu2/em_win_size_min_us
	echo "500000" >/sys/module/msm_dcvs/cores/cpu2/em_win_size_max_us
	echo "0" >/sys/module/msm_dcvs/cores/cpu2/slack_mode_dynamic
	echo "1000000" >/sys/module/msm_dcvs/cores/cpu2/disable_pc_threshold
	echo "25000" >/sys/module/msm_dcvs/cores/cpu3/slack_time_max_us
	echo "25000" >/sys/module/msm_dcvs/cores/cpu3/slack_time_min_us
	echo "100000" >/sys/module/msm_dcvs/cores/cpu3/em_win_size_min_us
	echo "500000" >/sys/module/msm_dcvs/cores/cpu3/em_win_size_max_us
	echo "0" >/sys/module/msm_dcvs/cores/cpu3/slack_mode_dynamic
	echo "1000000" >/sys/module/msm_dcvs/cores/cpu3/disable_pc_threshold
	echo "20000" >/sys/module/msm_dcvs/cores/gpu0/slack_time_max_us
	echo "20000" >/sys/module/msm_dcvs/cores/gpu0/slack_time_min_us
	echo "0" >/sys/module/msm_dcvs/cores/gpu0/slack_mode_dynamic
	echo "45000" >/sys/module/msm_mpdecision/slack_time_max_us
	echo "15000" >/sys/module/msm_mpdecision/slack_time_min_us
	echo "100000" >/sys/module/msm_mpdecision/em_win_size_min_us
	echo "1000000" >/sys/module/msm_mpdecision/em_win_size_max_us
	echo "3" >/sys/module/msm_mpdecision/online_util_pct_min
	echo "25" >/sys/module/msm_mpdecision/online_util_pct_max
	echo "97" >/sys/module/msm_mpdecision/em_max_util_pct
	echo "2" >/sys/module/msm_mpdecision/rq_avg_poll_ms
	echo "10" >/sys/module/msm_mpdecision/mp_em_rounding_point_min
	echo "85" >/sys/module/msm_mpdecision/mp_em_rounding_point_max
	echo "50" >/sys/module/msm_mpdecision/iowait_threshold_pct
	chown -h system /sys/module/msm_dcvs/cores/cpu0/slack_time_max_us
	chown -h system /sys/module/msm_dcvs/cores/cpu0/slack_time_min_us
	chown -h system /sys/module/msm_mpdecision/slack_time_max_us
	chown -h system /sys/module/msm_mpdecision/slack_time_min_us
	chmod -h 664 /sys/module/msm_dcvs/cores/cpu0/slack_time_max_us
	chmod -h 664 /sys/module/msm_dcvs/cores/cpu0/slack_time_min_us
	chmod -h 664 /sys/module/msm_mpdecision/slack_time_max_us
	chmod -h 664 /sys/module/msm_mpdecision/slack_time_min_us
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"130")
		echo "230" >/sys/class/gpio/export
		echo "228" >/sys/class/gpio/export
		echo "229" >/sys/class/gpio/export
		echo "in" >/sys/class/gpio/gpio230/direction
		echo "rising" >/sys/class/gpio/gpio230/edge
		echo "in" >/sys/class/gpio/gpio228/direction
		echo "rising" >/sys/class/gpio/gpio228/edge
		echo "in" >/sys/class/gpio/gpio229/direction
		echo "rising" >/sys/class/gpio/gpio229/edge
		echo "253" >/sys/class/gpio/export
		echo "254" >/sys/class/gpio/export
		echo "257" >/sys/class/gpio/export
		echo "258" >/sys/class/gpio/export
		echo "259" >/sys/class/gpio/export
		echo "out" >/sys/class/gpio/gpio253/direction
		echo "out" >/sys/class/gpio/gpio254/direction
		echo "out" >/sys/class/gpio/gpio257/direction
		echo "out" >/sys/class/gpio/gpio258/direction
		echo "out" >/sys/class/gpio/gpio259/direction
		chown -h media /sys/class/gpio/gpio253/value
		chown -h media /sys/class/gpio/gpio254/value
		chown -h media /sys/class/gpio/gpio257/value
		chown -h media /sys/class/gpio/gpio258/value
		chown -h media /sys/class/gpio/gpio259/value
		chown -h media /sys/class/gpio/gpio253/direction
		chown -h media /sys/class/gpio/gpio254/direction
		chown -h media /sys/class/gpio/gpio257/direction
		chown -h media /sys/class/gpio/gpio258/direction
		chown -h media /sys/class/gpio/gpio259/direction
		echo "0" >/sys/module/rpm_resources/enable_low_power/vdd_dig
		echo "0" >/sys/module/rpm_resources/enable_low_power/vdd_mem
		;;
	esac
	;;
esac
case "$target" in
"msm8974")
	echo "4" >/sys/module/lpm_levels/enable_low_power/l2
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/retention/idle_enabled
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"208" | "211" | "214" | "217" | "209" | "212" | "215" | "218" | "194" | "210" | "213" | "216")
		for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor; do
			echo "cpubw_hwmon" >"$devfreq_gov"
		done
		echo "20000 1400000:40000 1700000:20000" >/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
		echo "90" >/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
		echo "1190400" >/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
		echo "1" >/sys/devices/system/cpu/cpufreq/interactive/io_is_busy
		echo "85 1500000:90 1800000:70" >/sys/devices/system/cpu/cpufreq/interactive/target_loads
		echo "40000" >/sys/devices/system/cpu/cpufreq/interactive/min_sample_time
		echo "20" >/sys/module/cpu_boost/parameters/boost_ms
		echo "1728000" >/sys/module/cpu_boost/parameters/sync_threshold
		echo "100000" >/sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
		echo "1497600" >/sys/module/cpu_boost/parameters/input_boost_freq
		echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
		;;
	*)
		echo "50000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
		echo "90" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold
		echo "1" >/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
		echo "2" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
		echo "10" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential
		echo "70" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
		echo "3" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
		echo "960000" >/sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
		echo "960000" >/sys/devices/system/cpu/cpufreq/ondemand/sync_freq
		echo "1190400" >/sys/devices/system/cpu/cpufreq/ondemand/input_boost
		echo "80" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
		;;
	esac
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	chown -h root.system /sys/devices/system/cpu/mfreq
	chmod -h 220 /sys/devices/system/cpu/mfreq
	chown -h root.system /sys/devices/system/cpu/cpu1/online
	chown -h root.system /sys/devices/system/cpu/cpu2/online
	chown -h root.system /sys/devices/system/cpu/cpu3/online
	chmod -h 664 /sys/devices/system/cpu/cpu1/online
	chmod -h 664 /sys/devices/system/cpu/cpu2/online
	chmod -h 664 /sys/devices/system/cpu/cpu3/online
	echo "1" >/dev/cpuctl/apps/cpu.notify_on_migrate
	;;
esac
case "$target" in
"msm8916")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"206")
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "2" >/sys/class/net/rmnet0/queues/rx-0/rps_cpus
		;;
	"247" | "248" | "249" | "250")
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		;;
	"239" | "241" | "263")
		if [ -f /sys/devices/soc0/revision ]; then
			revision=$(cat /sys/devices/soc0/revision)
		else
			revision=$(cat /sys/devices/system/soc/soc0/revision)
		fi
		echo "10" >/sys/class/net/rmnet0/queues/rx-0/rps_cpus
		if [ -f /sys/devices/soc0/platform_subtype_id ]; then
			platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
		fi
		if [ -f /sys/devices/soc0/hw_platform ]; then
			hw_platform=$(cat /sys/devices/soc0/hw_platform)
		fi
		case "$soc_id" in
		"239")
			case "$hw_platform" in
			"Surf")
				case "$platform_subtype_id" in
				"1" | "2")
					start_hbtp
					;;
				esac
				;;
			"MTP")
				case "$platform_subtype_id" in
				"3")
					start_hbtp
					;;
				esac
				;;
			esac
			;;
		esac
		;;
	"268" | "269" | "270" | "271")
		echo "10" >/sys/class/net/rmnet0/queues/rx-0/rps_cpus
		;;
	"233" | "240" | "242")
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		;;
	esac
	;;
esac
case "$target" in
"msm8226")
	echo "4" >/sys/module/lpm_levels/enable_low_power/l2
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	echo "50000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	echo "90" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold
	echo "1" >/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
	echo "2" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
	echo "10" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential
	echo "70" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
	echo "10" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
	echo "787200" >/sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
	echo "300000" >/sys/devices/system/cpu/cpufreq/ondemand/sync_freq
	echo "80" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	chown -h root.system /sys/devices/system/cpu/cpu1/online
	chown -h root.system /sys/devices/system/cpu/cpu2/online
	chown -h root.system /sys/devices/system/cpu/cpu3/online
	chmod -h 664 /sys/devices/system/cpu/cpu1/online
	chmod -h 664 /sys/devices/system/cpu/cpu2/online
	chmod -h 664 /sys/devices/system/cpu/cpu3/online
	;;
esac
case "$target" in
"msm8610")
	echo "4" >/sys/module/lpm_levels/enable_low_power/l2
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	echo "50000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	echo "90" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold
	echo "1" >/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
	echo "2" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
	echo "10" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential
	echo "70" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
	echo "10" >/sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
	echo "787200" >/sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
	echo "300000" >/sys/devices/system/cpu/cpufreq/ondemand/sync_freq
	echo "80" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
	echo "1" >/sys/kernel/mm/ksm/deferred_timer
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	chown -h root.system /sys/devices/system/cpu/cpu1/online
	chown -h root.system /sys/devices/system/cpu/cpu2/online
	chown -h root.system /sys/devices/system/cpu/cpu3/online
	chmod -h 664 /sys/devices/system/cpu/cpu1/online
	chmod -h 664 /sys/devices/system/cpu/cpu2/online
	chmod -h 664 /sys/devices/system/cpu/cpu3/online
	;;
esac
case "$target" in
"msm8916")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	echo "3" >/proc/sys/kernel/sched_window_stats_policy
	echo "3" >/proc/sys/kernel/sched_ravg_hist_size
	case "$soc_id" in
	"206" | "247" | "248" | "249" | "250")
		echo "3" >/proc/sys/kernel/sched_ravg_hist_size
		echo "20" >/proc/sys/kernel/sched_small_task
		echo "30" >/proc/sys/kernel/sched_mostly_idle_load
		echo "3" >/proc/sys/kernel/sched_mostly_idle_nr_run
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		echo "1" >/sys/devices/system/cpu/cpu0/online
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		echo "25000 1094400:50000" >/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
		echo "90" >/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
		echo "30000" >/sys/devices/system/cpu/cpufreq/interactive/timer_rate
		echo "998400" >/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/interactive/io_is_busy
		echo "1 800000:85 998400:90 1094400:80" >/sys/devices/system/cpu/cpufreq/interactive/target_loads
		echo "50000" >/sys/devices/system/cpu/cpufreq/interactive/min_sample_time
		echo "50000" >/sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		;;
	esac
	case "$soc_id" in
	"233" | "240" | "242")
		echo "3" >/proc/sys/kernel/sched_ravg_hist_size
		echo "50" >/proc/sys/kernel/sched_small_task
		echo "50" >/proc/sys/kernel/sched_mostly_idle_load
		echo "10" >/proc/sys/kernel/sched_mostly_idle_nr_run
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		echo "1" >/sys/devices/system/cpu/cpu0/online
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		echo "25000 1113600:50000" >/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
		echo "90" >/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
		echo "30000" >/sys/devices/system/cpu/cpufreq/interactive/timer_rate
		echo "960000" >/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/interactive/io_is_busy
		echo "1 800000:85 1113600:90 1267200:80" >/sys/devices/system/cpu/cpufreq/interactive/target_loads
		echo "50000" >/sys/devices/system/cpu/cpufreq/interactive/min_sample_time
		echo "50000" >/sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent; do
			echo "40" >"$gpu_bimc_io_percent"
		done
		;;
	esac
	case "$soc_id" in
	"239" | "241" | "263" | "268" | "269" | "270" | "271")
		if [ "$(cat /sys/devices/soc0/revision)" != "3.0" ]; then
			echo "5" >/proc/sys/kernel/sched_ravg_hist_size
			echo "20" >/proc/sys/kernel/sched_small_task
			for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor; do
				echo "cpufreq" >"$devfreq_gov"
			done
			for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor; do
				echo "bw_hwmon" >"$devfreq_gov"
				for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent; do
					echo "20" >"$cpu_io_percent"
				done
			done
			for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent; do
				echo "40" >"$gpu_bimc_io_percent"
			done
			echo "0" >/sys/module/msm_thermal/core_control/enabled
			echo "1" >/sys/devices/system/cpu/cpu0/online
			echo "20000 1113600:50000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
			echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
			echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
			echo "1113600" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
			echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
			echo "1 960000:85 1113600:90 1344000:80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
			echo "50000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
			echo "50000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor
			echo "1" >/sys/devices/system/cpu/cpu4/online
			echo "25000 800000:50000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
			echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
			echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
			echo "998400" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
			echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
			echo "1 800000:90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
			echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
			echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
			echo "1" >/sys/module/msm_thermal/core_control/enabled
			echo "1" >/sys/devices/system/cpu/cpu1/online
			echo "1" >/sys/devices/system/cpu/cpu2/online
			echo "1" >/sys/devices/system/cpu/cpu3/online
			echo "1" >/sys/devices/system/cpu/cpu4/online
			echo "1" >/sys/devices/system/cpu/cpu5/online
			echo "1" >/sys/devices/system/cpu/cpu6/online
			echo "1" >/sys/devices/system/cpu/cpu7/online
			echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
			echo "75" >/proc/sys/kernel/sched_upmigrate
			echo "60" >/proc/sys/kernel/sched_downmigrate
			echo "30" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_load
			echo "30" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_load
			echo "30" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_load
			echo "30" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_load
			echo "30" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_load
			echo "30" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_load
			echo "30" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_load
			echo "30" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_load
			echo "3" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
			echo "3" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
			echo "3" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
			echo "3" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
			echo "3" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
			echo "3" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
			echo "3" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
			echo "3" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run
		else
			echo "3" >/proc/sys/kernel/sched_window_stats_policy
			echo "3" >/proc/sys/kernel/sched_ravg_hist_size
			echo "20000000" >/proc/sys/kernel/sched_ravg_window
			echo "20" >/proc/sys/kernel/sched_small_task
			echo "30" >/proc/sys/kernel/sched_mostly_idle_load
			echo "3" >/proc/sys/kernel/sched_mostly_idle_nr_run
			echo "0" >/sys/devices/system/cpu/cpu0/sched_prefer_idle
			echo "0" >/sys/devices/system/cpu/cpu1/sched_prefer_idle
			echo "0" >/sys/devices/system/cpu/cpu2/sched_prefer_idle
			echo "0" >/sys/devices/system/cpu/cpu3/sched_prefer_idle
			echo "0" >/sys/devices/system/cpu/cpu4/sched_prefer_idle
			echo "0" >/sys/devices/system/cpu/cpu5/sched_prefer_idle
			echo "0" >/sys/devices/system/cpu/cpu6/sched_prefer_idle
			echo "0" >/sys/devices/system/cpu/cpu7/sched_prefer_idle
			for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor; do
				echo "cpufreq" >"$devfreq_gov"
			done
			for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor; do
				echo "bw_hwmon" >"$devfreq_gov"
				for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent; do
					echo "20" >"$cpu_io_percent"
				done
			done
			for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent; do
				echo "40" >"$gpu_bimc_io_percent"
			done
			echo "0" >/sys/module/msm_thermal/core_control/enabled
			echo "1" >/sys/devices/system/cpu/cpu0/online
			echo "19000 1113600:39000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
			echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
			echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
			echo "1113600" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
			echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
			echo "1 960000:85 1113600:90 1344000:80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
			echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
			echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor
			echo "1" >/sys/devices/system/cpu/cpu4/online
			echo "39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
			echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
			echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
			echo "800000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
			echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
			echo "1 800000:90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
			echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
			echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
			echo "1" >/sys/module/msm_thermal/core_control/enabled
			echo "1" >/sys/devices/system/cpu/cpu1/online
			echo "1" >/sys/devices/system/cpu/cpu2/online
			echo "1" >/sys/devices/system/cpu/cpu3/online
			echo "1" >/sys/devices/system/cpu/cpu5/online
			echo "1" >/sys/devices/system/cpu/cpu6/online
			echo "1" >/sys/devices/system/cpu/cpu7/online
			echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
			echo "93" >/proc/sys/kernel/sched_upmigrate
			echo "83" >/proc/sys/kernel/sched_downmigrate
			echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
			echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
			echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
			echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
			echo "50000" >/proc/sys/kernel/sched_freq_inc_notify
			echo "50000" >/proc/sys/kernel/sched_freq_dec_notify
			echo "2" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
			echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/max_cpus
			echo "68" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
			echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
			echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
			case "$revision" in
			"3.0")
				echo "1" >/sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
				;;
			esac
		fi
		;;
	esac
	configure_memory_parameters
	;;
esac
case "$target" in
"msm8952")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"264" | "289")
		echo "3" >/proc/sys/kernel/sched_window_stats_policy
		echo "3" >/proc/sys/kernel/sched_ravg_hist_size
		echo "20000000" >/proc/sys/kernel/sched_ravg_window
		echo "20" >/proc/sys/kernel/sched_small_task
		echo "30" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_load
		echo "30" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_load
		echo "30" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_load
		echo "30" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_load
		echo "30" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_load
		echo "30" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_load
		echo "30" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_load
		echo "30" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_load
		echo "3" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run
		echo "0" >/sys/devices/system/cpu/cpu0/sched_prefer_idle
		echo "0" >/sys/devices/system/cpu/cpu1/sched_prefer_idle
		echo "0" >/sys/devices/system/cpu/cpu2/sched_prefer_idle
		echo "0" >/sys/devices/system/cpu/cpu3/sched_prefer_idle
		echo "0" >/sys/devices/system/cpu/cpu4/sched_prefer_idle
		echo "0" >/sys/devices/system/cpu/cpu5/sched_prefer_idle
		echo "0" >/sys/devices/system/cpu/cpu6/sched_prefer_idle
		echo "0" >/sys/devices/system/cpu/cpu7/sched_prefer_idle
		echo "0" >/proc/sys/kernel/sched_boost
		for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor; do
			echo "cpufreq" >"$devfreq_gov"
		done
		for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor; do
			echo "bw_hwmon" >"$devfreq_gov"
			for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent; do
				echo "20" >"$cpu_io_percent"
			done
			for cpu_guard_band in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/guard_band_mbps; do
				echo "30" >"$cpu_guard_band"
			done
		done
		for gpu_bimc_io_percent in /sys/class/devfreq/qcom,gpubw*/bw_hwmon/io_percent; do
			echo "40" >"$gpu_bimc_io_percent"
		done
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			bcl_hotplug_mask=$(cat "$hotplug_mask")
			echo "0" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			bcl_soc_hotplug_mask=$(cat "$hotplug_soc_mask")
			echo "0" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "1" >/sys/devices/system/cpu/cpu0/online
		echo "19000 1113600:39000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
		echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
		echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
		echo "1113600" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
		echo "1 960000:85 1113600:90 1344000:80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
		echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
		echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
		echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
		echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
		echo "806400" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
		echo "1 806400:90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
		echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
		echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "1" >/sys/devices/system/cpu/cpu5/online
		echo "1" >/sys/devices/system/cpu/cpu6/online
		echo "1" >/sys/devices/system/cpu/cpu7/online
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "93" >/proc/sys/kernel/sched_upmigrate
		echo "83" >/proc/sys/kernel/sched_downmigrate
		echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
		echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
		echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
		echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
		echo "50000" >/proc/sys/kernel/sched_freq_inc_notify
		echo "50000" >/proc/sys/kernel/sched_freq_dec_notify
		echo "2" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		echo "68" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "1" >/sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			echo "$bcl_hotplug_mask" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			echo "$bcl_soc_hotplug_mask" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "1" >/sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
		echo "1" >/proc/sys/kernel/power_aware_timer_migration
		configure_memory_parameters
		;;
	*)
		panel=$(cat /sys/class/graphics/fb0/modes)
		if [ "${panel:5:1}" == "x" ]; then
			panel=${panel:2:3}
		else
			panel=${panel:2:4}
		fi
		echo "95" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_downmigrate
		echo "2" >/proc/sys/kernel/sched_window_stats_policy
		echo "5" >/proc/sys/kernel/sched_ravg_hist_size
		echo "3" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
		echo "3" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run
		for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor; do
			echo "cpufreq" >"$devfreq_gov"
		done
		for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor; do
			echo "bw_hwmon" >"$devfreq_gov"
			for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent; do
				echo "20" >"$cpu_io_percent"
			done
			for cpu_guard_band in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/guard_band_mbps; do
				echo "30" >"$cpu_guard_band"
			done
		done
		for gpu_bimc_io_percent in /sys/class/devfreq/qcom,gpubw*/bw_hwmon/io_percent; do
			echo "40" >"$gpu_bimc_io_percent"
		done
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			bcl_hotplug_mask=$(cat "$hotplug_mask")
			echo "0" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			bcl_soc_hotplug_mask=$(cat "$hotplug_soc_mask")
			echo "0" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "1" >/sys/devices/system/cpu/cpu0/online
		echo "80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
		echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
		echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
		echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
		echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
		echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
		echo "60000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
		if [ "$panel" -gt 1080 ]; then
			setprop ro.hwui.texture_cache_size 72
		fi
		echo "59000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
		echo "1305600" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
		echo "1 691200:80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
		echo "1382400" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
		echo "19000 1382400:39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
		echo "85 1382400:90 1747200:80" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
		echo "30" >/proc/sys/kernel/sched_small_task
		echo "20" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_load
		echo "20" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_load
		echo "20" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_load
		echo "20" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_load
		echo "20" >/sys/devices/system/cpu/cpu4/sched_mostly_idle_load
		echo "20" >/sys/devices/system/cpu/cpu5/sched_mostly_idle_load
		echo "20" >/sys/devices/system/cpu/cpu6/sched_mostly_idle_load
		echo "20" >/sys/devices/system/cpu/cpu7/sched_mostly_idle_load
		echo "0" >/proc/sys/kernel/sched_boost
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "1" >/sys/devices/system/cpu/cpu5/online
		echo "1" >/sys/devices/system/cpu/cpu6/online
		echo "1" >/sys/devices/system/cpu/cpu7/online
		ProductName=$(getprop ro.product.name)
		if [ "$ProductName" == "msm8952_32" ] || [ "$ProductName" == "msm8952_32_LMT" ]; then
			echo "N" >/sys/module/lpm_levels/system/a72/cpu4/retention/idle_enabled
			echo "N" >/sys/module/lpm_levels/system/a72/cpu5/retention/idle_enabled
			echo "N" >/sys/module/lpm_levels/system/a72/cpu6/retention/idle_enabled
			echo "N" >/sys/module/lpm_levels/system/a72/cpu7/retention/idle_enabled
		fi
		if [ "$(cat /sys/devices/soc0/revision)" == "1.0" ]; then
			echo "N" >/sys/module/lpm_levels/system/a53/a53-l2-gdhs/idle_enabled
			echo "N" >/sys/module/lpm_levels/system/a72/a72-l2-gdhs/idle_enabled
			echo "N" >/sys/module/lpm_levels/system/a53/a53-l2-pc/idle_enabled
			echo "N" >/sys/module/lpm_levels/system/a72/a72-l2-pc/idle_enabled
		fi
		echo "1" >/sys/module/lpm_levels/parameters/lpm_prediction
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "N" >/sys/module/lpm_levels/system/a53/a53-l2-gdhs/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/a72/a72-l2-gdhs/idle_enabled
		echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
		echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
		echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
		echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
		echo "50000" >/proc/sys/kernel/sched_freq_inc_notify
		echo "50000" >/proc/sys/kernel/sched_freq_dec_notify
		echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo "4" >/sys/devices/system/cpu/cpu4/core_ctl/max_cpus
		echo "68" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
		echo "1" >/sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			echo "$bcl_hotplug_mask" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			echo "$bcl_soc_hotplug_mask" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "1" >/proc/sys/kernel/power_aware_timer_migration
		case "$soc_id" in
		"277" | "278")
			start energy-awareness
			;;
		esac
		echo "130" >/proc/sys/kernel/sched_grp_upmigrate
		echo "110" >/proc/sys/kernel/sched_grp_downmigrate
		echo " 1" >/proc/sys/kernel/sched_enable_thread_grouping
		configure_memory_parameters
		;;
	esac
	enable_memory_features
	restorecon -R /sys/devices/system/cpu
	;;
esac
case "$target" in
"msm8953")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
	fi
	echo "0" >/proc/sys/kernel/sched_boost
	case "$soc_id" in
	"293" | "304" | "338" | "351")
		case "$hw_platform" in
		"MTP" | "Surf" | "RCM")
			dir="/sys/bus/i2c/devices/3-0038"
			if [ ! -d "$dir" ]; then
				start_hbtp
			fi
			;;
		esac
		if [ "$soc_id" -eq "338" ]; then
			case "$hw_platform" in
			"QRD")
				if [ "$platform_subtype_id" -eq "1" ]; then
					start_hbtp
				fi
				;;
			esac
		fi
		echo "15" >/proc/sys/kernel/sched_init_task_load
		for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor; do
			echo "cpufreq" >"$devfreq_gov"
		done
		for devfreq_gov in /sys/class/devfreq/soc:qcom,cpubw/governor; do
			echo "bw_hwmon" >$devfreq_gov
			for cpu_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent; do
				echo "34" >$cpu_io_percent
			done
			for cpu_guard_band in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps; do
				echo "0" >$cpu_guard_band
			done
			for cpu_hist_memory in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hist_memory; do
				echo "20" >$cpu_hist_memory
			done
			for cpu_hyst_length in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hyst_length; do
				echo "10" >$cpu_hyst_length
			done
			for cpu_idle_mbps in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/idle_mbps; do
				echo "1600" >$cpu_idle_mbps
			done
			for cpu_low_power_delay in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_delay; do
				echo "20" >$cpu_low_power_delay
			done
			for cpu_low_power_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_io_percent; do
				echo "34" >$cpu_low_power_io_percent
			done
			for cpu_mbps_zones in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/mbps_zones; do
				echo "1611 3221 5859 6445 7104" >$cpu_mbps_zones
			done
			for cpu_sample_ms in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/sample_ms; do
				echo "4" >$cpu_sample_ms
			done
			for cpu_up_scale in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/up_scale; do
				echo "250" >$cpu_up_scale
			done
			for cpu_min_freq in /sys/class/devfreq/soc:qcom,cpubw/min_freq; do
				echo "1611" >$cpu_min_freq
			done
		done
		for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent; do
			echo "40" >$gpu_bimc_io_percent
		done
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			bcl_hotplug_mask=$(cat "$hotplug_mask")
			echo "0" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			bcl_soc_hotplug_mask=$(cat "$hotplug_soc_mask")
			echo "0" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -ge 9 ]; then
			8953_sched_dcvs_eas
		else
			8953_sched_dcvs_hmp
		fi
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "1" >/sys/devices/system/cpu/cpu5/online
		echo "1" >/sys/devices/system/cpu/cpu6/online
		echo "1" >/sys/devices/system/cpu/cpu7/online
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			echo "$bcl_hotplug_mask" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			echo "$bcl_soc_hotplug_mask" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "85" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_downmigrate
		configure_memory_parameters
		;;
	esac
	case "$soc_id" in
	"349" | "350")
		case "$hw_platform" in
		"MTP" | "Surf" | "RCM" | "QRD")
			start_hbtp
			;;
		esac
		for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor; do
			echo "cpufreq" >"$devfreq_gov"
		done
		for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "50" >"$cpubw"/polling_interval
			echo "1611 3221 5859 6445 7104" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "34" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "80" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/hyst_length
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
		done
		for DCC_PATH in /sys/bus/platform/devices/*.dcc*; do
			echo "0" >"$DCC_PATH"/enable
			echo "cap" >"$DCC_PATH"/func_type
			echo "sram" >"$DCC_PATH"/data_sink
			echo "1" >"$DCC_PATH"/config_reset
			echo "0xb1d2c18 1" >"$DCC_PATH"/config
			echo "0xb1d2900 1" >"$DCC_PATH"/config
			echo "0xb1112b0 1" >"$DCC_PATH"/config
			echo "0xb018798 1" >"$DCC_PATH"/config
			echo "1" >"$DCC_PATH"/enable
		done
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			bcl_hotplug_mask=$(cat "$hotplug_mask")
			echo "0" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			bcl_soc_hotplug_mask=$(cat "$hotplug_soc_mask")
			echo "0" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "1" >/sys/devices/system/cpu/cpu0/online
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1363200" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
		echo "-6" >/sys/devices/system/cpu/cpu0/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu1/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu2/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu3/sched_load_boost
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
		echo "1401600" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
		echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
		echo "-6" >/sys/devices/system/cpu/cpu4/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu5/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "0-3" >/dev/cpuset/background/cpus
		echo "0-3" >/dev/cpuset/system-background/cpus
		echo "1" >/dev/stune/top-app/schedtune.prefer_idle
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			echo "$bcl_hotplug_mask" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			echo "$bcl_soc_hotplug_mask" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/enable
		echo "0" >/sys/devices/system/cpu/cpu4/core_ctl/enable
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "1" >/sys/devices/system/cpu/cpu5/online
		echo "1" >/sys/devices/system/cpu/cpu6/online
		echo "1" >/sys/devices/system/cpu/cpu7/online
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		configure_memory_parameters
		echo "76" >/proc/sys/kernel/sched_downmigrate
		echo "86" >/proc/sys/kernel/sched_upmigrate
		echo "80" >/proc/sys/kernel/sched_group_downmigrate
		echo "90" >/proc/sys/kernel/sched_group_upmigrate
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		if [ -f /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster ]; then
			echo "4-7" >/sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster
		fi
		echo "1" >/sys/module/big_cluster_min_freq_adjust/parameters/min_freq_adjust
		;;
	esac
	;;
esac
case "$target" in
"msm8937")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
	fi
	case "$soc_id" in
	"303" | "307" | "308" | "309" | "320" | "386" | "436")
		case "$hw_platform" in
		"MTP")
			start_hbtp
			;;
		esac
		case "$hw_platform" in
		"Surf" | "RCM")
			if [ "$platform_subtype_id" -ne "4" ]; then
				start_hbtp
			fi
			;;
		esac
		echo "20000000" >/proc/sys/kernel/sched_ravg_window
		echo "0" >/proc/sys/kernel/sched_boost
		disable_core_ctl
		for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor; do
			echo "cpufreq" >"$devfreq_gov"
		done
		for devfreq_gov in /sys/class/devfreq/soc:qcom,cpubw/governor; do
			echo "bw_hwmon" >$devfreq_gov
			for cpu_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent; do
				echo "20" >$cpu_io_percent
			done
			for cpu_guard_band in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps; do
				echo "30" >$cpu_guard_band
			done
		done
		for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent; do
			echo "40" >$gpu_bimc_io_percent
		done
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -ge 9 ]; then
			8917_sched_dcvs_eas
		else
			8917_sched_dcvs_hmp
		fi
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		echo "N" >/sys/module/lpm_levels/perf/perf-l2-gdhs/idle_enabled
		echo "N" >/sys/module/lpm_levels/perf/perf-l2-gdhs/suspend_enabled
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "2" >/sys/class/net/rmnet0/queues/rx-0/rps_cpus
		echo "1" >/sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
		echo "1" >/proc/sys/kernel/power_aware_timer_migration
		configure_memory_parameters
		;;
	*) ;;
	esac
	case "$soc_id" in
	"294" | "295" | "313")
		case "$hw_platform" in
		"MTP" | "Surf" | "RCM")
			start_hbtp
			;;
		esac
		echo "3" >/proc/sys/kernel/sched_window_stats_policy
		echo "3" >/proc/sys/kernel/sched_ravg_hist_size
		echo "20000000" >/proc/sys/kernel/sched_ravg_window
		echo "0" >/proc/sys/kernel/sched_boost
		for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor; do
			echo "cpufreq" >"$devfreq_gov"
		done
		for devfreq_gov in /sys/class/devfreq/soc:qcom,cpubw/governor; do
			echo "bw_hwmon" >$devfreq_gov
			for cpu_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent; do
				echo "20" >$cpu_io_percent
			done
			for cpu_guard_band in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps; do
				echo "30" >$cpu_guard_band
			done
		done
		for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent; do
			echo "40" >$gpu_bimc_io_percent
		done
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -ge 9 ]; then
			8937_sched_dcvs_eas
		else
			8937_sched_dcvs_hmp
		fi
		echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/suspend_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-gdhs/suspend_enabled
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "1" >/sys/devices/system/cpu/cpu5/online
		echo "1" >/sys/devices/system/cpu/cpu6/online
		echo "1" >/sys/devices/system/cpu/cpu7/online
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "93" >/proc/sys/kernel/sched_upmigrate
		echo "83" >/proc/sys/kernel/sched_downmigrate
		echo "2" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/max_cpus
		echo "68" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "1" >/sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		echo "1" >/sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
		echo "1" >/proc/sys/kernel/power_aware_timer_migration
		configure_memory_parameters
		;;
	*) ;;
	esac
	case "$soc_id" in
	"354" | "364" | "353" | "363")
		case "$hw_platform" in
		"MTP" | "Surf" | "RCM" | "QRD")
			start_hbtp
			;;
		esac
		for cpubw in /sys/class/devfreq/*qcom,mincpubw*; do
			echo "cpufreq" >"$cpubw"/governor
		done
		for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "20" >"$cpubw"/bw_hwmon/io_percent
			echo "30" >"$cpubw"/bw_hwmon/guard_band_mbps
		done
		for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent; do
			echo "40" >$gpu_bimc_io_percent
		done
		case "$soc_id" in
		"353" | "363")
			echo "1" >/sys/devices/system/cpu/cpu0/online
			echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
			echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
			echo "1497600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
			echo "80" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
			echo "-6" >/sys/devices/system/cpu/cpu0/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu1/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu2/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu3/sched_load_boost
			echo "1" >/sys/devices/system/cpu/cpu4/online
			echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
			echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
			echo "998400" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
			echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
			echo "-6" >/sys/devices/system/cpu/cpu4/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu5/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
			echo "93" >/proc/sys/kernel/sched_upmigrate
			echo "83" >/proc/sys/kernel/sched_downmigrate
			echo "140" >/proc/sys/kernel/sched_group_upmigrate
			echo "120" >/proc/sys/kernel/sched_group_downmigrate
			echo "1" >/sys/devices/system/cpu/cpu1/online
			echo "1" >/sys/devices/system/cpu/cpu2/online
			echo "1" >/sys/devices/system/cpu/cpu3/online
			echo "1" >/sys/devices/system/cpu/cpu4/online
			echo "1" >/sys/devices/system/cpu/cpu5/online
			echo "1" >/sys/devices/system/cpu/cpu6/online
			echo "1" >/sys/devices/system/cpu/cpu7/online
			echo "2" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
			echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/max_cpus
			echo "68" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
			echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
			echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
			echo "1" >/sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
			echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
			if [ -f /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster ]; then
				echo "0-3" >/sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster
			fi
			;;
		*)
			echo "1" >/sys/devices/system/cpu/cpu0/online
			echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
			echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
			echo "1305600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
			echo "80" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
			echo "-6" >/sys/devices/system/cpu/cpu0/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu1/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu2/sched_load_boost
			echo "-6" >/sys/devices/system/cpu/cpu3/sched_load_boost
			echo "1" >/sys/devices/system/cpu/cpu1/online
			echo "1" >/sys/devices/system/cpu/cpu2/online
			echo "1" >/sys/devices/system/cpu/cpu3/online
			;;
		esac
		configure_memory_parameters
		echo "0" >/proc/sys/kernel/sched_boost
		echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/suspend_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-gdhs/suspend_enabled
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		case "$soc_id" in
		"353" | "363")
			echo "1" >/sys/module/big_cluster_min_freq_adjust/parameters/min_freq_adjust
			;;
		esac
		;;
	esac
	case "$soc_id" in
	"386" | "436")
		case "$hw_platform" in
		"QRD")
			start_hbtp
			;;
		esac
		;;
	esac
	;;
esac
case "$target" in
"sdm660")
	echo "f" >/proc/irq/default_smp_affinity
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	panel=$(cat /sys/class/graphics/fb0/modes)
	if [ "${panel:5:1}" == "x" ]; then
		panel=${panel:2:3}
	else
		panel=${panel:2:4}
	fi
	if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -le 14 ]; then
		if [ "$panel" -gt 1080 ]; then
			echo "2" >/proc/sys/kernel/sched_window_stats_policy
			echo "5" >/proc/sys/kernel/sched_ravg_hist_size
		else
			echo "3" >/proc/sys/kernel/sched_window_stats_policy
			echo "3" >/proc/sys/kernel/sched_ravg_hist_size
		fi
	fi
	case "$soc_id" in
	"317" | "324" | "325" | "326" | "345" | "346")
		echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
		echo "30" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
		echo "1" >/sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
		echo "4" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
		echo "96" >/proc/sys/kernel/sched_upmigrate
		echo "90" >/proc/sys/kernel/sched_downmigrate
		echo "140" >/proc/sys/kernel/sched_group_upmigrate
		echo "120" >/proc/sys/kernel/sched_group_downmigrate
		echo "0-3" >/dev/cpuset/background/cpus
		echo "0-3" >/dev/cpuset/system-background/cpus
		if [ "$KernelVersionA" -ge 4 ] && [ "$KernelVersionB" -ge 14 ]; then
			sdm660_sched_schedutil_dcvs
		else
			sdm660_sched_interactive_dcvs
		fi
		configure_memory_parameters
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		start vendor.cdsprpcd
		case "$hw_platform" in
		"MTP" | "Surf" | "RCM" | "QRD")
			start_hbtp
			;;
		esac
		;;
	esac
	case "$soc_id" in
	"318" | "327" | "385")
		case "$hw_platform" in
		"MTP" | "Surf" | "RCM" | "QRD")
			start_hbtp
			;;
		esac
		echo "85" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_downmigrate
		echo "900" >/proc/sys/kernel/sched_group_upmigrate
		echo "900" >/proc/sys/kernel/sched_group_downmigrate
		echo "0" >/proc/sys/kernel/sched_select_prev_cpu_us
		echo "400000" >/proc/sys/kernel/sched_freq_inc_notify
		echo "400000" >/proc/sys/kernel/sched_freq_dec_notify
		echo "3" >/proc/sys/kernel/sched_spill_nr_run
		echo "15" >/proc/sys/kernel/sched_init_task_load
		echo "1" >/proc/sys/kernel/sched_restrict_cluster_spill
		echo "50000" >/proc/sys/kernel/sched_short_burst_ns
		echo "0-3" >/dev/cpuset/background/cpus
		echo "0-3" >/dev/cpuset/system-background/cpus
		echo "0" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			bcl_hotplug_mask=$(cat "$hotplug_mask")
			echo "0" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			bcl_soc_hotplug_mask=$(cat "$hotplug_soc_mask")
			echo "0" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		echo "1" >/sys/devices/system/cpu/cpu0/online
		echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
		echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
		echo "19000 1344000:39000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
		echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
		echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
		echo "1344000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
		echo "85 1344000:80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
		echo "39000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
		echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
		echo "19000 1094400:39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
		echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
		echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
		echo "1094400" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
		echo "85 1094400:80" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
		echo "39000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif
		echo "1" >/sys/devices/system/cpu/cpu0/online
		echo "1" >/sys/devices/system/cpu/cpu1/online
		echo "1" >/sys/devices/system/cpu/cpu2/online
		echo "1" >/sys/devices/system/cpu/cpu3/online
		echo "1" >/sys/devices/system/cpu/cpu4/online
		echo "1" >/sys/devices/system/cpu/cpu5/online
		echo "1" >/sys/devices/system/cpu/cpu6/online
		echo "1" >/sys/devices/system/cpu/cpu7/online
		echo "N" >/sys/module/lpm_levels/system/perf/cpu0/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/cpu1/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/cpu2/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/cpu3/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/cpu4/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/cpu5/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/cpu6/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/cpu7/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "1" >/sys/module/msm_thermal/core_control/enabled
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n disable" >"$mode"
		done
		for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
			echo "$bcl_hotplug_mask" >"$hotplug_mask"
		done
		for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
			echo "$bcl_soc_hotplug_mask" >"$hotplug_soc_mask"
		done
		for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
			echo "-n enable" >"$mode"
		done
		configure_memory_parameters
		for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "50" >"$cpubw"/polling_interval
			echo "762" >"$cpubw"/min_freq
			echo "1525 3143 4173 5195 5859 7759 9887 10327" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4 " >"$cpubw"/bw_hwmon/sample_ms
			echo "85" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "0 " >"$cpubw"/bw_hwmon/hyst_length
			echo "100" >"$cpubw"/bw_hwmon/decay_rate
			echo "50" >"$cpubw"/bw_hwmon/bw_step
			echo "80" >"$cpubw"/bw_hwmon/down_thres
			echo "0 " >"$cpubw"/bw_hwmon/low_power_ceil_mbps
			echo "50" >"$cpubw"/bw_hwmon/low_power_io_percent
			echo "20" >"$cpubw"/bw_hwmon/low_power_delay
			echo "0 " >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
		done
		for memlat in /sys/class/devfreq/*qcom,memlat-cpu*; do
			echo "mem_latency" >"$memlat"/governor
			echo "10" >"$memlat"/polling_interval
			echo "400" >"$memlat"/mem_latency/ratio_ceil
		done
		echo "cpufreq" >/sys/class/devfreq/soc:qcom,mincpubw/governor
		;;
	esac
	;;
esac
case "$target" in
"sdm710")
	echo "3f" >/proc/irq/default_smp_affinity
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	case "$soc_id" in
	"336" | "337" | "347" | "360" | "393")
		case "$hw_platform" in
		"MTP" | "Surf" | "RCM" | "QRD")
			start_hbtp
			;;
		esac
		echo "0 0 0 0 1 1" >/sys/devices/system/cpu/cpu0/core_ctl/not_preferred
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "60" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
		echo "8" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
		echo "96" >/proc/sys/kernel/sched_upmigrate
		echo "90" >/proc/sys/kernel/sched_downmigrate
		echo "140" >/proc/sys/kernel/sched_group_upmigrate
		echo "120" >/proc/sys/kernel/sched_group_downmigrate
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
		echo "1209600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/rate_limit_us
		echo "1344000" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "85" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
		echo "0:1209600" >/sys/module/cpu_boost/parameters/input_boost_freq
		echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
		configure_memory_parameters
		for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "50" >"$cpubw"/polling_interval
			echo "1144 1720 2086 2929 3879 5931 6881" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "68" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "0" >"$cpubw"/bw_hwmon/hyst_length
			echo "80" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
		done
		for memlat in /sys/class/devfreq/*qcom,memlat-cpu*; do
			echo "mem_latency" >"$memlat"/governor
			echo "10" >"$memlat"/polling_interval
			echo "400" >"$memlat"/mem_latency/ratio_ceil
		done
		for memlat in /sys/class/devfreq/*qcom,l3-cpu*; do
			echo "mem_latency" >"$memlat"/governor
			echo "10" >"$memlat"/polling_interval
			echo "400" >"$memlat"/mem_latency/ratio_ceil
		done
		for l3cdsp in /sys/class/devfreq/*qcom,l3-cdsp*; do
			echo "userspace" >"$l3cdsp"/governor
			chown -h system "$l3cdsp"/userspace/set_freq
		done
		echo "cpufreq" >/sys/class/devfreq/soc:qcom,mincpubw/governor
		echo "N" >/sys/module/lpm_levels/L3/cpu0/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/L3/cpu1/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/L3/cpu2/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/L3/cpu3/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/L3/cpu4/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/L3/cpu5/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/L3/cpu6/ret/idle_enabled
		echo "N" >/sys/module/lpm_levels/L3/cpu7/ret/idle_enabled
		echo "0-5" >/dev/cpuset/background/cpus
		echo "0-5" >/dev/cpuset/system-background/cpus
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	;;
esac
case "$target" in
"trinket")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"394")
		echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo "40" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
		echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
		echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
		echo "1" >/sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
		echo "4" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
		echo "67" >/proc/sys/kernel/sched_downmigrate
		echo "77" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_group_downmigrate
		echo "100" >/proc/sys/kernel/sched_group_upmigrate
		echo "0-3" >/dev/cpuset/background/cpus
		echo "0-3" >/dev/cpuset/system-background/cpus
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1305600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1401600" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		echo "-6" >/sys/devices/system/cpu/cpu0/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu1/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu2/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu3/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu4/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu5/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
		echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
		configure_memory_parameters
		ddr_type=$(od -An -tx /proc/device-tree/memory/ddr_device_type)
		ddr_type4="07"
		ddr_type3="05"
		for device in /sys/devices/platform/soc; do
			for cpubw in "$device"/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw; do
				echo "bw_hwmon" >"$cpubw"/governor
				echo "762" >"$cpubw"/min_freq
				if [ "${ddr_type:4:2}" == $ddr_type4 ]; then
					echo "2288 3440 4173 5195 5859 7759 10322 11863 13763" >"$cpubw"/bw_hwmon/mbps_zones
					echo "85" >"$cpubw"/bw_hwmon/io_percent
				fi
				if [ "${ddr_type:4:2}" == $ddr_type3 ]; then
					echo "1525 3440 5195 5859 7102" >"$cpubw"/bw_hwmon/mbps_zones
					echo "34" >"$cpubw"/bw_hwmon/io_percent
				fi
				echo "4" >"$cpubw"/bw_hwmon/sample_ms
				echo "90" >"$cpubw"/bw_hwmon/decay_rate
				echo "190" >"$cpubw"/bw_hwmon/bw_step
				echo "20" >"$cpubw"/bw_hwmon/hist_memory
				echo "0" >"$cpubw"/bw_hwmon/hyst_length
				echo "80" >"$cpubw"/bw_hwmon/down_thres
				echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$cpubw"/bw_hwmon/up_scale
				echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
				echo "50" >"$cpubw"/polling_interval
			done
		done
		setprop vendor.dcvs.prop 1
		echo "0" >/proc/sys/kernel/sched_min_task_util_for_boost
		echo "0" >/proc/sys/kernel/sched_min_task_util_for_colocation
		echo "0" >/proc/sys/kernel/sched_little_cluster_coloc_fmin_khz
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	;;
esac
case "$target" in
"sm6150")
	echo "3f" >/proc/irq/default_smp_affinity
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"355" | "369" | "377" | "380" | "384")
		target_type=$(getprop ro.hardware.type)
		if [ "$target_type" == "automotive" ]; then
			configure_sku_parameters
		fi
		echo "0 0 0 0 1 1" >/sys/devices/system/cpu/cpu0/core_ctl/not_preferred
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "60" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
		echo "8" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
		echo "0" >/sys/devices/system/cpu/cpu6/core_ctl/enable
		echo "65" >/proc/sys/kernel/sched_downmigrate
		echo "71" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_group_downmigrate
		echo "100" >/proc/sys/kernel/sched_group_upmigrate
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		echo "740000" >/proc/sys/kernel/sched_little_cluster_coloc_fmin_khz
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1209600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
		echo "1209600" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "85" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
		echo "0:1209600" >/sys/module/cpu_boost/parameters/input_boost_freq
		echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
		configure_memory_parameters
		for device in /sys/devices/platform/soc; do
			for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
				echo "bw_hwmon" >"$cpubw"/governor
				echo "2288 4577 7110 9155 12298 14236" >"$cpubw"/bw_hwmon/mbps_zones
				echo "4" >"$cpubw"/bw_hwmon/sample_ms
				echo "68" >"$cpubw"/bw_hwmon/io_percent
				echo "20" >"$cpubw"/bw_hwmon/hist_memory
				echo "0" >"$cpubw"/bw_hwmon/hyst_length
				echo "80" >"$cpubw"/bw_hwmon/down_thres
				echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$cpubw"/bw_hwmon/up_scale
				echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
				echo "50" >"$cpubw"/polling_interval
			done
			for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
				echo "bw_hwmon" >"$llccbw"/governor
				echo "1144 1720 2086 2929 3879 5931 6881" >"$llccbw"/bw_hwmon/mbps_zones
				echo "4" >"$llccbw"/bw_hwmon/sample_ms
				echo "68" >"$llccbw"/bw_hwmon/io_percent
				echo "20" >"$llccbw"/bw_hwmon/hist_memory
				echo "0" >"$llccbw"/bw_hwmon/hyst_length
				echo "80" >"$llccbw"/bw_hwmon/down_thres
				echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
				echo "250" >"$llccbw"/bw_hwmon/up_scale
				echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
				echo "40" >"$llccbw"/polling_interval
			done
		done
		setprop vendor.dcvs.prop 1
		echo "0-5" >/dev/cpuset/background/cpus
		echo "0-5" >/dev/cpuset/system-background/cpus
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	case "$soc_id" in
	"365" | "366")
		echo "0 0 0 0 1 1" >/sys/devices/system/cpu/cpu0/core_ctl/not_preferred
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "60" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
		echo "8" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
		echo "0" >/sys/devices/system/cpu/cpu6/core_ctl/enable
		echo "65" >/proc/sys/kernel/sched_downmigrate
		echo "71" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_group_downmigrate
		echo "100" >/proc/sys/kernel/sched_group_upmigrate
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		echo "740000" >/proc/sys/kernel/sched_little_cluster_coloc_fmin_khz
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1248000" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
		echo "1324600" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "85" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
		echo "0:1248000" >/sys/module/cpu_boost/parameters/input_boost_freq
		echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
		configure_memory_parameters
		for device in /sys/devices/platform/soc; do
			for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
				echo "bw_hwmon" >"$cpubw"/governor
				echo "2288 4577 7110 9155 12298 14236" >"$cpubw"/bw_hwmon/mbps_zones
				echo "4" >"$cpubw"/bw_hwmon/sample_ms
				echo "68" >"$cpubw"/bw_hwmon/io_percent
				echo "20" >"$cpubw"/bw_hwmon/hist_memory
				echo "0" >"$cpubw"/bw_hwmon/hyst_length
				echo "80" >"$cpubw"/bw_hwmon/down_thres
				echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$cpubw"/bw_hwmon/up_scale
				echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
				echo "50" >"$cpubw"/polling_interval
			done
			for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
				echo "bw_hwmon" >"$llccbw"/governor
				echo "1144 1720 2086 2929 3879 5931 6881" >"$llccbw"/bw_hwmon/mbps_zones
				echo "4" >"$llccbw"/bw_hwmon/sample_ms
				echo "68" >"$llccbw"/bw_hwmon/io_percent
				echo "20" >"$llccbw"/bw_hwmon/hist_memory
				echo "0" >"$llccbw"/bw_hwmon/hyst_length
				echo "80" >"$llccbw"/bw_hwmon/down_thres
				echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
				echo "250" >"$llccbw"/bw_hwmon/up_scale
				echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
				echo "40" >"$llccbw"/polling_interval
			done
			for npubw in "$device"/*npu-npu-ddr-bw/devfreq/*npu-npu-ddr-bw; do
				echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
				echo "bw_hwmon" >"$npubw"/governor
				echo "1144 1720 2086 2929 3879 5931 6881" >"$npubw"/bw_hwmon/mbps_zones
				echo "4" >"$npubw"/bw_hwmon/sample_ms
				echo "80" >"$npubw"/bw_hwmon/io_percent
				echo "20" >"$npubw"/bw_hwmon/hist_memory
				echo "10" >"$npubw"/bw_hwmon/hyst_length
				echo "30" >"$npubw"/bw_hwmon/down_thres
				echo "0" >"$npubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$npubw"/bw_hwmon/up_scale
				echo "0" >"$npubw"/bw_hwmon/idle_mbps
				echo "40" >"$npubw"/polling_interval
				echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
			done
		done
		setprop vendor.dcvs.prop 1
		echo "0-5" >/dev/cpuset/background/cpus
		echo "0-5" >/dev/cpuset/system-background/cpus
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	;;
esac
case "$target" in
"lito")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	fi
	case "$soc_id" in
	"400" | "440" | "476")
		echo "0 0 0 0 1 1" >/sys/devices/system/cpu/cpu0/core_ctl/not_preferred
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "60" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "8" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "0" >/sys/devices/system/cpu/cpu6/core_ctl/enable
		echo "0" >/sys/devices/system/cpu/cpu7/core_ctl/enable
		echo "65 85" >/proc/sys/kernel/sched_downmigrate
		echo "71 95" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_group_downmigrate
		echo "100" >/proc/sys/kernel/sched_group_upmigrate
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		echo "0" >/proc/sys/kernel/sched_coloc_busy_hyst_ns
		echo "0" >/proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus
		echo "0" >/proc/sys/kernel/sched_coloc_busy_hyst_max_ms
		echo "20000000" >/proc/sys/kernel/sched_task_unfilter_period
		echo "1" >/proc/sys/kernel/sched_task_unfilter_nr_windows
		echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
		echo "1228800" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
		echo "650000" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpufreq/policy6/schedutil/down_rate_limit_us
		echo "1228800" >/sys/devices/system/cpu/cpufreq/policy6/schedutil/hispeed_freq
		echo "85" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "0" >/sys/devices/system/cpu/cpufreq/policy6/schedutil/pl
		echo "0" >/sys/devices/system/cpu/cpufreq/policy6/schedutil/rtg_boost_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
		echo "1228800" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
		echo "85" >/sys/devices/system/cpu/cpu7/cpufreq/schedutil/hispeed_load
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/pl
		echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/rtg_boost_freq
		echo "51" >/proc/sys/kernel/sched_min_task_util_for_boost
		echo "35" >/proc/sys/kernel/sched_min_task_util_for_colocation
		echo "1" >/proc/sys/kernel/sched_conservative_pl
		echo "0:1228800" >/sys/devices/system/cpu/cpu_boost/input_boost_freq
		echo "120" >/sys/devices/system/cpu/cpu_boost/input_boost_ms
		configure_memory_parameters
		if [ "$(cat /sys/devices/soc0/revision)" == "2.0" ]; then
			echo "0:1075200" >/sys/devices/system/cpu/cpu_boost/input_boost_freq
			echo "610000" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq
			echo "1075200" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
			echo "1152000" >/sys/devices/system/cpu/cpufreq/policy6/schedutil/hispeed_freq
			echo "1401600" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
			echo "83" >/proc/sys/kernel/sched_asym_cap_sibling_freq_match_pct
		fi
		for device in /sys/devices/platform/soc; do
			for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
				echo "bw_hwmon" >"$cpubw"/governor
				echo "2288 4577 7110 9155 12298 14236 16265" >"$cpubw"/bw_hwmon/mbps_zones
				echo "4" >"$cpubw"/bw_hwmon/sample_ms
				echo "68" >"$cpubw"/bw_hwmon/io_percent
				echo "20" >"$cpubw"/bw_hwmon/hist_memory
				echo "0" >"$cpubw"/bw_hwmon/hyst_length
				echo "80" >"$cpubw"/bw_hwmon/down_thres
				echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$cpubw"/bw_hwmon/up_scale
				echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
				echo "50" >"$cpubw"/polling_interval
			done
			for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
				echo "bw_hwmon" >"$llccbw"/governor
				echo "1144 1720 2086 2929 3879 5931 6881 7980" >"$llccbw"/bw_hwmon/mbps_zones
				echo "4" >"$llccbw"/bw_hwmon/sample_ms
				echo "68" >"$llccbw"/bw_hwmon/io_percent
				echo "20" >"$llccbw"/bw_hwmon/hist_memory
				echo "0" >"$llccbw"/bw_hwmon/hyst_length
				echo "80" >"$llccbw"/bw_hwmon/down_thres
				echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
				echo "250" >"$llccbw"/bw_hwmon/up_scale
				echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
				echo "50" >"$llccbw"/polling_interval
			done
			for npubw in "$device"/*npu*-ddr-bw/devfreq/*npu*-ddr-bw; do
				echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
				echo "bw_hwmon" >"$npubw"/governor
				echo "1144 1720 2086 2929 3879 5931 6881 7980" >"$npubw"/bw_hwmon/mbps_zones
				echo "4" >"$npubw"/bw_hwmon/sample_ms
				echo "80" >"$npubw"/bw_hwmon/io_percent
				echo "20" >"$npubw"/bw_hwmon/hist_memory
				echo "10" >"$npubw"/bw_hwmon/hyst_length
				echo "30" >"$npubw"/bw_hwmon/down_thres
				echo "0" >"$npubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$npubw"/bw_hwmon/up_scale
				echo "0" >"$npubw"/bw_hwmon/idle_mbps
				echo "40" >"$npubw"/polling_interval
				echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
			done
			for npullccbw in "$device"/*npu*-llcc-bw/devfreq/*npu*-llcc-bw; do
				echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
				echo "bw_hwmon" >"$npullccbw"/governor
				echo "2288 4577 7110 9155 12298 14236 16265" >"$npullccbw"/bw_hwmon/mbps_zones
				echo "4" >"$npullccbw"/bw_hwmon/sample_ms
				echo "100" >"$npullccbw"/bw_hwmon/io_percent
				echo "20" >"$npullccbw"/bw_hwmon/hist_memory
				echo "10" >"$npullccbw"/bw_hwmon/hyst_length
				echo "30" >"$npullccbw"/bw_hwmon/down_thres
				echo "0" >"$npullccbw"/bw_hwmon/guard_band_mbps
				echo "250" >"$npullccbw"/bw_hwmon/up_scale
				echo "40" >"$npullccbw"/polling_interval
				echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
			done
		done
		setprop vendor.dcvs.prop 0
		setprop vendor.dcvs.prop 1
		echo "0-5" >/dev/cpuset/background/cpus
		echo "0-5" >/dev/cpuset/system-background/cpus
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	case "$soc_id" in
	"434" | "459")
		echo "0 0 0 0 1 1" >/sys/devices/system/cpu/cpu0/core_ctl/not_preferred
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "60" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "8" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
		echo "0" >/sys/devices/system/cpu/cpu6/core_ctl/enable
		echo "20000000" >/proc/sys/kernel/sched_task_unfilter_period
		echo "65" >/proc/sys/kernel/sched_downmigrate
		echo "71" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_group_downmigrate
		echo "100" >/proc/sys/kernel/sched_group_upmigrate
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		echo "0" >/proc/sys/kernel/sched_coloc_busy_hyst_ns
		echo "0" >/proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus
		echo "0" >/proc/sys/kernel/sched_coloc_busy_hyst_max_ms
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1248000" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
		echo "1248000" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
		echo "740000" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq
		echo "0" >/sys/devices/system/cpu/cpufreq/policy6/schedutil/rtg_boost_freq
		echo "51" >/proc/sys/kernel/sched_min_task_util_for_boost
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "85" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
		echo "1" >/proc/sys/kernel/sched_conservative_pl
		echo "0:1248000" >/sys/devices/system/cpu/cpu_boost/input_boost_freq
		echo "120" >/sys/devices/system/cpu/cpu_boost/input_boost_ms
		configure_memory_parameters
		for device in /sys/devices/platform/soc; do
			for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
				echo "bw_hwmon" >"$cpubw"/governor
				echo "2288 4577 7110 9155 12298 14236" >"$cpubw"/bw_hwmon/mbps_zones
				echo "4" >"$cpubw"/bw_hwmon/sample_ms
				echo "68" >"$cpubw"/bw_hwmon/io_percent
				echo "20" >"$cpubw"/bw_hwmon/hist_memory
				echo "0" >"$cpubw"/bw_hwmon/hyst_length
				echo "80" >"$cpubw"/bw_hwmon/down_thres
				echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$cpubw"/bw_hwmon/up_scale
				echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
				echo "50" >"$cpubw"/polling_interval
			done
			for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
				echo "bw_hwmon" >"$llccbw"/governor
				echo "1144 1720 2086 2929 3879 5931 6881 8137" >"$llccbw"/bw_hwmon/mbps_zones
				echo "4" >"$llccbw"/bw_hwmon/sample_ms
				echo "68" >"$llccbw"/bw_hwmon/io_percent
				echo "20" >"$llccbw"/bw_hwmon/hist_memory
				echo "0" >"$llccbw"/bw_hwmon/hyst_length
				echo "80" >"$llccbw"/bw_hwmon/down_thres
				echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
				echo "250" >"$llccbw"/bw_hwmon/up_scale
				echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
				echo "40" >"$llccbw"/polling_interval
			done
			for npubw in "$device"/*npu*-ddr-bw/devfreq/*npu*-ddr-bw; do
				echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
				echo "bw_hwmon" >"$npubw"/governor
				echo "1144 1720 2086 2929 3879 5931 6881 7980" >"$npubw"/bw_hwmon/mbps_zones
				echo "4" >"$npubw"/bw_hwmon/sample_ms
				echo "80" >"$npubw"/bw_hwmon/io_percent
				echo "20" >"$npubw"/bw_hwmon/hist_memory
				echo "10" >"$npubw"/bw_hwmon/hyst_length
				echo "30" >"$npubw"/bw_hwmon/down_thres
				echo "0" >"$npubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$npubw"/bw_hwmon/up_scale
				echo "0" >"$npubw"/bw_hwmon/idle_mbps
				echo "40" >"$npubw"/polling_interval
				echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
			done
			for npullccbw in "$device"/*npu*-llcc-bw/devfreq/*npu*-llcc-bw; do
				echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
				echo "bw_hwmon" >"$npullccbw"/governor
				echo "2288 4577 7110 9155 12298 14236 16265" >"$npullccbw"/bw_hwmon/mbps_zones
				echo "4" >"$npullccbw"/bw_hwmon/sample_ms
				echo "100" >"$npullccbw"/bw_hwmon/io_percent
				echo "20" >"$npullccbw"/bw_hwmon/hist_memory
				echo "10" >"$npullccbw"/bw_hwmon/hyst_length
				echo "30" >"$npullccbw"/bw_hwmon/down_thres
				echo "0" >"$npullccbw"/bw_hwmon/guard_band_mbps
				echo "250" >"$npullccbw"/bw_hwmon/up_scale
				echo "40" >"$npullccbw"/polling_interval
				echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
			done
		done
		setprop vendor.dcvs.prop 1
		echo "0-5" >/dev/cpuset/background/cpus
		echo "0-5" >/dev/cpuset/system-background/cpus
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	;;
esac
case "$target" in
"bengal")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"417" | "420" | "444" | "445" | "469" | "470")
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/enable
		echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
		echo "40" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
		echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
		echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
		echo "4" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
		echo "67" >/proc/sys/kernel/sched_downmigrate
		echo "77" >/proc/sys/kernel/sched_upmigrate
		echo "85" >/proc/sys/kernel/sched_group_downmigrate
		echo "100" >/proc/sys/kernel/sched_group_upmigrate
		echo "0-3" >/dev/cpuset/background/cpus
		echo "0-3" >/dev/cpuset/system-background/cpus
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1305600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/rtg_boost_freq
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
		echo "1401600" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/rtg_boost_freq
		echo "0:1017600" >/sys/devices/system/cpu/cpu_boost/input_boost_freq
		echo "80" >/sys/devices/system/cpu/cpu_boost/input_boost_ms
		echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
		echo "-6" >/sys/devices/system/cpu/cpu0/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu1/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu2/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu3/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu4/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu5/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
		echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
		echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
		configure_memory_parameters
		ddr_type=$(od -An -tx /proc/device-tree/memory/ddr_device_type)
		ddr_type4="07"
		ddr_type3="05"
		for device in /sys/devices/platform/soc; do
			for cpubw in "$device"/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw; do
				echo "bw_hwmon" >"$cpubw"/governor
				echo "50" >"$cpubw"/polling_interval
				echo "762" >"$cpubw"/min_freq
				if [ "${ddr_type:4:2}" == $ddr_type4 ]; then
					echo "2288 3440 4173 5195 5859 7759 10322 11863 13763" >"$cpubw"/bw_hwmon/mbps_zones
					echo "85" >"$cpubw"/bw_hwmon/io_percent
				fi
				if [ "${ddr_type:4:2}" == $ddr_type3 ]; then
					echo "1525 3440 5195 5859 7102" >"$cpubw"/bw_hwmon/mbps_zones
					echo "34" >"$cpubw"/bw_hwmon/io_percent
				fi
				echo "4" >"$cpubw"/bw_hwmon/sample_ms
				echo "90" >"$cpubw"/bw_hwmon/decay_rate
				echo "190" >"$cpubw"/bw_hwmon/bw_step
				echo "20" >"$cpubw"/bw_hwmon/hist_memory
				echo "0" >"$cpubw"/bw_hwmon/hyst_length
				echo "80" >"$cpubw"/bw_hwmon/down_thres
				echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$cpubw"/bw_hwmon/up_scale
				echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
			done
		done
		setprop vendor.dcvs.prop 1
		echo "0" >/proc/sys/kernel/sched_min_task_util_for_boost
		echo "0" >/proc/sys/kernel/sched_min_task_util_for_colocation
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	case "$soc_id" in
	"441")
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/enable
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
		echo "1305600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/rtg_boost_freq
		echo "0" >/proc/sys/kernel/sched_boost
		echo "-6" >/sys/devices/system/cpu/cpu0/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu1/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu2/sched_load_boost
		echo "-6" >/sys/devices/system/cpu/cpu3/sched_load_boost
		echo "85" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
		configure_memory_parameters
		ddr_type=$(od -An -tx /proc/device-tree/memory/ddr_device_type)
		ddr_type4="07"
		ddr_type3="05"
		for device in /sys/devices/platform/soc; do
			for cpubw in "$device"/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw; do
				echo "bw_hwmon" >"$cpubw"/governor
				echo "50" >"$cpubw"/polling_interval
				echo "762" >"$cpubw"/min_freq
				if [ "${ddr_type:4:2}" == $ddr_type4 ]; then
					echo "2288 3440 4173 5195 5859 7759 10322 11863 13763" >"$cpubw"/bw_hwmon/mbps_zones
					echo "85" >"$cpubw"/bw_hwmon/io_percent
				fi
				if [ "${ddr_type:4:2}" == $ddr_type3 ]; then
					echo "1525 3440 5195 5859 7102" >"$cpubw"/bw_hwmon/mbps_zones
					echo "34" >"$cpubw"/bw_hwmon/io_percent
				fi
				echo "4" >"$cpubw"/bw_hwmon/sample_ms
				echo "90" >"$cpubw"/bw_hwmon/decay_rate
				echo "190" >"$cpubw"/bw_hwmon/bw_step
				echo "20" >"$cpubw"/bw_hwmon/hist_memory
				echo "0" >"$cpubw"/bw_hwmon/hyst_length
				echo "80" >"$cpubw"/bw_hwmon/down_thres
				echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
				echo "250" >"$cpubw"/bw_hwmon/up_scale
				echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
			done
			for memlat in "$device"/*cpu*-lat/devfreq/*cpu*-lat; do
				echo "mem_latency" >"$memlat"/governor
				echo "10" >"$memlat"/polling_interval
				echo "400" >"$memlat"/mem_latency/ratio_ceil
			done
			for latfloor in "$device"/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*; do
				echo "compute" >"$latfloor"/governor
				echo "10" >"$latfloor"/polling_interval
			done
		done
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		;;
	esac
	;;
esac
case "$target" in
"atoll")
	echo "0 0 0 0 1 1" >/sys/devices/system/cpu/cpu0/core_ctl/not_preferred
	echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
	echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
	echo "8" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
	echo "0" >/sys/devices/system/cpu/cpu6/core_ctl/enable
	echo "65" >/proc/sys/kernel/sched_downmigrate
	echo "71" >/proc/sys/kernel/sched_upmigrate
	echo "85" >/proc/sys/kernel/sched_group_downmigrate
	echo "100" >/proc/sys/kernel/sched_group_upmigrate
	echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
	echo "740000" >/proc/sys/kernel/sched_little_cluster_coloc_fmin_khz
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
	echo "1248000" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
	echo "1267200" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
	echo "-6" >/sys/devices/system/cpu/cpu6/sched_load_boost
	echo "-6" >/sys/devices/system/cpu/cpu7/sched_load_boost
	echo "85" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
	echo "0:1248000" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
	configure_memory_parameters
	for device in /sys/devices/platform/soc; do
		for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "2288 4577 7110 9155 12298 14236" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "68" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "0" >"$cpubw"/bw_hwmon/hyst_length
			echo "80" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
			echo "50" >"$cpubw"/polling_interval
		done
		for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
			echo "bw_hwmon" >"$llccbw"/governor
			echo "1144 1720 2086 2929 3879 5931 6881 8137" >"$llccbw"/bw_hwmon/mbps_zones
			echo "4" >"$llccbw"/bw_hwmon/sample_ms
			echo "68" >"$llccbw"/bw_hwmon/io_percent
			echo "20" >"$llccbw"/bw_hwmon/hist_memory
			echo "0" >"$llccbw"/bw_hwmon/hyst_length
			echo "80" >"$llccbw"/bw_hwmon/down_thres
			echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
			echo "250" >"$llccbw"/bw_hwmon/up_scale
			echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
			echo "40" >"$llccbw"/polling_interval
		done
		for npubw in "$device"/*npu*-npu-ddr-bw/devfreq/*npu*-npu-ddr-bw; do
			echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
			echo "bw_hwmon" >"$npubw"/governor
			echo "1144 1720 2086 2929 3879 5931 6881 8137" >"$npubw"/bw_hwmon/mbps_zones
			echo "4" >"$npubw"/bw_hwmon/sample_ms
			echo "80" >"$npubw"/bw_hwmon/io_percent
			echo "20" >"$npubw"/bw_hwmon/hist_memory
			echo "10" >"$npubw"/bw_hwmon/hyst_length
			echo "30" >"$npubw"/bw_hwmon/down_thres
			echo "0" >"$npubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$npubw"/bw_hwmon/up_scale
			echo "0" >"$npubw"/bw_hwmon/idle_mbps
			echo "40" >"$npubw"/polling_interval
			echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
		done
	done
	setprop vendor.dcvs.prop 1
	echo "0-5" >/dev/cpuset/background/cpus
	echo "0-5" >/dev/cpuset/system-background/cpus
	echo "0" >/proc/sys/kernel/sched_boost
	echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
	;;
esac
case "$target" in
"qcs605")
	echo "3f" >/proc/irq/default_smp_affinity
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
	fi
	case "$soc_id" in
	"347")
		case "$hw_platform" in
		"Surf" | "RCM" | "QRD")
			start_hbtp
			;;
		"MTP")
			if [ "$platform_subtype_id" != 5 ]; then
				start_hbtp
			fi
			;;
		esac
		echo "4" >/sys/devices/system/cpu/cpu0/core_ctl/min_cpus
		echo "60" >/sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
		echo "40" >/sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
		echo "100" >/sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
		echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
		echo "8" >/sys/devices/system/cpu/cpu0/core_ctl/task_thres
		echo "96" >/proc/sys/kernel/sched_upmigrate
		echo "90" >/proc/sys/kernel/sched_downmigrate
		echo "140" >/proc/sys/kernel/sched_group_upmigrate
		echo "120" >/proc/sys/kernel/sched_group_downmigrate
		echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
		echo "1209600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
		echo "0" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/rate_limit_us
		echo "1344000" >/sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
		echo "0:1209600" >/sys/module/cpu_boost/parameters/input_boost_freq
		echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
		for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "50" >"$cpubw"/polling_interval
			echo "1144 1720 2086 2929 3879 5931 6881" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "68" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "0" >"$cpubw"/bw_hwmon/hyst_length
			echo "80" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/low_power_ceil_mbps
			echo "68" >"$cpubw"/bw_hwmon/low_power_io_percent
			echo "20" >"$cpubw"/bw_hwmon/low_power_delay
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
		done
		for memlat in /sys/class/devfreq/*qcom,memlat-cpu*; do
			echo "mem_latency" >"$memlat"/governor
			echo "10" >"$memlat"/polling_interval
			echo "400" >"$memlat"/mem_latency/ratio_ceil
		done
		for memlat in /sys/class/devfreq/*qcom,l3-cpu*; do
			echo "mem_latency" >"$memlat"/governor
			echo "10" >"$memlat"/polling_interval
			echo "400" >"$memlat"/mem_latency/ratio_ceil
		done
		echo "cpufreq" >/sys/class/devfreq/soc:qcom,mincpubw/governor
		echo "0-5" >/dev/cpuset/background/cpus
		echo "0-5" >/dev/cpuset/system-background/cpus
		echo "0" >/proc/sys/kernel/sched_boost
		echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
		echo "100" >/proc/sys/vm/swappiness
		;;
	esac
	;;
esac
case "$target" in
"apq8084")
	echo "4" >/sys/module/lpm_levels/enable_low_power/l2
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/retention/idle_enabled
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor; do
		echo "cpubw_hwmon" >"$devfreq_gov"
	done
	echo "20000 1400000:40000 1700000:20000" >/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
	echo "1497600" >/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
	echo "85 1500000:90 1800000:70" >/sys/devices/system/cpu/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpufreq/interactive/min_sample_time
	echo "20" >/sys/module/cpu_boost/parameters/boost_ms
	echo "1728000" >/sys/module/cpu_boost/parameters/sync_threshold
	echo "100000" >/sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
	echo "1497600" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "1" >/dev/cpuctl/apps/cpu.notify_on_migrate
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	chown -h root.system /sys/devices/system/cpu/mfreq
	chmod -h 220 /sys/devices/system/cpu/mfreq
	chown -h root.system /sys/devices/system/cpu/cpu1/online
	chown -h root.system /sys/devices/system/cpu/cpu2/online
	chown -h root.system /sys/devices/system/cpu/cpu3/online
	chmod -h 664 /sys/devices/system/cpu/cpu1/online
	chmod -h 664 /sys/devices/system/cpu/cpu2/online
	chmod -h 664 /sys/devices/system/cpu/cpu3/online
	;;
esac
case "$target" in
"mpq8092")
	echo "4" >/sys/module/lpm_levels/enable_low_power/l2
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu0/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu1/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu2/retention/idle_enabled
	echo "1" >/sys/module/msm_pm/modes/cpu3/retention/idle_enabled
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	echo "50000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	echo "90" >/sys/devices/system/cpu/cpufreq/ondemand/up_threshold
	echo "1" >/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	chown -h root.system /sys/devices/system/cpu/mfreq
	chmod -h 220 /sys/devices/system/cpu/mfreq
	chown -h root.system /sys/devices/system/cpu/cpu1/online
	chown -h root.system /sys/devices/system/cpu/cpu2/online
	chown -h root.system /sys/devices/system/cpu/cpu3/online
	chmod -h 664 /sys/devices/system/cpu/cpu1/online
	chmod -h 664 /sys/devices/system/cpu/cpu2/online
	chmod -h 664 /sys/devices/system/cpu/cpu3/online
	;;
esac
case "$target" in
"msm8992")
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "-n disable" >/sys/devices/soc.*/qcom,bcl.*/mode
	bcl_hotplug_mask=$(cat /sys/devices/soc.*/qcom,bcl.*/hotplug_mask)
	echo "0" >/sys/devices/soc.*/qcom,bcl.*/hotplug_mask
	echo "-n enable" >/sys/devices/soc.*/qcom,bcl.*/mode
	echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
	echo "19000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
	echo "960000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
	echo "80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
	echo "80000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu4/online
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
	echo "19000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
	echo "1536000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
	echo "85" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
	echo "80000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	echo "-n disable" >/sys/devices/soc.*/qcom,bcl.*/mode
	echo "$bcl_hotplug_mask" >/sys/devices/soc.*/qcom,bcl.*/hotplug_mask
	echo "$bcl_soc_hotplug_mask" >/sys/devices/soc.*/qcom,bcl.*/hotplug_soc_mask
	echo "-n enable" >/sys/devices/soc.*/qcom,bcl.*/mode
	echo "1" >/sys/devices/system/cpu/cpu5/online
	echo "0:1248000" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "1" >/proc/sys/kernel/sched_migration_fixup
	for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor; do
		echo "bw_hwmon" >"$devfreq_gov"
	done
	echo "8" >/sys/class/net/rmnet_ipa0/queues/rx-0/rps_cpus
	echo "30" >/proc/sys/kernel/sched_small_task
	;;
esac
case "$target" in
"msm8994")
	echo "0" >/sys/devices/system/cpu/cpu5/online
	echo "0" >/sys/devices/system/cpu/cpu6/online
	echo "0" >/sys/devices/system/cpu/cpu7/online
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
		echo "-n disable" >"$mode"
	done
	for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
		bcl_hotplug_mask=$(cat "$hotplug_mask")
		echo "0" >"$hotplug_mask"
	done
	for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
		bcl_soc_hotplug_mask=$(cat "$hotplug_soc_mask")
		echo "0" >"$hotplug_soc_mask"
	done
	for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
		echo "-n enable" >"$mode"
	done
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
	echo "19000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
	echo "960000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
	echo "80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
	echo "80000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu4/online
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
	echo "19000 1400000:39000 1700000:19000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
	echo "1248000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
	echo "85 1500000:90 1800000:70" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
	echo "40000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
	echo "80000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
		echo "-n disable" >"$mode"
	done
	for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask; do
		echo "$bcl_hotplug_mask" >"$hotplug_mask"
	done
	for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask; do
		echo "$bcl_soc_hotplug_mask" >"$hotplug_soc_mask"
	done
	for mode in /sys/devices/soc.0/qcom,bcl.*/mode; do
		echo "-n enable" >"$mode"
	done
	echo "1" >/sys/devices/system/cpu/cpu5/online
	echo "1" >/sys/devices/system/cpu/cpu6/online
	echo "1" >/sys/devices/system/cpu/cpu7/online
	echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
	echo "0:1344000" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "1" >/proc/sys/kernel/sched_migration_fixup
	echo "30" >/proc/sys/kernel/sched_small_task
	echo "20" >/proc/sys/kernel/sched_mostly_idle_load
	echo "3" >/proc/sys/kernel/sched_mostly_idle_nr_run
	echo "99" >/proc/sys/kernel/sched_upmigrate
	echo "85" >/proc/sys/kernel/sched_downmigrate
	echo "400000" >/proc/sys/kernel/sched_freq_inc_notify
	echo "400000" >/proc/sys/kernel/sched_freq_dec_notify
	echo "8" >/sys/class/net/rmnet_ipa0/queues/rx-0/rps_cpus
	for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor; do
		echo "bw_hwmon" >"$devfreq_gov"
	done
	;;
esac
case "$target" in
"msm8996")
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "-n disable" >/sys/devices/soc/soc:qcom,bcl/mode
	bcl_hotplug_mask=$(cat /sys/devices/soc/soc:qcom,bcl/hotplug_mask)
	echo "0" >/sys/devices/soc/soc:qcom,bcl/hotplug_mask
	bcl_soc_hotplug_mask=$(cat /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask)
	echo "0" >/sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
	echo "-n enable" >/sys/devices/soc/soc:qcom,bcl/mode
	echo "1" >/proc/sys/kernel/sched_prefer_sync_wakee_to_waker
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
	echo "19000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
	echo "960000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
	echo "80" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo "19000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
	echo "79000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif
	echo "19000 1400000:39000 1700000:19000 2100000:79000" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_rate
	echo "1248000" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/io_is_busy
	echo "85 1500000:90 1800000:70 2100000:95" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads
	echo "19000" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/min_sample_time
	echo "79000" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu2/cpufreq/interactive/ignore_hispeed_on_notif
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	echo "-n disable" >/sys/devices/soc/soc:qcom,bcl/mode
	echo "$bcl_hotplug_mask" >/sys/devices/soc/soc:qcom,bcl/hotplug_mask
	echo "$bcl_soc_hotplug_mask" >/sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
	echo "-n enable" >/sys/devices/soc/soc:qcom,bcl/mode
	echo "0:1324800 2:1324800" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "0" >/proc/sys/kernel/sched_boost
	echo "1" >/proc/sys/kernel/sched_migration_fixup
	echo "45" >/proc/sys/kernel/sched_downmigrate
	echo "45" >/proc/sys/kernel/sched_upmigrate
	echo "400000" >/proc/sys/kernel/sched_freq_inc_notify
	echo "400000" >/proc/sys/kernel/sched_freq_dec_notify
	echo "3" >/proc/sys/kernel/sched_spill_nr_run
	echo "100" >/proc/sys/kernel/sched_init_task_load
	for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
		echo "bw_hwmon" >"$cpubw"/governor
		echo "50" >"$cpubw"/polling_interval
		echo "1525" >"$cpubw"/min_freq
		echo "1525 5195 11863 13763" >"$cpubw"/bw_hwmon/mbps_zones
		echo "4" >"$cpubw"/bw_hwmon/sample_ms
		echo "34" >"$cpubw"/bw_hwmon/io_percent
		echo "20" >"$cpubw"/bw_hwmon/hist_memory
		echo "10" >"$cpubw"/bw_hwmon/hyst_length
		echo "0" >"$cpubw"/bw_hwmon/low_power_ceil_mbps
		echo "34" >"$cpubw"/bw_hwmon/low_power_io_percent
		echo "20" >"$cpubw"/bw_hwmon/low_power_delay
		echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
		echo "250" >"$cpubw"/bw_hwmon/up_scale
		echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
	done
	for memlat in /sys/class/devfreq/*qcom,memlat-cpu*; do
		echo "mem_latency" >"$memlat"/governor
		echo "10" >"$memlat"/polling_interval
	done
	echo "cpufreq" >/sys/class/devfreq/soc:qcom,mincpubw/governor
	soc_revision=$(cat /sys/devices/soc0/revision)
	if [ "$soc_revision" == "2.1" ]; then
		echo "0" >/sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
		echo "0" >/sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/cpu0/fpc-def/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/pwr/cpu1/fpc-def/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/cpu2/fpc-def/idle_enabled
		echo "N" >/sys/module/lpm_levels/system/perf/cpu3/fpc-def/idle_enabled
	else
		echo "N" >/sys/module/lpm_levels/parameters/sleep_disabled
	fi
	echo "N" >/sys/module/lpm_levels/parameters/sleep_disabled
	start iop
	configure_memory_parameters
	;;
esac
case "$target" in
"sdm845")
	echo "f" >/proc/irq/default_smp_affinity
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
	fi
	case "$soc_id" in
	"321" | "341")
		case "$hw_platform" in
		"QRD")
			case "$platform_subtype_id" in
			"32") ;;
			*)
				start_hbtp
				;;
			esac
			;;
		*)
			start_hbtp
			;;
		esac
		;;
	esac
	echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo "1" >/sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
	echo "4" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
	echo "95" >/proc/sys/kernel/sched_upmigrate
	echo "85" >/proc/sys/kernel/sched_downmigrate
	echo "100" >/proc/sys/kernel/sched_group_upmigrate
	echo "95" >/proc/sys/kernel/sched_group_downmigrate
	echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
	echo "0" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
	echo "1209600" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/schedutil/pl
	echo "0" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/rate_limit_us
	echo "1574400" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/schedutil/pl
	echo "0:1324800" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "120" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "1" >/sys/module/lowmemorykiller/parameters/oom_reaper
	for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
		echo "bw_hwmon" >"$cpubw"/governor
		echo "50" >"$cpubw"/polling_interval
		echo "2288 4577 6500 8132 9155 10681" >"$cpubw"/bw_hwmon/mbps_zones
		echo "4" >"$cpubw"/bw_hwmon/sample_ms
		echo "50" >"$cpubw"/bw_hwmon/io_percent
		echo "20" >"$cpubw"/bw_hwmon/hist_memory
		echo "10" >"$cpubw"/bw_hwmon/hyst_length
		echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
		echo "250" >"$cpubw"/bw_hwmon/up_scale
		echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
	done
	for llccbw in /sys/class/devfreq/*qcom,llccbw*; do
		echo "bw_hwmon" >"$llccbw"/governor
		echo "50" >"$llccbw"/polling_interval
		echo "1720 2929 3879 5931 6881" >"$llccbw"/bw_hwmon/mbps_zones
		echo "4" >"$llccbw"/bw_hwmon/sample_ms
		echo "80" >"$llccbw"/bw_hwmon/io_percent
		echo "20" >"$llccbw"/bw_hwmon/hist_memory
		echo "10" >"$llccbw"/bw_hwmon/hyst_length
		echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
		echo "250" >"$llccbw"/bw_hwmon/up_scale
		echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
	done
	for memlat in /sys/class/devfreq/*qcom,memlat-cpu*; do
		echo "mem_latency" >"$memlat"/governor
		echo "10" >"$memlat"/polling_interval
		echo "400" >"$memlat"/mem_latency/ratio_ceil
	done
	for memlat in /sys/class/devfreq/*qcom,l3-cpu*; do
		echo "mem_latency" >"$memlat"/governor
		echo "10" >"$memlat"/polling_interval
		echo "400" >"$memlat"/mem_latency/ratio_ceil
	done
	for l3cdsp in /sys/class/devfreq/*qcom,l3-cdsp*; do
		echo "userspace" >"$l3cdsp"/governor
		chown -h system "$l3cdsp"/userspace/set_freq
	done
	echo "4000" >/sys/class/devfreq/soc:qcom,l3-cpu4/mem_latency/ratio_ceil
	echo "compute" >/sys/class/devfreq/soc:qcom,mincpubw/governor
	echo "10" >/sys/class/devfreq/soc:qcom,mincpubw/polling_interval
	echo "0-3" >/dev/cpuset/background/cpus
	echo "0-3" >/dev/cpuset/system-background/cpus
	echo "0" >/proc/sys/kernel/sched_boost
	echo "N" >/sys/module/lpm_levels/L3/cpu0/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/cpu1/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/cpu2/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/cpu3/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/cpu4/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/cpu5/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/cpu6/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/cpu7/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/L3/l3-dyn-ret/idle_enabled
	echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
	echo "100" >/proc/sys/vm/swappiness
	echo "120" >/proc/sys/vm/watermark_scale_factor
	;;
esac
case "$target" in
"msmnile")
	echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo "3" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
	echo "0" >/sys/devices/system/cpu/cpu7/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
	echo "1" >/sys/devices/system/cpu/cpu7/core_ctl/task_thres
	echo "1" >/sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh
	echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/enable
	echo "95 95" >/proc/sys/kernel/sched_upmigrate
	echo "85 85" >/proc/sys/kernel/sched_downmigrate
	echo "100" >/proc/sys/kernel/sched_group_upmigrate
	echo "10" >/proc/sys/kernel/sched_group_downmigrate
	echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
	echo "0-3" >/dev/cpuset/background/cpus
	echo "0-3" >/dev/cpuset/system-background/cpus
	echo "0" >/proc/sys/kernel/sched_boost
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo "1209600" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
	echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo "1612800" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/pl
	echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo "1612800" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/pl
	echo "0:1324800" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "120" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "1" >/proc/sys/vm/watermark_scale_factor
	echo "0-3" >/dev/cpuset/background/cpus
	echo "0-3" >/dev/cpuset/system-background/cpus
	if [ -f /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
		echo "1" >/sys/module/lowmemorykiller/parameters/oom_reaper
	else
		echo "1" >/proc/sys/vm/reap_mem_on_sigkill
	fi
	for device in /sys/devices/platform/soc; do
		for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "2288 4577 7110 9155 12298 14236 15258" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "50" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "10" >"$cpubw"/bw_hwmon/hyst_length
			echo "30" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
			echo "14236" >"$cpubw"/max_freq
			echo "40" >"$cpubw"/polling_interval
		done
		for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
			echo "bw_hwmon" >"$llccbw"/governor
			echo "1720 2929 3879 5931 6881 7980" >"$llccbw"/bw_hwmon/mbps_zones
			echo "4" >"$llccbw"/bw_hwmon/sample_ms
			echo "80" >"$llccbw"/bw_hwmon/io_percent
			echo "20" >"$llccbw"/bw_hwmon/hist_memory
			echo "10" >"$llccbw"/bw_hwmon/hyst_length
			echo "30" >"$llccbw"/bw_hwmon/down_thres
			echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
			echo "250" >"$llccbw"/bw_hwmon/up_scale
			echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
			echo "6881" >"$llccbw"/max_freq
			echo "40" >"$llccbw"/polling_interval
		done
		for npubw in "$device"/*npu-npu-ddr-bw/devfreq/*npu-npu-ddr-bw; do
			echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
			echo "bw_hwmon" >"$npubw"/governor
			echo "1720 2929 3879 5931 6881 7980" >"$npubw"/bw_hwmon/mbps_zones
			echo "4" >"$npubw"/bw_hwmon/sample_ms
			echo "80" >"$npubw"/bw_hwmon/io_percent
			echo "20" >"$npubw"/bw_hwmon/hist_memory
			echo "6 " >"$npubw"/bw_hwmon/hyst_length
			echo "30" >"$npubw"/bw_hwmon/down_thres
			echo "0" >"$npubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$npubw"/bw_hwmon/up_scale
			echo "0" >"$npubw"/bw_hwmon/idle_mbps
			echo "40" >"$npubw"/polling_interval
			echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
		done
	done
	setprop vendor.dcvs.prop 1
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
	fi
	case "$hw_platform" in
	"MTP" | "Surf" | "RCM")
		case "$platform_subtype_id" in
		"0" | "1" | "2" | "3" | "4")
			start_hbtp
			;;
		esac
		;;
	"HDK")
		if [ -d /sys/kernel/hbtpsensor ]; then
			start_hbtp
		fi
		;;
	esac
	echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
	configure_memory_parameters
	;;
esac
case "$target" in
"sdmshrike")
	echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo "3" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
	echo "0" >/sys/devices/system/cpu/cpu7/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
	echo "1" >/sys/devices/system/cpu/cpu7/core_ctl/task_thres
	echo "1" >/sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh
	echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/enable
	echo "95 95" >/proc/sys/kernel/sched_upmigrate
	echo "85 85" >/proc/sys/kernel/sched_downmigrate
	echo "100" >/proc/sys/kernel/sched_group_upmigrate
	echo "10" >/proc/sys/kernel/sched_group_downmigrate
	echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
	echo "0-3" >/dev/cpuset/background/cpus
	echo "0-3" >/dev/cpuset/system-background/cpus
	echo "0" >/proc/sys/kernel/sched_boost
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo "1209600" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
	echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo "1612800" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/pl
	echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
	echo "1612800" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/pl
	echo "0:1324800" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "120" >/sys/module/cpu_boost/parameters/input_boost_ms
	echo "1" >/proc/sys/vm/watermark_scale_factor
	echo "0-3" >/dev/cpuset/background/cpus
	echo "0-3" >/dev/cpuset/system-background/cpus
	if [ -f /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
		echo "1" >/sys/module/lowmemorykiller/parameters/oom_reaper
	else
		echo "1" >/proc/sys/vm/reap_mem_on_sigkill
	fi
	for device in /sys/devices/platform/soc; do
		for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "40" >"$cpubw"/polling_interval
			echo "2288 4577 7110 9155 12298 14236 15258" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "50" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "10" >"$cpubw"/bw_hwmon/hyst_length
			echo "30" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
			echo "14236" >"$cpubw"/max_freq
		done
		for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
			echo "bw_hwmon" >"$llccbw"/governor
			echo "40" >"$llccbw"/polling_interval
			echo "1720 2929 3879 5931 6881 7980" >"$llccbw"/bw_hwmon/mbps_zones
			echo "4" >"$llccbw"/bw_hwmon/sample_ms
			echo "80" >"$llccbw"/bw_hwmon/io_percent
			echo "20" >"$llccbw"/bw_hwmon/hist_memory
			echo "10" >"$llccbw"/bw_hwmon/hyst_length
			echo "30" >"$llccbw"/bw_hwmon/down_thres
			echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
			echo "250" >"$llccbw"/bw_hwmon/up_scale
			echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
			echo "6881" >"$llccbw"/max_freq
		done
		for npubw in "$device"/*npu-npu-ddr-bw/devfreq/*npu-npu-ddr-bw; do
			echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
			echo "bw_hwmon" >"$npubw"/governor
			echo "40" >"$npubw"/polling_interval
			echo "1720 2929 3879 5931 6881 7980" >"$npubw"/bw_hwmon/mbps_zones
			echo "4" >"$npubw"/bw_hwmon/sample_ms
			echo "80" >"$npubw"/bw_hwmon/io_percent
			echo "20" >"$npubw"/bw_hwmon/hist_memory
			echo "6 " >"$npubw"/bw_hwmon/hyst_length
			echo "30" >"$npubw"/bw_hwmon/down_thres
			echo "0" >"$npubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$npubw"/bw_hwmon/up_scale
			echo "0" >"$npubw"/bw_hwmon/idle_mbps
			echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
		done
		for memlat in "$device"/*cpu*-lat/devfreq/*cpu*-lat; do
			echo "mem_latency" >"$memlat"/governor
			echo "10" >"$memlat"/polling_interval
			echo "400" >"$memlat"/mem_latency/ratio_ceil
		done
		for l3cdsp in "$device"/*cdsp-cdsp-l3-lat/devfreq/*cdsp-cdsp-l3-lat; do
			echo "cdspl3" >"$l3cdsp"/governor
		done
		for latfloor in "$device"/*cpu-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*; do
			echo "compute" >"$latfloor"/governor
			echo "10" >"$latfloor"/polling_interval
		done
		for l3gold in "$device"/*cpu4-cpu-l3-lat/devfreq/*cpu4-cpu-l3-lat; do
			echo "4000" >"$l3gold"/mem_latency/ratio_ceil
		done
		for l3prime in "$device"/*cpu7-cpu-l3-lat/devfreq/*cpu7-cpu-l3-lat; do
			echo "20000" >"$l3prime"/mem_latency/ratio_ceil
		done
	done
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
	fi
	case "$hw_platform" in
	"MTP" | "Surf" | "RCM")
		case "$platform_subtype_id" in
		"0" | "1")
			start_hbtp
			;;
		esac
		;;
	"HDK")
		if [ -d /sys/kernel/hbtpsensor ]; then
			start_hbtp
		fi
		;;
	esac
	echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
	configure_memory_parameters
	;;
esac
case "$target" in
"kona")
	rev=$(cat /sys/devices/soc0/revision)
	ddr_type=$(od -An -tx /proc/device-tree/memory/ddr_device_type)
	ddr_type4="07"
	ddr_type5="08"
	echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo "3" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
	echo "0" >/sys/devices/system/cpu/cpu7/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
	echo "1" >/sys/devices/system/cpu/cpu7/core_ctl/task_thres
	echo "1" >/sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh
	echo "0" >/sys/devices/system/cpu/cpu0/core_ctl/enable
	echo "95 95" >/proc/sys/kernel/sched_upmigrate
	echo "85 85" >/proc/sys/kernel/sched_downmigrate
	echo "100" >/proc/sys/kernel/sched_group_upmigrate
	echo "85" >/proc/sys/kernel/sched_group_downmigrate
	echo "1" >/proc/sys/kernel/sched_walt_rotate_big_tasks
	echo "400000000" >/proc/sys/kernel/sched_coloc_downmigrate_ns
	echo "0-3" >/dev/cpuset/background/cpus
	echo "0-3" >/dev/cpuset/system-background/cpus
	echo "0" >/proc/sys/kernel/sched_boost
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	if [ "$rev" == "2.0" ] || [ "$rev" == "2.1" ]; then
		echo "1248000" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	else
		echo "1228800" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	fi
	echo "1" >/sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
	echo "0:1324800" >/sys/devices/system/cpu/cpu_boost/input_boost_freq
	echo "120" >/sys/devices/system/cpu/cpu_boost/input_boost_ms
	echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo "1574400" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpufreq/policy4/schedutil/pl
	echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
	echo "0" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
	if [ "$rev" == "2.0" ] || [ "$rev" == "2.1" ]; then
		echo "1632000" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	else
		echo "1612800" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	fi
	echo "1" >/sys/devices/system/cpu/cpufreq/policy7/schedutil/pl
	for device in /sys/devices/platform/soc; do
		for cpubw in "$device"/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
			echo "bw_hwmon" >"$cpubw"/governor
			echo "4577 7110 9155 12298 14236 15258" >"$cpubw"/bw_hwmon/mbps_zones
			echo "4" >"$cpubw"/bw_hwmon/sample_ms
			echo "50" >"$cpubw"/bw_hwmon/io_percent
			echo "20" >"$cpubw"/bw_hwmon/hist_memory
			echo "10" >"$cpubw"/bw_hwmon/hyst_length
			echo "30" >"$cpubw"/bw_hwmon/down_thres
			echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$cpubw"/bw_hwmon/up_scale
			echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
			echo "14236" >"$cpubw"/max_freq
			echo "40" >"$cpubw"/polling_interval
		done
		for llccbw in "$device"/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
			echo "bw_hwmon" >"$llccbw"/governor
			if [ "${ddr_type:4:2}" == $ddr_type4 ]; then
				echo "1720 2086 2929 3879 5161 5931 6881 7980" >"$llccbw"/bw_hwmon/mbps_zones
			elif [ "${ddr_type:4:2}" == $ddr_type5 ]; then
				echo "1720 2086 2929 3879 5931 6881 7980 10437" >"$llccbw"/bw_hwmon/mbps_zones
			fi
			echo "4" >"$llccbw"/bw_hwmon/sample_ms
			echo "80" >"$llccbw"/bw_hwmon/io_percent
			echo "20" >"$llccbw"/bw_hwmon/hist_memory
			echo "10" >"$llccbw"/bw_hwmon/hyst_length
			echo "30" >"$llccbw"/bw_hwmon/down_thres
			echo "0" >"$llccbw"/bw_hwmon/guard_band_mbps
			echo "250" >"$llccbw"/bw_hwmon/up_scale
			echo "1600" >"$llccbw"/bw_hwmon/idle_mbps
			echo "6881" >"$llccbw"/max_freq
			echo "40" >"$llccbw"/polling_interval
		done
		for npubw in "$device"/*npu*-ddr-bw/devfreq/*npu*-ddr-bw; do
			echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
			echo "bw_hwmon" >"$npubw"/governor
			if [ "${ddr_type:4:2}" == $ddr_type4 ]; then
				echo "1720 2086 2929 3879 5931 6881 7980" >"$npubw"/bw_hwmon/mbps_zones
			elif [ "${ddr_type:4:2}" == $ddr_type5 ]; then
				echo "1720 2086 2929 3879 5931 6881 7980 10437" >"$npubw"/bw_hwmon/mbps_zones
			fi
			echo "4" >"$npubw"/bw_hwmon/sample_ms
			echo "160" >"$npubw"/bw_hwmon/io_percent
			echo "20" >"$npubw"/bw_hwmon/hist_memory
			echo "10" >"$npubw"/bw_hwmon/hyst_length
			echo "30" >"$npubw"/bw_hwmon/down_thres
			echo "0" >"$npubw"/bw_hwmon/guard_band_mbps
			echo "250" >"$npubw"/bw_hwmon/up_scale
			echo "1600" >"$npubw"/bw_hwmon/idle_mbps
			echo "40" >"$npubw"/polling_interval
			echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
		done
		for npullccbw in "$device"/*npu*-llcc-bw/devfreq/*npu*-llcc-bw; do
			echo "1" >/sys/devices/virtual/npu/msm_npu/pwr
			echo "bw_hwmon" >"$npullccbw"/governor
			echo "4577 7110 9155 12298 14236 15258" >"$npullccbw"/bw_hwmon/mbps_zones
			echo "4" >"$npullccbw"/bw_hwmon/sample_ms
			echo "160" >"$npullccbw"/bw_hwmon/io_percent
			echo "20" >"$npullccbw"/bw_hwmon/hist_memory
			echo "10" >"$npullccbw"/bw_hwmon/hyst_length
			echo "30" >"$npullccbw"/bw_hwmon/down_thres
			echo "0" >"$npullccbw"/bw_hwmon/guard_band_mbps
			echo "250" >"$npullccbw"/bw_hwmon/up_scale
			echo "1600" >"$npullccbw"/bw_hwmon/idle_mbps
			echo "40" >"$npullccbw"/polling_interval
			echo "0" >/sys/devices/virtual/npu/msm_npu/pwr
		done
	done
	setprop vendor.dcvs.prop 0
	setprop vendor.dcvs.prop 1
	echo "N" >/sys/module/lpm_levels/parameters/sleep_disabled
	configure_memory_parameters
	;;
esac
case "$target" in
"msm8998" | "apq8098_latv")
	echo "2" >/sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo "60" >/sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo "30" >/sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo "100" >/sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo "1" >/sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
	echo "4" >/sys/devices/system/cpu/cpu4/core_ctl/task_thres
	echo "1" >/proc/sys/kernel/sched_migration_fixup
	echo "95" >/proc/sys/kernel/sched_upmigrate
	echo "90" >/proc/sys/kernel/sched_downmigrate
	echo "100" >/proc/sys/kernel/sched_group_upmigrate
	echo "95" >/proc/sys/kernel/sched_group_downmigrate
	echo "0" >/proc/sys/kernel/sched_select_prev_cpu_us
	echo "400000" >/proc/sys/kernel/sched_freq_inc_notify
	echo "400000" >/proc/sys/kernel/sched_freq_dec_notify
	echo "5" >/proc/sys/kernel/sched_spill_nr_run
	echo "1" >/proc/sys/kernel/sched_restrict_cluster_spill
	echo "1" >/proc/sys/kernel/sched_prefer_sync_wakee_to_waker
	start iop
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
	echo "19000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
	echo "1248000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
	echo "83 1804800:95" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo "19000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
	echo "79000" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
	echo "1" >/sys/devices/system/cpu/cpu4/online
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
	echo "19000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
	echo "20000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
	echo "1574400" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
	echo "83 1939200:90 2016000:95" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
	echo "19000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
	echo "79000" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
	echo "1" >/sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	echo "0:1324800" >/sys/module/cpu_boost/parameters/input_boost_freq
	echo "40" >/sys/module/cpu_boost/parameters/input_boost_ms
	for cpubw in /sys/class/devfreq/*qcom,cpubw*; do
		echo "bw_hwmon" >"$cpubw"/governor
		echo "50" >"$cpubw"/polling_interval
		echo "1525" >"$cpubw"/min_freq
		echo "3143 5859 11863 13763" >"$cpubw"/bw_hwmon/mbps_zones
		echo "4" >"$cpubw"/bw_hwmon/sample_ms
		echo "34" >"$cpubw"/bw_hwmon/io_percent
		echo "20" >"$cpubw"/bw_hwmon/hist_memory
		echo "10" >"$cpubw"/bw_hwmon/hyst_length
		echo "0" >"$cpubw"/bw_hwmon/low_power_ceil_mbps
		echo "34" >"$cpubw"/bw_hwmon/low_power_io_percent
		echo "20" >"$cpubw"/bw_hwmon/low_power_delay
		echo "0" >"$cpubw"/bw_hwmon/guard_band_mbps
		echo "250" >"$cpubw"/bw_hwmon/up_scale
		echo "1600" >"$cpubw"/bw_hwmon/idle_mbps
	done
	for memlat in /sys/class/devfreq/*qcom,memlat-cpu*; do
		echo "mem_latency" >"$memlat"/governor
		echo "10" >"$memlat"/polling_interval
		echo "400" >"$memlat"/mem_latency/ratio_ceil
	done
	echo "cpufreq" >/sys/class/devfreq/soc:qcom,mincpubw/governor
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=$(cat /sys/devices/soc0/hw_platform)
	else
		hw_platform=$(cat /sys/devices/system/soc/soc0/hw_platform)
	fi
	if [ -f /sys/devices/soc0/platform_version ]; then
		platform_version=$(cat /sys/devices/soc0/platform_version)
		platform_major_version=$((10#${platform_version} >> 16))
	fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=$(cat /sys/devices/soc0/platform_subtype_id)
	fi
	case "$soc_id" in
	"292")
		case "$hw_platform" in
		"QRD")
			case "$platform_subtype_id" in
			"0")
				start_hbtp
				;;
			"16")
				if [ "$platform_major_version" -lt 6 ]; then
					start_hbtp
				fi
				;;
			esac
			;;
		esac
		;;
	esac
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu0/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu1/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu2/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/cpu3/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu4/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu5/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu6/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/cpu7/ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/pwr/pwr-l2-ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
	echo "N" >/sys/module/lpm_levels/system/perf/perf-l2-ret/idle_enabled
	echo "N" >/sys/module/lpm_levels/parameters/sleep_disabled
	echo "0-3" >/dev/cpuset/background/cpus
	echo "0-3" >/dev/cpuset/system-background/cpus
	echo "0" >/proc/sys/kernel/sched_boost
	configure_memory_parameters
	;;
esac
case "$target" in
"msm8909")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	echo "3" >/proc/sys/kernel/sched_window_stats_policy
	echo "3" >/proc/sys/kernel/sched_ravg_hist_size
	echo "1" >/proc/sys/kernel/sched_restrict_tasks_spread
	echo "20" >/proc/sys/kernel/sched_small_task
	echo "30" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_load
	echo "30" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_load
	echo "3" >/sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
	echo "3" >/sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
	echo "0" >/sys/devices/system/cpu/cpu0/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu1/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu2/sched_prefer_idle
	echo "0" >/sys/devices/system/cpu/cpu3/sched_prefer_idle
	echo "0" >/sys/module/msm_thermal/core_control/enabled
	echo "1" >/sys/devices/system/cpu/cpu0/online
	echo "1" >/sys/module/msm_thermal/core_control/enabled
	echo "29000 1094400:49000" >/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
	echo "90" >/sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
	echo "30000" >/sys/devices/system/cpu/cpufreq/interactive/timer_rate
	echo "998400" >/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
	echo "0" >/sys/devices/system/cpu/cpufreq/interactive/io_is_busy
	echo "1 800000:85 998400:90 1094400:80" >/sys/devices/system/cpu/cpufreq/interactive/target_loads
	echo "50000" >/sys/devices/system/cpu/cpufreq/interactive/min_sample_time
	echo "50000" >/sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
	echo "1" >/sys/devices/system/cpu/cpu1/online
	echo "1" >/sys/devices/system/cpu/cpu2/online
	echo "1" >/sys/devices/system/cpu/cpu3/online
	echo "0" >/sys/module/lpm_levels/parameters/sleep_disabled
	for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor; do
		echo "bw_hwmon" >"$devfreq_gov"
		for cpu_bimc_bw_step in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/bw_step; do
			echo "60" >"$cpu_bimc_bw_step"
		done
		for cpu_guard_band_mbps in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/guard_band_mbps; do
			echo "30" >"$cpu_guard_band_mbps"
		done
	done
	for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent; do
		echo "40" >"$gpu_bimc_io_percent"
	done
	for gpu_bimc_bw_step in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/bw_step; do
		echo "60" >"$gpu_bimc_bw_step"
	done
	for gpu_bimc_guard_band_mbps in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/guard_band_mbps; do
		echo "30" >"$gpu_bimc_guard_band_mbps"
	done
	configure_memory_parameters
	restorecon -R /sys/devices/system/cpu
	;;
esac
case "$target" in
"msm7627_ffa" | "msm7627_surf" | "msm7627_6x")
	echo "25000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	;;
esac
case "$target" in
"qsd8250_surf" | "qsd8250_ffa" | "qsd8650a_st1x")
	echo "50000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	;;
esac
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
emmc_boot=$(getprop vendor.boot.emmc)
case "$emmc_boot" in "true")
	chown -h system /sys/devices/platform/rs300000a7.65536/force_sync
	chown -h system /sys/devices/platform/rs300000a7.65536/sync_sts
	chown -h system /sys/devices/platform/rs300100a7.65536/force_sync
	chown -h system /sys/devices/platform/rs300100a7.65536/sync_sts
	;;
esac
case "$target" in
"msm8960" | "msm8660" | "msm7630_surf")
	echo "10" >/sys/devices/platform/msm_sdcc.3/idle_timeout
	;;
"msm7627a")
	echo "10" >/sys/devices/platform/msm_sdcc.1/idle_timeout
	;;
esac
case "$target" in
"msm8660" | "msm8960" | "msm8226" | "msm8610" | "mpq8092")
	start mpdecision
	;;
"msm8974")
	start mpdecision
	echo "512" >/sys/block/mmcblk0/bdi/read_ahead_kb
	;;
"msm8909" | "msm8916" | "msm8937" | "msm8952" | "msm8953" | "msm8994" | "msm8992" | "msm8996" | "msm8998" | "sdm660" | "apq8098_latv" | "sdm845" | "sdm710" | "msmnile" | "msmsteppe" | "sm6150" | "kona" | "lito" | "trinket" | "atoll" | "bengal" | "sdmshrike")
	setprop vendor.post_boot.parsed 1
	;;
"apq8084")
	rm /data/system/perfd/default_values
	start mpdecision
	echo "512" >/sys/block/mmcblk0/bdi/read_ahead_kb
	echo "512" >/sys/block/sda/bdi/read_ahead_kb
	echo "512" >/sys/block/sdb/bdi/read_ahead_kb
	echo "512" >/sys/block/sdc/bdi/read_ahead_kb
	echo "512" >/sys/block/sdd/bdi/read_ahead_kb
	echo "512" >/sys/block/sde/bdi/read_ahead_kb
	echo "512" >/sys/block/sdf/bdi/read_ahead_kb
	echo "512" >/sys/block/sdg/bdi/read_ahead_kb
	echo "512" >/sys/block/sdh/bdi/read_ahead_kb
	;;
"msm7627a")
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=$(cat /sys/devices/soc0/soc_id)
	else
		soc_id=$(cat /sys/devices/system/soc/soc0/id)
	fi
	case "$soc_id" in
	"127" | "128" | "129")
		start mpdecision
		;;
	esac
	;;
esac
case "$target" in
"msm7627a")
	start qosmgrd
	echo "1" >/sys/module/pm2/modes/cpu0/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/pm2/modes/cpu1/standalone_power_collapse/idle_enabled
	echo "1" >/sys/module/pm2/modes/cpu0/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/pm2/modes/cpu1/standalone_power_collapse/suspend_enabled
	echo "1" >/sys/module/pm2/modes/cpu0/power_collapse/suspend_enabled
	echo "1" >/sys/module/pm2/modes/cpu0/power_collapse/idle_enabled
	echo "25000" >/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
	;;
esac
case "$target" in
"msm7627a")
	echo "0,1,2,4,9,12" >/sys/module/lowmemorykiller/parameters/adj
	echo "5120" >/proc/sys/vm/min_free_kbytes
	;;
esac
case "$target" in
"msm8660")
	start qosmgrd
	echo "0,1,2,4,9,12" >/sys/module/lowmemorykiller/parameters/adj
	echo "5120" >/proc/sys/vm/min_free_kbytes
	;;
esac
if [ -f /sys/devices/soc0/select_image ]; then
	image_version="10:"
	image_version+=$(getprop ro.build.id)
	image_version+=":"
	image_version+=$(getprop ro.build.version.incremental)
	image_variant=$(getprop ro.product.name)
	image_variant+="-"
	image_variant+=$(getprop ro.build.type)
	oem_version=$(getprop ro.build.version.codename)
	echo "10" >/sys/devices/soc0/select_image
	echo "$image_version" >/sys/devices/soc0/image_version
	echo "$image_variant" >/sys/devices/soc0/image_variant
	echo "$oem_version" >/sys/devices/soc0/image_crm_version
fi
misc_link=$(ls -l /dev/block/bootdevice/by-name/misc)
real_path=${misc_link##*>}
setprop persist.vendor.mmi.misc_dev_path "$real_path"
