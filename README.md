Bento is a project that encapsulates
[Veewee](https://github.com/jedi4ever/veewee/) definitions for
building [Vagrant](http://vagrantup.com) baseboxes. We use these boxes
internally at Opscode for testing Hosted Chef, Private Chef and
our open source [cookbooks](http://community.opscode.com/users/Opscode).

These basebox definitions are originally based on
[work done by Tim Dysinger](https://github.com/dysinger/basebox) to
make "Don't Repeat Yourself" (DRY) modular baseboxes. Thanks Tim!


# Getting Started

First, clone the project, then install the required Gems with Bundler.

    $ git clone git://github.com/scalp42/bento.git
    $ cd bento
    $ git checkout audax
    $ bundle install

List available baseboxes that can be built:

    $ bundle exec veewee vbox list

Build the ubuntu-12.04-audax basebox, export it and add it to Vagrant:

    $ bundle exec thor bento:box create -af ubuntu-12.04-audax

Congratulations! You now have `./ubuntu-12.04-audax.box`, a fully functional
basebox including Ruby 1.9.3, Chef (as well as fog gem) and packages from zs-common.

Edit your Vagrantfile to use the newly created box:

	$ nano Vagrantfile
	$ zs1.vm.box = "ubuntu-12.04-audax"

# How It Works

Veewee reads the definition specified and automatically builds a
VirtualBox machine. The VirtualBox guest additions and the target OS
ISO are downloaded into the `iso/` directory.

We use Veewee version 0.3.0.alpha+ because it contains fixes for
building CentOS boxes under certain circumstances.

# Definitions

The definitions themselves are split up into directories that get
symlinked into specific basebox directories.

Most of the files are symlinked for a particular box. The one
exception is the `definition.rb` file, which contains the specific
configuration for the Veewee session for a basebox, including the ISO
filename, its source URL, and the MD5 checksum of the file.

## Common

* `chef-client.sh`: Installs Chef and Ruby with
  [Opscode's full stack installer](http://opscode.com/chef/install)
* `minimize.sh`: Zeroes out the root disk to reduce file size of the box
* `ruby.sh`: **Deprecated** Use `chef-client.sh`
* `session.rb`: Baseline session settings for Veewee
* `sshd.sh`: Adds some sshd configs to speed up vagrant
* `vagrant.sh`: Installs VirtualBox Guest Additions, adds the Vagrant
  SSH key

## Ubuntu (Audax build)

* `ruby.sh`: Install Ruby and rubygems from source
* `chef-omnibus.sh`: Install Chef using omnibus
* `chef-gems.sh`: Install gems required in our cookbooks (`fog` and `hipchat`)
* `zs-common.sh`: Install required packages from `zs-common::packages`
* `cleanup.sh`: Removes unneeded packages, cleans up package cache,
  and removes the VBox ISO and Chef deb
* `networking.sh`: Removes networking setup like udev that may
  interfere with Vagrant network setup
* `preseed.cfg`: The Debian Preseed file for automated OS installation
* `session.rb`: General Ubuntu session settings for Veewee
* `sudoers.sh`: Customization for `/etc/sudoers`
* `update.sh`: Ensures that the OS installation is updated

License and Authors
===================

- Author:: Seth Chisamore (<schisamo@opscode.com>)
- Author:: Stephen Delano (<stephen@opscode.com>)
- Author:: Joshua Timberman (<joshua@opscode.com>)
- Author:: Tim Dysinger (<tim@dysinger.net>)
- Author:: Chris McClimans (<chris@hippiehacker.org>)
- Author:: Julian Dunn (<jdunn@opscode.com>)

Copyright:: 2012-2013, Opscode, Inc (<legal@opscode.com>)
Copyright:: 2011-2012, Tim Dysinger (<tim@dysinger.net>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
