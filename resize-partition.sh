#
#   gparted-pkexec
#

#
#    Resize (grow) 3rd partition.
#

#
# first the 4th parition needs to shrink
#

#  1. Check filesystem for errors. If possible, fix them
sudo e2fsck -f -y -v -C 0 /dev/${device}4 

#  2. Shrink filesystem
sudo resize2fs -p /dev/${device}4  4M

#  3. Shrink partition
#     Last parameter (25M): new end of partition. This
#     parameter needs to be smaller than old end.
#
#  !!!!! Why does this command insist on asking me if I am sure !!!!!
#
# $exec_parted  resizepart  4  25M
#
# Ah, it's a bug:
#   https://unix.stackexchange.com/a/202872/6479

sudo $parted_executable /dev/${device} unit B resizepart 4 $((25*1024*1024)) Yes


#  4. Check filesystem for errors again.
sudo e2fsck -f -y -v -C 0 /dev/${device}4 

#  5. Move filesystem to the right
#
#     -r : create raw image file (instead of normal one).
#     -a : include all data
#     -O : offset when writing data
#     -p : show progress

sudo e2image -ra -p -O $((5000*1024*1024)) /dev/${device}4 img
