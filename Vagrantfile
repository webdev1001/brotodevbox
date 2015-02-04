VAGRANTFILE_API_VERSION = '2'
SYNCED_FOLDER = 'code'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'utopic64_virtualbox'
  config.vm.box_url = 'http://brennovich.s3.amazonaws.com/utopic64_virtualbox.box'
  config.vm.host_name = 'brotodevbox'

  config.vm.provider 'virtualbox' do |v|
    v.memory = 2048
    v.cpus = 4

    v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
  end

  config.ssh.forward_agent = true

  config.vm.network :private_network, ip: '192.168.33.10'

  config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 1080, host: 1080
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 4321, host: 4321

  config.vm.synced_folder "#{ENV['HOME']}/#{SYNCED_FOLDER}", "/home/vagrant/#{SYNCED_FOLDER}", nfs: true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = 'cookbooks'
    chef.add_recipe 'brotodevbox'
  end
end
