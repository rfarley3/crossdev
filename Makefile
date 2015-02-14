# Makefile for a Win7 64b build on a linux VM

# phony targets
.PHONY : default install run virtbox-install vagrant-install vagrant-up clean product buildProduct publish help

# list of any cpp and h that if modified mean that product should be recompiled
PRODUCT_SOURCES := src/product.cpp src/lib1.cpp src/lib1.h
# name of the executable we want to build
BASENAME := superawesome

# link in this dir to destination (symlink to smb share on target win7 machine)
DEST_DIR := win7dir

# name of the vm to vagrant (set in  config.vm.define)
VAGR_NAME := crossdev

#vars:
#	@echo "Base: $(BASENAME)"
#	@echo "Args: $(BUILDER_ARGS)"
#	@echo "Dir/Name: $(BUILT_DIR)/$(BUILT_NAME)"

default: help

install: vagrant-install vagrant-up product

# I ran something else here, but this is an example of how to launch
# a proc on the VM to appear locally (on dev machine), like a GUI 
# or unit testing script 
run: vagrant-up
	(cd src ; vagrant ssh -c "cd /vagrant; python unitTester.py")

virtbox-install:
	@(which -s VirtualBox) ; \
	if [ $$? -eq 0 ]; then \
		echo "VirtualBox already installed" ; \
	else \
		echo "Error: You need to install VirtualBox" ; \
		echo "Goto: https://www.virtualbox.org/wiki/Downloads" ; \
		false; \
	fi

vagrant-install: virtbox-install
	@(which -s vagrant) ; \
	if [ $$? -eq 0 ]; then \
		echo "Vagrant already installed" ; \
	else \
		echo "Error: You need to install Vagrant" ; \
		echo "Goto: https://docs.vagrantup.com/v2/installation/" ; \
		false; \
	fi
	@(cd src; vagrant plugin list | grep -q proxyconf) ; \
	if [ $$? -eq 0 ]; then \
		echo "Vagrant proxyconf plugin already installed" ; \
	else \
		echo "Installing Vagrant Proxyconf plugin" ; \
		vagrant plugin install vagrant-proxyconf --plugin-source=http://rubygems.org ; \
	fi

vagrant-up:
	@(cd src; vagrant status | grep -q $(VAGR_NAME).*running) ; \
	if [ $$? -eq 0 ]; then \
		echo "Vagrant VM already up" ; \
	else \
		echo "Turning on Vagrant VM" ; \
		(cd src ; vagrant up) ; \
	fi

clean:
	make -C src clean

product: src/$(BASENAME).exe

src/$(BASENAME).exe: $(PRODUCT_SOURCES)
	@make vagrant-up 
	(cd src ; vagrant ssh -c "cd /vagrant; make all EXECUTABLE=$(BASENAME).exe")

# this is optional
# modify (not related to compile/link) the exe directly 
# via pefile to enable/disable options, etc
# built results are in src/$(BUILT_DIR) so you'll need:
#BUILT_DIR := builtProduct
# And then the actual target:
#buildProduct: src/$(BUILT_DIR)/$(BUILT_NAME)
#
# But to do this you need to know the 'built_name' which is 
# determined by the builder in the VM. You'll need a 'getBuiltName.py'
# which import builder.py to access the code that determines the built_name
# so you'll need:
#BUILT_NAME := $(shell ./utils/getBuiltName.py $(IP) $(PORT))
# as well as the args for the builder, such as:
#BUILDER_ARGS := $(OPT1) $(OPT2) $(BASENAME).exe $(BUILT_DIR)/$(BUILT_NAME)
# and the target
#src/$(BUILT_DIR)/$(BUILT_NAME): src/$(BASENAME).exe src/builder.py
#	@make vagrant-up
#	(cd src ; vagrant ssh -c "cd /vagrant; python builder.py $(BUILDER_ARGS)")
#
# This is the target if you are publishing a built product
#$(DEST_DIR)/$(BASENAME).exe: src/$(BUILT_DIR)/$(BUILT_NAME) 
#	cp src/$(BUILT_DIR)/$(BUILT_NAME) $(DEST_DIR)/$(BASENAME).exe

publish: $(DEST_DIR)/$(BASENAME).exe

# this is the target for unbuilt product
$(DEST_DIR)/$(BASENAME).exe: src/$(BASENAME).exe
	cp src/$(BASENAME).exe $(DEST_DIR)/$(BASENAME).exe


help:
	@echo "Primary Project Makefile. Designed for Posix (Linux/OS X/Cygwin/etc)."
	@echo "\thelp\t\tThis message"
	@echo "\tinstall\t\tInstall project inside a Vagrant VM"
	@echo "\trun\t\tRun the unit tester within Vagrant VM"
	@echo "\tproduct\t\tCompile product code changes within Vagrant VM"
	#@echo "\tbuildProduct\tBuild product exe within Vagrant VM"
	#@echo ""
	#@echo "  If you did a 'make install' then 'make buildProduct' and 'make publish' or 'make unitTest'"

