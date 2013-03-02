ifneq ($(filter msm8960,$(TARGET_BOARD_PLATFORM)),)
LOCAL_PATH:= $(call my-dir)
include $(call all-subdir-makefiles)
endif
