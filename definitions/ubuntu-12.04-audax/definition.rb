require File.dirname(__FILE__) + "/../.common/session.rb"

UBUNTU_SESSION =
  COMMON_SESSION.merge({ :boot_cmd_sequence =>
                         [
                          "<Esc>",
                          "<Esc>",
                          "<Enter>",
                          "/install/vmlinuz" ,
                          " auto",
                          " console-setup/ask_detect=false",
                          " console-setup/layoutcode=us",
                          " console-setup/modelcode=pc105",
                          " debconf/frontend=noninteractive",
                          " debian-installer=en_US",
                          " fb=false",
                          " initrd=/install/initrd.gz",
                          " kbd-chooser/method=us",
                          " keyboard-configuration/layout=USA",
                          " keyboard-configuration/variant=USA",
                          " locale=en_US",
                          " netcfg/get_domain=vm",
                          " netcfg/get_hostname=vagrant",
                          " noapic" ,
                          " preseed/url=http://%IP%:%PORT%/preseed.cfg",
                          " -- ",
                          "<Enter>"
                         ],
                         :os_type_id => 'Ubuntu_64',
                         :postinstall_files => [ "update.sh",
                                                 "vagrant.sh",
                                                 "sshd.sh",
                                                 "networking.sh",
                                                 "sudoers.sh",
                                                 "ruby.sh",
                                                 "chef-omnibus.sh",
                                                 "chef-gems.sh",
                                                 "zs-common.sh"
                                                 "cleanup.sh",
                                                 "minimize.sh" ],
                         :kickstart_file => "preseed.cfg",
                         :shutdown_cmd => "shutdown -P now" })


iso = "ubuntu-12.04.3-server-amd64.iso"

session =
  UBUNTU_SESSION.merge( :iso_file => iso,
                        :iso_md5 => "2cbe868812a871242cdcdd8f2fd6feb9",
                        :iso_src => "http://releases.ubuntu.com/12.04/#{iso}" )

Veewee::Session.declare session
