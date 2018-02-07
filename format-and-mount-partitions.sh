rm -rf $mount_dir
 
# for device_to_mount in $(ls -1 /dev/${dev}?*); do
#   device_short=${device_to_mount:5}
#   mount_point=${mount_dir}$device_short
#   echo "mounting $device_to_mount to $mount_point"
#   mkdir -p $mount_point
#   sudo mount $device_to_mount $mount_point
# done
# ----------------------------------

format_and_mount() {
    local dev_nr=$1
    mkdir -p ${mount_dir}${device}${dev_nr}


  # Wipe partition 

    local logical_block_size=$(cat /sys/block/$device/queue/logical_block_size)
    local size=$(cat /sys/block/$device/${device}${dev_nr}/size)                   # size in block size?

  # use dd to overwrite partition.
  # status=none only writes error messages.
    sudo dd if=/dev/zero of=/dev/${device}${dev_nr} bs=$logical_block_size count=$size status=none

    echo "formatting /dev/${device}$dev_nr"

    sudo mkfs.ext4 /dev/${device}$dev_nr  -q  # -q: quiet mode
    sudo mount /dev/${device}$dev_nr ${mount_dir}${device}${dev_nr} # -o uid=$(id -u),gid=$(id -g)
    sudo chown -R $(id -u):$(id -g)  ${mount_dir}${device}${dev_nr} 
}

# don't create 1
format_and_mount 2
format_and_mount 3
format_and_mount 4
format_and_mount 5
format_and_mount 6
# don't create 7
