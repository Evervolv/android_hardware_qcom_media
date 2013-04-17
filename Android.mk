ifeq ($(call is-vendor-board-platform,QCOM),true)
ifneq ($(TARGET_QCOM_DISPLAY_VARIANT),legacy)

include $(call all-subdir-makefiles)

endif
endif
