# encctl - the enclosure management tool for ZFS on Linux

## Tested Hardware

* HBA
  * SAS2
    * LSI SAS 9207-8e (LSI SAS 2308)
  * SAS3
    * Supermicro AOC-S3008L-L8e (LSI SAS 3008)
* Chassis
  * SAS2
    * CSE-837E16-RJBOD1
      * BPN-SAS2-837EL1 (LSI SAS2X36)
      * BPN-SAS-837A
  * SAS3
    * CSE-847BE2C-R1K28LPB
      * BPN-SAS3-846EL2 (LSI SAS3x40)
      * BPN-SAS3-826EL2 (LSI SAS3x28)

## Tested OS

* CentOS 7.1
* CentOS 6.6

## Install

+ install ZFS on Linux

See http://zfsonlinux.org/epel.html

+ setup multipath as needed

  # mpathconf --enable --with_multipathd y

+ install encctl

  # make install

+ reload udev rules

  # make reload

+ check vdev alias

  # ls -l /dev/disk/by-vdev

+ create zpool

++ mirror pool

  # echo zpool create tank `echo 0xXXXXXXXXXXXXXXXX:{0..11} | xargs -n 2 echo mirror`
  # echo zpool create tank `echo 0xXXXXXXXXXXXXXXXX:{0..11} | xargs -n 2 echo mirror` | sh -x

++ raidz2 pool

  # echo zpool create tank `echo 0xXXXXXXXXXXXXXXXX:{0..11} 0xYYYYYYYYYYYYYYYY:{0..11} | xargs -n 6 echo raidz2`
  # echo zpool create tank `echo 0xXXXXXXXXXXXXXXXX:{0..11} 0xYYYYYYYYYYYYYYYY:{0..11} | xargs -n 6 echo raidz2` | sh -x

## Usage

+ check enclosure status

  # encctl --show

+ check disk SMART

++ for SATA devices

  # encctl --smart
  # encctl --smarterror 30 (check last 30 days error)

++ for SAS devices

  # encctl --unc

+ locate indicator

  # encctl --locate 0xXXXXXXXXXXXXXXXX:0     # locate 0xXXXXXXXXXXXXXXXX:0
  # encctl --locate 0xXXXXXXXXXXXXXXXX       # locate 0xXXXXXXXXXXXXXXXX:*
  # encctl --locate all                      # locate *:*
  # encctl --locate_off 0xXXXXXXXXXXXXXXXX:0 # unlocate 0xXXXXXXXXXXXXXXXX:0
  # encctl --locate_off 0xXXXXXXXXXXXXXXXX   # unlocate 0xXXXXXXXXXXXXXXXX:*
  # encctl --locate_off all                  # unlocate *:*
