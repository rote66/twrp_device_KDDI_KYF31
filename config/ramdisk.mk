#Kernel
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilt/kernel:kernel 

#Extra
PRODUCT_COPY_FILES += $(call find-copy-subdir-files,*,device/KDDI/KYF31/recovery/root,root)
