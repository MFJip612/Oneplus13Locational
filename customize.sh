#!/system/bin/sh
MODDIR=${0%/*}

ui_print() { echo "$1"; }

set_perm_recursive $MODPATH 0 0 0755 0644

ui_print "正在清理 /data/system/package_cache/ ..."
rm -rf /data/system/package_cache/* 2>/dev/null
ui_print "完成！"

ui_print "若重启后应用频繁停止服务，请给予Root权限。"