# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise32"
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "build-essential"
    chef.add_recipe "git"
    chef.add_recipe "apt"
    chef.add_recipe "rvm::vagrant"
    chef.add_recipe "rvm::system"
    chef.add_recipe "nodejs"

    chef.json = {
      'rvm' => {
        'default_ruby' => 'ruby-2.0.0-p247',
        'user_default_ruby' => 'ruby-2.0.0-p247',
        'global_gems'  => [
            {'name'    => 'bundler'},
            {'name'    => 'rake'}
        ],
        'vagrant' => {
          'system_chef_solo' => '/usr/bin/chef-solo'
        },
        'group_users' => [ "vagrant" ]
      }
    }
  end
end
