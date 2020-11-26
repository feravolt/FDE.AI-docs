#! /vendor/bin/sh

# Copyright (c) 2012-2013, 2016-2020, The Linux Foundation. All rights reserved.
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

function 8953_sched_dcvs_eas()
{
    #governor settings
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
    #set the hispeed_freq
    echo 1401600 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_freq
    #default value for hispeed_load is 90, for 8953 and sdm450 it should be 85
    echo 85 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_load
}

function 8917_sched_dcvs_eas()
{
    #governor settings
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
    #set the hispeed_freq
    echo 1094400 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_freq
    #default value for hispeed_load is 90, for 8917 it should be 85
    echo 85 > /sys/devices/system/cpu/cpufreq/schedutil/hispeed_load
}

function 8937_sched_dcvs_eas()
{
    # enable governor for perf cluster
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
    #set the hispeed_freq
    echo 1094400 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
    #default value for hispeed_load is 90, for 8937 it should be 85
    echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
    ## enable governor for power cluster
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/rate_limit_us
    #set the hispeed_freq
    echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
    #default value for hispeed_load is 90, for 8937 it should be 85
    echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load

}

function configure_automotive_sku_parameters() {

    echo 1036800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo 1056000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo 1171200 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
    echo 1785600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
    echo 902400000  > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
    echo 902400000  > /sys/class/devfreq/soc\:qcom,cpu4-cpu-l3-lat/min_freq
    echo 902400000  > /sys/class/devfreq/soc\:qcom,cpu7-cpu-l3-lat/min_freq
    echo 1612800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
    echo 1612800000 > /sys/class/devfreq/soc\:qcom,cpu4-cpu-l3-lat/max_freq
    echo 1612800000 > /sys/class/devfreq/soc\:qcom,cpu7-cpu-l3-lat/max_freq
#read feature id from nvram
reg_val=`cat /sys/devices/platform/soc/780130.qfprom/qfprom0/nvmem | od -An -t d4`
feature_id=$(((reg_val >> 20) & 0xFF))
log -t BOOT -p i "feature id '$feature_id'"
if [ $feature_id == 0 ]; then
       echo " SKU Configured : SA8155P"
       echo 2131200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
       echo 2419200 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
       echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
elif [ $feature_id == 1 ]; then
        echo "SKU Configured : SA8150P"
        echo 1920000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        echo 2227200 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
        echo 3 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
else
        echo "unknown feature_id value" $feature_id
fi
}

function configure_sku_parameters() {

#read feature id from nvram
reg_val=`cat /sys/devices/platform/soc/780130.qfprom/qfprom0/nvmem | od -An -t d4`
feature_id=$(((reg_val >> 20) & 0xFF))
log -t BOOT -p i "feature id '$feature_id'"
if [ $feature_id == 6 ]; then
	echo " SKU Configured : SA6145"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1017600000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1017600000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 3 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo {class:ddr, res:capped, val: 1016} > /sys/kernel/debug/aop_send_message
	setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6145"
elif [ $feature_id == 5 ]; then
	echo "SKU Configured : SA6150"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 998400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 998400 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1708800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1708800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 2 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo {class:ddr, res:capped, val: 1333} > /sys/kernel/debug/aop_send_message
	setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6150"
elif [ $feature_id == 4 ] || [ $feature_id == 3 ]; then
	echo "SKU Configured : SA6155"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 1593600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo {class:ddr, res:capped, val: 1555} > /sys/kernel/debug/aop_send_message
	setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6155"
else
	echo "SKU Configured : SA6155"
	echo 748800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 748800 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
	echo 1017600 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
	echo 1593600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
	echo 1593600 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_max_freq
	echo 1900800 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu0-cpu-l3-lat/max_freq
	echo 940800000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/min_freq
	echo 1363200000 > /sys/class/devfreq/soc\:qcom,cpu6-cpu-l3-lat/max_freq
	echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
	echo {class:ddr, res:capped, val: 1555} > /sys/kernel/debug/aop_send_message
        setprop vendor.sku_identified 1
	setprop vendor.sku_name "SA6155"
fi
}

function 8953_sched_dcvs_hmp()
{
    #scheduler settings
    echo 3 > /proc/sys/kernel/sched_window_stats_policy
    echo 3 > /proc/sys/kernel/sched_ravg_hist_size
    #task packing settings
    echo 0 > /sys/devices/system/cpu/cpu0/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu1/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu2/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu3/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu4/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu5/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu6/sched_static_cpu_pwr_cost
    echo 0 > /sys/devices/system/cpu/cpu7/sched_static_cpu_pwr_cost
    # spill load is set to 100% by default in the kernel
    echo 3 > /proc/sys/kernel/sched_spill_nr_run
    # Apply inter-cluster load balancer restrictions
    echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
    # set sync wakee policy tunable
    echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker

    #governor settings
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "19000 1401600:39000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
    echo 85 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
    echo 1401600 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
    echo "85 1401600:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
    echo 39000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
    echo 19 > /proc/sys/kernel/sched_upmigrate_min_nice
    # Enable sched guided freq control
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif
    echo 200000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 200000 > /proc/sys/kernel/sched_freq_dec_notify

}

function 8917_sched_dcvs_hmp()
{
    # HMP scheduler settings
    echo 3 > /proc/sys/kernel/sched_window_stats_policy
    echo 3 > /proc/sys/kernel/sched_ravg_hist_size
    echo 1 > /proc/sys/kernel/sched_restrict_tasks_spread
    # HMP Task packing settings
    echo 20 > /proc/sys/kernel/sched_small_task
    echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load

    echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run

    echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle

    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "19000 1094400:39000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
    echo 85 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
    echo 1094400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
    echo "1 960000:85 1094400:90" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
    echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor

    # Enable sched guided freq control
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpufreq/interactive/use_migration_notif
    echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 50000 > /proc/sys/kernel/sched_freq_dec_notify
}

function 8937_sched_dcvs_hmp()
{
    # HMP scheduler settings
    echo 3 > /proc/sys/kernel/sched_window_stats_policy
    echo 3 > /proc/sys/kernel/sched_ravg_hist_size
    # HMP Task packing settings
    echo 20 > /proc/sys/kernel/sched_small_task
    echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_load
    echo 30 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_load

    echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
    echo 3 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run

    echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu4/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu5/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu6/sched_prefer_idle
    echo 0 > /sys/devices/system/cpu/cpu7/sched_prefer_idle
    # enable governor for perf cluster
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo "19000 1094400:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
    echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
    echo 1094400 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
    echo "1 960000:85 1094400:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
    echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor

    # enable governor for power cluster
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
    echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
    echo "1 768000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
    echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
    echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor

    # Enable sched guided freq control
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
    echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 50000 > /proc/sys/kernel/sched_freq_dec_notify

}

function sdm660_sched_interactive_dcvs() {

    echo 0 > /proc/sys/kernel/sched_select_prev_cpu_us
    echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
    echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
    echo 5 > /proc/sys/kernel/sched_spill_nr_run
    echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
    echo 100000 > /proc/sys/kernel/sched_short_burst_ns
    echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker
    echo 20 > /proc/sys/kernel/sched_small_wakee_task_load

    # disable thermal bcl hotplug to switch governor
    echo 0 > /sys/module/msm_thermal/core_control/enabled

    # online CPU0
    echo 1 > /sys/devices/system/cpu/cpu0/online
    # configure governor settings for little cluster
    echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
    echo "19000 1401600:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
    echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
    echo "85 1747200:95" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
    echo 39000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
    echo 633600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
    echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/fast_ramp_down
    # online CPU4
    echo 1 > /sys/devices/system/cpu/cpu4/online
    # configure governor settings for big cluster
    echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
    echo "19000 1401600:39000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
    echo 1401600 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
    echo "85 1401600:90 2150400:95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
    echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
    echo 59000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
    echo 1113600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif
    echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/fast_ramp_down

    # bring all cores online
    echo 1 > /sys/devices/system/cpu/cpu0/online
    echo 1 > /sys/devices/system/cpu/cpu1/online
    echo 1 > /sys/devices/system/cpu/cpu2/online
    echo 1 > /sys/devices/system/cpu/cpu3/online
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo 1 > /sys/devices/system/cpu/cpu5/online
    echo 1 > /sys/devices/system/cpu/cpu6/online
    echo 1 > /sys/devices/system/cpu/cpu7/online

    # configure LPM
    echo N > /sys/module/lpm_levels/system/pwr/cpu0/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/cpu1/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/cpu2/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/cpu3/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu4/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu5/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu6/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/cpu7/ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
    echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-ret/idle_enabled
    echo N > /sys/module/lpm_levels/system/perf/perf-l2-ret/idle_enabled

    # re-enable thermal and BCL hotplug
    echo 1 > /sys/module/msm_thermal/core_control/enabled

    # Enable bus-dcvs
    for cpubw in /sys/class/devfreq/*qcom,cpubw*
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo 762 > $cpubw/min_freq
            echo "1525 3143 5859 7759 9887 10327 11863 13763" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 85 > $cpubw/bw_hwmon/io_percent
            echo 100 > $cpubw/bw_hwmon/decay_rate
            echo 50 > $cpubw/bw_hwmon/bw_step
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 0 > $cpubw/bw_hwmon/hyst_length
            echo 80 > $cpubw/bw_hwmon/down_thres
            echo 0 > $cpubw/bw_hwmon/low_power_ceil_mbps
            echo 34 > $cpubw/bw_hwmon/low_power_io_percent
            echo 20 > $cpubw/bw_hwmon/low_power_delay
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

    for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done
    echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor
}

function sdm660_sched_schedutil_dcvs() {

    # configure governor settings for little cluster
    echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
    echo 1401600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq

    # configure governor settings for big cluster
    echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
    echo 1401600 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq

    echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

    echo "0:1401600" > /sys/module/cpu_boost/parameters/input_boost_freq
    echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

    # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
    echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu5/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
    echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
    echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load

    # Enable bus-dcvs
    for device in /sys/devices/platform/soc
    do
        for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo 762 > $cpubw/min_freq
            echo "1525 3143 5859 7759 9887 10327 11863 13763" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 85 > $cpubw/bw_hwmon/io_percent
            echo 100 > $cpubw/bw_hwmon/decay_rate
            echo 50 > $cpubw/bw_hwmon/bw_step
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 0 > $cpubw/bw_hwmon/hyst_length
            echo 80 > $cpubw/bw_hwmon/down_thres
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

        for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done

        for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
        do
            echo "compute" > $latfloor/governor
            echo 10 > $latfloor/polling_interval
        done

    done
}

target=`getprop ro.board.platform`

function configure_read_ahead_kb_values() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    dmpts=$(ls /sys/block/*/queue/read_ahead_kb | grep -e dm -e mmc)

    # Set 128 for <= 3GB &
    # set 512 for >= 4GB targets.
    if [ $MemTotal -le 3145728 ]; then
        echo 128 > /sys/block/mmcblk0/bdi/read_ahead_kb
        echo 128 > /sys/block/mmcblk0rpmb/bdi/read_ahead_kb
        for dm in $dmpts; do
            echo 128 > $dm
        done
    else
        echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
        echo 512 > /sys/block/mmcblk0rpmb/bdi/read_ahead_kb
        for dm in $dmpts; do
            echo 512 > $dm
        done
    fi
}

function disable_core_ctl() {
    if [ -f /sys/devices/system/cpu/cpu0/core_ctl/enable ]; then
        echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
    else
        echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/disable
    fi
}

function enable_swap() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    SWAP_ENABLE_THRESHOLD=1048576
    swap_enable=`getprop ro.vendor.qti.config.swap`

    # Enable swap initially only for 1 GB targets
    if [ "$MemTotal" -le "$SWAP_ENABLE_THRESHOLD" ] && [ "$swap_enable" == "true" ]; then
        # Static swiftness
        echo 1 > /proc/sys/vm/swap_ratio_enable
        echo 70 > /proc/sys/vm/swap_ratio

        # Swap disk - 200MB size
        if [ ! -f /data/vendor/swap/swapfile ]; then
            dd if=/dev/zero of=/data/vendor/swap/swapfile bs=1m count=200
        fi
        mkswap /data/vendor/swap/swapfile
        swapon /data/vendor/swap/swapfile -p 32758
    fi
}

function configure_memory_parameters() {
    # Set Memory parameters.
    #
    # Set per_process_reclaim tuning parameters
    # All targets will use vmpressure range 50-70,
    # All targets will use 512 pages swap size.
    #
    # Set Low memory killer minfree parameters
    # 32 bit Non-Go, all memory configurations will use 15K series
    # 32 bit Go, all memory configurations will use uLMK + Memcg
    # 64 bit will use Google default LMK series.
    #
    # Set ALMK parameters (usually above the highest minfree values)
    # vmpressure_file_min threshold is always set slightly higher
    # than LMK minfree's last bin value for all targets. It is calculated as
    # vmpressure_file_min = (last bin - second last bin ) + last bin
    #
    # Set allocstall_threshold to 0 for all targets.
    #

ProductName=`getprop ro.product.name`
low_ram=`getprop ro.config.low_ram`

if [ "$ProductName" == "msmnile" ] || [ "$ProductName" == "kona" ] || [ "$ProductName" == "sdmshrike_au" ]; then
      configure_read_ahead_kb_values
      echo 0 > /proc/sys/vm/page-cluster
      echo 100 > /proc/sys/vm/swappiness
else
    arch_type=`uname -m`

    # Set parameters for 32-bit Go targets.
    if [ "$low_ram" == "true" ]; then
        # Disable KLMK, ALMK, PPR & Core Control for Go devices
        echo 0 > /sys/module/lowmemorykiller/parameters/enable_lmk
        echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
        echo 0 > /sys/module/process_reclaim/parameters/enable_process_reclaim
        disable_core_ctl
        # Enable oom_reaper for Go devices
        if [ -f /proc/sys/vm/reap_mem_on_sigkill ]; then
            echo 1 > /proc/sys/vm/reap_mem_on_sigkill
        fi
    else

        # Read adj series and set adj threshold for PPR and ALMK.
        # This is required since adj values change from framework to framework.
        adj_series=`cat /sys/module/lowmemorykiller/parameters/adj`
        adj_1="${adj_series#*,}"
        set_almk_ppr_adj="${adj_1%%,*}"

        # PPR and ALMK should not act on HOME adj and below.
        # Normalized ADJ for HOME is 6. Hence multiply by 6
        # ADJ score represented as INT in LMK params, actual score can be in decimal
        # Hence add 6 considering a worst case of 0.9 conversion to INT (0.9*6).
        # For uLMK + Memcg, this will be set as 6 since adj is zero.
        set_almk_ppr_adj=$(((set_almk_ppr_adj * 6) + 6))
        echo $set_almk_ppr_adj > /sys/module/lowmemorykiller/parameters/adj_max_shift

        # Calculate vmpressure_file_min as below & set for 64 bit:
        # vmpressure_file_min = last_lmk_bin + (last_lmk_bin - last_but_one_lmk_bin)
        if [ "$arch_type" == "aarch64" ]; then
            minfree_series=`cat /sys/module/lowmemorykiller/parameters/minfree`
            minfree_1="${minfree_series#*,}" ; rem_minfree_1="${minfree_1%%,*}"
            minfree_2="${minfree_1#*,}" ; rem_minfree_2="${minfree_2%%,*}"
            minfree_3="${minfree_2#*,}" ; rem_minfree_3="${minfree_3%%,*}"
            minfree_4="${minfree_3#*,}" ; rem_minfree_4="${minfree_4%%,*}"
            minfree_5="${minfree_4#*,}"

            vmpres_file_min=$((minfree_5 + (minfree_5 - rem_minfree_4)))
            echo $vmpres_file_min > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
        else
            # Set LMK series, vmpressure_file_min for 32 bit non-go targets.
            # Disable Core Control, enable KLMK for non-go 8909.
            if [ "$ProductName" == "msm8909" ]; then
                disable_core_ctl
                echo 1 > /sys/module/lowmemorykiller/parameters/enable_lmk
            fi
        echo "15360,19200,23040,26880,34415,43737" > /sys/module/lowmemorykiller/parameters/minfree
        echo 53059 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
        fi

        # Enable adaptive LMK for all targets &
        # use Google default LMK series for all 64-bit targets >=2GB.
        echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk

        # Enable oom_reaper
        if [ -f /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
            echo 1 > /sys/module/lowmemorykiller/parameters/oom_reaper
        fi

        if [[ "$ProductName" != "bengal"* ]]; then
            #bengal has appcompaction enabled. So not needed
            # Set PPR parameters for other targets
            if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
            else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
            fi

            case "$soc_id" in
              # Do not set PPR parameters for premium targets
              # sdm845 - 321, 341
              # msm8998 - 292, 319
              # msm8996 - 246, 291, 305, 312
              "321" | "341" | "292" | "319" | "246" | "291" | "305" | "312")
                ;;
              *)
                #Set PPR parameters for all other targets.
                echo $set_almk_ppr_adj > /sys/module/process_reclaim/parameters/min_score_adj
                echo 1 > /sys/module/process_reclaim/parameters/enable_process_reclaim
                echo 50 > /sys/module/process_reclaim/parameters/pressure_min
                echo 70 > /sys/module/process_reclaim/parameters/pressure_max
                echo 30 > /sys/module/process_reclaim/parameters/swap_opt_eff
                echo 512 > /sys/module/process_reclaim/parameters/per_swap_size
                ;;
            esac
        fi
    fi

    if [[ "$ProductName" == "bengal"* ]]; then
        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi
        case "$soc_id" in
            # Only for scuba and scuba iot qcm
            "441" | "473")
            #Set PPR nomap parameters for scuba and scuba iot qcm targets
            echo 1 > /sys/module/process_reclaim/parameters/enable_process_reclaim
            echo 50 > /sys/module/process_reclaim/parameters/pressure_min
            echo 70 > /sys/module/process_reclaim/parameters/pressure_max
            echo 30 > /sys/module/process_reclaim/parameters/swap_opt_eff
            echo 0 > /sys/module/process_reclaim/parameters/per_swap_size
            echo 7680 > /sys/module/process_reclaim/parameters/tsk_nomap_swap_sz
            ;;
        esac
    fi

    # Set allocstall_threshold to 0 for all targets.
    # Set swappiness to 100 for all targets
    echo 0 > /sys/module/vmpressure/parameters/allocstall_threshold
    echo 100 > /proc/sys/vm/swappiness

    # Disable wsf for all targets beacause we are using efk.
    # wsf Range : 1..1000 So set to bare minimum value 1.
    echo 1 > /proc/sys/vm/watermark_scale_factor

    configure_read_ahead_kb_values

    enable_swap
fi
}

function enable_memory_features()
{
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    if [ $MemTotal -le 2097152 ]; then
        #Enable B service adj transition for 2GB or less memory
        setprop ro.vendor.qti.sys.fw.bservice_enable true
        setprop ro.vendor.qti.sys.fw.bservice_limit 5
        setprop ro.vendor.qti.sys.fw.bservice_age 5000

        #Enable Delay Service Restart
        setprop ro.vendor.qti.am.reschedule_service true
    fi
}

function start_hbtp()
{
        # Start the Host based Touch processing but not in the power off mode.
        bootmode=`getprop ro.bootmode`
        if [ "charger" != $bootmode ]; then
                start vendor.hbtp
        fi
}

case "$target" in
    "msm7201a_ffa" | "msm7201a_surf" | "msm7627_ffa" | "msm7627_6x" | "msm7627a"  | "msm7627_surf" | \
    "qsd8250_surf" | "qsd8250_ffa" | "msm7630_surf" | "msm7630_1x" | "msm7630_fusion" | "qsd8650a_st1x")
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
        ;;
esac

case "$target" in
    "msm7201a_ffa" | "msm7201a_surf")
        echo 500000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        ;;
esac

case "$target" in
    "msm7630_surf" | "msm7630_1x" | "msm7630_fusion")
        echo 75000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        echo 1 > /sys/module/pm2/parameters/idle_sleep_mode
        ;;
esac

case "$target" in
     "msm7201a_ffa" | "msm7201a_surf" | "msm7627_ffa" | "msm7627_6x" | "msm7627_surf" | "msm7630_surf" | "msm7630_1x" | "msm7630_fusion" | "msm7627a" )
        echo 245760 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        ;;
esac

