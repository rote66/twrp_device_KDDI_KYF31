#!/bin/bash
cd ../../../..
#cd system/core
#git apply --ignore-space-change --ignore-whitespace -v ../../device/KDDI/KYF31/patches/system_core/0001-fix.patch
#cd ../..
#cd external/sepolicy
#git apply --ignore-space-change --ignore-whitespace -v ../../device/KDDI/KYF31/patches/external_sepolicy/0001-fix-for-gcc8-9.patch
#cd ../..
cd external/sepolicy
patch -p1 < ../../device/KDDI/KYF31/patches/external_sepolicy/0001-remove-ioctl-for-V29.patch
cd ../..
echo Patches Applied Successfully!
