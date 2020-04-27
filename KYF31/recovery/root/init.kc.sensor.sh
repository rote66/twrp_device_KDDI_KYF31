#!/system/bin/sh

PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

for file in /sys/class/input/input*; do
	name=`cat ${file}/name`
	case "${name}" in
		"alps_compass")
			chown system:system ${file}/acc_enable
			chown system:system ${file}/acc_data
			chown system:system ${file}/get_hw_data
			chown system:system ${file}/mag_enable
			chown system:system ${file}/mag_data
			chown system:system ${file}/self_test_A
			chown system:system ${file}/self_test_B
			chown system:system ${file}/sw_correction_data
			chown system:system ${file}/delay
			chown system:system ${file}/imit_data
			;;
		"light sensor")
			chown system:system ${file}/als_enable
			chown system:system ${file}/als_poll_delay
			;;
		"proximity sensor")
			chown system:system ${file}/ps_enable
			chown system:system ${file}/ps_detection
			;;
	esac
done