case "$target" in
    "msm8660")
     echo 1 > /sys/module/rpm_resources/enable_low_power/L2_cache
     echo 1 > /sys/module/rpm_resources/enable_low_power/pxo
     echo 2 > /sys/module/rpm_resources/enable_low_power/vdd_dig
     echo 2 > /sys/module/rpm_resources/enable_low_power/vdd_mem
     echo 1 > /sys/module/rpm_resources/enable_low_power/rpm_cpu
     echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
     echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
     echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
     echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
     echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
     echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
     echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
     echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
     echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
     echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
     echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
     echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
     echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
     echo 4 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
     echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
     echo 384000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
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
         echo 1 > /sys/module/rpm_resources/enable_low_power/L2_cache
         echo 1 > /sys/module/rpm_resources/enable_low_power/pxo
         echo 1 > /sys/module/rpm_resources/enable_low_power/vdd_dig
         echo 1 > /sys/module/rpm_resources/enable_low_power/vdd_mem
         echo 1 > /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
         echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
	 echo 0 > /sys/module/msm_thermal/core_control/enabled
         echo 1 > /sys/devices/system/cpu/cpu1/online
         echo 1 > /sys/devices/system/cpu/cpu2/online
         echo 1 > /sys/devices/system/cpu/cpu3/online
         echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
         echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
         echo "ondemand" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
         echo "ondemand" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
         echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
         echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
         echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
         echo 4 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
         echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
         echo 70 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
         echo 3 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
         echo 918000 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
         echo 1026000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq
         echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
         chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
         chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
         chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
         echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
         echo 384000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
         echo 384000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
         echo 384000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
         chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
         chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
         chown -h system /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
         chown -h system /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
         chown -h system /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
         chown -h system /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
         chown -h system /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
         chown -h system /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
	 echo 1 > /sys/module/msm_thermal/core_control/enabled
         chown -h root.system /sys/devices/system/cpu/mfreq
         chmod -h 220 /sys/devices/system/cpu/mfreq
         chown -h root.system /sys/devices/system/cpu/cpu1/online
         chown -h root.system /sys/devices/system/cpu/cpu2/online
         chown -h root.system /sys/devices/system/cpu/cpu3/online
         chmod -h 664 /sys/devices/system/cpu/cpu1/online
         chmod -h 664 /sys/devices/system/cpu/cpu2/online
         chmod -h 664 /sys/devices/system/cpu/cpu3/online
         # set DCVS parameters for CPU
         echo 40000 > /sys/module/msm_dcvs/cores/cpu0/slack_time_max_us
         echo 40000 > /sys/module/msm_dcvs/cores/cpu0/slack_time_min_us
         echo 100000 > /sys/module/msm_dcvs/cores/cpu0/em_win_size_min_us
         echo 500000 > /sys/module/msm_dcvs/cores/cpu0/em_win_size_max_us
         echo 0 > /sys/module/msm_dcvs/cores/cpu0/slack_mode_dynamic
         echo 1000000 > /sys/module/msm_dcvs/cores/cpu0/disable_pc_threshold
         echo 25000 > /sys/module/msm_dcvs/cores/cpu1/slack_time_max_us
         echo 25000 > /sys/module/msm_dcvs/cores/cpu1/slack_time_min_us
         echo 100000 > /sys/module/msm_dcvs/cores/cpu1/em_win_size_min_us
         echo 500000 > /sys/module/msm_dcvs/cores/cpu1/em_win_size_max_us
         echo 0 > /sys/module/msm_dcvs/cores/cpu1/slack_mode_dynamic
         echo 1000000 > /sys/module/msm_dcvs/cores/cpu1/disable_pc_threshold
         echo 25000 > /sys/module/msm_dcvs/cores/cpu2/slack_time_max_us
         echo 25000 > /sys/module/msm_dcvs/cores/cpu2/slack_time_min_us
         echo 100000 > /sys/module/msm_dcvs/cores/cpu2/em_win_size_min_us
         echo 500000 > /sys/module/msm_dcvs/cores/cpu2/em_win_size_max_us
         echo 0 > /sys/module/msm_dcvs/cores/cpu2/slack_mode_dynamic
         echo 1000000 > /sys/module/msm_dcvs/cores/cpu2/disable_pc_threshold
         echo 25000 > /sys/module/msm_dcvs/cores/cpu3/slack_time_max_us
         echo 25000 > /sys/module/msm_dcvs/cores/cpu3/slack_time_min_us
         echo 100000 > /sys/module/msm_dcvs/cores/cpu3/em_win_size_min_us
         echo 500000 > /sys/module/msm_dcvs/cores/cpu3/em_win_size_max_us
         echo 0 > /sys/module/msm_dcvs/cores/cpu3/slack_mode_dynamic
         echo 1000000 > /sys/module/msm_dcvs/cores/cpu3/disable_pc_threshold
         # set DCVS parameters for GPU
         echo 20000 > /sys/module/msm_dcvs/cores/gpu0/slack_time_max_us
         echo 20000 > /sys/module/msm_dcvs/cores/gpu0/slack_time_min_us
         echo 0 > /sys/module/msm_dcvs/cores/gpu0/slack_mode_dynamic
         # set msm_mpdecision parameters
         echo 45000 > /sys/module/msm_mpdecision/slack_time_max_us
         echo 15000 > /sys/module/msm_mpdecision/slack_time_min_us
         echo 100000 > /sys/module/msm_mpdecision/em_win_size_min_us
         echo 1000000 > /sys/module/msm_mpdecision/em_win_size_max_us
         echo 3 > /sys/module/msm_mpdecision/online_util_pct_min
         echo 25 > /sys/module/msm_mpdecision/online_util_pct_max
         echo 97 > /sys/module/msm_mpdecision/em_max_util_pct
         echo 2 > /sys/module/msm_mpdecision/rq_avg_poll_ms
         echo 10 > /sys/module/msm_mpdecision/mp_em_rounding_point_min
         echo 85 > /sys/module/msm_mpdecision/mp_em_rounding_point_max
         echo 50 > /sys/module/msm_mpdecision/iowait_threshold_pct
         #set permissions for the nodes needed by display on/off hook
         chown -h system /sys/module/msm_dcvs/cores/cpu0/slack_time_max_us
         chown -h system /sys/module/msm_dcvs/cores/cpu0/slack_time_min_us
         chown -h system /sys/module/msm_mpdecision/slack_time_max_us
         chown -h system /sys/module/msm_mpdecision/slack_time_min_us
         chmod -h 664 /sys/module/msm_dcvs/cores/cpu0/slack_time_max_us
         chmod -h 664 /sys/module/msm_dcvs/cores/cpu0/slack_time_min_us
         chmod -h 664 /sys/module/msm_mpdecision/slack_time_max_us
         chmod -h 664 /sys/module/msm_mpdecision/slack_time_min_us
         if [ -f /sys/devices/soc0/soc_id ]; then
             soc_id=`cat /sys/devices/soc0/soc_id`
         else
             soc_id=`cat /sys/devices/system/soc/soc0/id`
         fi
         case "$soc_id" in
             "130")
                 echo 230 > /sys/class/gpio/export
                 echo 228 > /sys/class/gpio/export
                 echo 229 > /sys/class/gpio/export
                 echo "in" > /sys/class/gpio/gpio230/direction
                 echo "rising" > /sys/class/gpio/gpio230/edge
                 echo "in" > /sys/class/gpio/gpio228/direction
                 echo "rising" > /sys/class/gpio/gpio228/edge
                 echo "in" > /sys/class/gpio/gpio229/direction
                 echo "rising" > /sys/class/gpio/gpio229/edge
                 echo 253 > /sys/class/gpio/export
                 echo 254 > /sys/class/gpio/export
                 echo 257 > /sys/class/gpio/export
                 echo 258 > /sys/class/gpio/export
                 echo 259 > /sys/class/gpio/export
                 echo "out" > /sys/class/gpio/gpio253/direction
                 echo "out" > /sys/class/gpio/gpio254/direction
                 echo "out" > /sys/class/gpio/gpio257/direction
                 echo "out" > /sys/class/gpio/gpio258/direction
                 echo "out" > /sys/class/gpio/gpio259/direction
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
                 echo 0 > /sys/module/rpm_resources/enable_low_power/vdd_dig
                 echo 0 > /sys/module/rpm_resources/enable_low_power/vdd_mem
                 ;;
         esac
         ;;
esac

case "$target" in
    "msm8974")
        echo 4 > /sys/module/lpm_levels/enable_low_power/l2
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/retention/idle_enabled
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi
        case "$soc_id" in
            "208" | "211" | "214" | "217" | "209" | "212" | "215" | "218" | "194" | "210" | "213" | "216")
                for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
                do
                    echo "cpubw_hwmon" > $devfreq_gov
                done
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                echo "interactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                echo "20000 1400000:40000 1700000:20000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
                echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
                echo 1190400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
                echo 1 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
                echo "85 1500000:90 1800000:70" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
                echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
                echo 20 > /sys/module/cpu_boost/parameters/boost_ms
                echo 1728000 > /sys/module/cpu_boost/parameters/sync_threshold
                echo 100000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
                echo 1497600 > /sys/module/cpu_boost/parameters/input_boost_freq
                echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
            ;;
            *)
                echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
                echo "ondemand" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
                echo "ondemand" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
                echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
                echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
                echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
                echo 2 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
                echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
                echo 70 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
                echo 3 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
                echo 960000 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
                echo 960000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq
                echo 1190400 > /sys/devices/system/cpu/cpufreq/ondemand/input_boost
                echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
            ;;
        esac
        echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
        chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
        chown -h system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        chown -h root.system /sys/devices/system/cpu/mfreq
        chmod -h 220 /sys/devices/system/cpu/mfreq
        chown -h root.system /sys/devices/system/cpu/cpu1/online
        chown -h root.system /sys/devices/system/cpu/cpu2/online
        chown -h root.system /sys/devices/system/cpu/cpu3/online
        chmod -h 664 /sys/devices/system/cpu/cpu1/online
        chmod -h 664 /sys/devices/system/cpu/cpu2/online
        chmod -h 664 /sys/devices/system/cpu/cpu3/online
        echo 1 > /dev/cpuctl/apps/cpu.notify_on_migrate
    ;;
esac

case "$target" in
    "msm8916")
        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi
        case "$soc_id" in
            "206")
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 2 > /sys/class/net/rmnet0/queues/rx-0/rps_cpus
            ;;
            "247" | "248" | "249" | "250")
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
            ;;
            "239" | "241" | "263")
               if [ -f /sys/devices/soc0/revision ]; then
                   revision=`cat /sys/devices/soc0/revision`
               else
                   revision=`cat /sys/devices/system/soc/soc0/revision`
               fi
               echo 10 > /sys/class/net/rmnet0/queues/rx-0/rps_cpus
                if [ -f /sys/devices/soc0/platform_subtype_id ]; then
                    platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
                fi
                if [ -f /sys/devices/soc0/hw_platform ]; then
                    hw_platform=`cat /sys/devices/soc0/hw_platform`
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
                echo 10 > /sys/class/net/rmnet0/queues/rx-0/rps_cpus
            ;;
             "233" | "240" | "242")
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
            ;;
       esac
    ;;
esac

case "$target" in
    "msm8226")
        echo 4 > /sys/module/lpm_levels/enable_low_power/l2
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
        echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
        echo 2 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
        echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
        echo 70 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
        echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
        echo 787200 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
        echo 300000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq
        echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
        echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
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
        echo 4 > /sys/module/lpm_levels/enable_low_power/l2
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
        echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
        echo 2 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
        echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
        echo 70 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
        echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
        echo 787200 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
        echo 300000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq
        echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
        echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        setprop ro.qualcomm.perf.min_freq 7
        echo 1 > /sys/kernel/mm/ksm/deferred_timer
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
           soc_id=`cat /sys/devices/soc0/soc_id`
        else
           soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        # HMP scheduler settings for 8916, 8936, 8939, 8929
        echo 3 > /proc/sys/kernel/sched_window_stats_policy
        echo 3 > /proc/sys/kernel/sched_ravg_hist_size

        # Apply governor settings for 8916
        case "$soc_id" in
            "206" | "247" | "248" | "249" | "250")

                # HMP scheduler load tracking settings
                echo 3 > /proc/sys/kernel/sched_ravg_hist_size

                # HMP Task packing settings for 8916
                echo 20 > /proc/sys/kernel/sched_small_task
                echo 30 > /proc/sys/kernel/sched_mostly_idle_load
                echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run

                # disable thermal core_control to update scaling_min_freq
                echo 0 > /sys/module/msm_thermal/core_control/enabled
                echo 1 > /sys/devices/system/cpu/cpu0/online
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                # enable thermal core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled

                echo "25000 1094400:50000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
                echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
                echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
                echo 998400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
                echo "1 800000:85 998400:90 1094400:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
                echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
                echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu4/online
            ;;
        esac

        # Apply governor settings for 8936
        case "$soc_id" in
            "233" | "240" | "242")

                # HMP scheduler load tracking settings
                echo 3 > /proc/sys/kernel/sched_ravg_hist_size

                # HMP Task packing settings for 8936
                echo 50 > /proc/sys/kernel/sched_small_task
                echo 50 > /proc/sys/kernel/sched_mostly_idle_load
                echo 10 > /proc/sys/kernel/sched_mostly_idle_nr_run

                # disable thermal core_control to update scaling_min_freq, interactive gov
                echo 0 > /sys/module/msm_thermal/core_control/enabled
                echo 1 > /sys/devices/system/cpu/cpu0/online
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                # enable thermal core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled

                echo "25000 1113600:50000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
                echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
                echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
                echo 960000 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
                echo "1 800000:85 1113600:90 1267200:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
                echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
                echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu4/online

                # Enable low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent
                do
                        echo 40 > $gpu_bimc_io_percent
                done
            ;;
        esac

        # Apply governor settings for 8939
        case "$soc_id" in
            "239" | "241" | "263" | "268" | "269" | "270" | "271")

            if [ `cat /sys/devices/soc0/revision` != "3.0" ]; then
                # Apply 1.0 and 2.0 specific Sched & Governor settings

                # HMP scheduler load tracking settings
                echo 5 > /proc/sys/kernel/sched_ravg_hist_size

                # HMP Task packing settings for 8939, 8929
                echo 20 > /proc/sys/kernel/sched_small_task

                for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor
                do
                        echo "cpufreq" > $devfreq_gov
                done

                for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor
                do
                         echo "bw_hwmon" > $devfreq_gov
                         for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent
                         do
                                echo 20 > $cpu_io_percent
                         done
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent
                do
                         echo 40 > $gpu_bimc_io_percent
                done
                # disable thermal core_control to update interactive gov settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled

                # enable governor for perf cluster
                echo 1 > /sys/devices/system/cpu/cpu0/online
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo "20000 1113600:50000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
                echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
                echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
                echo 1113600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
                echo "1 960000:85 1113600:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
                echo 50000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
                echo 50000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor
                echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

                # enable governor for power cluster
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
                echo "25000 800000:50000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
                echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
                echo 998400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
                echo "1 800000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
                echo 800000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

                # enable thermal core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo 1 > /sys/devices/system/cpu/cpu5/online
                echo 1 > /sys/devices/system/cpu/cpu6/online
                echo 1 > /sys/devices/system/cpu/cpu7/online

                # Enable low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                # HMP scheduler (big.Little cluster related) settings
                echo 75 > /proc/sys/kernel/sched_upmigrate
                echo 60 > /proc/sys/kernel/sched_downmigrate

                # cpu idle load threshold
                echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_load

                # cpu idle nr run threshold
                echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run

            else
                # Apply 3.0 specific Sched & Governor settings
                # HMP scheduler settings for 8939 V3.0
                echo 3 > /proc/sys/kernel/sched_window_stats_policy
                echo 3 > /proc/sys/kernel/sched_ravg_hist_size
                echo 20000000 > /proc/sys/kernel/sched_ravg_window

                # HMP Task packing settings for 8939 V3.0
                echo 20 > /proc/sys/kernel/sched_small_task
                echo 30 > /proc/sys/kernel/sched_mostly_idle_load
                echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run

                echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu4/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu5/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu6/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu7/sched_prefer_idle

                for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor
                do
                        echo "cpufreq" > $devfreq_gov
                done

                for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor
                do
                    echo "bw_hwmon" > $devfreq_gov
                    for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent
                    do
                        echo 20 > $cpu_io_percent
                    done
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent
                do
                    echo 40 > $gpu_bimc_io_percent
                done
                # disable thermal core_control to update interactive gov settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled

                # enable governor for perf cluster
                echo 1 > /sys/devices/system/cpu/cpu0/online
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo "19000 1113600:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
                echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
                echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
                echo 1113600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
                echo "1 960000:85 1113600:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
                echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
                echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor
                echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

                # enable governor for power cluster
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
                echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
                echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
                echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
                echo 800000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
                echo "1 800000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
                echo 800000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

                # enable thermal core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu5/online
                echo 1 > /sys/devices/system/cpu/cpu6/online
                echo 1 > /sys/devices/system/cpu/cpu7/online

                # Enable low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                # HMP scheduler (big.Little cluster related) settings
                echo 93 > /proc/sys/kernel/sched_upmigrate
                echo 83 > /proc/sys/kernel/sched_downmigrate

                # Enable sched guided freq control
                echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
                echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
                echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
                echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
                echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
                echo 50000 > /proc/sys/kernel/sched_freq_dec_notify

                # Enable core control
#                insmod /system/lib/modules/core_ctl.ko
                echo 2 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
                echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
                echo 68 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
                echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
                echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
                case "$revision" in
                     "3.0")
                     # Enable dynamic clock gatin
                    echo 1 > /sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
                    ;;
                esac
            fi
            ;;
        esac
        # Set Memory parameters
        configure_memory_parameters
    ;;
esac

case "$target" in
    "msm8952")

        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi
        case "$soc_id" in
            "264" | "289")
                # Apply Scheduler and Governor settings for 8952

                # HMP scheduler settings
                echo 3 > /proc/sys/kernel/sched_window_stats_policy
                echo 3 > /proc/sys/kernel/sched_ravg_hist_size
                echo 20000000 > /proc/sys/kernel/sched_ravg_window

                # HMP Task packing settings
                echo 20 > /proc/sys/kernel/sched_small_task
                echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_load
                echo 30 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_load

                echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run

                echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu4/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu5/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu6/sched_prefer_idle
                echo 0 > /sys/devices/system/cpu/cpu7/sched_prefer_idle

                echo 0 > /proc/sys/kernel/sched_boost

                for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor
                do
                    echo "cpufreq" > $devfreq_gov
                done

                for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor
                do
                    echo "bw_hwmon" > $devfreq_gov
                    for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent
                    do
                        echo 20 > $cpu_io_percent
                    done
                    for cpu_guard_band in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/guard_band_mbps
                    do
                        echo 30 > $cpu_guard_band
                    done
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/qcom,gpubw*/bw_hwmon/io_percent
                do
                    echo 40 > $gpu_bimc_io_percent
                done
                # disable thermal & BCL core_control to update interactive gov settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n disable > $mode
                done
                for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
                do
                    bcl_hotplug_mask=`cat $hotplug_mask`
                    echo 0 > $hotplug_mask
                done
                for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
                do
                    bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
                    echo 0 > $hotplug_soc_mask
                done
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n enable > $mode
                done

                # enable governor for perf cluster
                echo 1 > /sys/devices/system/cpu/cpu0/online
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo "19000 1113600:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
                echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
                echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
                echo 1113600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
                echo "1 960000:85 1113600:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
                echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
                echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/sampling_down_factor
                echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

                # enable governor for power cluster
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
                echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
                echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
                echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
                echo 806400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
                echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
                echo "1 806400:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
                echo 806400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo 1 > /sys/devices/system/cpu/cpu5/online
                echo 1 > /sys/devices/system/cpu/cpu6/online
                echo 1 > /sys/devices/system/cpu/cpu7/online

                # Enable Low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                # HMP scheduler (big.Little cluster related) settings
                echo 93 > /proc/sys/kernel/sched_upmigrate
                echo 83 > /proc/sys/kernel/sched_downmigrate

                # Enable sched guided freq control
                echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
                echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
                echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
                echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
                echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
                echo 50000 > /proc/sys/kernel/sched_freq_dec_notify

                # Enable core control
                echo 2 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
                echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
                echo 68 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
                echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
                echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
                echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster

                # re-enable thermal & BCL core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n disable > $mode
                done
                for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
                do
                    echo $bcl_hotplug_mask > $hotplug_mask
                done
                for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
                do
                    echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
                done
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n enable > $mode
                done

                # Enable dynamic clock gating
                echo 1 > /sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
                # Enable timer migration to little cluster
                echo 1 > /proc/sys/kernel/power_aware_timer_migration

                # Set Memory parameters
                configure_memory_parameters

            ;;
            *)
                panel=`cat /sys/class/graphics/fb0/modes`
                if [ "${panel:5:1}" == "x" ]; then
                    panel=${panel:2:3}
                else
                    panel=${panel:2:4}
                fi

                # Apply Scheduler and Governor settings for 8976
                # SoC IDs are 266, 274, 277, 278

                # HMP scheduler (big.Little cluster related) settings
                echo 95 > /proc/sys/kernel/sched_upmigrate
                echo 85 > /proc/sys/kernel/sched_downmigrate

                echo 2 > /proc/sys/kernel/sched_window_stats_policy
                echo 5 > /proc/sys/kernel/sched_ravg_hist_size

                echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
                echo 3 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run

                for devfreq_gov in /sys/class/devfreq/*qcom,mincpubw*/governor
                do
                    echo "cpufreq" > $devfreq_gov
                done

                for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor
                do
                    echo "bw_hwmon" > $devfreq_gov
                    for cpu_io_percent in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/io_percent
                    do
                        echo 20 > $cpu_io_percent
                    done
                    for cpu_guard_band in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/guard_band_mbps
                    do
                        echo 30 > $cpu_guard_band
                    done
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/qcom,gpubw*/bw_hwmon/io_percent
                do
                    echo 40 > $gpu_bimc_io_percent
                done
                # disable thermal & BCL core_control to update interactive gov settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n disable > $mode
                done
                for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
                do
                    bcl_hotplug_mask=`cat $hotplug_mask`
                    echo 0 > $hotplug_mask
                done
                for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
                do
                    bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
                    echo 0 > $hotplug_soc_mask
                done
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n enable > $mode
                done

                # enable governor for power cluster
                echo 1 > /sys/devices/system/cpu/cpu0/online
                echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
                echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
                echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
                echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
                echo 691200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

                # enable governor for perf cluster
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
                echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
                echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
                echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
                echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/sampling_down_factor
                echo 883200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
                echo 60000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis

                if [ $panel -gt 1080 ]; then
                    #set texture cache size for resolution greater than 1080p
                    setprop ro.hwui.texture_cache_size 72
                fi

                echo 59000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
                echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
                echo "1 691200:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
                echo 1382400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
                echo "19000 1382400:39000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
                echo "85 1382400:90 1747200:80" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
                # HMP Task packing settings for 8976
                echo 30 > /proc/sys/kernel/sched_small_task
                echo 20 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
                echo 20 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
                echo 20 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
                echo 20 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load
                echo 20 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_load
                echo 20 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_load
                echo 20 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_load
                echo 20 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_load

                echo 0 > /proc/sys/kernel/sched_boost

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo 1 > /sys/devices/system/cpu/cpu5/online
                echo 1 > /sys/devices/system/cpu/cpu6/online
                echo 1 > /sys/devices/system/cpu/cpu7/online

                #Disable CPU retention modes for 32bit builds
                ProductName=`getprop ro.product.name`
                if [ "$ProductName" == "msm8952_32" ] || [ "$ProductName" == "msm8952_32_LMT" ]; then
                    echo N > /sys/module/lpm_levels/system/a72/cpu4/retention/idle_enabled
                    echo N > /sys/module/lpm_levels/system/a72/cpu5/retention/idle_enabled
                    echo N > /sys/module/lpm_levels/system/a72/cpu6/retention/idle_enabled
                    echo N > /sys/module/lpm_levels/system/a72/cpu7/retention/idle_enabled
                fi

                if [ `cat /sys/devices/soc0/revision` == "1.0" ]; then
                    # Disable l2-pc and l2-gdhs low power modes
                    echo N > /sys/module/lpm_levels/system/a53/a53-l2-gdhs/idle_enabled
                    echo N > /sys/module/lpm_levels/system/a72/a72-l2-gdhs/idle_enabled
                    echo N > /sys/module/lpm_levels/system/a53/a53-l2-pc/idle_enabled
                    echo N > /sys/module/lpm_levels/system/a72/a72-l2-pc/idle_enabled
                fi

                # Enable LPM Prediction
                echo 1 > /sys/module/lpm_levels/parameters/lpm_prediction

                # Enable Low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
                # Disable L2 GDHS on 8976
                echo N > /sys/module/lpm_levels/system/a53/a53-l2-gdhs/idle_enabled
                echo N > /sys/module/lpm_levels/system/a72/a72-l2-gdhs/idle_enabled

                # Enable sched guided freq control
                echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
                echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
                echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
                echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
                echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
                echo 50000 > /proc/sys/kernel/sched_freq_dec_notify

                # Enable core control
                #for 8976
                echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
                echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
                echo 68 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
                echo 40 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
                echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
                echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster

                # re-enable thermal & BCL core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n disable > $mode
                done
                for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
                do
                    echo $bcl_hotplug_mask > $hotplug_mask
                done
                for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
                do
                    echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
                done
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n enable > $mode
                done

                # Enable timer migration to little cluster
                echo 1 > /proc/sys/kernel/power_aware_timer_migration

                case "$soc_id" in
                        "277" | "278")
                        # Start energy-awareness for 8976
                        start energy-awareness
                ;;
                esac

                #enable sched colocation and colocation inheritance
                echo 130 > /proc/sys/kernel/sched_grp_upmigrate
                echo 110 > /proc/sys/kernel/sched_grp_downmigrate
                echo   1 > /proc/sys/kernel/sched_enable_thread_grouping

                # Set Memory parameters
                configure_memory_parameters

            ;;
        esac
        #Enable Memory Features
        enable_memory_features
        restorecon -R /sys/devices/system/cpu
    ;;
