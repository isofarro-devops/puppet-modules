baseBox    = 'ubuntu-12.04'
baseBoxUrl = 'http://timhuegdon.com/vagrant-boxes/ubuntu-12.04.box'
ipAddress  = '33.33.33.50'


Vagrant.configure('2') do |config|
    config.vm.box     = baseBox
    config.vm.box_url = baseBoxUrl

    config.vm.network :private_network, ip: ipAddress

    config.vm.provider 'virtualbox' do |my_vm|
        my_vm.customize [
            'modifyvm', :id, 
            '--memory', "512"
        ]
    end

    config.vm.synced_folder '.', '/home/vagrant/php5-beanstalk', :nfs => true

    config.vm.provision :puppet do |puppet|
        #puppet.options = '-vd'  # Verbose and Debug
        puppet.options = '-v'  # Verbose

        puppet.manifests_path = 'puppet'
        puppet.manifest_file  = 'base.pp'
        puppet.module_path    = 'puppet/modules'
    end

end
