ECP5 FOSS ULX3S Blinky
======================

<img src="https://github.com/q3k/ulx3s-foss-blinky/raw/master/ulx3s/photo.png" width="250">

This is a simple, sample project that blinks some LEDs on the [ULX3S](https://github.com/emard/ulx3s) ECP5 FPGA board. It only uses Open Source software to accomplish this goal, from Verilog to bitstream.

Prerequisites
-------------

 - [yosys](https://github.com/YosysHS/yosys) (at least git revision 5387ccb041f4acafc96c7b3fcf8db04dddfb8ab5)
 - [nextpnr](https://github.com/YosysHQ/nextpnr) (at least git revision 15d9b3d3cc05656e58d01ba2f97ec92b6daaee1c, with ECP5 support enabled)
 - [openocd](https://openocd.org) with [4f134c755d7209a8eb1c4460e09f5c68622ef0bd](http://openocd.zylin.com/gitweb?p=openocd.git;a=commitdiff;h=4f134c755d7209a8eb1c4460e09f5c68622ef0bd) cherrypicked or merged

Usage
-----

Clone this repository. Either use it as a starting point for your project, or just copy the files over.

By default, we target the ULX3S with an LFE5U-85F. If you target a different chip, you will have to edit the `PART_*` variables in the Makefile, and, to use OpenOCD for flashing, you will have to edit the idcode in `ulx3s/openocd.cfg`.

To build the blinky, run `make flash`.

Runtime options for Makefile
----------------------------

 - `YOSYS` - path to Yosys binary. By default, `yosys` in path.
 - `NEXTPNR` - path to `nextpnr-ecp5` binary. By default, `nextpnr-ecp5` in path.
 - `ECPPACK` - path to `ecppack` from prjtrellis. By default, `ecppack` in path.
 - `TRELLIS` - path to prjtrellis installation directory. By default, `/usr/share/terllis`.

License
-------

The blinky code comes from nextpnr and is licensed under the ISC License.

The bit\_to\_svf utility comes from prjtrellis and is licensed under the ISC License.

The Makefile, LPF constraint file, OpenOCD script, title photograph and this README are under CC0.
