parted_executable=/sbin/parted

if [[ ! -x $parted_executable ]]; then
   echo "$parted_executable not executable, exiting"
   exit
fi

#
#    How parted is to be executed.
#    The -s flag is for non-interactive (scripted) mode. So
#    no questions will be asked from parted.
#
exec_parted="sudo $parted_executable -s /dev/$device"


#
#    Specify the device on which we're going to run the examples.
#
device=sdb

#
#    The directory into which the partitions/devices will be
#    mounted.
#
mount_dir=./mountpoints/