esac

case "$target" in
    "msm8953")

        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /sys/devices/soc0/hw_platform ]; then
            hw_platform=`cat /sys/devices/soc0/hw_platform`
        else
            hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
        fi

        if [ -f /sys/devices/soc0/platform_subtype_id ]; then
            platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
        fi

        echo 0 > /proc/sys/kernel/sched_boost

        case "$soc_id" in
            "293" | "304" | "338" | "351")

                # Start Host based Touch processing
                case "$hw_platform" in
                     "MTP" | "Surf" | "RCM" )
                        #if this directory is present, it means that a
                        #1200p panel is connected to the device.
                        dir="/sys/bus/i2c/devices/3-0038"
                        if [ ! -d "$dir" ]; then
                              start_hbtp
                        fi
                        ;;
                esac

                if [ $soc_id -eq "338" ]; then
                    case "$hw_platform" in
                        "QRD" )
                            if [ $platform_subtype_id -eq "1" ]; then
                               start_hbtp
                            fi
                            ;;
                    esac
                fi

                #init task load, restrict wakeups to preferred cluster
                echo 15 > /proc/sys/kernel/sched_init_task_load

                for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor
                do
                    echo "cpufreq" > $devfreq_gov
                done

                for devfreq_gov in /sys/class/devfreq/soc:qcom,cpubw/governor
                do
                    echo "bw_hwmon" > $devfreq_gov
                    for cpu_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent
                    do
                        echo 34 > $cpu_io_percent
                    done
                    for cpu_guard_band in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps
                    do
                        echo 0 > $cpu_guard_band
                    done
                    for cpu_hist_memory in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hist_memory
                    do
                        echo 20 > $cpu_hist_memory
                    done
                    for cpu_hyst_length in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/hyst_length
                    do
                        echo 10 > $cpu_hyst_length
                    done
                    for cpu_idle_mbps in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/idle_mbps
                    do
                        echo 1600 > $cpu_idle_mbps
                    done
                    for cpu_low_power_delay in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_delay
                    do
                        echo 20 > $cpu_low_power_delay
                    done
                    for cpu_low_power_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/low_power_io_percent
                    do
                        echo 34 > $cpu_low_power_io_percent
                    done
                    for cpu_mbps_zones in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/mbps_zones
                    do
                        echo "1611 3221 5859 6445 7104" > $cpu_mbps_zones
                    done
                    for cpu_sample_ms in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/sample_ms
                    do
                        echo 4 > $cpu_sample_ms
                    done
                    for cpu_up_scale in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/up_scale
                    do
                        echo 250 > $cpu_up_scale
                    done
                    for cpu_min_freq in /sys/class/devfreq/soc:qcom,cpubw/min_freq
                    do
                        echo 1611 > $cpu_min_freq
                    done
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent
                do
                    echo 40 > $gpu_bimc_io_percent
                done

                # disable thermal & BCL core_control to update interactive gov settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n disable > $mode
                done
                for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
                do
                    bcl_hotplug_mask=`cat $hotplug_mask`
                    echo 0 > $hotplug_mask
                done
                for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
                do
                    bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
                    echo 0 > $hotplug_soc_mask
                done
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n enable > $mode
                done

                #if the kernel version >=4.9,use the schedutil governor
                KernelVersionStr=`cat /proc/sys/kernel/osrelease`
                KernelVersionS=${KernelVersionStr:2:2}
                KernelVersionA=${KernelVersionStr:0:1}
                KernelVersionB=${KernelVersionS%.*}
                if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 9 ]; then
                    8953_sched_dcvs_eas
                else
                    8953_sched_dcvs_hmp
                fi
                echo 652800 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo 1 > /sys/devices/system/cpu/cpu5/online
                echo 1 > /sys/devices/system/cpu/cpu6/online
                echo 1 > /sys/devices/system/cpu/cpu7/online

                # Enable low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                # re-enable thermal & BCL core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n disable > $mode
                done
                for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
                do
                    echo $bcl_hotplug_mask > $hotplug_mask
                done
                for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
                do
                    echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
                done
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n enable > $mode
                done

                # SMP scheduler
                echo 85 > /proc/sys/kernel/sched_upmigrate
                echo 85 > /proc/sys/kernel/sched_downmigrate

                # Set Memory parameters
                configure_memory_parameters
            ;;
        esac
        case "$soc_id" in
            "349" | "350")

            # Start Host based Touch processing
            case "$hw_platform" in
                 "MTP" | "Surf" | "RCM" | "QRD" )
                          start_hbtp
                    ;;
            esac

            for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor
            do
                echo "cpufreq" > $devfreq_gov
            done
            for cpubw in /sys/class/devfreq/*qcom,cpubw*
            do
                echo "bw_hwmon" > $cpubw/governor
                echo 50 > $cpubw/polling_interval
                echo "1611 3221 5859 6445 7104" > $cpubw/bw_hwmon/mbps_zones
                echo 4 > $cpubw/bw_hwmon/sample_ms
                echo 34 > $cpubw/bw_hwmon/io_percent
                echo 20 > $cpubw/bw_hwmon/hist_memory
                echo 80 > $cpubw/bw_hwmon/down_thres
                echo 0 > $cpubw/bw_hwmon/hyst_length
                echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                echo 250 > $cpubw/bw_hwmon/up_scale
                echo 1600 > $cpubw/bw_hwmon/idle_mbps
            done

            # Configure DCC module to capture critical register contents when device crashes
            for DCC_PATH in /sys/bus/platform/devices/*.dcc*
            do
                echo  0 > $DCC_PATH/enable
                echo cap >  $DCC_PATH/func_type
                echo sram > $DCC_PATH/data_sink
                echo  1 > $DCC_PATH/config_reset

			# Register specifies APC CPR closed-loop settled voltage for current voltage corner
			echo 0xb1d2c18 1 > $DCC_PATH/config

			# Register specifies SW programmed open-loop voltage for current voltage corner
			echo 0xb1d2900 1 > $DCC_PATH/config

			# Register specifies APM switch settings and APM FSM state
			echo 0xb1112b0 1 > $DCC_PATH/config

			# Register specifies CPR mode change state and also #online cores input to CPR HW
			echo 0xb018798 1 > $DCC_PATH/config

			echo  1 > $DCC_PATH/enable
		done

                # disable thermal & BCL core_control to update interactive gov settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n disable > $mode
                done
                for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
                do
                    bcl_hotplug_mask=`cat $hotplug_mask`
                    echo 0 > $hotplug_mask
                done
                for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
                do
                    bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
                    echo 0 > $hotplug_soc_mask
                done
                for mode in /sys/devices/soc.0/qcom,bcl.*/mode
                do
                    echo -n enable > $mode
                done

            # configure governor settings for little cluster
            echo 1 > /sys/devices/system/cpu/cpu0/online
            echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
            echo 1363200 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
            #default value for hispeed_load is 90, for sdm632 it should be 85
            echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
            # sched_load_boost as -6 is equivalent to target load as 85.
            echo -6 > /sys/devices/system/cpu/cpu0/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu1/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu2/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu3/sched_load_boost

            # configure governor settings for big cluster
            echo 1 > /sys/devices/system/cpu/cpu4/online
            echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/rate_limit_us
            echo 1401600 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
            #default value for hispeed_load is 90, for sdm632 it should be 85
            echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
            # sched_load_boost as -6 is equivalent to target load as 85.
            echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu5/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu7/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu6/sched_load_boost

            echo 614400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
            echo 633600 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

            # cpuset settings
            echo 0-3 > /dev/cpuset/background/cpus
            echo 0-3 > /dev/cpuset/system-background/cpus
            # choose idle CPU for top app tasks
            echo 1 > /dev/stune/top-app/schedtune.prefer_idle

            # re-enable thermal & BCL core_control now
            echo 1 > /sys/module/msm_thermal/core_control/enabled
            for mode in /sys/devices/soc.0/qcom,bcl.*/mode
            do
                echo -n disable > $mode
            done
            for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
            do
                echo $bcl_hotplug_mask > $hotplug_mask
            done
            for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
            do
                echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
            done
            for mode in /sys/devices/soc.0/qcom,bcl.*/mode
            do
                echo -n enable > $mode
            done

            # Disable Core control
            echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
            echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/enable

            # Bring up all cores online
            echo 1 > /sys/devices/system/cpu/cpu1/online
            echo 1 > /sys/devices/system/cpu/cpu2/online
            echo 1 > /sys/devices/system/cpu/cpu3/online
            echo 1 > /sys/devices/system/cpu/cpu4/online
            echo 1 > /sys/devices/system/cpu/cpu5/online
            echo 1 > /sys/devices/system/cpu/cpu6/online
            echo 1 > /sys/devices/system/cpu/cpu7/online

            # Enable low power modes
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

            # Set Memory parameters
            configure_memory_parameters

            # Setting b.L scheduler parameters
            echo 76 > /proc/sys/kernel/sched_downmigrate
            echo 86 > /proc/sys/kernel/sched_upmigrate
            echo 80 > /proc/sys/kernel/sched_group_downmigrate
            echo 90 > /proc/sys/kernel/sched_group_upmigrate
            echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

            # Enable min frequency adjustment for big cluster
            if [ -f /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster ]; then
                echo "4-7" > /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster
            fi
            echo 1 > /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_adjust

            ;;
        esac
    ;;
esac

