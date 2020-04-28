LOCAL_PATH := device/KDDI/KYF31

## Specify phone tech before including full_phone

#$(call inherit-product, $(SRC_TARGET_DIR)/product/core.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Inherit some common CM stuff.
#$(call inherit-product, vendor/cm/config/common_full_phone.mk)
#$(call inherit-product, vendor/omni/config/gsm.mk)
$(call inherit-product, vendor/omni/config/common.mk)
#$(call inherit-product, build/target/product/embedded.mk)

#$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
 
include $(call all-subdir-makefiles)

# Charger
PRODUCT_PACKAGES += charger charger_res_images

# Encryption
#PRODUCT_PACKAGES += libcryptfs_hw

# Time Zone data for recovery
#PRODUCT_COPY_FILES += \
    bionic/libc/zoneinfo/tzdata:recovery/root/system/usr/share/zoneinfo/tzdata
    
# Release name
PRODUCT_RELEASE_NAME := KYF31

TARGET_SCREEN_HEIGHT := 854
TARGET_SCREEN_WIDTH := 480

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := KYF31
PRODUCT_NAME := omni_KYF31
PRODUCT_BRAND := KDDI
PRODUCT_MODEL := KYF31
PRODUCT_MANUFACTURER := KYOCERA

# enable stock zip packages flash
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.build.product=KYF31 \
    ro.product.device=KYF31
