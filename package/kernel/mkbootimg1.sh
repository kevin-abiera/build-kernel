#!/sbin/sh
mkdir /tmp/rdnew
cd /tmp/rdnew
gunzip -c < /tmp/boot.img-ramdisk.gz | /tmp/cpio -i
cp -r /tmp/res /tmp/rdnew/
find . | /tmp/cpio -co | gzip -c > /tmp/boot.img-rdnew.gz
echo \#!/sbin/sh > /tmp/createnewboot.sh
echo /tmp/mkbootimg --kernel /tmp/boot.img-zImage --ramdisk /tmp/boot.img-rdnew.gz --cmdline \"$(cat /tmp/boot.img-cmdline)\" --base $(cat /tmp/boot.img-base) --output /tmp/newboot.img >> /tmp/createnewboot.sh
chmod 777 /tmp/createnewboot.sh
/tmp/createnewboot.sh
return $?