case "$target" in
    "msm8937")

        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /sys/devices/soc0/hw_platform ]; then
            hw_platform=`cat /sys/devices/soc0/hw_platform`
        else
            hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
        fi
	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
	    platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
        fi

        # Socid 386 = Pukeena
        case "$soc_id" in
           "303" | "307" | "308" | "309" | "320" | "386" | "436")

                  # Start Host based Touch processing
                  case "$hw_platform" in
                    "MTP" )
			start_hbtp
                        ;;
                  esac

                  case "$hw_platform" in
                    "Surf" | "RCM" )
			if [ $platform_subtype_id -ne "4" ]; then
			    start_hbtp
		        fi
                        ;;
                  esac
                # Apply Scheduler and Governor settings for 8917 / 8920

                echo 20000000 > /proc/sys/kernel/sched_ravg_window

                #disable sched_boost in 8917
                echo 0 > /proc/sys/kernel/sched_boost

		# core_ctl is not needed for 8917. Disable it.
                disable_core_ctl

                for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor
                do
                    echo "cpufreq" > $devfreq_gov
                done

                for devfreq_gov in /sys/class/devfreq/soc:qcom,cpubw/governor
                do
                    echo "bw_hwmon" > $devfreq_gov
                    for cpu_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent
                    do
                        echo 20 > $cpu_io_percent
                    done
                for cpu_guard_band in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps
                    do
                        echo 30 > $cpu_guard_band
                    done
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent
                do
                    echo 40 > $gpu_bimc_io_percent
                done

                # disable thermal core_control to update interactive gov settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled

                KernelVersionStr=`cat /proc/sys/kernel/osrelease`
                KernelVersionS=${KernelVersionStr:2:2}
                KernelVersionA=${KernelVersionStr:0:1}
                KernelVersionB=${KernelVersionS%.*}
                if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 9 ]; then
                    8917_sched_dcvs_eas
                else
                    8917_sched_dcvs_hmp
                fi
                echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                # re-enable thermal core_control now
                echo 1 > /sys/module/msm_thermal/core_control/enabled

                # Disable L2-GDHS low power modes
                echo N > /sys/module/lpm_levels/perf/perf-l2-gdhs/idle_enabled
                echo N > /sys/module/lpm_levels/perf/perf-l2-gdhs/suspend_enabled

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online

                # Enable low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                # Set rps mask
                echo 2 > /sys/class/net/rmnet0/queues/rx-0/rps_cpus

                # Enable dynamic clock gating
                echo 1 > /sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
                # Enable timer migration to little cluster
                echo 1 > /proc/sys/kernel/power_aware_timer_migration
                # Set Memory parameters
                configure_memory_parameters
                ;;
                *)
                ;;
        esac

        case "$soc_id" in
             "294" | "295" | "313" )

                  # Start Host based Touch processing
                  case "$hw_platform" in
                    "MTP" | "Surf" | "RCM" )
                        start_hbtp
                        ;;
                  esac

                # Apply Scheduler and Governor settings for 8937/8940

                # HMP scheduler settings
                echo 3 > /proc/sys/kernel/sched_window_stats_policy
                echo 3 > /proc/sys/kernel/sched_ravg_hist_size
                echo 20000000 > /proc/sys/kernel/sched_ravg_window

                #disable sched_boost in 8937
                echo 0 > /proc/sys/kernel/sched_boost

                for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor
                do
                    echo "cpufreq" > $devfreq_gov
                done

                for devfreq_gov in /sys/class/devfreq/soc:qcom,cpubw/governor
                do
                    echo "bw_hwmon" > $devfreq_gov
                    for cpu_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent
                    do
                        echo 20 > $cpu_io_percent
                    done
                for cpu_guard_band in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps
                    do
                        echo 30 > $cpu_guard_band
                    done
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent
                do
                    echo 40 > $gpu_bimc_io_percent
                done

                # disable thermal core_control to update interactive gov and core_ctl settings
                echo 0 > /sys/module/msm_thermal/core_control/enabled

                KernelVersionStr=`cat /proc/sys/kernel/osrelease`
                KernelVersionS=${KernelVersionStr:2:2}
                KernelVersionA=${KernelVersionStr:0:1}
                KernelVersionB=${KernelVersionS%.*}
                if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 9 ]; then
                    8937_sched_dcvs_eas
                else
                    8937_sched_dcvs_hmp
                fi
                echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
                # Disable L2-GDHS low power modes
                echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/suspend_enabled
                echo N > /sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/perf-l2-gdhs/suspend_enabled

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online
                echo 1 > /sys/devices/system/cpu/cpu4/online
                echo 1 > /sys/devices/system/cpu/cpu5/online
                echo 1 > /sys/devices/system/cpu/cpu6/online
                echo 1 > /sys/devices/system/cpu/cpu7/online

                # Enable low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                # HMP scheduler (big.Little cluster related) settings
                echo 93 > /proc/sys/kernel/sched_upmigrate
                echo 83 > /proc/sys/kernel/sched_downmigrate

                # re-enable thermal core_control
                echo 1 > /sys/module/msm_thermal/core_control/enabled

                # Enable dynamic clock gating
                echo 1 > /sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
                # Enable timer migration to little cluster
                echo 1 > /proc/sys/kernel/power_aware_timer_migration
                # Set Memory parameters
                configure_memory_parameters
            ;;
            *)

            ;;
        esac

        case "$soc_id" in
             "354" | "364" | "353" | "363" )

                # Start Host based Touch processing
                case "$hw_platform" in
                    "MTP" | "Surf" | "RCM" | "QRD" )
                    start_hbtp
                ;;
                esac

                # Apply settings for sdm429/sda429/sdm439/sda439

                for cpubw in /sys/class/devfreq/*qcom,mincpubw*
                do
                    echo "cpufreq" > $cpubw/governor
                done

                for cpubw in /sys/class/devfreq/*qcom,cpubw*
                do
                    echo "bw_hwmon" > $cpubw/governor
                    echo 20 > $cpubw/bw_hwmon/io_percent
                    echo 30 > $cpubw/bw_hwmon/guard_band_mbps
                done

                for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent
                do
                    echo 40 > $gpu_bimc_io_percent
                done

                case "$soc_id" in
                     "353" | "363" )
                     # Apply settings for sdm439/sda439
                     # configure schedutil governor settings
                     # enable governor for perf cluster
                     echo 1 > /sys/devices/system/cpu/cpu0/online
                     echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                     echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
                     #set the hispeed_freq
                     echo 1497600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
                     echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
                     echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                     # sched_load_boost as -6 is equivalent to target load as 85.
                     echo -6 > /sys/devices/system/cpu/cpu0/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu1/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu2/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu3/sched_load_boost

                     ## enable governor for power cluster
                     echo 1 > /sys/devices/system/cpu/cpu4/online
                     echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
                     echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/rate_limit_us
                     #set the hispeed_freq
                     echo 998400 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
                     echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load
                     echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
                     # sched_load_boost as -6 is equivalent to target load as 85.
                     echo -6 > /sys/devices/system/cpu/cpu4/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu5/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu6/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu7/sched_load_boost

                     # EAS scheduler (big.Little cluster related) settings
                     echo 93 > /proc/sys/kernel/sched_upmigrate
                     echo 83 > /proc/sys/kernel/sched_downmigrate
                     echo 140 > /proc/sys/kernel/sched_group_upmigrate
                     echo 120 > /proc/sys/kernel/sched_group_downmigrate

                     # cpuset settings
                     #echo 0-3 > /dev/cpuset/background/cpus
                     #echo 0-3 > /dev/cpuset/system-background/cpus

                     # Bring up all cores online
                     echo 1 > /sys/devices/system/cpu/cpu1/online
                     echo 1 > /sys/devices/system/cpu/cpu2/online
                     echo 1 > /sys/devices/system/cpu/cpu3/online
                     echo 1 > /sys/devices/system/cpu/cpu4/online
                     echo 1 > /sys/devices/system/cpu/cpu5/online
                     echo 1 > /sys/devices/system/cpu/cpu6/online
                     echo 1 > /sys/devices/system/cpu/cpu7/online

                     # Enable core control
                     echo 2 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
                     echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
                     echo 68 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
                     echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
                     echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
                     echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
                     echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres

                     # Big cluster min frequency adjust settings
                     if [ -f /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster ]; then
                         echo "0-3" > /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_cluster
                     fi
                     echo 1305600 > /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_floor
                 ;;
                 *)
                     # Apply settings for sdm429/sda429
                     # configure schedutil governor settings
                     echo 1 > /sys/devices/system/cpu/cpu0/online
                     echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
                     echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
                     #set the hispeed_freq
                     echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
                     echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
                     echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
                     # sched_load_boost as -6 is equivalent to target load as 85.
                     echo -6 > /sys/devices/system/cpu/cpu0/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu1/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu2/sched_load_boost
                     echo -6 > /sys/devices/system/cpu/cpu3/sched_load_boost

                     # Bring up all cores online
                     echo 1 > /sys/devices/system/cpu/cpu1/online
                     echo 1 > /sys/devices/system/cpu/cpu2/online
                     echo 1 > /sys/devices/system/cpu/cpu3/online
                 ;;
                esac

                # Set Memory parameters
                configure_memory_parameters

                #disable sched_boost
                echo 0 > /proc/sys/kernel/sched_boost

                # Disable L2-GDHS low power modes
                echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
                echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/suspend_enabled
                echo N > /sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled
                echo N > /sys/module/lpm_levels/system/perf/perf-l2-gdhs/suspend_enabled

                # Enable low power modes
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

                case "$soc_id" in
                     "353" | "363" )
                     echo 1 > /sys/module/big_cluster_min_freq_adjust/parameters/min_freq_adjust
                     ;;
                esac
            ;;
        esac

        case "$soc_id" in
             "386" | "436")

                # Start Host based Touch processing
                case "$hw_platform" in
                    "QRD" )
                    start_hbtp
                ;;
                esac
	    ;;
	esac
    ;;
esac

case "$target" in
    "sdm660")

        # Set the default IRQ affinity to the primary cluster. When a
        # CPU is isolated/hotplugged, the IRQ affinity is adjusted
        # to one of the CPU from the default IRQ affinity mask.
        echo f > /proc/irq/default_smp_affinity

        if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
        else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /sys/devices/soc0/hw_platform ]; then
                hw_platform=`cat /sys/devices/soc0/hw_platform`
        else
                hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
        fi

        panel=`cat /sys/class/graphics/fb0/modes`
        if [ "${panel:5:1}" == "x" ]; then
            panel=${panel:2:3}
        else
            panel=${panel:2:4}
        fi

        if [ $panel -gt 1080 ]; then
            echo 2 > /proc/sys/kernel/sched_window_stats_policy
            echo 5 > /proc/sys/kernel/sched_ravg_hist_size
        else
            echo 3 > /proc/sys/kernel/sched_window_stats_policy
            echo 3 > /proc/sys/kernel/sched_ravg_hist_size
        fi
        #Apply settings for sdm660, sdm636,sda636
        case "$soc_id" in
                "317" | "324" | "325" | "326" | "345" | "346" )

            echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
            echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
            echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
            echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
            echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
            echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

            # Setting b.L scheduler parameters
            echo 96 > /proc/sys/kernel/sched_upmigrate
            echo 90 > /proc/sys/kernel/sched_downmigrate
            echo 140 > /proc/sys/kernel/sched_group_upmigrate
            echo 120 > /proc/sys/kernel/sched_group_downmigrate

            # cpuset settings
            echo 0-3 > /dev/cpuset/background/cpus
            echo 0-3 > /dev/cpuset/system-background/cpus

            #if the kernel version >=4.14,use the schedutil governor
            KernelVersionStr=`cat /proc/sys/kernel/osrelease`
            KernelVersionS=${KernelVersionStr:2:2}
            KernelVersionA=${KernelVersionStr:0:1}
            KernelVersionB=${KernelVersionS%.*}
            if [ $KernelVersionA -ge 4 ] && [ $KernelVersionB -ge 14 ]; then
                sdm660_sched_schedutil_dcvs
            else
                sdm660_sched_interactive_dcvs
            fi

            # Set Memory parameters
            configure_memory_parameters

            # enable LPM
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

            # Start cdsprpcd only for sdm660 and disable for sdm630
            start vendor.cdsprpcd

            # Start Host based Touch processing
                case "$hw_platform" in
                        "MTP" | "Surf" | "RCM" | "QRD" )
                        start_hbtp
                        ;;
                esac
            ;;
        esac
        #Apply settings for sdm630 and Tahaa
        case "$soc_id" in
            "318" | "327" | "385" )

            # Start Host based Touch processing
            case "$hw_platform" in
                "MTP" | "Surf" | "RCM" | "QRD" )
                start_hbtp
                ;;
            esac

            # Setting b.L scheduler parameters
            echo 85 > /proc/sys/kernel/sched_upmigrate
            echo 85 > /proc/sys/kernel/sched_downmigrate
            echo 900 > /proc/sys/kernel/sched_group_upmigrate
            echo 900 > /proc/sys/kernel/sched_group_downmigrate
            echo 0 > /proc/sys/kernel/sched_select_prev_cpu_us
            echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
            echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
            echo 3 > /proc/sys/kernel/sched_spill_nr_run

            #init task load, restrict wakeups to preferred cluster
            echo 15 > /proc/sys/kernel/sched_init_task_load
            echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
            echo 50000 > /proc/sys/kernel/sched_short_burst_ns

            # cpuset settings
            echo 0-3 > /dev/cpuset/background/cpus
            echo 0-3 > /dev/cpuset/system-background/cpus

            # disable thermal bcl hotplug to switch governor
            echo 0 > /sys/module/msm_thermal/core_control/enabled
            for mode in /sys/devices/soc.0/qcom,bcl.*/mode
            do
                echo -n disable > $mode
            done
            for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
            do
                bcl_hotplug_mask=`cat $hotplug_mask`
                echo 0 > $hotplug_mask
            done
            for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
            do
                bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
                echo 0 > $hotplug_soc_mask
            done
            for mode in /sys/devices/soc.0/qcom,bcl.*/mode
            do
                echo -n enable > $mode
            done

            # online CPU0
            echo 1 > /sys/devices/system/cpu/cpu0/online
            # configure governor settings for Big cluster(CPU0 to CPU3)
            echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
            echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
            echo "19000 1344000:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
            echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
            echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
            echo 1344000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
            echo "85 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
            echo 39000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
            echo 787200 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif

            # online CPU4
            echo 1 > /sys/devices/system/cpu/cpu4/online
            # configure governor settings for Little cluster(CPU4 to CPU7)
            echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
            echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
            echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
            echo "19000 1094400:39000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
            echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
            echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
            echo 1094400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
            echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
            echo "85 1094400:80" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
            echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
            echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
            echo 614400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
            echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif

            # bring all cores online
            echo 1 > /sys/devices/system/cpu/cpu0/online
            echo 1 > /sys/devices/system/cpu/cpu1/online
            echo 1 > /sys/devices/system/cpu/cpu2/online
            echo 1 > /sys/devices/system/cpu/cpu3/online
            echo 1 > /sys/devices/system/cpu/cpu4/online
            echo 1 > /sys/devices/system/cpu/cpu5/online
            echo 1 > /sys/devices/system/cpu/cpu6/online
            echo 1 > /sys/devices/system/cpu/cpu7/online

            # configure LPM
            echo N > /sys/module/lpm_levels/system/perf/cpu0/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/perf/cpu1/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/perf/cpu2/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/perf/cpu3/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/pwr/cpu4/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/pwr/cpu5/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/pwr/cpu6/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/pwr/cpu7/ret/idle_enabled
            echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
            echo N > /sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
            # enable LPM
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

            # re-enable thermal and BCL hotplug
            echo 1 > /sys/module/msm_thermal/core_control/enabled
            for mode in /sys/devices/soc.0/qcom,bcl.*/mode
            do
                echo -n disable > $mode
            done
            for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
            do
                echo $bcl_hotplug_mask > $hotplug_mask
            done
            for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
            do
                echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
            done
            for mode in /sys/devices/soc.0/qcom,bcl.*/mode
            do
                echo -n enable > $mode
            done

            # Set Memory parameters
            configure_memory_parameters

            # Enable bus-dcvs
            for cpubw in /sys/class/devfreq/*qcom,cpubw*
            do
                echo "bw_hwmon" > $cpubw/governor
                echo 50 > $cpubw/polling_interval
                echo 762 > $cpubw/min_freq
                echo "1525 3143 4173 5195 5859 7759 9887 10327" > $cpubw/bw_hwmon/mbps_zones
                echo 4  > $cpubw/bw_hwmon/sample_ms
                echo 85 > $cpubw/bw_hwmon/io_percent
                echo 20 > $cpubw/bw_hwmon/hist_memory
                echo 0  > $cpubw/bw_hwmon/hyst_length
                echo 100 > $cpubw/bw_hwmon/decay_rate
                echo 50 > $cpubw/bw_hwmon/bw_step
                echo 80 > $cpubw/bw_hwmon/down_thres
                echo 0  > $cpubw/bw_hwmon/low_power_ceil_mbps
                echo 50 > $cpubw/bw_hwmon/low_power_io_percent
                echo 20 > $cpubw/bw_hwmon/low_power_delay
                echo 0  > $cpubw/bw_hwmon/guard_band_mbps
                echo 250 > $cpubw/bw_hwmon/up_scale
                echo 1600 > $cpubw/bw_hwmon/idle_mbps
            done

            for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
            do
                echo "mem_latency" > $memlat/governor
                echo 10 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor
            ;;
        esac
    ;;
esac

case "$target" in
    "sdm710")

        #Apply settings for sdm710
        # Set the default IRQ affinity to the silver cluster. When a
        # CPU is isolated/hotplugged, the IRQ affinity is adjusted
        # to one of the CPU from the default IRQ affinity mask.
        echo 3f > /proc/irq/default_smp_affinity

        if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
        else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /sys/devices/soc0/hw_platform ]; then
            hw_platform=`cat /sys/devices/soc0/hw_platform`
        else
            hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
        fi

        case "$soc_id" in
            "336" | "337" | "347" | "360" | "393" )

            # Start Host based Touch processing
            case "$hw_platform" in
              "MTP" | "Surf" | "RCM" | "QRD" )
                  start_hbtp
                  ;;
            esac

      # Core control parameters on silver
      echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
      echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
      echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
      echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
      echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
      echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
      echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres

      # Setting b.L scheduler parameters
      echo 96 > /proc/sys/kernel/sched_upmigrate
      echo 90 > /proc/sys/kernel/sched_downmigrate
      echo 140 > /proc/sys/kernel/sched_group_upmigrate
      echo 120 > /proc/sys/kernel/sched_group_downmigrate
      echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

      # configure governor settings for little cluster
      echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
      echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
      echo 1209600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
      echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

      # configure governor settings for big cluster
      echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
      echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/rate_limit_us
      echo 1344000 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
      echo 652800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq

      # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
      echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
      echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
      echo 85 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load

      echo "0:1209600" > /sys/module/cpu_boost/parameters/input_boost_freq
      echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

      # Set Memory parameters
      configure_memory_parameters

      # Enable bus-dcvs
      for cpubw in /sys/class/devfreq/*qcom,cpubw*
            do
                echo "bw_hwmon" > $cpubw/governor
                echo 50 > $cpubw/polling_interval
                echo "1144 1720 2086 2929 3879 5931 6881" > $cpubw/bw_hwmon/mbps_zones
                echo 4 > $cpubw/bw_hwmon/sample_ms
                echo 68 > $cpubw/bw_hwmon/io_percent
                echo 20 > $cpubw/bw_hwmon/hist_memory
                echo 0 > $cpubw/bw_hwmon/hyst_length
                echo 80 > $cpubw/bw_hwmon/down_thres
                echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                echo 250 > $cpubw/bw_hwmon/up_scale
                echo 1600 > $cpubw/bw_hwmon/idle_mbps
            done

            #Enable mem_latency governor for DDR scaling
            for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
            do
                echo "mem_latency" > $memlat/governor
                echo 10 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            #Enable mem_latency governor for L3 scaling
            for memlat in /sys/class/devfreq/*qcom,l3-cpu*
            do
                echo "mem_latency" > $memlat/governor
                echo 10 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            #Enable userspace governor for L3 cdsp nodes
            for l3cdsp in /sys/class/devfreq/*qcom,l3-cdsp*
            do
                echo "userspace" > $l3cdsp/governor
                chown -h system $l3cdsp/userspace/set_freq
            done

            echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor

            # Disable CPU Retention
            echo N > /sys/module/lpm_levels/L3/cpu0/ret/idle_enabled
            echo N > /sys/module/lpm_levels/L3/cpu1/ret/idle_enabled
            echo N > /sys/module/lpm_levels/L3/cpu2/ret/idle_enabled
            echo N > /sys/module/lpm_levels/L3/cpu3/ret/idle_enabled
            echo N > /sys/module/lpm_levels/L3/cpu4/ret/idle_enabled
            echo N > /sys/module/lpm_levels/L3/cpu5/ret/idle_enabled
            echo N > /sys/module/lpm_levels/L3/cpu6/ret/idle_enabled
            echo N > /sys/module/lpm_levels/L3/cpu7/ret/idle_enabled

            # cpuset parameters
            echo 0-5 > /dev/cpuset/background/cpus
            echo 0-5 > /dev/cpuset/system-background/cpus

            # Turn off scheduler boost at the end
            echo 0 > /proc/sys/kernel/sched_boost

            # Turn on sleep modes.
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
            ;;
        esac
    ;;
esac

case "$target" in
    "trinket")

        if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
        else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        case "$soc_id" in
                 "394" | "467" | "468" )

            # Core control parameters on big
            echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
            echo 40 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
            echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
            echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
            echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
            echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

            # Setting b.L scheduler parameters
            echo 67 > /proc/sys/kernel/sched_downmigrate
            echo 77 > /proc/sys/kernel/sched_upmigrate
            echo 85 > /proc/sys/kernel/sched_group_downmigrate
            echo 100 > /proc/sys/kernel/sched_group_upmigrate

            # cpuset settings
            echo 0-3 > /dev/cpuset/background/cpus
            echo 0-3 > /dev/cpuset/system-background/cpus


            # configure governor settings for little cluster
            echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
            echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
            echo 614400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

            # configure governor settings for big cluster
            echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
            echo 1401600 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
            echo 1056000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

	    echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

            # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
            echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu5/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
            echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
            echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load

            # Set Memory parameters
            configure_memory_parameters

            # Enable bus-dcvs
            ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
            ddr_type4="07"
            ddr_type3="05"

            for device in /sys/devices/platform/soc
            do
                for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
                do
                    echo "bw_hwmon" > $cpubw/governor
                    echo 762 > $cpubw/min_freq
                    if [ ${ddr_type:4:2} == $ddr_type4 ]; then
                        # LPDDR4
                        echo "2288 3440 4173 5195 5859 7759 10322 11863 13763" > $cpubw/bw_hwmon/mbps_zones
                        echo 85 > $cpubw/bw_hwmon/io_percent
                    fi
                    if [ ${ddr_type:4:2} == $ddr_type3 ]; then
                        # LPDDR3
                        echo "1525 3440 5195 5859 7102" > $cpubw/bw_hwmon/mbps_zones
                        echo 34 > $cpubw/bw_hwmon/io_percent
                    fi
                    echo 4 > $cpubw/bw_hwmon/sample_ms
                    echo 90 > $cpubw/bw_hwmon/decay_rate
                    echo 190 > $cpubw/bw_hwmon/bw_step
                    echo 20 > $cpubw/bw_hwmon/hist_memory
                    echo 0 > $cpubw/bw_hwmon/hyst_length
                    echo 80 > $cpubw/bw_hwmon/down_thres
                    echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                    echo 250 > $cpubw/bw_hwmon/up_scale
                    echo 1600 > $cpubw/bw_hwmon/idle_mbps
                    echo 50 > $cpubw/polling_interval
                done

                for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
                do
                    echo "mem_latency" > $memlat/governor
                    echo 10 > $memlat/polling_interval
                    echo 400 > $memlat/mem_latency/ratio_ceil
                done

                for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
                do
                    echo "compute" > $latfloor/governor
                    echo 10 > $latfloor/polling_interval
                done

            done

            # colcoation v3 disabled
            echo 0 > /proc/sys/kernel/sched_min_task_util_for_boost
            echo 0 > /proc/sys/kernel/sched_min_task_util_for_colocation
            echo 0 > /proc/sys/kernel/sched_little_cluster_coloc_fmin_khz

            # Turn off scheduler boost at the end
            echo 0 > /proc/sys/kernel/sched_boost

            # Turn on sleep modes.
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

            ;;
        esac
    ;;
esac

case "$target" in
    "sm6150")

        #Apply settings for sm6150
        # Set the default IRQ affinity to the silver cluster. When a
        # CPU is isolated/hotplugged, the IRQ affinity is adjusted
        # to one of the CPU from the default IRQ affinity mask.
        echo 3f > /proc/irq/default_smp_affinity

        if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
        else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        case "$soc_id" in
            "355" | "369" | "377" | "380" | "384" )
      target_type=`getprop ro.hardware.type`
      if [ "$target_type" == "automotive" ]; then
	# update frequencies
	configure_sku_parameters
	sku_identified=`getprop vendor.sku_identified`
      else
	sku_identified=0
      fi

      # Core control parameters on silver
      echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
      echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
      echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
      echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
      echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
      echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
      echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres
      echo 0 > /sys/devices/system/cpu/cpu6/core_ctl/enable


      # Setting b.L scheduler parameters
      # default sched up and down migrate values are 90 and 85
      echo 65 > /proc/sys/kernel/sched_downmigrate
      echo 71 > /proc/sys/kernel/sched_upmigrate
      # default sched up and down migrate values are 100 and 95
      echo 85 > /proc/sys/kernel/sched_group_downmigrate
      echo 100 > /proc/sys/kernel/sched_group_upmigrate
      echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

      # colocation v3 settings
      echo 740000 > /proc/sys/kernel/sched_little_cluster_coloc_fmin_khz


      # configure governor settings for little cluster
      echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
      echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
      echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
      echo 1209600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
      if [ $sku_identified != 1 ]; then
        echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
      fi

      # configure governor settings for big cluster
      echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
      echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
      echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
      echo 1209600 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
      if [ $sku_identified != 1 ]; then
        echo 768000 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
      fi

      # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
      echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
      echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
      echo 85 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load

      echo "0:1209600" > /sys/module/cpu_boost/parameters/input_boost_freq
      echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

      # Set Memory parameters
      configure_memory_parameters

      # Enable bus-dcvs
      for device in /sys/devices/platform/soc
      do
          for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
          do
	      echo "bw_hwmon" > $cpubw/governor
	      echo "2288 4577 7110 9155 12298 14236" > $cpubw/bw_hwmon/mbps_zones
	      echo 4 > $cpubw/bw_hwmon/sample_ms
	      echo 68 > $cpubw/bw_hwmon/io_percent
	      echo 20 > $cpubw/bw_hwmon/hist_memory
	      echo 0 > $cpubw/bw_hwmon/hyst_length
	      echo 80 > $cpubw/bw_hwmon/down_thres
	      echo 0 > $cpubw/bw_hwmon/guard_band_mbps
	      echo 250 > $cpubw/bw_hwmon/up_scale
	      echo 1600 > $cpubw/bw_hwmon/idle_mbps
              echo 50 > $cpubw/polling_interval
	  done

	  for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
	  do
	      echo "bw_hwmon" > $llccbw/governor
	      echo "1144 1720 2086 2929 3879 5931 6881" > $llccbw/bw_hwmon/mbps_zones
	      echo 4 > $llccbw/bw_hwmon/sample_ms
	      echo 68 > $llccbw/bw_hwmon/io_percent
	      echo 20 > $llccbw/bw_hwmon/hist_memory
	      echo 0 > $llccbw/bw_hwmon/hyst_length
	      echo 80 > $llccbw/bw_hwmon/down_thres
	      echo 0 > $llccbw/bw_hwmon/guard_band_mbps
	      echo 250 > $llccbw/bw_hwmon/up_scale
	      echo 1600 > $llccbw/bw_hwmon/idle_mbps
              echo 40 > $llccbw/polling_interval
	  done

	    #Enable mem_latency governor for L3, LLCC, and DDR scaling
	  for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
	  do
	      echo "mem_latency" > $memlat/governor
	      echo 10 > $memlat/polling_interval
	      echo 400 > $memlat/mem_latency/ratio_ceil
          done

          #Gold L3 ratio ceil
          echo 4000 > /sys/class/devfreq/soc:qcom,cpu6-cpu-l3-lat/mem_latency/ratio_ceil

          #Enable cdspl3 governor for L3 cdsp nodes
          for l3cdsp in $device/*cdsp-cdsp-l3-lat/devfreq/*cdsp-cdsp-l3-lat
          do
              echo "cdspl3" > $l3cdsp/governor
          done

	  #Enable compute governor for gold latfloor
	  for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
	  do
	      echo "compute" > $latfloor/governor
	      echo 10 > $latfloor/polling_interval
	  done

      done
            # cpuset parameters
            echo 0-5 > /dev/cpuset/background/cpus
            echo 0-5 > /dev/cpuset/system-background/cpus

            # Turn off scheduler boost at the end
            echo 0 > /proc/sys/kernel/sched_boost

            # Turn on sleep modes.
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
            ;;
        esac

        #Apply settings for moorea
        case "$soc_id" in
            "365" | "366" )

            # Core control parameters on silver
            echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
            echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
            echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
            echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
            echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
            echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
            echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres
            echo 0 > /sys/devices/system/cpu/cpu6/core_ctl/enable

            # Setting b.L scheduler parameters
            # default sched up and down migrate values are 71 and 65
            echo 65 > /proc/sys/kernel/sched_downmigrate
            echo 71 > /proc/sys/kernel/sched_upmigrate
            # default sched up and down migrate values are 100 and 95
            echo 85 > /proc/sys/kernel/sched_group_downmigrate
            echo 100 > /proc/sys/kernel/sched_group_upmigrate
            echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

            #colocation v3 settings
            echo 740000 > /proc/sys/kernel/sched_little_cluster_coloc_fmin_khz

            # configure governor settings for little cluster
            echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
            echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
            echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

            # configure governor settings for big cluster
            echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
            echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
            echo 1324600 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
            echo 652800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq

            # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
            echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
            echo 85 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load

            echo "0:1248000" > /sys/module/cpu_boost/parameters/input_boost_freq
            echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

            # Set Memory parameters
            configure_memory_parameters

            # Enable bus-dcvs
            for device in /sys/devices/platform/soc
            do
                for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
                do
                    echo "bw_hwmon" > $cpubw/governor
                    echo "2288 4577 7110 9155 12298 14236" > $cpubw/bw_hwmon/mbps_zones
                    echo 4 > $cpubw/bw_hwmon/sample_ms
                    echo 68 > $cpubw/bw_hwmon/io_percent
                    echo 20 > $cpubw/bw_hwmon/hist_memory
                    echo 0 > $cpubw/bw_hwmon/hyst_length
                    echo 80 > $cpubw/bw_hwmon/down_thres
                    echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                    echo 250 > $cpubw/bw_hwmon/up_scale
                    echo 1600 > $cpubw/bw_hwmon/idle_mbps
                    echo 50 > $cpubw/polling_interval
                done

                for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
                do
                    echo "bw_hwmon" > $llccbw/governor
                    echo "1144 1720 2086 2929 3879 5931 6881" > $llccbw/bw_hwmon/mbps_zones
                    echo 4 > $llccbw/bw_hwmon/sample_ms
                    echo 68 > $llccbw/bw_hwmon/io_percent
                    echo 20 > $llccbw/bw_hwmon/hist_memory
                    echo 0 > $llccbw/bw_hwmon/hyst_length
                    echo 80 > $llccbw/bw_hwmon/down_thres
                    echo 0 > $llccbw/bw_hwmon/guard_band_mbps
                    echo 250 > $llccbw/bw_hwmon/up_scale
                    echo 1600 > $llccbw/bw_hwmon/idle_mbps
                    echo 40 > $llccbw/polling_interval
                done

                for npubw in $device/*npu-npu-ddr-bw/devfreq/*npu-npu-ddr-bw
                do
                    echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
                    echo "bw_hwmon" > $npubw/governor
                    echo "1144 1720 2086 2929 3879 5931 6881" > $npubw/bw_hwmon/mbps_zones
                    echo 4 > $npubw/bw_hwmon/sample_ms
                    echo 80 > $npubw/bw_hwmon/io_percent
                    echo 20 > $npubw/bw_hwmon/hist_memory
                    echo 10 > $npubw/bw_hwmon/hyst_length
                    echo 30 > $npubw/bw_hwmon/down_thres
                    echo 0 > $npubw/bw_hwmon/guard_band_mbps
                    echo 250 > $npubw/bw_hwmon/up_scale
                    echo 0 > $npubw/bw_hwmon/idle_mbps
                    echo 40 > $npubw/polling_interval
                    echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
                done

                #Enable mem_latency governor for L3, LLCC, and DDR scaling
                for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
                do
                    echo "mem_latency" > $memlat/governor
                    echo 10 > $memlat/polling_interval
                    echo 400 > $memlat/mem_latency/ratio_ceil
                done

                #Gold L3 ratio ceil
                echo 4000 > /sys/class/devfreq/soc:qcom,cpu6-cpu-l3-lat/mem_latency/ratio_ceil

                #Enable cdspl3 governor for L3 cdsp nodes
                for l3cdsp in $device/*cdsp-cdsp-l3-lat/devfreq/*cdsp-cdsp-l3-lat
                do
                    echo "cdspl3" > $l3cdsp/governor
                done

                #Enable compute governor for gold latfloor
                for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
                do
                    echo "compute" > $latfloor/governor
                    echo 10 > $latfloor/polling_interval
                done

            done

            # cpuset parameters
                echo 0-5 > /dev/cpuset/background/cpus
                echo 0-5 > /dev/cpuset/system-background/cpus

                # Turn off scheduler boost at the end
                echo 0 > /proc/sys/kernel/sched_boost

                # Turn on sleep modes.
                echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
          ;;
        esac

    ;;
esac


case "$target" in
    "lito")

    #Apply settings for lito
    if [ -f /sys/devices/soc0/soc_id ]; then
        soc_id=`cat /sys/devices/soc0/soc_id`
    fi

    case "$soc_id" in
        "400" | "440" )
        # Core control parameters on silver
        echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
        echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
        echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
        echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
        echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres
        echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms

        # Disable Core control on gold, prime
        echo 0 > /sys/devices/system/cpu/cpu6/core_ctl/enable
        echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/enable

        # Setting b.L scheduler parameters
        echo 65 85 > /proc/sys/kernel/sched_downmigrate
        echo 71 95 > /proc/sys/kernel/sched_upmigrate
        echo 85 > /proc/sys/kernel/sched_group_downmigrate
        echo 100 > /proc/sys/kernel/sched_group_upmigrate
        echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks
        echo 0 > /proc/sys/kernel/sched_coloc_busy_hyst_ns
        echo 0 > /proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus
        echo 0 > /proc/sys/kernel/sched_coloc_busy_hyst_max_ms

        # disable unfiltering
        echo 20000000 > /proc/sys/kernel/sched_task_unfilter_period
        echo 1 > /proc/sys/kernel/sched_task_unfilter_nr_windows

        # configure governor settings for silver cluster
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
        echo 1228800 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl
        echo 576000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
        echo 650000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq

        # configure governor settings for gold cluster
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy6/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/down_rate_limit_us
        echo 1228800 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/hispeed_freq
        echo 85 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load
        echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
        echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/pl
        echo 672000 > /sys/devices/system/cpu/cpufreq/policy6/scaling_min_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/rtg_boost_freq

        # configure governor settings for gold+ cluster
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
        echo 1228800 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
        echo 85 > /sys/devices/system/cpu/cpu7/cpufreq/schedutil/hispeed_load
        echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
        echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pl
        echo 672000 > /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/rtg_boost_freq

        # colocation v3 settings
        echo 51 > /proc/sys/kernel/sched_min_task_util_for_boost
        echo 35 > /proc/sys/kernel/sched_min_task_util_for_colocation

        # Enable conservative pl
        echo 1 > /proc/sys/kernel/sched_conservative_pl

        echo "0:1228800" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
        echo 120 > /sys/devices/system/cpu/cpu_boost/input_boost_ms

        # Set Memory parameters
        configure_memory_parameters

        if [ `cat /sys/devices/soc0/revision` == "2.0" ]; then
             # r2.0 related changes
             echo "0:1075200" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
             echo 610000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq
             echo 1075200 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
             echo 1152000 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/hispeed_freq
             echo 1401600 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
             echo 614400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
             echo 652800 > /sys/devices/system/cpu/cpufreq/policy6/scaling_min_freq
             echo 806400 > /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq
             echo 83 > /proc/sys/kernel/sched_asym_cap_sibling_freq_match_pct
        fi

        # Enable bus-dcvs
        for device in /sys/devices/platform/soc
        do
            for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
            do
                echo "bw_hwmon" > $cpubw/governor
                echo "2288 4577 7110 9155 12298 14236 16265" > $cpubw/bw_hwmon/mbps_zones
                echo 4 > $cpubw/bw_hwmon/sample_ms
                echo 68 > $cpubw/bw_hwmon/io_percent
                echo 20 > $cpubw/bw_hwmon/hist_memory
                echo 0 > $cpubw/bw_hwmon/hyst_length
                echo 80 > $cpubw/bw_hwmon/down_thres
                echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                echo 250 > $cpubw/bw_hwmon/up_scale
                echo 1600 > $cpubw/bw_hwmon/idle_mbps
                echo 50 > $cpubw/polling_interval
            done

            for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
            do
                echo "bw_hwmon" > $llccbw/governor
                echo "1144 1720 2086 2929 3879 5931 6881 7980" > $llccbw/bw_hwmon/mbps_zones
                echo 4 > $llccbw/bw_hwmon/sample_ms
                echo 68 > $llccbw/bw_hwmon/io_percent
                echo 20 > $llccbw/bw_hwmon/hist_memory
                echo 0 > $llccbw/bw_hwmon/hyst_length
                echo 80 > $llccbw/bw_hwmon/down_thres
                echo 0 > $llccbw/bw_hwmon/guard_band_mbps
                echo 250 > $llccbw/bw_hwmon/up_scale
                echo 1600 > $llccbw/bw_hwmon/idle_mbps
                echo 50 > $llccbw/polling_interval
            done

            for npubw in $device/*npu*-ddr-bw/devfreq/*npu*-ddr-bw
            do
                echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
                echo "bw_hwmon" > $npubw/governor
                echo "1144 1720 2086 2929 3879 5931 6881 7980" > $npubw/bw_hwmon/mbps_zones
                echo 4 > $npubw/bw_hwmon/sample_ms
                echo 80 > $npubw/bw_hwmon/io_percent
                echo 20 > $npubw/bw_hwmon/hist_memory
                echo 10 > $npubw/bw_hwmon/hyst_length
                echo 30 > $npubw/bw_hwmon/down_thres
                echo 0 > $npubw/bw_hwmon/guard_band_mbps
                echo 250 > $npubw/bw_hwmon/up_scale
                echo 0 > $npubw/bw_hwmon/idle_mbps
                echo 40 > $npubw/polling_interval
                echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
            done

            for npullccbw in $device/*npu*-llcc-bw/devfreq/*npu*-llcc-bw
        do
                echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
                echo "bw_hwmon" > $npullccbw/governor
                echo "2288 4577 7110 9155 12298 14236 16265" > $npullccbw/bw_hwmon/mbps_zones
                echo 4 > $npullccbw/bw_hwmon/sample_ms
                echo 100 > $npullccbw/bw_hwmon/io_percent
                echo 20 > $npullccbw/bw_hwmon/hist_memory
                echo 10 > $npullccbw/bw_hwmon/hyst_length
                echo 30 > $npullccbw/bw_hwmon/down_thres
                echo 0 > $npullccbw/bw_hwmon/guard_band_mbps
                echo 250 > $npullccbw/bw_hwmon/up_scale
                echo 40 > $npullccbw/polling_interval
                echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
        done

            #Enable mem_latency governor for L3, LLCC, and DDR scaling
        for memlat in $device/*qcom,devfreq-l3/*cpu*-lat/devfreq/*cpu*-lat
            do
                echo "mem_latency" > $memlat/governor
                echo 8 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

        #Enable cdspl3 governor for L3 cdsp nodes
        for l3cdsp in $device/*qcom,devfreq-l3/*cdsp-l3-lat/devfreq/*cdsp-l3-lat
        do
                echo "cdspl3" > $l3cdsp/governor
        done

        #Enable mem_latency governor for LLCC and DDR scaling
        for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
        do
            echo "mem_latency" > $memlat/governor
            echo 8 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
            done

            #Gold L3 ratio ceil
        for l3gold in $device/*qcom,devfreq-l3/*cpu6-cpu-l3-lat/devfreq/*cpu6-cpu-l3-lat
            do
                echo 4000 > $l3gold/mem_latency/ratio_ceil
            done

            #Prime L3 ratio ceil
        for l3prime in $device/*qcom,devfreq-l3/*cpu7-cpu-l3-lat/devfreq/*cpu7-cpu-l3-lat
            do
                echo 4000 > $l3prime/mem_latency/ratio_ceil
            done

            #Enable compute governor for gold latfloor
            for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
            do
                echo "compute" > $latfloor/governor
                echo 8 > $latfloor/polling_interval
            done
        done

        # cpuset parameters
        echo 0-5 > /dev/cpuset/background/cpus
        echo 0-5 > /dev/cpuset/system-background/cpus

        # Turn off scheduler boost at the end
        echo 0 > /proc/sys/kernel/sched_boost

        # Turn on sleep modes
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
        ;;
    esac

    #Apply settings for lagoon
    case "$soc_id" in
        "434" | "459" )

        # Core control parameters on silver
        echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
        echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
        echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
        echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
        echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
        echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres

        # Disable Core control on gold
        echo 0 > /sys/devices/system/cpu/cpu6/core_ctl/enable


        # disable unfiltering
        echo 20000000 > /proc/sys/kernel/sched_task_unfilter_period

        # Setting b.L scheduler parameters
        # default sched up and down migrate values are 95 and 85
        echo 65 > /proc/sys/kernel/sched_downmigrate
        echo 71 > /proc/sys/kernel/sched_upmigrate
        # default sched up and down migrate values are 100 and 95
        echo 85 > /proc/sys/kernel/sched_group_downmigrate
        echo 100 > /proc/sys/kernel/sched_group_upmigrate
        echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks
        echo 0 > /proc/sys/kernel/sched_coloc_busy_hyst_ns
        echo 0 > /proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus
        echo 0 > /proc/sys/kernel/sched_coloc_busy_hyst_max_ms

        # configure governor settings for little cluster
        echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
        echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
        echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

        # configure governor settings for big cluster
        echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
        echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
        echo 1248000 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
        echo 652800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq

        #colocation v3 settings
        echo 740000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/policy6/schedutil/rtg_boost_freq
        echo 51 > /proc/sys/kernel/sched_min_task_util_for_boost

        # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
        echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
        echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
        echo 85 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load

        # Enable conservative pl
        echo 1 > /proc/sys/kernel/sched_conservative_pl

        echo "0:1248000" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
        echo 120 > /sys/devices/system/cpu/cpu_boost/input_boost_ms

        # Set Memory parameters
        configure_memory_parameters

        # Enable bus-dcvs
        for device in /sys/devices/platform/soc
        do
            for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
            do
                echo "bw_hwmon" > $cpubw/governor
                echo "2288 4577 7110 9155 12298 14236" > $cpubw/bw_hwmon/mbps_zones
                echo 4 > $cpubw/bw_hwmon/sample_ms
                echo 68 > $cpubw/bw_hwmon/io_percent
                echo 20 > $cpubw/bw_hwmon/hist_memory
                echo 0 > $cpubw/bw_hwmon/hyst_length
                echo 80 > $cpubw/bw_hwmon/down_thres
                echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                echo 250 > $cpubw/bw_hwmon/up_scale
                echo 1600 > $cpubw/bw_hwmon/idle_mbps
                echo 50 > $cpubw/polling_interval
            done

            for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
            do
                echo "bw_hwmon" > $llccbw/governor
                echo "1144 1720 2086 2929 3879 5931 6881 8137" > $llccbw/bw_hwmon/mbps_zones
                echo 4 > $llccbw/bw_hwmon/sample_ms
                echo 68 > $llccbw/bw_hwmon/io_percent
                echo 20 > $llccbw/bw_hwmon/hist_memory
                echo 0 > $llccbw/bw_hwmon/hyst_length
                echo 80 > $llccbw/bw_hwmon/down_thres
                echo 0 > $llccbw/bw_hwmon/guard_band_mbps
                echo 250 > $llccbw/bw_hwmon/up_scale
                echo 1600 > $llccbw/bw_hwmon/idle_mbps
                echo 40 > $llccbw/polling_interval
            done

            for npubw in $device/*npu*-ddr-bw/devfreq/*npu*-ddr-bw
            do
                echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
                echo "bw_hwmon" > $npubw/governor
                echo "1144 1720 2086 2929 3879 5931 6881 7980" > $npubw/bw_hwmon/mbps_zones
                echo 4 > $npubw/bw_hwmon/sample_ms
                echo 80 > $npubw/bw_hwmon/io_percent
                echo 20 > $npubw/bw_hwmon/hist_memory
                echo 10 > $npubw/bw_hwmon/hyst_length
                echo 30 > $npubw/bw_hwmon/down_thres
                echo 0 > $npubw/bw_hwmon/guard_band_mbps
                echo 250 > $npubw/bw_hwmon/up_scale
                echo 0 > $npubw/bw_hwmon/idle_mbps
                echo 40 > $npubw/polling_interval
                echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
            done

            for npullccbw in $device/*npu*-llcc-bw/devfreq/*npu*-llcc-bw
            do
                echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
                echo "bw_hwmon" > $npullccbw/governor
                echo "2288 4577 7110 9155 12298 14236 16265" > $npullccbw/bw_hwmon/mbps_zones
                echo 4 > $npullccbw/bw_hwmon/sample_ms
                echo 100 > $npullccbw/bw_hwmon/io_percent
                echo 20 > $npullccbw/bw_hwmon/hist_memory
                echo 10 > $npullccbw/bw_hwmon/hyst_length
                echo 30 > $npullccbw/bw_hwmon/down_thres
                echo 0 > $npullccbw/bw_hwmon/guard_band_mbps
                echo 250 > $npullccbw/bw_hwmon/up_scale
                echo 40 > $npullccbw/polling_interval
                echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
            done

           #Enable mem_latency governor for L3 scaling
            for memlat in $device/*qcom,devfreq-l3/*cpu*-lat/devfreq/*cpu*-lat
            do
                echo "mem_latency" > $memlat/governor
                echo 8 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            for gold_memlat in $device/*qcom,devfreq-l3/*cpu6*-lat/devfreq/*cpu6*-lat
            do
                echo 25000 > $gold_memlat/mem_latency/wb_filter_ratio
                echo 60 > $gold_memlat/mem_latency/wb_pct_thres
            done

            #Enable mem_latency governor for LLCC, and DDR scaling
            for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
            do
                echo "mem_latency" > $memlat/governor
                echo 8 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            #Enable cdspl3 governor for L3 cdsp nodes
            for l3cdsp in $device/*qcom,devfreq-l3/*cdsp-l3-lat/devfreq/*cdsp-l3-lat
            do
                echo "powersave" > $l3cdsp/governor
            done

            #Gold L3 ratio ceil
            for l3gold in $device/*qcom,devfreq-l3/*cpu6-cpu-l3-lat/devfreq/*cpu6-cpu-l3-lat
            do
                echo 4000 > $l3gold/mem_latency/ratio_ceil
            done

            #Enable compute governor for gold latfloor
            for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
            do
                echo "compute" > $latfloor/governor
                echo 8 > $latfloor/polling_interval
            done

        done

        # cpuset parameters
        echo 0-5 > /dev/cpuset/background/cpus
        echo 0-5 > /dev/cpuset/system-background/cpus

        # Turn off scheduler boost at the end
        echo 0 > /proc/sys/kernel/sched_boost

        # Turn off sleep modes
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
      ;;
    esac
esac


case "$target" in
    "bengal")

        if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
        else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        case "$soc_id" in
                 "417" | "420" | "444" | "445" | "469" | "470" )

            # Core control is temporarily disabled till bring up
            echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
            echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
            # Core control parameters on big
            echo 40 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
            echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
            echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
            echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

            # Setting b.L scheduler parameters
            echo 67 > /proc/sys/kernel/sched_downmigrate
            echo 77 > /proc/sys/kernel/sched_upmigrate
            echo 85 > /proc/sys/kernel/sched_group_downmigrate
            echo 100 > /proc/sys/kernel/sched_group_upmigrate

            # cpuset settings
            echo 0-3 > /dev/cpuset/background/cpus
            echo 0-3 > /dev/cpuset/system-background/cpus


            # configure governor settings for little cluster
            echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
            echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
            echo 614400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rtg_boost_freq

            # configure input boost settings
            echo "0:1017600" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
            echo 80 > /sys/devices/system/cpu/cpu_boost/input_boost_ms

            # configure governor settings for big cluster
            echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/up_rate_limit_us
            echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/down_rate_limit_us
            echo 1401600 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
            echo 1056000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
            echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/rtg_boost_freq

	    echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

            # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
            echo -6 >  /sys/devices/system/cpu/cpu0/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu1/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu2/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu3/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu4/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu5/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
            echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
            echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load
            echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_load

            # Set Memory parameters
            configure_memory_parameters

            # Enable bus-dcvs
            ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
            ddr_type4="07"
            ddr_type3="05"

            for device in /sys/devices/platform/soc
            do
                for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
                do
                    echo "bw_hwmon" > $cpubw/governor
                    echo 50 > $cpubw/polling_interval
                    echo 762 > $cpubw/min_freq
                    if [ ${ddr_type:4:2} == $ddr_type4 ]; then
                        # LPDDR4
                        echo "2288 3440 4173 5195 5859 7759 10322 11863 13763" > $cpubw/bw_hwmon/mbps_zones
                        echo 85 > $cpubw/bw_hwmon/io_percent
                    fi
                    if [ ${ddr_type:4:2} == $ddr_type3 ]; then
                        # LPDDR3
                        echo "1525 3440 5195 5859 7102" > $cpubw/bw_hwmon/mbps_zones
                        echo 34 > $cpubw/bw_hwmon/io_percent
                    fi
                    echo 4 > $cpubw/bw_hwmon/sample_ms
                    echo 90 > $cpubw/bw_hwmon/decay_rate
                    echo 190 > $cpubw/bw_hwmon/bw_step
                    echo 20 > $cpubw/bw_hwmon/hist_memory
                    echo 0 > $cpubw/bw_hwmon/hyst_length
                    echo 80 > $cpubw/bw_hwmon/down_thres
                    echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                    echo 250 > $cpubw/bw_hwmon/up_scale
                   echo 1600 > $cpubw/bw_hwmon/idle_mbps
                done

                for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
                do
                    echo "mem_latency" > $memlat/governor
                    echo 10 > $memlat/polling_interval
                    echo 400 > $memlat/mem_latency/ratio_ceil
                done

                for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
                do
                    echo "compute" > $latfloor/governor
                    echo 10 > $latfloor/polling_interval
                done

            done

            # colcoation v3 disabled
            echo 0 > /proc/sys/kernel/sched_min_task_util_for_boost
            echo 0 > /proc/sys/kernel/sched_min_task_util_for_colocation

            # Turn off scheduler boost at the end
            echo 0 > /proc/sys/kernel/sched_boost

            # Turn on sleep modes
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

            ;;
        esac

        # Scuba perf/power tunings
        case "$soc_id" in
             "441" | "473" | "474" )

            # Quad-core device. disable core_ctl
            echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

            # Configure schedutil governor settings
            echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
            echo 1305600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
            echo 614400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
            echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rtg_boost_freq

            # sched_load_boost as -6 is equivalent to target load as 85.
            echo 0 > /proc/sys/kernel/sched_boost
            echo 1 > /proc/sys/kernel/sched_prefer_spread
            echo -6 > /sys/devices/system/cpu/cpu0/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu1/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu2/sched_load_boost
            echo -6 > /sys/devices/system/cpu/cpu3/sched_load_boost
            echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_load

            # configure input boost settings
            echo "0:1017600" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
            echo 80 > /sys/devices/system/cpu/cpu_boost/input_boost_ms

            # Set Memory parameters
            configure_memory_parameters

            # Enable bus-dcvs
            ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
            ddr_type4="07"
            ddr_type3="05"

            for device in /sys/devices/platform/soc
            do
                for cpubw in $device/*cpu-cpu-ddr-bw/devfreq/*cpu-cpu-ddr-bw
                do
                    echo "bw_hwmon" > $cpubw/governor
                    echo 50 > $cpubw/polling_interval
                    echo 762 > $cpubw/min_freq
                    if [ ${ddr_type:4:2} == $ddr_type4 ]; then
                        # LPDDR4
                        echo "2288 3440 4173 5195 5859 7759 10322 11863 13763" > $cpubw/bw_hwmon/mbps_zones
                        echo 85 > $cpubw/bw_hwmon/io_percent
                    fi
                    if [ ${ddr_type:4:2} == $ddr_type3 ]; then
                        # LPDDR3
                        echo "1525 3440 5195 5859 7102" > $cpubw/bw_hwmon/mbps_zones
                        echo 34 > $cpubw/bw_hwmon/io_percent
                    fi
                    echo 4 > $cpubw/bw_hwmon/sample_ms
                    echo 90 > $cpubw/bw_hwmon/decay_rate
                    echo 190 > $cpubw/bw_hwmon/bw_step
                    echo 20 > $cpubw/bw_hwmon/hist_memory
                    echo 0 > $cpubw/bw_hwmon/hyst_length
                    echo 80 > $cpubw/bw_hwmon/down_thres
                    echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                    echo 250 > $cpubw/bw_hwmon/up_scale
                   echo 1600 > $cpubw/bw_hwmon/idle_mbps
                done

                for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
                do
                    echo "mem_latency" > $memlat/governor
                    echo 10 > $memlat/polling_interval
                    echo 400 > $memlat/mem_latency/ratio_ceil
                done

                for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
                do
                    echo "compute" > $latfloor/governor
                    echo 10 > $latfloor/polling_interval
                done
            done

            # Enable low power modes.
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
            ;;
        esac

    ;;
esac





#Apply settings for atoll
case "$target" in
    "atoll")

    # Core control parameters on silver
    echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
    echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
    echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
    echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
    echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres
    echo 0 > /sys/devices/system/cpu/cpu6/core_ctl/enable

    # Setting b.L scheduler parameters
    # default sched up and down migrate values are 95 and 85
    echo 65 > /proc/sys/kernel/sched_downmigrate
    echo 71 > /proc/sys/kernel/sched_upmigrate
    # default sched up and down migrate values are 100 and 95
    echo 85 > /proc/sys/kernel/sched_group_downmigrate
    echo 100 > /proc/sys/kernel/sched_group_upmigrate
    echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

    #colocation v3 settings
    echo 740000 > /proc/sys/kernel/sched_little_cluster_coloc_fmin_khz

    # configure governor settings for little cluster
    echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/up_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/down_rate_limit_us
    echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
    echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

    # configure governor settings for big cluster
    echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/up_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/down_rate_limit_us
    echo 1267200 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
    echo 652800 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq

    # sched_load_boost as -6 is equivalent to target load as 85. It is per cpu tunable.
    echo -6 >  /sys/devices/system/cpu/cpu6/sched_load_boost
    echo -6 >  /sys/devices/system/cpu/cpu7/sched_load_boost
    echo 85 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_load

    # Enable conservative pl
    echo 1 > /proc/sys/kernel/sched_conservative_pl

    echo "0:1248000" > /sys/module/cpu_boost/parameters/input_boost_freq
    echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

    # Set Memory parameters
    configure_memory_parameters

    # Enable bus-dcvs
    for device in /sys/devices/platform/soc
    do
        for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
        do
            echo "bw_hwmon" > $cpubw/governor
            echo "2288 4577 7110 9155 12298 14236" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 68 > $cpubw/bw_hwmon/io_percent
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 0 > $cpubw/bw_hwmon/hyst_length
            echo 80 > $cpubw/bw_hwmon/down_thres
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
            echo 50 > $cpubw/polling_interval
        done

        for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
        do
            echo "bw_hwmon" > $llccbw/governor
            echo "1144 1720 2086 2929 3879 5931 6881 8137" > $llccbw/bw_hwmon/mbps_zones
            echo 4 > $llccbw/bw_hwmon/sample_ms
            echo 68 > $llccbw/bw_hwmon/io_percent
            echo 20 > $llccbw/bw_hwmon/hist_memory
            echo 0 > $llccbw/bw_hwmon/hyst_length
            echo 80 > $llccbw/bw_hwmon/down_thres
            echo 0 > $llccbw/bw_hwmon/guard_band_mbps
            echo 250 > $llccbw/bw_hwmon/up_scale
            echo 1600 > $llccbw/bw_hwmon/idle_mbps
            echo 40 > $llccbw/polling_interval
        done

        for npubw in $device/*npu*-npu-ddr-bw/devfreq/*npu*-npu-ddr-bw
        do
            echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
            echo "bw_hwmon" > $npubw/governor
            echo "1144 1720 2086 2929 3879 5931 6881 8137" > $npubw/bw_hwmon/mbps_zones
            echo 4 > $npubw/bw_hwmon/sample_ms
            echo 80 > $npubw/bw_hwmon/io_percent
            echo 20 > $npubw/bw_hwmon/hist_memory
            echo 10 > $npubw/bw_hwmon/hyst_length
            echo 30 > $npubw/bw_hwmon/down_thres
            echo 0 > $npubw/bw_hwmon/guard_band_mbps
            echo 250 > $npubw/bw_hwmon/up_scale
            echo 0 > $npubw/bw_hwmon/idle_mbps
            echo 40 > $npubw/polling_interval
            echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
        done

        #Enable mem_latency governor for L3, LLCC, and DDR scaling
        for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done

        #Enable cdspl3 governor for L3 cdsp nodes
        for l3cdsp in $device/*cdsp-cdsp-l3-lat/devfreq/*cdsp-cdsp-l3-lat
        do
            echo "cdspl3" > $l3cdsp/governor
        done

        #Gold L3 ratio ceil
        echo 4000 > /sys/class/devfreq/soc:qcom,cpu6-cpu-l3-lat/mem_latency/ratio_ceil

        #Enable compute governor for gold latfloor
        for latfloor in $device/*cpu*-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
        do
            echo "compute" > $latfloor/governor
            echo 10 > $latfloor/polling_interval
        done

    done

    # cpuset parameters
    echo 0-5 > /dev/cpuset/background/cpus
    echo 0-5 > /dev/cpuset/system-background/cpus

    # Turn off scheduler boost at the end
    echo 0 > /proc/sys/kernel/sched_boost

    # Turn on sleep modes
    echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
  ;;
esac


case "$target" in
    "qcs605")

        #Apply settings for qcs605
        # Set the default IRQ affinity to the silver cluster. When a
        # CPU is isolated/hotplugged, the IRQ affinity is adjusted
        # to one of the CPU from the default IRQ affinity mask.
        echo 3f > /proc/irq/default_smp_affinity

        if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
        else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /sys/devices/soc0/hw_platform ]; then
            hw_platform=`cat /sys/devices/soc0/hw_platform`
        else
            hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
        fi

        if [ -f /sys/devices/soc0/platform_subtype_id ]; then
            platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
        fi

        case "$soc_id" in
            "347" )

            # Start Host based Touch processing
            case "$hw_platform" in
              "Surf" | "RCM" | "QRD" )
                  start_hbtp
                  ;;
              "MTP" )
                  if [ $platform_subtype_id != 5 ]; then
                      start_hbtp
                  fi
                  ;;
            esac

      # Core control parameters on silver
      echo 0 0 0 0 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred
      echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
      echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
      echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
      echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
      echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
      echo 8 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres

      # Setting b.L scheduler parameters
      echo 96 > /proc/sys/kernel/sched_upmigrate
      echo 90 > /proc/sys/kernel/sched_downmigrate
      echo 140 > /proc/sys/kernel/sched_group_upmigrate
      echo 120 > /proc/sys/kernel/sched_group_downmigrate

      # configure governor settings for little cluster
      echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
      echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
      echo 1209600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
      echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

      # configure governor settings for big cluster
      echo "schedutil" > /sys/devices/system/cpu/cpu6/cpufreq/scaling_governor
      echo 0 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/rate_limit_us
      echo 1344000 > /sys/devices/system/cpu/cpu6/cpufreq/schedutil/hispeed_freq
      echo 825600 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq

      echo "0:1209600" > /sys/module/cpu_boost/parameters/input_boost_freq
      echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms

      # Enable bus-dcvs
      for cpubw in /sys/class/devfreq/*qcom,cpubw*
            do
                echo "bw_hwmon" > $cpubw/governor
                echo 50 > $cpubw/polling_interval
                echo "1144 1720 2086 2929 3879 5931 6881" > $cpubw/bw_hwmon/mbps_zones
                echo 4 > $cpubw/bw_hwmon/sample_ms
                echo 68 > $cpubw/bw_hwmon/io_percent
                echo 20 > $cpubw/bw_hwmon/hist_memory
                echo 0 > $cpubw/bw_hwmon/hyst_length
                echo 80 > $cpubw/bw_hwmon/down_thres
                echo 0 > $cpubw/bw_hwmon/low_power_ceil_mbps
                echo 68 > $cpubw/bw_hwmon/low_power_io_percent
                echo 20 > $cpubw/bw_hwmon/low_power_delay
                echo 0 > $cpubw/bw_hwmon/guard_band_mbps
                echo 250 > $cpubw/bw_hwmon/up_scale
                echo 1600 > $cpubw/bw_hwmon/idle_mbps
            done

            #Enable mem_latency governor for DDR scaling
            for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
            do
                echo "mem_latency" > $memlat/governor
                echo 10 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            #Enable mem_latency governor for L3 scaling
            for memlat in /sys/class/devfreq/*qcom,l3-cpu*
            do
                echo "mem_latency" > $memlat/governor
                echo 10 > $memlat/polling_interval
                echo 400 > $memlat/mem_latency/ratio_ceil
            done

            echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor

            # cpuset parameters
            echo 0-5 > /dev/cpuset/background/cpus
            echo 0-5 > /dev/cpuset/system-background/cpus

            # Turn off scheduler boost at the end
            echo 0 > /proc/sys/kernel/sched_boost

            # Turn on sleep modes.
            echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
            echo 100 > /proc/sys/vm/swappiness
            ;;
        esac
    ;;
esac

case "$target" in
    "apq8084")
        echo 4 > /sys/module/lpm_levels/enable_low_power/l2
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/retention/idle_enabled
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
        do
            echo "cpubw_hwmon" > $devfreq_gov
        done
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo "interactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo "20000 1400000:40000 1700000:20000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
        echo 1497600 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
        echo "85 1500000:90 1800000:70" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
        echo 40000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
        echo 20 > /sys/module/cpu_boost/parameters/boost_ms
        echo 1728000 > /sys/module/cpu_boost/parameters/sync_threshold
        echo 100000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor
        echo 1497600 > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
        echo 1 > /dev/cpuctl/apps/cpu.notify_on_migrate
        echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        chown -h  system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
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
        echo 4 > /sys/module/lpm_levels/enable_low_power/l2
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/suspend_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/standalone_power_collapse/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu0/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu1/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu2/retention/idle_enabled
        echo 1 > /sys/module/msm_pm/modes/cpu3/retention/idle_enabled
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo "ondemand" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo "ondemand" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
        echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
        echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        chown -h  system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
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
        # disable thermal bcl hotplug to switch governor
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        echo -n disable > /sys/devices/soc.*/qcom,bcl.*/mode
        bcl_hotplug_mask=`cat /sys/devices/soc.*/qcom,bcl.*/hotplug_mask`
        echo 0 > /sys/devices/soc.*/qcom,bcl.*/hotplug_mask
        echo -n enable > /sys/devices/soc.*/qcom,bcl.*/mode
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
        # configure governor settings for little cluster
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
        echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        echo 80000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
        echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        # online CPU4
        echo 1 > /sys/devices/system/cpu/cpu4/online
        # configure governor settings for big cluster
        echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
        echo 19000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
        echo 1536000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
        echo 85 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
        echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
        echo 80000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
        echo 384000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
        # re-enable thermal and BCL hotplug
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        echo -n disable > /sys/devices/soc.*/qcom,bcl.*/mode
        echo $bcl_hotplug_mask > /sys/devices/soc.*/qcom,bcl.*/hotplug_mask
        echo $bcl_soc_hotplug_mask > /sys/devices/soc.*/qcom,bcl.*/hotplug_soc_mask
        echo -n enable > /sys/devices/soc.*/qcom,bcl.*/mode
        # plugin remaining A57s
        echo 1 > /sys/devices/system/cpu/cpu5/online
        # input boost configuration
        echo 0:1248000 > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
        # Enable task migration fixups in the scheduler
        echo 1 > /proc/sys/kernel/sched_migration_fixup
        for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
        do
            echo "bw_hwmon" > $devfreq_gov
        done
        #enable rps static configuration
        echo 8 >  /sys/class/net/rmnet_ipa0/queues/rx-0/rps_cpus
        echo 30 > /proc/sys/kernel/sched_small_task
    ;;
