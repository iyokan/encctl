# encctl - the enclosure management tool for ZFS on Linux

## Tested Hardware

* HBA
  * SAS2
    * LSI SAS 9207-8e (LSI SAS 2308)
  * SAS3
    * Supermicro AOC-S3008L-L8e (LSI SAS 3008)
    * AOC-SAS3-9300-8e (SAS3008)
* Chassis
  * SAS2
    * CSE-837E16-RJBOD1
      * BPN-SAS2-837EL1 (LSI SAS2X36)
      * BPN-SAS-837A
  * SAS3
    * CSE-847BE2C-R1K28LPB
      * BPN-SAS3-846EL2 (LSI SAS3x40)
      * BPN-SAS3-826EL2 (LSI SAS3x28)
    * CSE-847E1C-R1K28JBOD
      * BPN-SAS3-846EL1
      * BPN-SAS3-847EL1

## Tested OS

* CentOS 7.2 https://bugzilla.redhat.com/show_bug.cgi?id=1394089
* CentOS 6.6

## Install

* install ZFS on Linux

See http://zfsonlinux.org/epel.html

* setup multipath as needed

```
# mpathconf --enable --with_multipathd y
```

* install encctl

```
# make install
```

* reload udev rules

```
# make reload
```

* check vdev alias

```
# ls -l /dev/disk/by-vdev
```

* create zpool

  * mirror pool

```
# encctl --show | cut -f1 | xargs -n2 echo mirror
# zpool create tank `!!`
```

  * raidz2 pool

```
# encctl --show | cut -f1 | xargs -n11 echo raidz2
# zpool create tank `!!`
```

## Usage

* check enclosure status

```
# encctl --show
```

* check SMART Attribute (SATA)

```
# encctl --smart
```

* check SMART error log (SATA)

```
# encctl --smarterror 30 (check last 30 days error)
```

* check uncorrectable error (SAS)

```
# encctl --unc
```

* locate indicator

```
# encctl --locate 0xXXXXXXXXXXXXXXXX:00     # locate 0xXXXXXXXXXXXXXXXX:00
# encctl --locate 0xXXXXXXXXXXXXXXXX        # locate 0xXXXXXXXXXXXXXXXX:*
# encctl --locate all                       # locate *:*
# encctl --locate_off 0xXXXXXXXXXXXXXXXX:00 # unlocate 0xXXXXXXXXXXXXXXXX:00
# encctl --locate_off 0xXXXXXXXXXXXXXXXX    # unlocate 0xXXXXXXXXXXXXXXXX:*
# encctl --locate_off all                   # unlocate *:*
```
