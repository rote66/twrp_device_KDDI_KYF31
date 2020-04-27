# Release name
PRODUCT_RELEASE_NAME := KYF31

LOCAL_PATH := device/KDDI/KYF31

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

#$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
 
include $(call all-subdir-makefiles)

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
