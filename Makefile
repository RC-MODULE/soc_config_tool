
files:=$(addprefix output/,$(subst .ini,.bin,$(shell ls configs/)))

all: $(files)

clean:
	-rm -Rfv output
	-rm -Rfv build

mrproper:
	git submodule deinit -f RumBoot

output/%.bin: configs/%.ini
	mkdir -p output
	cp config_tool.tmpl $@
	cat $< >> $@
	echo -ne "\x00" >> $@
	rumboot-packimage -C -f $@

recompile:
#	git submodule update --init RumBoot
	mkdir -p build
	cd build && cmake ../RumBoot -DRUMBOOT_PLATFORM=basis -DCMAKE_BUILD_TYPE=Production
	cd build && make rumboot-basis-Production-spl-bconfig.all
	cp build/rumboot-basis-Production-spl-bconfig.bin config_tool.tmpl