esac

case "$target" in
    "msm8994")
        # ensure at most one A57 is online when thermal hotplug is disabled
        echo 0 > /sys/devices/system/cpu/cpu5/online
        echo 0 > /sys/devices/system/cpu/cpu6/online
        echo 0 > /sys/devices/system/cpu/cpu7/online
        # in case CPU4 is online, limit its frequency
        echo 960000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        # Limit A57 max freq from msm_perf module in case CPU 4 is offline
        echo "4:960000 5:960000 6:960000 7:960000" > /sys/module/msm_performance/parameters/cpu_max_freq
        # disable thermal bcl hotplug to switch governor
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n disable > $mode
        done
        for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
        do
            bcl_hotplug_mask=`cat $hotplug_mask`
            echo 0 > $hotplug_mask
        done
        for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
        do
            bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
            echo 0 > $hotplug_soc_mask
        done
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n enable > $mode
        done
        # configure governor settings for little cluster
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
        echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        echo 80000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
        echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        # online CPU4
        echo 1 > /sys/devices/system/cpu/cpu4/online
        # Best effort limiting for first time boot if msm_performance module is absent
        echo 960000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        # configure governor settings for big cluster
        echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
        echo "19000 1400000:39000 1700000:19000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
        echo 1248000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
        echo "85 1500000:90 1800000:70" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
        echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
        echo 80000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
        echo 384000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
        # restore A57's max
        cat /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        # re-enable thermal and BCL hotplug
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n disable > $mode
        done
        for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
        do
            echo $bcl_hotplug_mask > $hotplug_mask
        done
        for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
        do
            echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
        done
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n enable > $mode
        done
        # plugin remaining A57s
        echo 1 > /sys/devices/system/cpu/cpu5/online
        echo 1 > /sys/devices/system/cpu/cpu6/online
        echo 1 > /sys/devices/system/cpu/cpu7/online
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
        # Restore CPU 4 max freq from msm_performance
        echo "4:4294967295 5:4294967295 6:4294967295 7:4294967295" > /sys/module/msm_performance/parameters/cpu_max_freq
        # input boost configuration
        echo 0:1344000 > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
        # Setting b.L scheduler parameters
        echo 1 > /proc/sys/kernel/sched_migration_fixup
        echo 30 > /proc/sys/kernel/sched_small_task
        echo 20 > /proc/sys/kernel/sched_mostly_idle_load
        echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run
        echo 99 > /proc/sys/kernel/sched_upmigrate
        echo 85 > /proc/sys/kernel/sched_downmigrate
        echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
        echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
        #enable rps static configuration
        echo 8 >  /sys/class/net/rmnet_ipa0/queues/rx-0/rps_cpus
        for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
        do
            echo "bw_hwmon" > $devfreq_gov
        done
    ;;
