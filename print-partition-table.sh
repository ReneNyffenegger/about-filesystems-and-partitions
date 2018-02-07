#
#    Print actual partition table
#

print_partition_table() {
    local unit=$1

  #
  # Print the partition table.
  # The sed construct skips until the first
  # empty line (the header of parted).
  #
    $exec_parted  unit $unit  print | sed -n '/^$/,$p'
}

print_partition_table s    # s    = sectors
print_partition_table b    # b    = bytes
print_partition_table kb   # kb   = kilobytes = 1000 bytes
print_partition_table kib  # kib  = kibibytes = 1024 bytes
print_partition_table mb   # mb   = megabytes = 1000 kilobytes
print_partition_table mib  # mib  = mebibytes = 1020 kibibytes
print_partition_table gb
print_partition_table gib
