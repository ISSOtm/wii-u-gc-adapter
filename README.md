wii-u-gc-adapter
================

Tool for using the Wii U GameCube Adapter on Linux

Prerequisites
-------------
* libudev
* libusb(x) >= 1.0.16

Building
--------
Just run `make`. That's all there is to it!

To install the program, the udev rule, and the Xorg rule, run `make install` as root.

Usage
-----
The provided udev rule should automatically start the program as soon as the
adapter is plugged in.

Alternatively, you can `systemctl start wii-u-gc-controller` manually, or
even simply run the program (though you will probably need privileges in
order to grab the USB device from the kernel, and to use the uinput interface.)

To stop the program, just kill it in any way you want.

Separate virtual controllers are created for each GC controller plugged into
the adapter; hotplugging (both controllers and adapters) is supported.

Quirks
------
* It's new, so there might be bugs! Please report them!
* The uinput kernel module is required. If it's not autoloaded, you should do
  so with `modprobe uinput` (the systemd service does so automatically).
* Input ranges on the sticks/analog triggers are scaled to try to match the
  physical ranges of the controls. To remove this scaling run the program with
  the `--raw` flag.
* If all your controllers start messing with the mouse cursor, try placing
  `51-ignore-gc-controllers.conf` in `/usr/share/X11/xorg.conf.d`.