esac

case "$target" in
    "msm8996")
        # disable thermal bcl hotplug to switch governor
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
        bcl_hotplug_mask=`cat /sys/devices/soc/soc:qcom,bcl/hotplug_mask`
        echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
        bcl_soc_hotplug_mask=`cat /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask`
        echo 0 > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
        echo -n enable > /sys/devices/soc/soc:qcom,bcl/mode
        # set sync wakee policy tunable
        echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker
        # configure governor settings for little cluster
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
        echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
        echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
        echo 80 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
        echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
        echo 79000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
        echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
        # online CPU2
        echo 1 > /sys/devices/system/cpu/cpu2/online
        # configure governor settings for big cluster
        echo "interactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_sched_load
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/use_migration_notif
        echo "19000 1400000:39000 1700000:19000 2100000:79000" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/go_hispeed_load
        echo 20000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/timer_rate
        echo 1248000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/hispeed_freq
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/io_is_busy
        echo "85 1500000:90 1800000:70 2100000:95" > /sys/devices/system/cpu/cpu2/cpufreq/interactive/target_loads
        echo 19000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/min_sample_time
        echo 79000 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/max_freq_hysteresis
        echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 1 > /sys/devices/system/cpu/cpu2/cpufreq/interactive/ignore_hispeed_on_notif
        # re-enable thermal and BCL hotplug
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        echo -n disable > /sys/devices/soc/soc:qcom,bcl/mode
        echo $bcl_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_mask
        echo $bcl_soc_hotplug_mask > /sys/devices/soc/soc:qcom,bcl/hotplug_soc_mask
        echo -n enable > /sys/devices/soc/soc:qcom,bcl/mode
        # input boost configuration
        echo "0:1324800 2:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
        # Setting b.L scheduler parameters
        echo 0 > /proc/sys/kernel/sched_boost
        echo 1 > /proc/sys/kernel/sched_migration_fixup
        echo 45 > /proc/sys/kernel/sched_downmigrate
        echo 45 > /proc/sys/kernel/sched_upmigrate
        echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
        echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
        echo 3 > /proc/sys/kernel/sched_spill_nr_run
        echo 100 > /proc/sys/kernel/sched_init_task_load
        # Enable bus-dcvs
        for cpubw in /sys/class/devfreq/*qcom,cpubw*
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo 1525 > $cpubw/min_freq
            echo "1525 5195 11863 13763" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 34 > $cpubw/bw_hwmon/io_percent
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 10 > $cpubw/bw_hwmon/hyst_length
            echo 0 > $cpubw/bw_hwmon/low_power_ceil_mbps
            echo 34 > $cpubw/bw_hwmon/low_power_io_percent
            echo 20 > $cpubw/bw_hwmon/low_power_delay
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

        for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
        done
        echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor

	soc_revision=`cat /sys/devices/soc0/revision`
	if [ "$soc_revision" == "2.0" ]; then
		#Disable suspend for v2.0
		echo pwr_dbg > /sys/power/wake_lock
	elif [ "$soc_revision" == "2.1" ]; then
		# Enable C4.D4.E4.M3 LPM modes
		# Disable D3 state
		echo 0 > /sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
		echo 0 > /sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled
		# Disable DEF-FPC mode
		echo N > /sys/module/lpm_levels/system/pwr/cpu0/fpc-def/idle_enabled
		echo N > /sys/module/lpm_levels/system/pwr/cpu1/fpc-def/idle_enabled
		echo N > /sys/module/lpm_levels/system/perf/cpu2/fpc-def/idle_enabled
		echo N > /sys/module/lpm_levels/system/perf/cpu3/fpc-def/idle_enabled
	else
		# Enable all LPMs by default
		# This will enable C4, D4, D3, E4 and M3 LPMs
		echo N > /sys/module/lpm_levels/parameters/sleep_disabled
	fi
	echo N > /sys/module/lpm_levels/parameters/sleep_disabled
        # Starting io prefetcher service
        start iop

        # Set Memory parameters
        configure_memory_parameters
    ;;
esac

case "$target" in
    "sdm845")

        # Set the default IRQ affinity to the silver cluster. When a
        # CPU is isolated/hotplugged, the IRQ affinity is adjusted
        # to one of the CPU from the default IRQ affinity mask.
        echo f > /proc/irq/default_smp_affinity

        if [ -f /sys/devices/soc0/soc_id ]; then
                soc_id=`cat /sys/devices/soc0/soc_id`
        else
                soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /sys/devices/soc0/hw_platform ]; then
                hw_platform=`cat /sys/devices/soc0/hw_platform`
        fi

        if [ -f /sys/devices/soc0/platform_subtype_id ]; then
                platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
        fi

        case "$soc_id" in
                "321" | "341")
                # Start Host based Touch processing
                case "$hw_platform" in
                    "QRD" )
                            case "$platform_subtype_id" in
                                   "32") #QVR845 do nothing
                                     ;;
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
	# Core control parameters
	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
	echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

	# Setting b.L scheduler parameters
	echo 95 > /proc/sys/kernel/sched_upmigrate
	echo 85 > /proc/sys/kernel/sched_downmigrate
	echo 100 > /proc/sys/kernel/sched_group_upmigrate
	echo 95 > /proc/sys/kernel/sched_group_downmigrate
	echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

	# configure governor settings for little cluster
	echo "schedutil" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/rate_limit_us
	echo 1209600 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/schedutil/pl
        echo 576000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

	# configure governor settings for big cluster
	echo "schedutil" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/rate_limit_us
	echo 1574400 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/schedutil/pl
	echo "0:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 120 > /sys/module/cpu_boost/parameters/input_boost_ms
	# Limit the min frequency to 825MHz
	echo 825000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

        # Enable oom_reaper
        echo 1 > /sys/module/lowmemorykiller/parameters/oom_reaper

        # Enable bus-dcvs
        for cpubw in /sys/class/devfreq/*qcom,cpubw*
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo "2288 4577 6500 8132 9155 10681" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 50 > $cpubw/bw_hwmon/io_percent
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 10 > $cpubw/bw_hwmon/hyst_length
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

        for llccbw in /sys/class/devfreq/*qcom,llccbw*
        do
            echo "bw_hwmon" > $llccbw/governor
            echo 50 > $llccbw/polling_interval
            echo "1720 2929 3879 5931 6881" > $llccbw/bw_hwmon/mbps_zones
            echo 4 > $llccbw/bw_hwmon/sample_ms
            echo 80 > $llccbw/bw_hwmon/io_percent
            echo 20 > $llccbw/bw_hwmon/hist_memory
            echo 10 > $llccbw/bw_hwmon/hyst_length
            echo 0 > $llccbw/bw_hwmon/guard_band_mbps
            echo 250 > $llccbw/bw_hwmon/up_scale
            echo 1600 > $llccbw/bw_hwmon/idle_mbps
        done

	#Enable mem_latency governor for DDR scaling
        for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
        do
	echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done

	#Enable mem_latency governor for L3 scaling
        for memlat in /sys/class/devfreq/*qcom,l3-cpu*
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done

        #Enable userspace governor for L3 cdsp nodes
        for l3cdsp in /sys/class/devfreq/*qcom,l3-cdsp*
        do
            echo "userspace" > $l3cdsp/governor
            chown -h system $l3cdsp/userspace/set_freq
        done

	#Gold L3 ratio ceil
        echo 4000 > /sys/class/devfreq/soc:qcom,l3-cpu4/mem_latency/ratio_ceil

	echo "compute" > /sys/class/devfreq/soc:qcom,mincpubw/governor
	echo 10 > /sys/class/devfreq/soc:qcom,mincpubw/polling_interval

	# cpuset parameters
        echo 0-3 > /dev/cpuset/background/cpus
        echo 0-3 > /dev/cpuset/system-background/cpus

	# Turn off scheduler boost at the end
        echo 0 > /proc/sys/kernel/sched_boost
	# Disable CPU Retention
        echo N > /sys/module/lpm_levels/L3/cpu0/ret/idle_enabled
        echo N > /sys/module/lpm_levels/L3/cpu1/ret/idle_enabled
        echo N > /sys/module/lpm_levels/L3/cpu2/ret/idle_enabled
        echo N > /sys/module/lpm_levels/L3/cpu3/ret/idle_enabled
        echo N > /sys/module/lpm_levels/L3/cpu4/ret/idle_enabled
        echo N > /sys/module/lpm_levels/L3/cpu5/ret/idle_enabled
        echo N > /sys/module/lpm_levels/L3/cpu6/ret/idle_enabled
        echo N > /sys/module/lpm_levels/L3/cpu7/ret/idle_enabled
	echo N > /sys/module/lpm_levels/L3/l3-dyn-ret/idle_enabled
        # Turn on sleep modes.
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
	echo 100 > /proc/sys/vm/swappiness
	echo 120 > /proc/sys/vm/watermark_scale_factor
    ;;
esac

case "$target" in
    "msmnile")
	# Core control parameters for gold
	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

	# Core control parameters for gold+
	echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/task_thres
	# Controls how many more tasks should be eligible to run on gold CPUs
	# w.r.t number of gold CPUs available to trigger assist (max number of
	# tasks eligible to run on previous cluster minus number of CPUs in
	# the previous cluster).
	#
	# Setting to 1 by default which means there should be at least
	# 4 tasks eligible to run on gold cluster (tasks running on gold cores
	# plus misfit tasks on silver cores) to trigger assitance from gold+.
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh

	# Disable Core control on silver
	echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

	# Setting b.L scheduler parameters
	echo 95 95 > /proc/sys/kernel/sched_upmigrate
	echo 85 85 > /proc/sys/kernel/sched_downmigrate
	echo 100 > /proc/sys/kernel/sched_group_upmigrate
	echo 10 > /proc/sys/kernel/sched_group_downmigrate
	echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

	# cpuset parameters
	echo 0-3 > /dev/cpuset/background/cpus
	echo 0-3 > /dev/cpuset/system-background/cpus

	# Turn off scheduler boost at the end
	echo 0 > /proc/sys/kernel/sched_boost

	# configure governor settings for silver cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 1209600 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	echo 576000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl

	# configure governor settings for gold cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 1612800 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl

	# configure governor settings for gold+ cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 1612800 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pl

	# configure input boost settings
	echo "0:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 120 > /sys/module/cpu_boost/parameters/input_boost_ms

	# Disable wsf, beacause we are using efk.
	# wsf Range : 1..1000 So set to bare minimum value 1.
        echo 1 > /proc/sys/vm/watermark_scale_factor

        echo 0-3 > /dev/cpuset/background/cpus
        echo 0-3 > /dev/cpuset/system-background/cpus

        # Enable oom_reaper
	if [ -f /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
		echo 1 > /sys/module/lowmemorykiller/parameters/oom_reaper
	else
		echo 1 > /proc/sys/vm/reap_mem_on_sigkill
	fi

	# Enable bus-dcvs
	for device in /sys/devices/platform/soc
	do
	    for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
	    do
		echo "bw_hwmon" > $cpubw/governor
		echo "2288 4577 7110 9155 12298 14236 15258" > $cpubw/bw_hwmon/mbps_zones
		echo 4 > $cpubw/bw_hwmon/sample_ms
		echo 50 > $cpubw/bw_hwmon/io_percent
		echo 20 > $cpubw/bw_hwmon/hist_memory
		echo 10 > $cpubw/bw_hwmon/hyst_length
		echo 30 > $cpubw/bw_hwmon/down_thres
		echo 0 > $cpubw/bw_hwmon/guard_band_mbps
		echo 250 > $cpubw/bw_hwmon/up_scale
		echo 1600 > $cpubw/bw_hwmon/idle_mbps
		echo 14236 > $cpubw/max_freq
                echo 40 > $cpubw/polling_interval
	    done

	    for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
	    do
		echo "bw_hwmon" > $llccbw/governor
		echo "1720 2929 3879 5931 6881 7980" > $llccbw/bw_hwmon/mbps_zones
		echo 4 > $llccbw/bw_hwmon/sample_ms
		echo 80 > $llccbw/bw_hwmon/io_percent
		echo 20 > $llccbw/bw_hwmon/hist_memory
		echo 10 > $llccbw/bw_hwmon/hyst_length
		echo 30 > $llccbw/bw_hwmon/down_thres
		echo 0 > $llccbw/bw_hwmon/guard_band_mbps
		echo 250 > $llccbw/bw_hwmon/up_scale
		echo 1600 > $llccbw/bw_hwmon/idle_mbps
		echo 6881 > $llccbw/max_freq
                echo 40 > $llccbw/polling_interval
	    done

	    for npubw in $device/*npu-npu-ddr-bw/devfreq/*npu-npu-ddr-bw
	    do
		echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
		echo "bw_hwmon" > $npubw/governor
		echo "1720 2929 3879 5931 6881 7980" > $npubw/bw_hwmon/mbps_zones
		echo 4 > $npubw/bw_hwmon/sample_ms
		echo 80 > $npubw/bw_hwmon/io_percent
		echo 20 > $npubw/bw_hwmon/hist_memory
		echo 6  > $npubw/bw_hwmon/hyst_length
		echo 30 > $npubw/bw_hwmon/down_thres
		echo 0 > $npubw/bw_hwmon/guard_band_mbps
		echo 250 > $npubw/bw_hwmon/up_scale
		echo 0 > $npubw/bw_hwmon/idle_mbps
                echo 40 > $npubw/polling_interval
		echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
	    done

	    #Enable mem_latency governor for L3, LLCC, and DDR scaling
	    for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
	    do
		echo "mem_latency" > $memlat/governor
		echo 10 > $memlat/polling_interval
		echo 400 > $memlat/mem_latency/ratio_ceil
	    done

	    #Enable userspace governor for L3 cdsp nodes
	    for l3cdsp in $device/*cdsp-cdsp-l3-lat/devfreq/*cdsp-cdsp-l3-lat
	    do
		echo "cdspl3" > $l3cdsp/governor
	    done

	    #Enable compute governor for gold latfloor
	    for latfloor in $device/*cpu-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
	    do
		echo "compute" > $latfloor/governor
		echo 10 > $latfloor/polling_interval
	    done

	    #Gold L3 ratio ceil
	    for l3gold in $device/*cpu4-cpu-l3-lat/devfreq/*cpu4-cpu-l3-lat
	    do
		echo 4000 > $l3gold/mem_latency/ratio_ceil
	    done

	    #Prime L3 ratio ceil
	    for l3prime in $device/*cpu7-cpu-l3-lat/devfreq/*cpu7-cpu-l3-lat
	    do
		echo 20000 > $l3prime/mem_latency/ratio_ceil
	    done
	done

    if [ -f /sys/devices/soc0/hw_platform ]; then
        hw_platform=`cat /sys/devices/soc0/hw_platform`
    else
        hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
    fi

    if [ -f /sys/devices/soc0/platform_subtype_id ]; then
        platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
    fi

    case "$hw_platform" in
        "MTP" | "Surf" | "RCM" )
            # Start Host based Touch processing
            case "$platform_subtype_id" in
                "0" | "1" | "2" | "3" | "4" | "5")
                    start_hbtp
                    ;;
            esac
        ;;
        "HDK" )
            if [ -d /sys/kernel/hbtpsensor ] ; then
                start_hbtp
            fi
        ;;
    esac

    echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
    configure_memory_parameters
    target_type=`getprop ro.hardware.type`
	if [ "$target_type" == "automotive" ]; then
           # update frequencies
           configure_automotive_sku_parameters
	fi

    ;;
esac

case "$target" in
    "sdmshrike")
	# Core control parameters for gold
	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

	# Core control parameters for gold+
	echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/task_thres
	# Controls how many more tasks should be eligible to run on gold CPUs
	# w.r.t number of gold CPUs available to trigger assist (max number of
	# tasks eligible to run on previous cluster minus number of CPUs in
	# the previous cluster).
	#
	# Setting to 1 by default which means there should be at least
	# 4 tasks eligible to run on gold cluster (tasks running on gold cores
	# plus misfit tasks on silver cores) to trigger assitance from gold+.
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh

	# Disable Core control on silver
	echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

	# Setting b.L scheduler parameters
	echo 95 95 > /proc/sys/kernel/sched_upmigrate
	echo 85 85 > /proc/sys/kernel/sched_downmigrate
	echo 100 > /proc/sys/kernel/sched_group_upmigrate
	echo 10 > /proc/sys/kernel/sched_group_downmigrate
	echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks

	# cpuset parameters
	echo 0-3 > /dev/cpuset/background/cpus
	echo 0-3 > /dev/cpuset/system-background/cpus

	# Turn off scheduler boost at the end
	echo 0 > /proc/sys/kernel/sched_boost

	# configure governor settings for silver cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 1209600 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	echo 576000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl

	# configure governor settings for gold cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo 1612800 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl

	# configure governor settings for gold+ cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
	echo 1612800 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pl

	# configure input boost settings
	echo "0:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq
	echo 120 > /sys/module/cpu_boost/parameters/input_boost_ms

	# Disable wsf, beacause we are using efk.
	# wsf Range : 1..1000 So set to bare minimum value 1.
        echo 1 > /proc/sys/vm/watermark_scale_factor

        echo 0-3 > /dev/cpuset/background/cpus
        echo 0-3 > /dev/cpuset/system-background/cpus

        # Enable oom_reaper
	if [ -f /sys/module/lowmemorykiller/parameters/oom_reaper ]; then
		echo 1 > /sys/module/lowmemorykiller/parameters/oom_reaper
	else
		echo 1 > /proc/sys/vm/reap_mem_on_sigkill
	fi

	# Enable bus-dcvs
	for device in /sys/devices/platform/soc
	do
	    for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
	    do
		echo "bw_hwmon" > $cpubw/governor
		echo 40 > $cpubw/polling_interval
		echo "2288 4577 7110 9155 12298 14236 15258" > $cpubw/bw_hwmon/mbps_zones
		echo 4 > $cpubw/bw_hwmon/sample_ms
		echo 50 > $cpubw/bw_hwmon/io_percent
		echo 20 > $cpubw/bw_hwmon/hist_memory
		echo 10 > $cpubw/bw_hwmon/hyst_length
		echo 30 > $cpubw/bw_hwmon/down_thres
		echo 0 > $cpubw/bw_hwmon/guard_band_mbps
		echo 250 > $cpubw/bw_hwmon/up_scale
		echo 1600 > $cpubw/bw_hwmon/idle_mbps
		echo 14236 > $cpubw/max_freq
	    done

	    for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
	    do
		echo "bw_hwmon" > $llccbw/governor
		echo 40 > $llccbw/polling_interval
		echo "1720 2929 3879 5931 6881 7980" > $llccbw/bw_hwmon/mbps_zones
		echo 4 > $llccbw/bw_hwmon/sample_ms
		echo 80 > $llccbw/bw_hwmon/io_percent
		echo 20 > $llccbw/bw_hwmon/hist_memory
		echo 10 > $llccbw/bw_hwmon/hyst_length
		echo 30 > $llccbw/bw_hwmon/down_thres
		echo 0 > $llccbw/bw_hwmon/guard_band_mbps
		echo 250 > $llccbw/bw_hwmon/up_scale
		echo 1600 > $llccbw/bw_hwmon/idle_mbps
		echo 6881 > $llccbw/max_freq
	    done

	    for npubw in $device/*npu-npu-ddr-bw/devfreq/*npu-npu-ddr-bw
	    do
		echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
		echo "bw_hwmon" > $npubw/governor
		echo 40 > $npubw/polling_interval
		echo "1720 2929 3879 5931 6881 7980" > $npubw/bw_hwmon/mbps_zones
		echo 4 > $npubw/bw_hwmon/sample_ms
		echo 80 > $npubw/bw_hwmon/io_percent
		echo 20 > $npubw/bw_hwmon/hist_memory
		echo 6  > $npubw/bw_hwmon/hyst_length
		echo 30 > $npubw/bw_hwmon/down_thres
		echo 0 > $npubw/bw_hwmon/guard_band_mbps
		echo 250 > $npubw/bw_hwmon/up_scale
		echo 0 > $npubw/bw_hwmon/idle_mbps
		echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
	    done

	    #Enable mem_latency governor for L3, LLCC, and DDR scaling
	    for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
	    do
		echo "mem_latency" > $memlat/governor
		echo 10 > $memlat/polling_interval
		echo 400 > $memlat/mem_latency/ratio_ceil
	    done

	    #Enable userspace governor for L3 cdsp nodes
	    for l3cdsp in $device/*cdsp-cdsp-l3-lat/devfreq/*cdsp-cdsp-l3-lat
	    do
		echo "cdspl3" > $l3cdsp/governor
	    done

	    #Enable compute governor for gold latfloor
	    for latfloor in $device/*cpu-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
	    do
		echo "compute" > $latfloor/governor
		echo 10 > $latfloor/polling_interval
	    done

	    #Gold L3 ratio ceil
	    for l3gold in $device/*cpu4-cpu-l3-lat/devfreq/*cpu4-cpu-l3-lat
	    do
		echo 4000 > $l3gold/mem_latency/ratio_ceil
	    done

	    #Prime L3 ratio ceil
	    for l3prime in $device/*cpu7-cpu-l3-lat/devfreq/*cpu7-cpu-l3-lat
	    do
		echo 20000 > $l3prime/mem_latency/ratio_ceil
	    done
	done

    if [ -f /sys/devices/soc0/hw_platform ]; then
        hw_platform=`cat /sys/devices/soc0/hw_platform`
    else
        hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
    fi

    if [ -f /sys/devices/soc0/platform_subtype_id ]; then
        platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
    fi

    case "$hw_platform" in
        "MTP" | "Surf" | "RCM" )
            # Start Host based Touch processing
            case "$platform_subtype_id" in
                "0" | "1")
                    start_hbtp
                    ;;
            esac
        ;;
        "HDK" )
            if [ -d /sys/kernel/hbtpsensor ] ; then
                start_hbtp
            fi
        ;;
    esac

	#Setting the min and max supported frequencies
	reg_val=`cat /sys/devices/platform/soc/780130.qfprom/qfprom0/nvmem | od -An -t d4`
	feature_id=$(((reg_val >> 20) & 0xFF))

	#Setting the min supported frequencies
	echo 1113600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1113600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
	echo 1113600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 1113600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
        echo 1171200 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
        echo 1171200 > /sys/devices/system/cpu/cpu5/cpufreq/scaling_min_freq
        echo 1171200 > /sys/devices/system/cpu/cpu6/cpufreq/scaling_min_freq
        echo 1171200 > /sys/devices/system/cpu/cpu7/cpufreq/scaling_min_freq
        #setting min gpu freq to 392  MHz
        echo 4 > /sys/class/kgsl/kgsl-3d0/min_pwrlevel
        if [ $feature_id == 0 ]; then
                echo "feature_id is 0 for SA8185P"

                #setting max gpu freq to 530 MHz
                echo 3 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
                echo {class:ddr, res:capped, val: 1804} > /sys/kernel/debug/aop_send_message
        elif [ $feature_id == 1 ]; then
                echo "feature_id is 1 for SA8195P"

                #setting max gpu freq to 670 MHz
                echo 0 > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
                echo {class:ddr, res:capped, val: 2092} > /sys/kernel/debug/aop_send_message
        else
                echo "unknown feature_id value" $feature_id
        fi

    echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
    configure_memory_parameters
    ;;
esac

case "$target" in
	"kona")
	rev=`cat /sys/devices/soc0/revision`
	ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
	ddr_type4="07"
	ddr_type5="08"

	# Core control parameters for gold
	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

	# Core control parameters for gold+
	echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/task_thres
	# Controls how many more tasks should be eligible to run on gold CPUs
	# w.r.t number of gold CPUs available to trigger assist (max number of
	# tasks eligible to run on previous cluster minus number of CPUs in
	# the previous cluster).
	#
	# Setting to 1 by default which means there should be at least
	# 4 tasks eligible to run on gold cluster (tasks running on gold cores
	# plus misfit tasks on silver cores) to trigger assitance from gold+.
	echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh

	# Disable Core control on silver
	echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

	# Setting b.L scheduler parameters
	echo 95 95 > /proc/sys/kernel/sched_upmigrate
	echo 85 85 > /proc/sys/kernel/sched_downmigrate
	echo 100 > /proc/sys/kernel/sched_group_upmigrate
	echo 85 > /proc/sys/kernel/sched_group_downmigrate
	echo 1 > /proc/sys/kernel/sched_walt_rotate_big_tasks
	echo 400000000 > /proc/sys/kernel/sched_coloc_downmigrate_ns

	# cpuset parameters
	echo 0-3 > /dev/cpuset/background/cpus
	echo 0-3 > /dev/cpuset/system-background/cpus

	# Turn off scheduler boost at the end
	echo 0 > /proc/sys/kernel/sched_boost

	# configure governor settings for silver cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
        if [ $rev == "2.0" ] || [ $rev == "2.1"]; then
		echo 1248000 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	else
		echo 1228800 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
	fi
	echo 691200 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl

	# configure input boost settings
	echo "0:1324800" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
	echo 120 > /sys/devices/system/cpu/cpu_boost/input_boost_ms

	# configure governor settings for gold cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
	echo 1574400 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl

	# configure governor settings for gold+ cluster
	echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
	echo 0 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
        if [ $rev == "2.0" ] || [ $rev == "2.1"]; then
		echo 1632000 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	else
		echo 1612800 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
	fi
	echo 1 > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pl

	# Enable bus-dcvs
	for device in /sys/devices/platform/soc
	do
	    for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw
	    do
		echo "bw_hwmon" > $cpubw/governor
		echo "4577 7110 9155 12298 14236 15258" > $cpubw/bw_hwmon/mbps_zones
		echo 4 > $cpubw/bw_hwmon/sample_ms
		echo 50 > $cpubw/bw_hwmon/io_percent
		echo 20 > $cpubw/bw_hwmon/hist_memory
		echo 10 > $cpubw/bw_hwmon/hyst_length
		echo 30 > $cpubw/bw_hwmon/down_thres
		echo 0 > $cpubw/bw_hwmon/guard_band_mbps
		echo 250 > $cpubw/bw_hwmon/up_scale
		echo 1600 > $cpubw/bw_hwmon/idle_mbps
		echo 14236 > $cpubw/max_freq
		echo 40 > $cpubw/polling_interval
	    done

	    for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw
	    do
		echo "bw_hwmon" > $llccbw/governor
		if [ ${ddr_type:4:2} == $ddr_type4 ]; then
			echo "1720 2086 2929 3879 5161 5931 6881 7980" > $llccbw/bw_hwmon/mbps_zones
		elif [ ${ddr_type:4:2} == $ddr_type5 ]; then
			echo "1720 2086 2929 3879 5931 6881 7980 10437" > $llccbw/bw_hwmon/mbps_zones
		fi
		echo 4 > $llccbw/bw_hwmon/sample_ms
		echo 80 > $llccbw/bw_hwmon/io_percent
		echo 20 > $llccbw/bw_hwmon/hist_memory
		echo 10 > $llccbw/bw_hwmon/hyst_length
		echo 30 > $llccbw/bw_hwmon/down_thres
		echo 0 > $llccbw/bw_hwmon/guard_band_mbps
		echo 250 > $llccbw/bw_hwmon/up_scale
		echo 1600 > $llccbw/bw_hwmon/idle_mbps
		echo 6881 > $llccbw/max_freq
		echo 40 > $llccbw/polling_interval
	    done

	    for npubw in $device/*npu*-ddr-bw/devfreq/*npu*-ddr-bw
	    do
		echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
		echo "bw_hwmon" > $npubw/governor
		if [ ${ddr_type:4:2} == $ddr_type4 ]; then
			echo "1720 2086 2929 3879 5931 6881 7980" > $npubw/bw_hwmon/mbps_zones
		elif [ ${ddr_type:4:2} == $ddr_type5 ]; then
			echo "1720 2086 2929 3879 5931 6881 7980 10437" > $npubw/bw_hwmon/mbps_zones
		fi
		echo 4 > $npubw/bw_hwmon/sample_ms
		echo 160 > $npubw/bw_hwmon/io_percent
		echo 20 > $npubw/bw_hwmon/hist_memory
		echo 10 > $npubw/bw_hwmon/hyst_length
		echo 30 > $npubw/bw_hwmon/down_thres
		echo 0 > $npubw/bw_hwmon/guard_band_mbps
		echo 250 > $npubw/bw_hwmon/up_scale
		echo 1600 > $npubw/bw_hwmon/idle_mbps
		echo 40 > $npubw/polling_interval
		echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
	    done

	    for npullccbw in $device/*npu*-llcc-bw/devfreq/*npu*-llcc-bw
	    do
		echo 1 > /sys/devices/virtual/npu/msm_npu/pwr
		echo "bw_hwmon" > $npullccbw/governor
		echo "4577 7110 9155 12298 14236 15258" > $npullccbw/bw_hwmon/mbps_zones
		echo 4 > $npullccbw/bw_hwmon/sample_ms
		echo 160 > $npullccbw/bw_hwmon/io_percent
		echo 20 > $npullccbw/bw_hwmon/hist_memory
		echo 10 > $npullccbw/bw_hwmon/hyst_length
		echo 30 > $npullccbw/bw_hwmon/down_thres
		echo 0 > $npullccbw/bw_hwmon/guard_band_mbps
		echo 250 > $npullccbw/bw_hwmon/up_scale
		echo 1600 > $npullccbw/bw_hwmon/idle_mbps
		echo 40 > $npullccbw/polling_interval
		echo 0 > /sys/devices/virtual/npu/msm_npu/pwr
	    done
	    #Enable mem_latency governor for L3 scaling
	    for memlat in $device/*qcom,devfreq-l3/*cpu*-lat/devfreq/*cpu*-lat
	    do
		echo "mem_latency" > $memlat/governor
		echo 8 > $memlat/polling_interval
		echo 400 > $memlat/mem_latency/ratio_ceil
	    done

	    #Enable cdspl3 governor for L3 cdsp nodes
	    for l3cdsp in $device/*qcom,devfreq-l3/*cdsp-l3-lat/devfreq/*cdsp-l3-lat
	    do
                echo "cdspl3" > $l3cdsp/governor
	    done

	    #Enable mem_latency governor for LLCC and DDR scaling
	    for memlat in $device/*cpu*-lat/devfreq/*cpu*-lat
	    do
		echo "mem_latency" > $memlat/governor
		echo 8 > $memlat/polling_interval
		echo 400 > $memlat/mem_latency/ratio_ceil
	    done

	    #Enable compute governor for gold latfloor
	    for latfloor in $device/*cpu-ddr-latfloor*/devfreq/*cpu-ddr-latfloor*
	    do
		echo "compute" > $latfloor/governor
		echo 8 > $latfloor/polling_interval
	    done

	    #Gold L3 ratio ceil
	    for l3gold in $device/*qcom,devfreq-l3/*cpu4-cpu-l3-lat/devfreq/*cpu4-cpu-l3-lat
	    do
		echo 4000 > $l3gold/mem_latency/ratio_ceil
	    done

	    #Prime L3 ratio ceil
	    for l3prime in $device/*qcom,devfreq-l3/*cpu7-cpu-l3-lat/devfreq/*cpu7-cpu-l3-lat
	    do
		echo 20000 > $l3prime/mem_latency/ratio_ceil
	    done

	    #Enable mem_latency governor for qoslat
	    for qoslat in $device/*qoslat/devfreq/*qoslat
	    do
		echo "mem_latency" > $qoslat/governor
		echo 10 > $qoslat/polling_interval
		echo 50 > $qoslat/mem_latency/ratio_ceil
	    done
	done
    echo N > /sys/module/lpm_levels/parameters/sleep_disabled
    configure_memory_parameters
    ;;
esac

case "$target" in
    "msm8998" | "apq8098_latv")

	echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
	echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
	echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
	echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
	echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
	echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

	# Setting b.L scheduler parameters
	echo 1 > /proc/sys/kernel/sched_migration_fixup
	echo 95 > /proc/sys/kernel/sched_upmigrate
	echo 90 > /proc/sys/kernel/sched_downmigrate
	echo 100 > /proc/sys/kernel/sched_group_upmigrate
	echo 95 > /proc/sys/kernel/sched_group_downmigrate
	echo 0 > /proc/sys/kernel/sched_select_prev_cpu_us
	echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
	echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
	echo 5 > /proc/sys/kernel/sched_spill_nr_run
	echo 1 > /proc/sys/kernel/sched_restrict_cluster_spill
        echo 1 > /proc/sys/kernel/sched_prefer_sync_wakee_to_waker
	start iop

        # disable thermal bcl hotplug to switch governor
        echo 0 > /sys/module/msm_thermal/core_control/enabled

        # online CPU0
        echo 1 > /sys/devices/system/cpu/cpu0/online
	# configure governor settings for little cluster
	echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
	echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
	echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
	echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
	echo 90 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
	echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
	echo 1248000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
	echo "83 1804800:95" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
	echo 19000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
	echo 79000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
	echo 518400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
	echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/ignore_hispeed_on_notif
        # online CPU4
        echo 1 > /sys/devices/system/cpu/cpu4/online
	# configure governor settings for big cluster
	echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
	echo 19000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
	echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
	echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
	echo 1574400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
	echo "83 1939200:90 2016000:95" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
	echo 19000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
	echo 79000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
	echo 806400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
	echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/ignore_hispeed_on_notif

        # re-enable thermal and BCL hotplug
        echo 1 > /sys/module/msm_thermal/core_control/enabled

        # Enable input boost configuration
        echo "0:1324800" > /sys/module/cpu_boost/parameters/input_boost_freq
        echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
        # Enable bus-dcvs
        for cpubw in /sys/class/devfreq/*qcom,cpubw*
        do
            echo "bw_hwmon" > $cpubw/governor
            echo 50 > $cpubw/polling_interval
            echo 1525 > $cpubw/min_freq
            echo "3143 5859 11863 13763" > $cpubw/bw_hwmon/mbps_zones
            echo 4 > $cpubw/bw_hwmon/sample_ms
            echo 34 > $cpubw/bw_hwmon/io_percent
            echo 20 > $cpubw/bw_hwmon/hist_memory
            echo 10 > $cpubw/bw_hwmon/hyst_length
            echo 0 > $cpubw/bw_hwmon/low_power_ceil_mbps
            echo 34 > $cpubw/bw_hwmon/low_power_io_percent
            echo 20 > $cpubw/bw_hwmon/low_power_delay
            echo 0 > $cpubw/bw_hwmon/guard_band_mbps
            echo 250 > $cpubw/bw_hwmon/up_scale
            echo 1600 > $cpubw/bw_hwmon/idle_mbps
        done

        for memlat in /sys/class/devfreq/*qcom,memlat-cpu*
        do
            echo "mem_latency" > $memlat/governor
            echo 10 > $memlat/polling_interval
            echo 400 > $memlat/mem_latency/ratio_ceil
        done
        echo "cpufreq" > /sys/class/devfreq/soc:qcom,mincpubw/governor
	if [ -f /sys/devices/soc0/soc_id ]; then
		soc_id=`cat /sys/devices/soc0/soc_id`
	else
		soc_id=`cat /sys/devices/system/soc/soc0/id`
	fi

	if [ -f /sys/devices/soc0/hw_platform ]; then
		hw_platform=`cat /sys/devices/soc0/hw_platform`
	else
		hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
	fi

	if [ -f /sys/devices/soc0/platform_version ]; then
		platform_version=`cat /sys/devices/soc0/platform_version`
		platform_major_version=$((10#${platform_version}>>16))
	fi

	if [ -f /sys/devices/soc0/platform_subtype_id ]; then
		platform_subtype_id=`cat /sys/devices/soc0/platform_subtype_id`
	fi

	case "$soc_id" in
		"292") #msm8998 apq8098_latv
		# Start Host based Touch processing
		case "$hw_platform" in
		"QRD")
			case "$platform_subtype_id" in
				"0")
					start_hbtp
					;;
				"16")
					if [ $platform_major_version -lt 6 ]; then
						start_hbtp
					fi
					;;
			esac

			;;
		esac
	    ;;
	esac

	echo N > /sys/module/lpm_levels/system/pwr/cpu0/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/pwr/cpu1/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/pwr/cpu2/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/pwr/cpu3/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/perf/cpu4/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/perf/cpu5/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/perf/cpu6/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/perf/cpu7/ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-dynret/idle_enabled
	echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-ret/idle_enabled
	echo N > /sys/module/lpm_levels/system/perf/perf-l2-dynret/idle_enabled
	echo N > /sys/module/lpm_levels/system/perf/perf-l2-ret/idle_enabled
	echo N > /sys/module/lpm_levels/parameters/sleep_disabled

        echo 0-3 > /dev/cpuset/background/cpus
        echo 0-3 > /dev/cpuset/system-background/cpus
        echo 0 > /proc/sys/kernel/sched_boost

        # Set Memory parameters
        configure_memory_parameters
    ;;
esac

case "$target" in
    "msm8909")

        if [ -f /sys/devices/soc0/soc_id ]; then
           soc_id=`cat /sys/devices/soc0/soc_id`
        else
           soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        # HMP scheduler settings for 8909 similiar to 8917
        echo 3 > /proc/sys/kernel/sched_window_stats_policy
        echo 3 > /proc/sys/kernel/sched_ravg_hist_size

        echo 1 > /proc/sys/kernel/sched_restrict_tasks_spread

        echo 20 > /proc/sys/kernel/sched_small_task
        echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
        echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
        echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
        echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load

        echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
        echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
        echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
        echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run

        echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
        echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
        echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
        echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle

        # Apply governor settings for 8909

        # disable thermal core_control to update scaling_min_freq
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        echo 1 > /sys/devices/system/cpu/cpu0/online
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 800000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        # enable thermal core_control now
        echo 1 > /sys/module/msm_thermal/core_control/enabled

        echo "29000 1094400:49000" > /sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay
        echo 90 > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
        echo 30000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
        echo 998400 > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
        echo 0 > /sys/devices/system/cpu/cpufreq/interactive/io_is_busy
        echo "1 800000:85 998400:90 1094400:80" > /sys/devices/system/cpu/cpufreq/interactive/target_loads
        echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
        echo 50000 > /sys/devices/system/cpu/cpufreq/interactive/sampling_down_factor

        # Bring up all cores online
        echo 1 > /sys/devices/system/cpu/cpu1/online
        echo 1 > /sys/devices/system/cpu/cpu2/online
        echo 1 > /sys/devices/system/cpu/cpu3/online
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

        for devfreq_gov in /sys/class/devfreq/*qcom,cpubw*/governor
        do
            echo "bw_hwmon" > $devfreq_gov
            for cpu_bimc_bw_step in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/bw_step
            do
                echo 60 > $cpu_bimc_bw_step
            done
            for cpu_guard_band_mbps in /sys/class/devfreq/*qcom,cpubw*/bw_hwmon/guard_band_mbps
            do
                echo 30 > $cpu_guard_band_mbps
            done
        done

        for gpu_bimc_io_percent in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/io_percent
        do
            echo 40 > $gpu_bimc_io_percent
        done
        for gpu_bimc_bw_step in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/bw_step
        do
            echo 60 > $gpu_bimc_bw_step
        done
        for gpu_bimc_guard_band_mbps in /sys/class/devfreq/*qcom,gpubw*/bw_hwmon/guard_band_mbps
        do
            echo 30 > $gpu_bimc_guard_band_mbps
        done

        # Set Memory parameters
        configure_memory_parameters
        restorecon -R /sys/devices/system/cpu
	;;
