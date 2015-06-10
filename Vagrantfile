VAGRANTFILE_API_VERSION = '2'
SYNCED_FOLDER = 'code'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'phusion/ubuntu-14.04-amd64'
  config.vm.host_name = 'brotodevbox'

  config.vm.provider :vmware_fusion do |v|
    v.vmx['memsize'] = 3072
    v.vmx['numvcpus'] = 4

    v.gui = false
  end

  config.vm.network :private_network, ip: '192.168.33.10'

  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 4321, host: 4321
  config.vm.network :forwarded_port, guest: 4567, host: 4567
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.vm.synced_folder "#{ENV['HOME']}/#{SYNCED_FOLDER}", "/home/vagrant/#{SYNCED_FOLDER}", nfs: true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'brotodevbox'
  end
end
