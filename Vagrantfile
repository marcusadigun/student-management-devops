# Vagrantfile
Vagrant.configure("2") do |config|
  
  # Global Config:Ubuntu 22.04
  config.vm.box = "bento/ubuntu-22.04" 

  config.vm.define "db" do |db|
    db.vm.hostname = "db-server"
    # Static IP so the App knows exactly where to find it
    db.vm.network "private_network", ip: "192.168.56.10"
    
    db.vm.provider "vmware_desktop" do |v|
      v.gui = true      # popup window
      v.memory = "1024"   # 1GB RAM
      v.cpus = 1
      v.allowlist_verified = true
    end
    
  end

  config.vm.define "app" do |app|
    app.vm.hostname = "app-server"
    app.vm.network "private_network", ip: "192.168.56.11"
    
    app.vm.synced_folder ".", "/vagrant"

    app.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.memory = "1024"
      v.cpus = 1
      v.allowlist_verified = true
    end

   # app.vm.provision "shell", path: "scripts/install_app.sh"
  end

  config.vm.define "web" do |web|
    web.vm.hostname = "web-server"
    web.vm.network "private_network", ip: "192.168.56.12"
    
    # Port Forwarding: Traffic to localhost:8080 
    web.vm.network "forwarded_port", guest: 80, host: 8080

    web.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.memory = "1024"
      v.allowlist_verified = true
    end

  end

  config.vm.define "jenkins" do |jenkins|
    jenkins.vm.hostname = "jenkins-server"
    jenkins.vm.network "private_network", ip: "192.168.56.20"
    
    jenkins.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.memory = "2048" # Jenkins is hungry, it needs 2GB!
      v.allowlist_verified = true
    end

   # jenkins.vm.provision "shell", path: "scripts/install_jenkins.sh"
  end
end