esac

case "$target" in
    "msm7627_ffa" | "msm7627_surf" | "msm7627_6x")
        echo 25000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        ;;
esac

case "$target" in
    "qsd8250_surf" | "qsd8250_ffa" | "qsd8650a_st1x")
        echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        ;;
esac

case "$target" in
    "qsd8650a_st1x")
        mount -t debugfs none /sys/kernel/debug
    ;;
esac

chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy

emmc_boot=`getprop vendor.boot.emmc`
case "$emmc_boot"
    in "true")
        chown -h system /sys/devices/platform/rs300000a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown -h system /sys/devices/platform/rs300100a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac

case "$target" in
    "msm8960" | "msm8660" | "msm7630_surf")
        echo 10 > /sys/devices/platform/msm_sdcc.3/idle_timeout
        ;;
    "msm7627a")
        echo 10 > /sys/devices/platform/msm_sdcc.1/idle_timeout
        ;;
esac

# Post-setup services
case "$target" in
    "msm8660" | "msm8960" | "msm8226" | "msm8610" | "mpq8092" )
        start mpdecision
    ;;
    "msm8974")
        start mpdecision
        echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
    ;;
    "msm8909" | "msm8916" | "msm8937" | "msm8952" | "msm8953" | "msm8994" | "msm8992" | "msm8996" | "msm8998" | "sdm660" | "apq8098_latv" | "sdm845" | "sdm710" | "qcs605" |"msmnile" | "sdmshrike" |"msmsteppe" | "sm6150" | "kona" | "lito" | "trinket" | "atoll" | "bengal" )
        setprop vendor.post_boot.parsed 1
    ;;
    "apq8084")
        rm /data/system/perfd/default_values
        start mpdecision
        echo 512 > /sys/block/mmcblk0/bdi/read_ahead_kb
        echo 512 > /sys/block/sda/bdi/read_ahead_kb
        echo 512 > /sys/block/sdb/bdi/read_ahead_kb
        echo 512 > /sys/block/sdc/bdi/read_ahead_kb
        echo 512 > /sys/block/sdd/bdi/read_ahead_kb
        echo 512 > /sys/block/sde/bdi/read_ahead_kb
        echo 512 > /sys/block/sdf/bdi/read_ahead_kb
        echo 512 > /sys/block/sdg/bdi/read_ahead_kb
        echo 512 > /sys/block/sdh/bdi/read_ahead_kb
    ;;
    "msm7627a")
        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi
        case "$soc_id" in
            "127" | "128" | "129")
                start mpdecision
        ;;
        esac
    ;;
