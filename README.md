### Template Cross Dev Box

Uses vagrant to provision a debian box that can be used for cross platform development.

Edit your source on your local machine with your prefered editor.

Use the make bindings from the local machine to build via vagrant; or, vagrant ssh and run them directly on vm.

Currently supports Windows binary building from any host that supports vagrant.

#### Install

* Change: 'src/Vagrantfile' config.proxy.http and config.proxy.https or comment the section out if you are not behind a proxy.
* 'make product' 
    * Tests if VirtualBox and Vagrant are installed
    * Installs Vagrant plugins; if needed
    * Brings up Vagrant VM, provisions; if needed 
    * Calls makefile within VM
