all:
	@echo "Just run make install"

install:
	install -m 644 -t /etc/dhcp3/dhclient-exit-hooks.d dhclient-exit-hooks.d/*
	install -m 754 -t /etc/init.d init.d/*
