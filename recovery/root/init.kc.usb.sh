#!/system/bin/sh
# Copyright (c) 2012, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#
#
# This software is contributed or developed by KYOCERA Corporation.
# (C) 2015 KYOCERA Corporation
#
chown root.system /sys/devices/platform/msm_hsusb/gadget/wakeup
chmod 220 /sys/devices/platform/msm_hsusb/gadget/wakeup

#
# Allow persistent usb charging disabling
# User needs to set usb charging disabled in persist.usb.chgdisabled
#
target=`getprop ro.board.platform`
usbchgdisabled=`getprop persist.usb.chgdisabled`
case "$usbchgdisabled" in
    "") ;; #Do nothing here
    * )
    case $target in
        "msm8660")
        echo "$usbchgdisabled" > /sys/module/pmic8058_charger/parameters/disabled
        echo "$usbchgdisabled" > /sys/module/smb137b/parameters/disabled
	;;
        "msm8960")
        echo "$usbchgdisabled" > /sys/module/pm8921_charger/parameters/disabled
	;;
    esac
esac

usbcurrentlimit=`getprop persist.usb.currentlimit`
case "$usbcurrentlimit" in
    "") ;; #Do nothing here
    * )
    case $target in
        "msm8960")
        echo "$usbcurrentlimit" > /sys/module/pm8921_charger/parameters/usb_max_current
	;;
    esac
esac
#
# Allow USB enumeration with default PID/VID
#
baseband=`getprop ro.baseband`
echo 1  > /sys/class/android_usb/f_mass_storage/lun/nofua

#
# Add support for exposing lun0 as cdrom in mass-storage
#
target=`getprop ro.product.device`
cdromname="/system/etc/cdrom_install.iso"
cdromenable=`getprop persist.service.cdrom.enable`
case "$target" in
        "msm7627a")
                case "$cdromenable" in
                        0)
                                echo "" > /sys/class/android_usb/android0/f_mass_storage/lun0/file
                                ;;
                        1)
                                echo "mounting usbcdrom lun"
                                echo $cdromname > /sys/class/android_usb/android0/f_mass_storage/lun0/file
                                ;;
                esac
                ;;
esac

#
# Select USB BAM - 2.0 or 3.0
#
case "$target" in
    "msm8974")
        echo ssusb > /sys/bus/platform/devices/usb_bam/enable
    ;;
esac

# soc_ids for 8916/8939 differentiation
if [ -f /sys/devices/soc0/soc_id ]; then
	soc_id=`cat /sys/devices/soc0/soc_id`
else
	soc_id=`cat /sys/devices/system/soc/soc0/id`
fi

# enable rps cpus on msm8939/msm8909 target
setprop sys.usb.rps_mask 0
case "$soc_id" in
	"239" | "241" | "263")
		setprop sys.usb.rps_mask 10
	;;
	"245" | "260" | "261" | "262")
		setprop sys.usb.rps_mask 2
	;;
esac

log_save_enabled=`getprop ro.kcmount`
case "$log_save_enabled" in
	"1")
		if [ ! -e /data/usb ]; then
			mkdir /data/usb
			touch /data/usb/logcat.log
			touch /data/usb/kmsg.log
			chmod 0755 /data/usb
			chmod 0755 /data/usb/logcat.log
			chmod 0755 /data/usb/kmsg.log
			logcat -v threadtime > /data/usb/logcat.log&
			cat /proc/kmsg > /data/usb/kmsg.log&
		fi
	;;
esac
