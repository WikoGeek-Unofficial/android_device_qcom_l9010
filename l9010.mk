DEVICE_PACKAGE_OVERLAYS := device/qcom/l9010/overlay

TARGET_USES_QCOM_BSP := true
ifeq ($(TARGET_PRODUCT),l9010)
TARGET_USES_QCA_NFC := other
endif

# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# media_profiles and media_codecs xmls for 8916
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/l9010/media/media_profiles_8916.xml:system/etc/media_profiles.xml \
                      device/qcom/l9010/media/media_codecs_8916.xml:system/etc/media_codecs.xml \
                      device/qcom/l9010/media/media_codecs_8939.xml:system/etc/media_codecs_8939.xml \
                      device/qcom/l9010/media/media_codecs_8929.xml:system/etc/media_codecs_8929.xml
endif

PRODUCT_PROPERTY_OVERRIDES += \
       dalvik.vm.heapgrowthlimit=128m \
       dalvik.vm.heapminfree=6m \
       dalvik.vm.heapstartsize=14m
$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := l9010
PRODUCT_DEVICE := l9010


#wiko version
CUSTOM_BUILD_VERNO := WIKO HIGHWAY PURE L Version 8

INTERNAL_BUILD_VERNO := L9010AE_PP_5.0_WIK_FR_12_17
CUSTOM_BUILD_DE_VERNO := WIKO HIGHWAY PURE L Version 17

ifeq ($(strip $(TARGET_USES_QTIC)),true)
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
    MULTI_LANG_ENGINE := REVERIE
endif
endif

PRODUCT_BOOT_JARS += \
           qcmediaplayer \
           WfdCommon \
           oem-services \
           qcom.fmradio \
           org.codeaurora.Performance \
           tcmiface
#Line<BAL-130&132><20150309><config nosdcard for L9010>xiongdajun
PRODUCT_CHARACTERISTICS := nosdcard
# Audio configuration file
PRODUCT_COPY_FILES += \
    device/qcom/l9010/audio_policy.conf:system/etc/audio_policy.conf \
    device/qcom/l9010/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/qcom/l9010/mixer_paths_mtp.xml:system/etc/mixer_paths_mtp.xml \
    device/qcom/l9010/mixer_paths_qrd_skuh.xml:system/etc/mixer_paths_qrd_skuh.xml \
    device/qcom/l9010/mixer_paths_qrd_skui.xml:system/etc/mixer_paths_qrd_skui.xml \
    device/qcom/l9010/mixer_paths_qrd_skuhf.xml:system/etc/mixer_paths_qrd_skuhf.xml \
    device/qcom/l9010/mixer_paths_wcd9306.xml:system/etc/mixer_paths_wcd9306.xml \
    device/qcom/l9010/mixer_paths_skuk.xml:system/etc/mixer_paths_skuk.xml \
    device/qcom/l9010/mixer_paths_skul.xml:system/etc/mixer_paths_skul.xml \
    device/qcom/l9010/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/qcom/l9010/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/qcom/l9010/sound_trigger_mixer_paths_wcd9306.xml:system/etc/sound_trigger_mixer_paths_wcd9306.xml \
    device/qcom/l9010/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/qcom/l9010/mixer_paths_wcd9330.xml:system/etc/mixer_paths_wcd9330.xml

# ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

# NFC packages
ifeq ($(TARGET_USES_QCA_NFC),true)
NFC_D := true

ifeq ($(NFC_D), true)
    PRODUCT_PACKAGES += \
        libnfcD-nci \
        libnfcD_nci_jni \
        nfc_nci.msm8916 \
        NfcDNci \
        Tag \
        com.android.nfc_extras \
        com.android.nfc.helper
else
    PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8916 \
    NfcNci \
    Tag \
    com.android.nfc_extras
endif

# file that declares the MIFARE NFC constant
# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
        packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
        frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml
endif # TARGET_USES_QCA_NFC

# Feature definition files for msm8916
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown

PRODUCT_PACKAGES += wcnss_service

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/qcom/l9010/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/l9010/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/l9010/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat \
    device/qcom/l9010/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf
#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

#HBTP
PRODUCT_PACKAGES += hbtp_daemon
PRODUCT_PACKAGES += libhbtpclient.so
PRODUCT_PACKAGES += libhbtpfrmwk.so
PRODUCT_PACKAGES += libhbtparm.so
PRODUCT_PACKAGES += libafehal_5_rohm_v3.so
PRODUCT_PACKAGES += hbtp_8939_5_rohm_v3.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5_rohm_v3.dat
PRODUCT_PACKAGES += libafehal_5_rohm_v4.so
PRODUCT_PACKAGES += hbtp_8939_5_rohm_v4.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5_rohm_v4.dat
PRODUCT_PACKAGES += libafehal_5p5_rohm_v4.so
PRODUCT_PACKAGES += hbtp_8939_5p5_rohm_v4.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5p5_rohm_v4.dat
PRODUCT_PACKAGES += libafehal_6_rohm_v3.so
PRODUCT_PACKAGES += hbtp_8939_6_rohm_v3.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_6_rohm_v3.dat

PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system

# Defined the locales
PRODUCT_LOCALES := en_US ru_RU fr_FR es_ES de_DE tr_TR pt_PT cs_CZ pl_PL fi_FI hu_HU in_ID sk_SK uk_UA ar_EG ur_PK fa_IR it_IT nl_NL da_DK nb_NO sv_SE th_TH vi_VN zh_CN 

# Add the overlay path
ifeq ($(strip $(TARGET_USES_QTIC)),true)
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)
endif


##################################### TINNO L9010 HLOS ##############################################
L9010_HLOS := true
$(call inherit-product, device/qcom/l9010/res/audio/Audio.mk)

