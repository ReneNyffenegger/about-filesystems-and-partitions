
parted_executable=/sbin/parted

if [[ ! -x $parted_executable ]]; then
   echo "$parted_executable not executable, exiting"
   exit
fi

device=sdb

#
#    How parted is to be executed.
#    The -s flag is for non-interactive (scripted) mode. So
#    no questions will be asked from parted.
#
exec_parted="sudo $parted_executable -s /dev/$device"


#
#    Remove each partition
#
for part_nr in $($exec_parted  print | awk '/^ / {print $1}'); do
   echo "removing $part_nr on $device" 
   $exec_parted  rm  ${part_nr}
done

#
#   Create a GPT partition.
#     ( Other possible values would be:
#       aix, amiga, bsd, dvh, loop, mac, msdos, pc98, sun )
#
$exec_parted  mklabel gpt

#
#   Create a few partitions
#
#      use --align cylinder to prevent
#         »Warning: The resulting partition is not properly aligned for best performance.«
#
#      Note:
#        - apparently, multiple primary partitions are possible.
#

$exec_parted  mkpart  --align cylinder  primary    fat32            0M      32M
$exec_parted  mkpart  --align cylinder  primary    ext4            32M     100M
$exec_parted  mkpart  --align cylinder  primary    ext4           100M     200M
$exec_parted  mkpart  --align cylinder  secondary  ext4           200M     300M
$exec_parted  mkpart  --align cylinder  secondary  ext4           300M     400M
$exec_parted  mkpart  --align cylinder  secondary  ext4           400M     500M
$exec_parted  mkpart  --align cylinder  secondary  linux-swap     500M     505M

#
#    Print actual partition table
#
$exec_parted  print

#
#  Show device files
#
# ls -l /dev/$device*
# ls -l /sys/block/$dev/*/


#
#    Mount devices
#
# mount_dir=$(pwd)/mountpoints/
# ----------------------------------
mount_dir=./mountpoints/
rm -rf $mount_dir
# 
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

#   echo logical_block_size=$logical_block_size;
#   echo size=$size;

  # use dd to overwrite partition.
  # status=none only writes error messages.
    sudo dd if=/dev/zero of=/dev/${device}${dev_nr} bs=$logical_block_size count=$size status=none

    echo "formatting /dev/${device}$dev_nr"

    sudo mkfs.ext4 /dev/${device}$dev_nr  -q  # -q: quiet mode
    sudo mount /dev/${device}$dev_nr ${mount_dir}${device}${dev_nr}
}

# don't create 1
format_and_mount 2
format_and_mount 3
format_and_mount 4
format_and_mount 5
format_and_mount 6
# don't create 7

unmount() { # Note unmount, not umount
  local dev_nr=$1
  sudo umount /dev/${device}${dev_nr}
}

unmount 2
unmount 3
unmount 4
unmount 5
unmount 6

#
#    TODO
#
# optimal_io_size=$(cat /sys/block/$device/queue/optimal_io_size)
# minimum_io_size=$(cat /sys/block/$device/queue/minimum_io_size)
# 
# echo "
#   optimal_io_size: $optimal_io_size
#   minimum_io_size: $minimum_io_size
# "
