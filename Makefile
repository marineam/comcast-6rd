all:
	@echo "Just run make install"

install:
	install -m 644 -t /etc/dhcp3/dhclient-exit-hooks.d dhclient-exit-hooks.d/*
	install -m 755 -t /etc/dhcp3/comcast-6rd-start.d comcast-6rd-start.d/*
	install -m 755 -t /etc/dhcp3/comcast-6rd-stop.d comcast-6rd-stop.d/*
	install -m 755 -t /etc/init.d init.d/*
