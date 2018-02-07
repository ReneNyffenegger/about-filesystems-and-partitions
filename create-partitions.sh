#
#   Create a few partitions
#
#      use --align cylinder to prevent
#         »Warning: The resulting partition is not properly aligned for best performance.«
#
#      Note:
#        - apparently, multiple primary partitions are possible.
#

part_1_start=$((        17 * 1024    ))
part_2_start=$((       512 * 1024    )) 
part_3_start=$(( 10 * 1024 * 1024    ))
part_4_start=$(( 20 * 1024 * 1024    ))
part_5_start=$(( 30 * 1024 * 1024    ))
part_6_start=$(( 40 * 1024 * 1024    ))
part_7_start=$(( 50 * 1024 * 1024    ))
part_7_end=$((   60 * 1024 * 1024 - 1))

# echo part_1_start=$part_1_start
# echo part_2_start=$part_2_start
# echo part_3_start=$part_3_start

$exec_parted  mkpart  --align cylinder  primary    fat32       ${part_1_start}b $(( $part_2_start - 1 ))b
$exec_parted  mkpart  --align cylinder  primary    ext4        ${part_2_start}b $(( $part_3_start - 1 ))b
$exec_parted  mkpart  --align cylinder  primary    ext4        ${part_3_start}b $(( $part_4_start - 1 ))b
$exec_parted  mkpart  --align cylinder  secondary  ext4        ${part_4_start}b $(( $part_5_start - 1 ))b
$exec_parted  mkpart  --align cylinder  secondary  ext4        ${part_5_start}b $(( $part_6_start - 1 ))b
$exec_parted  mkpart  --align cylinder  secondary  ext4        ${part_6_start}b $(( $part_7_start - 1 ))b
$exec_parted  mkpart  --align cylinder  secondary  linux-swap  ${part_7_start}b $(( $part_7_end       ))b
