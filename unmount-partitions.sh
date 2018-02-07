unmount() { # Note unmount, not umount
  local dev_nr=$1
  sudo umount /dev/${device}${dev_nr}
}

unmount 2
unmount 3
unmount 4
unmount 5
unmount 6