TN_BOOTANIMATION_RES := true
ifeq ($(TN_BOOTANIMATION_RES), true)
$(call inherit-product, device/qcom/l9010/res/animation/animation.mk)
endif

#add TnNvOperate by huiyong.yin
PRODUCT_PACKAGES += TnNvOperate

# A mechanism for customer to enable their own sign key. liuzongbin add 2014.10.17
SIGNATURE_CUSTOMIZATION := true
SIGNATURE_CUSTOMIZATION_DIR := l9010

#add sts by liuzongbin
PRODUCT_PACKAGES += SaleTracker
PRODUCT_COPY_FILES += \
       vendor/tinno/packages/apps/SaleTracker/Tracksms:persist/sts/Tracksms \
       vendor/tinno/packages/apps/SaleTracker/SaleTrackerConfig.xml:system/etc/SaleTrackerConfig.xml \
       vendor/tinno/packages/apps/SaleTracker/libsltrckrcnfg.so:system/lib/libsltrckrcnfg.so

# GMS
$(call inherit-product-if-exists, vendor/google/gms/products/gms.mk)

# LINE <OTA> <DATA20150520> <TINNO OTA> limi.zhang
PRODUCT_PACKAGES += TNSystemUpdate
PRODUCT_COPY_FILES += \
       vendor/tinno/packages/apps/TinnoOTA/ota_settings_default.xml:system/etc/ota_settings.xml
 

#audio params <BEGIN><FFBAKK-105><2014.12.15>add for tfa9890-pa;yangliang
$(shell cp -af  device/qcom/l9010/audio/Bluetooth_cal.acdb vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/Bluetooth_cal.acdb)
$(shell cp -af  device/qcom/l9010/audio/General_cal.acdb vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/General_cal.acdb)
$(shell cp -af  device/qcom/l9010/audio/Global_cal.acdb vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/Global_cal.acdb)
$(shell cp -af  device/qcom/l9010/audio/Handset_cal.acdb vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/Handset_cal.acdb)
$(shell cp -af  device/qcom/l9010/audio/Hdmi_cal.acdb vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/Hdmi_cal.acdb)
$(shell cp -af  device/qcom/l9010/audio/Headset_cal.acdb vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/Headset_cal.acdb)
$(shell cp -af  device/qcom/l9010/audio/Speaker_cal.acdb vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/Speaker_cal.acdb)
$(shell cp -af  device/qcom/l9010/audio/workspaceFile.qwsp vendor/qcom/proprietary/mm-audio/audcal/family-b/acdbdata/8916/QRD/workspaceFile.qwsp)

#<BEGIN><FFBAKK-105><2014.12.15>add for tfa9890-pa;yangliang
ifeq ($(NXP_SMARTPA_SUPPORT),tfa9890)
PRODUCT_PACKAGES += \
        libtfahal \
        libtfa98xx \
        libtfasrv \
        libtfa9890 \
        climax
endif

#<BEGIN><FFBAKK-105><2014.12.15>add for tfa9890-pa;yangliang
PRODUCT_COPY_FILES += \
	vendor/tinno/tfa9890/settings/90_Sambo.parms:system/etc/settings/90_Sambo.parms \
	vendor/tinno/tfa9890/settings/coldboot.patch:system/etc/settings/coldboot.patch \
	vendor/tinno/tfa9890/settings/HQ90_13x18_Sambo_V2R2.eq:system/etc/settings/HQ90_13x18_Sambo_V2R2.eq \
	vendor/tinno/tfa9890/settings/HQ90_13x18_Sambo_V2R2.preset:system/etc/settings/HQ90_13x18_Sambo_V2R2.preset \
	vendor/tinno/tfa9890/settings/KS_13x18_Sambo_V2R2.speaker:system/etc/settings/KS_13x18_Sambo_V2R2.speaker \
	vendor/tinno/tfa9890/settings/readme.txt:system/etc/settings/readme.txt \
	vendor/tinno/tfa9890/settings/Speech90_13x18_Sambo_V2R2.eq:system/etc/settings/Speech90_13x18_Sambo_V2R2.eq \
	vendor/tinno/tfa9890/settings/Speech90_13x18_Sambo_V2R2.preset:system/etc/settings/Speech90_13x18_Sambo_V2R2.preset \
	vendor/tinno/tfa9890/settings/TFA9890_N1B12_N1C3_v2.config:system/etc/settings/TFA9890_N1B12_N1C3_v2.config \
	vendor/tinno/tfa9890/settings/TFA9890_N1C3_1_7_1.patch:system/etc/settings/TFA9890_N1C3_1_7_1.patch


#cp custom files
#$(shell cp -af  device/qcom/l9010/custom_files/bdroid_buildcfg.h  device/qcom/common/bdroid_buildcfg.h )
#$(shell cp -af  device/qcom/l9010/custom_files/buildinfo.sh   build/tools/buildinfo.sh   )
$(shell cp -af  device/qcom/l9010/custom_files/external/sepolicy/keys.conf  external/sepolicy/keys.conf)

#bt
$(call inherit-product, device/qcom/l9010/bt.mk)


# zenghaihui enable SSR
#ifneq ($(filter user, $(TARGET_BUILD_VARIANT)),)
ifeq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.ssr.restart_level=1
else
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.ssr.restart_level=0
endif


# MYOS Feature. SuMu20150611
MYOS_FILEMANAGER := apk


#add by tcp.smartstandby
PRODUCT_COPY_FILES += \
	device/qcom/l9010/st-settings-config.xml:system/etc/st-settings-config.xml
#add by tcp.smartstandby

##################################### WIKO L9010 HLOS ##############################################
L9010_WIKO_HLOS := true

#$(call inherit-product, vendor/tinno/wiko/wiko.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-wiko



