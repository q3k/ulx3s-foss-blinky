# Copyright 2018 Serge Bazanski <serge@bazanski.pl>
#
# SPDX-License-Identifier: CC0-1.0

# Target configuration - override where appropriate, either here or at the command line.
PART_BASECONFIG ?= lfe5u-85f
PART_NEXTPNR ?= --85k

# Tools - override this from the command line if they're installed in an unusual way.
NEXTPNR ?= nextpnr-ecp5
ECPPACK ?= ecppack
YOSYS ?= yosys
TRELLIS ?= /usr/share/trellis
BASECONFIG ?= $(TRELLIS)/misc/basecfgs/empty_$(PART_BASECONFIG).config

# Targets - you can rename some of those for cosmetic purposes.
NETLIST = build/top.json
BITSTREAM_ASC = build/top.config
BITSTREAM = build/top.bit
SVF = build/top.svf

# Project configuration
SOURCES = rtl/top.v
CONSTRAINTS = ulx3s/top.lpf

default: $(SVF)

build:
	mkdir build

$(NETLIST): $(SOURCES) build
	$(YOSYS) -p 'synth_ecp5 -noccu2 -nomux -nodram -json $@' $<

$(BITSTREAM_ASC): $(NETLIST) $(CONSTRAINTS) $(BASECONFIG)
	$(NEXTPNR) --json $(NETLIST) --lpf $(CONSTRAINTS) --basecfg $(BASECONFIG) $(PART_NEXTPNR) --textcfg $@

$(BITSTREAM): $(BITSTREAM_ASC)
	$(ECPPACK) --input $< --bit $@

$(SVF): $(BITSTREAM)
	python3 ulx3s/bit_to_svf.py $< $@

flash: $(SVF)
	openocd -f "ulx3s/openocd.cfg" -c "init; svf $<; exit"

clean:
	rm -rf build

.PHONY: default flash
