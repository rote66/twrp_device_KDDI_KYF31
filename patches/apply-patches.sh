#!/bin/bash
cd ../../../..
cd external/sepolicy
git apply --ignore-space-change --ignore-whitespace -v ../../device/KDDI/KYF31/patches/external_sepolicy/fix.patch
cd ../..
echo Patches Applied Successfully!
