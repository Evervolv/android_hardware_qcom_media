ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH := $(call my-dir)

# ---------------------------------------------------------------------------------
#             Make the Shared library audio_policy.msm7x30
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)

LOCAL_SRC_FILES := AudioPolicyManager.cpp
LOCAL_SHARED_LIBRARIES := libcutils
LOCAL_SHARED_LIBRARIES += libutils
LOCAL_SHARED_LIBRARIES += libmedia
LOCAL_MODULE := audio_policy.msm7x30
LOCAL_MODULE_TAGS := optional
#LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_STATIC_LIBRARIES := libaudiopolicy_legacy
LOCAL_WHOLE_STATIC_LIBRARIES += libmedia_helper

ifeq ($(BOARD_HAVE_BLUETOOTH),true)
  LOCAL_CFLAGS += -DWITH_A2DP
endif

ifeq ($(BOARD_USES_QCOM_LPA),true)
  LOCAL_CFLAGS += -DWITH_QCOM_LPA
endif

include $(BUILD_SHARED_LIBRARY)

# ---------------------------------------------------------------------------------
#             Make the Shared library audio.primary.msm7x30
# ---------------------------------------------------------------------------------

include $(CLEAR_VARS)

LOCAL_MODULE := audio.primary.msm7x30
LOCAL_MODULE_TAGS := optional

LOCAL_SHARED_LIBRARIES := \
    libcutils \
    libutils \
    libaudioalsa \
    libmedia \
    libhardware_legacy \
    libbinder \
    libdl

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_STATIC_LIBRARIES += libmedia_helper
LOCAL_WHOLE_STATIC_LIBRARIES := libaudiohw_legacy

ifeq ($(BOARD_USE_QCOM_SPEECH),true)
  LOCAL_CFLAGS += -DWITH_QCOM_SPEECH
endif

ifeq ($(BOARD_USES_QCOM_LPA),true)
  LOCAL_CFLAGS += -DWITH_QCOM_LPA
endif

ifeq ($(BOARD_USES_QCOM_VOIPMUTE),true)
  LOCAL_CFLAGS += -DWITH_QCOM_VOIPMUTE
endif

ifeq ($(BOARD_USES_QCOM_RESETALL),true)
  LOCAL_CFLAGS += -DWITH_QCOM_RESETALL
endif

ifeq ($(TARGET_BOOTLOADER_BOARD_NAME),spade)
  LOCAL_CFLAGS += -DWITH_SPADE_DSP_PROFILE
endif

ifeq ($TARGET_OS)-$(TARGET_SIMULATOR),linux-true)
LOCAL_LDLIBS += -ldl
endif
ifneq ($(TARGET_SIMULATOR),true)
LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_C_INCLUDES += $(TARGET_OUT_HEADERS)/mm-audio/audio-alsa
LOCAL_SRC_FILES += AudioHardware.cpp
LOCAL_CFLAGS += -fno-short-enums

include $(BUILD_SHARED_LIBRARY)

endif # not BUILD_TINY_ANDROID
