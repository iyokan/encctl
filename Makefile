help:
	@echo To install programs:
	@echo
	@echo \	${MAKE} install
	@echo
	@echo To reload udev rules:
	@echo
	@echo \	${MAKE} reload
	@echo

install:
	rpm -q perl-File-Slurp > /dev/null || yum -y install perl-File-Slurp
	rpm -q perl-Parallel-ForkManager > /dev/null || yum -y install perl-Parallel-ForkManager
	install -m 755 encctl /usr/local/bin
	install -m 755 vdev_id_auto /etc/udev
	install -m 644 69-vdev-auto.rules /etc/udev/rules.d
	if [ -d /etc/systemd/system ]; then install -m 644 zfs-multipath-detect.service /etc/systemd/system; systemctl enable zfs-multipath-detect.service; fi

reload:
	perl -c /etc/udev/vdev_id_auto && udevadm trigger
