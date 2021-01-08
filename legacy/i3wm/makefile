##
# i3wm
#
# @file
# @version 0.1

# Location of the configurations. Can be specified
config_dir ?= ./config.d/
# List of all configurations in $(config_dir)
configs := $(foreach dir, $(config_dir), $(wildcard $(dir)/*))
# The chassis type. can be specified as laptop or desktop
chassis ?= $(file < /sys/devices/virtual/dmi/id/chassis_type)

.PHONY: build restart

build: .make.build

restart: build
	i3-msg restart

.make.build: .make.config
# Values are grabbed from https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.0.0.pdf
ifeq ($(chassis),$(filter $(chassis), 8 9 14 laptop))
	cat laptop.conf >> config
endif
ifeq ($(chassis),$(filter $(chassis), 3 4 6 7 desktop))
	cat desktop.conf >> config
endif
	touch $@

.make.desktop_config: .make.config desktop.conf
	cat desktop.conf >> config
	touch $@

.make.laptop_config: .make.config laptop.conf
	cat laptop.conf >> config
	touch $@

.make.config: $(config_dir)$(configs) base.conf
	cat base.conf $(config_dir)*.conf > config
	touch $@

clean:
	rm .make.*
	rm config

# end
