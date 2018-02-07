
. variables.sh

. remove-partitions.sh

. create-partition-table.sh

. create-partitions.sh

. print-partition-table.sh

. format-and-mount-partitions.sh


#
#  Show device files
#
# ls -l /dev/$device*
# ls -l /sys/block/$dev/*/


. create-some-files.sh

. unmount-partitions.sh

. resize-partition.sh

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
