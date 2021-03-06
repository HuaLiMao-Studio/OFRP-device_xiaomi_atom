#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2022 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="atom"
fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ -f "$(gettop)/bootable/recovery/orangefox.cpp" ]; then
    echo -e "\x1b[96matom: 开始添加OrangeFox Vars...\x1b[m"

    # 设置显示在关于页面里的维护人员名称
    export OF_MAINTAINER=HuaLiMao-AQ
    # 设置版本号为日期
    export FOX_VERSION=$(date +%y.%m.%d)

    ## 添加功能
    # 使用完整版ps命令
    export FOX_REPLACE_BUSYBOX_PS=1
    # 使用完整版getprop命令
    export FOX_REPLACE_TOOLBOX_GETPROP=1
    # 支持tar命令
    export FOX_USE_TAR_BINARY=1
    # 支持sed命令
    export FOX_USE_SED_BINARY=1
    # 使用bash代替sh和ash
    export FOX_USE_BASH_SHELL=1
    export FOX_ASH_IS_BASH=1
    # 使用完整版grep命令
    export FOX_USE_GREP_BINARY=1
    # 支持lzma, xz命令
    export FOX_USE_XZ_UTILS=1
    # 使用橙狐编译的NANO编辑器
    export FOX_USE_NANO_EDITOR=1

	export OF_USE_GREEN_LED=0
    export FOX_ENABLE_APP_MANAGER=0
   	export TW_DEFAULT_LANGUAGE="en"
	export LC_ALL="C"
 	export ALLOW_MISSING_DEPENDENCIES=true
	export TARGET_DEVICE_ALT="bhima"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export OF_NO_MIUI_PATCH_WARNING=1
	export FOX_USE_BASH_SHELL=1
	export FOX_ASH_IS_BASH=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export OF_ENABLE_LPTOOLS=1
    export OF_QUICK_BACKUP_LIST="/boot;/data;"
	export OF_PATCH_AVB20=1
    export FOX_DELETE_AROMAFM=1

	# use magisk 24.3 for the magisk addon
	export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk.zip

    # OTA
    export OF_KEEP_DM_VERITY=1
    export OF_SUPPORT_ALL_BLOCK_OTA_UPDATES=1
    export OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR=1
    export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1

	# screen settings
	export OF_SCREEN_H=2400
	export OF_STATUS_H=100
	export OF_STATUS_INDENT_LEFT=48
	export OF_STATUS_INDENT_RIGHT=48
  	export OF_HIDE_NOTCH=1
	export OF_CLOCK_POS=1

	# maximum permissible splash image size (in kilobytes); do *NOT* increase!
	export OF_SPLASH_MAX_SIZE=130

    # addition
    export OF_FLASHLIGHT_ENABLE=0

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
	echo -e "\x1b[96matom: 当你看到这个消息的时候，所有的OrangeFox Var已经添加完毕！\x1b[m"
fi