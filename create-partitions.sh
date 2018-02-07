#
#   Create a few partitions
#
#      use --align cylinder to prevent
#         »Warning: The resulting partition is not properly aligned for best performance.«
#
#      Note:
#        - apparently, multiple primary partitions are possible.
#

$exec_parted  mkpart  --align cylinder  primary    fat32           0M    2M
$exec_parted  mkpart  --align cylinder  primary    ext4            2M   10M
$exec_parted  mkpart  --align cylinder  primary    ext4           10M   20M
$exec_parted  mkpart  --align cylinder  secondary  ext4           20M   30M
$exec_parted  mkpart  --align cylinder  secondary  ext4           30M   40M
$exec_parted  mkpart  --align cylinder  secondary  ext4           40M   50M
$exec_parted  mkpart  --align cylinder  secondary  linux-swap     50M   55M

