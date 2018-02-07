#
#    Remove each partition
#
for part_nr in $($exec_parted  print | awk '/^ / {print $1}'); do
   echo "removing $part_nr on $device" 
   $exec_parted  rm  ${part_nr}
done
