```
  ______                      _____
 / _____)                    (____ \
| /       ____ ___   ___  ___ _   \ \ ____ _   _
| |      / ___) _ \ /___)/___) |   | / _  ) | | |
| \_____| |  | |_| |___ |___ | |__/ ( (/ / \ V /
 \______)_|   \___/(___/(___/|_____/ \____) \_/
```
https://github.com/rfarley3/crossdev

git@github.com:rfarley3/crossdev.git

## Overview

This project generates a template cross develpoment virtual machine. It uses Vagrant to provision a Debian box that can be used for cross platform development. Allows you to edit your source on your local machine (from any host that supports Vagrant) with your prefered editor, then compile it for a Win7 64b target; all without the need for Windows or Visual Studio, etc.

Use the make bindings from the local machine to build via vagrant; or, vagrant ssh and run them directly on vm.

------

## Dependencies

* You will need the following:
    * Any host operating system that supports both VirtualBox and Vagrant
    * VirtualBox, available at https://www.virtualbox.org/wiki/Downloads
    * Vagrant, available at http://www.vagrantup.com/downloads
    * Some way to run the Win7 64b binaries you produce
        * wine is 32b on OS X

------

## Install

* Get the source:
    * To use:
        * `curl -o crossdev.zip https://github.com/rfarley3/crossdev/archive/master.zip`
        * `unzip crossdev.zip`
    * Alternatively, to contribute/track:
        * `git clone git@gitlab.mitre.org:rfarley/sanchopanza.git`
        * If this is your first time running git on OS X, then OS X will auto-install command line developer tools; if needed
        * If prompted for a password on the `git clone`, then you need to add an ssh key to your github account:
            * Make sure you have the proper user/email set (get-config)
            * Make sure you have a `~/.ssh/id_rsa.pub` otherwise follow https://help.github.com/articles/generating-ssh-keys/
            * github.com > Settings > SSH keys > Add SSH key
* `cd crossdev`
* Modify: `src/Vagrantfile` config.proxy.http and config.proxy.https to reflect your proxy, or comment the section out if you are not behind a proxy.
* `make product`
    * Prompts you to install VirtualBox if not found
    * Prompts you to install Vagrant if not found
    * Installs Vagrant proxy plugin if not found
        * Via `vagrant plugin install vagrant-proxyconf`
        * Available at https://github.com/tmatilai/vagrant-proxyconf
        * If you get Ruby Gem errors, then check your shell proxy settings
            * Add appropriate lines to `~/.profile`, like:
            * `http_proxy=http://<proxy url>:<proxy port>`
            * `export http_proxy`
            * `https_proxy=https://<proxy url>:<proxy port>`
            * `export https_proxy`
    * Runs `vagrant up` to provision the VM
    * Uses the VM env to compile a sample windows binary
        * Calls makefile within VM

-----

## Usage

* `make product`
    * Uses the VM env to compile a sample windows binary
* `(cd src; vagrant ssh)`
    * SSH into the Vagrant guest
    * You can run X11 over this connection
        * For OS X, you will need XQuartz installed
        * Available as a dmg at http://xquartz.macosforge.org/landing/
        * You will have to log out and log back in to complete the install
* Modify `src/Makefile` to fit your build needs
* Modify `Makefile` to add remove tasks interacting with the build system
