#!/system/bin/sh
MODDIR=${0%/*}

ui_print() { echo "$1"; }

log_msg() {
  msg="[locational_oneplus13] $1"
  echo "$msg" > /dev/kmsg
  log -t locational_oneplus13 "$1"
}

mount_bind_files() {
  src_dir="$1"
  dst_dir="$2"
  if [ -d "$src_dir" ] && [ -d "$dst_dir" ]; then
    log_msg "mounting matching files in $src_dir -> $dst_dir"
    for src in $(find "$src_dir" -type f 2>/dev/null); do
      rel="${src#$src_dir/}"
      dst="$dst_dir/$rel"
      if [ -f "$dst" ]; then
        if mountpoint -q "$dst"; then
          umount "$dst"
        fi
        if mount -o bind "$src" "$dst"; then
          log_msg "mounted $dst"
        else
          log_msg "failed to mount $dst"
        fi
      else
        log_msg "skip $dst (not exists)"
      fi
    done
  else
    log_msg "skip $src_dir -> $dst_dir (missing path)"
  fi
}

mount_bind_files "$MODDIR/my_carrier" /my_carrier
mount_bind_files "$MODDIR/my_product" /my_product
mount_bind_files "$MODDIR/my_region" /my_region
mount_bind_files "$MODDIR/my_stock" /my_stock
