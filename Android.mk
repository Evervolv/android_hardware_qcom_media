ifeq ($(BOARD_USES_QCOM_HARDWARE),true)
	media-hals := audio
	include $(call all-named-subdir-makefiles,$(media-hals))
endif