esac

# Enable Power modes and set the CPU Freq Sampling rates
case "$target" in
     "msm7627a")
        start qosmgrd
    echo 1 > /sys/module/pm2/modes/cpu0/standalone_power_collapse/idle_enabled
    echo 1 > /sys/module/pm2/modes/cpu1/standalone_power_collapse/idle_enabled
    echo 1 > /sys/module/pm2/modes/cpu0/standalone_power_collapse/suspend_enabled
    echo 1 > /sys/module/pm2/modes/cpu1/standalone_power_collapse/suspend_enabled
    #SuspendPC:
    echo 1 > /sys/module/pm2/modes/cpu0/power_collapse/suspend_enabled
    #IdlePC:
    echo 1 > /sys/module/pm2/modes/cpu0/power_collapse/idle_enabled
    echo 25000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
    ;;
esac

# Change adj level and min_free_kbytes setting for lowmemory killer to kick in
case "$target" in
     "msm7627a")
    echo 0,1,2,4,9,12 > /sys/module/lowmemorykiller/parameters/adj
    echo 5120 > /proc/sys/vm/min_free_kbytes
     ;;
esac

# Install AdrenoTest.apk if not already installed
if [ -f /data/prebuilt/AdrenoTest.apk ]; then
    if [ ! -d /data/data/com.qualcomm.adrenotest ]; then
        pm install /data/prebuilt/AdrenoTest.apk
    fi
fi

# Install SWE_Browser.apk if not already installed
if [ -f /data/prebuilt/SWE_AndroidBrowser.apk ]; then
    if [ ! -d /data/data/com.android.swe.browser ]; then
        pm install /data/prebuilt/SWE_AndroidBrowser.apk
    fi
fi

# Change adj level and min_free_kbytes setting for lowmemory killer to kick in
case "$target" in
     "msm8660")
        start qosmgrd
        echo 0,1,2,4,9,12 > /sys/module/lowmemorykiller/parameters/adj
        echo 5120 > /proc/sys/vm/min_free_kbytes
     ;;
esac

# Let kernel know our image version/variant/crm_version
if [ -f /sys/devices/soc0/select_image ]; then
    image_version="10:"
    image_version+=`getprop ro.build.id`
    image_version+=":"
    image_version+=`getprop ro.build.version.incremental`
    image_variant=`getprop ro.product.name`
    image_variant+="-"
    image_variant+=`getprop ro.build.type`
    oem_version=`getprop ro.build.version.codename`
    echo 10 > /sys/devices/soc0/select_image
    echo $image_version > /sys/devices/soc0/image_version
    echo $image_variant > /sys/devices/soc0/image_variant
    echo $oem_version > /sys/devices/soc0/image_crm_version
fi

# Change console log level as per console config property
console_config=`getprop persist.vendor.console.silent.config`
case "$console_config" in
    "1")
        echo "Enable console config to $console_config"
        echo 0 > /proc/sys/kernel/printk
        ;;
    *)
        echo "Enable console config to $console_config"
        ;;
esac

# Parse misc partition path and set property
misc_link=$(ls -l /dev/block/bootdevice/by-name/misc)
real_path=${misc_link##*>}
setprop persist.vendor.mmi.misc_dev_path $real_path
