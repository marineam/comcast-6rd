Comcast 6RD Automaticalness
===========================

This is a collection of scripts for automating the setup of a 6RD tunnel
on Comcast's network on Debian/Ubuntu machines using dhclient. Currently
only tested on Ubuntu Lucid but should work on any system that uses
dhclient for DHCP. It is based on an example script by `David Ames`_ and
extra information by `Nathan Lutchansky`_. Read their HOWTOs for further
details on how this thing works.

Overview
--------

The main script of interest is dhclient-exit-hooks.d/comcast-6rd-tunnel
which runs each time dhclient gets an IPv4 address and then sets up the
tunnel as needed (or tears it down if you ifdown eth0). When setting up
the tunnel it will configure and start radvd and optionally chatter with
bind and/or dhis.org. I use bind as a local caching name server and
dhis.org for public dynamic DNS for both v4 and v6. If you don't run
your own name server you will want to change the RDNS entry the script
writes to radvd.conf to point elsewhere.

There is also dhclient-exit-hooks.d/comcast-6rd-params which can be used
to watch for info via the 6RD DHCP option. Currently this doesn't work
for me (I assume because I am not an official trial participant) but if
it ever starts working I'll merge the two scripts to make things even
more automagical. That script was written by `Nathan Lutchansky`_.
Currently any info it finds is logged via syslog.

To keep my private home network private I use a simple firewall script
provided in init.d/firewall which sets up rules for both v4 and v6.

.. _David Ames: http://www.linux.com/learn/tutorials/371742:ipv6-6rd-linux-router-on-comcast-using-ubuntu-maverick-1010
.. _Nathan Lutchansky: http://www.litech.org/6rd/


Setup
-----

1. Be sure to edit the tunnel and firewall scripts to refer to the
   correct network interfaces for your system and any other tweaks you
   need. In my setup eth0 is the external interface and br1 (bridged to
   eth1) is my internal interface.

2. Switch your external interface to use the classic Debian
   configuration method with dhclient rather than NetworkManager if it
   isn't already. Something like this should be in
   /etc/network/interfaces::

      auto eth0
      iface eth0 inet dhcp

3. Add or uncomment the following in /etc/sysctl.conf::

      net.ipv4.ip_forward=1
      net.ipv6.conf.all.forwarding=1

4. Now it is go time! Install the scripts and bounce the interface::

      make install
      update-rc.d firewall defaults
      /etc/init.d/firewall start
      ifdown eth0; ifup eth0

5. Hopefully all is happy now, but I make no promises. :-)


Notes
-----

* For all the laptops and such on the internal network that use
  NetworkManager, you may need to edit the connection info to enable
  IPv6.  Set the Method option to "Automatic"

* For all those Android devices you are already done, they use IPv6 by
  default! (At least on WiFi, cell networks not so much...)
