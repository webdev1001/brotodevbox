VAGRANTFILE_API_VERSION = '2'
SYNCED_FOLDER = 'code'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'saucy64_vmware_fusion'
  config.vm.box_url = 'http://brennovich.s3.amazonaws.com/saucy64_vmware_fusion.box'
  config.vm.host_name = 'brotodevbox'

  config.vm.network :private_network, ip: '192.168.33.10'

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 4321, host: 4321

  config.vm.synced_folder "#{ENV['HOME']}/#{SYNCED_FOLDER}", "/home/vagrant/#{SYNCED_FOLDER}"


  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'main'
  end
end
