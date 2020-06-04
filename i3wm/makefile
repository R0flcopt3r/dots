##
# i3wm
#
# @file
# @version 0.1

config_dir := ./config.d/
configs := $(foreach dir, $(config_dir), $(wildcard $(dir)/*))

desktop: .make.desktop_config .make.desktop

laptop: .make.laptop_config .make.laptop

.make.desktop_config: .make.config .make.chassis desktop.conf
	cat desktop.conf >> config
	touch $@

.make.laptop_config: .make.config .make.chassis laptop.conf
	cat laptop.conf >> config
	touch $@

.make.config: .make.chassis $(config_dir)$(configs) base.conf
	cat base.conf $(config_dir)*.conf > config
	touch $@

.make.chassis:
	touch .make.$(lastword $(shell hostnamectl status | grep Chassis))
	touch $@


clean:
	rm .make.*
	rm config

# end
