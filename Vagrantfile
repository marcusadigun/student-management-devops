# Vagrantfile
Vagrant.configure("2") do |config|
  
  # Global Config: We use Ubuntu 22.04
  config.vm.box = "bento/ubuntu-22.04" 

  # --- VM 1: The Database (The Fridge) ---
  config.vm.define "db" do |db|
    db.vm.hostname = "db-server"
    # We give it a static IP so the App knows exactly where to find it
    db.vm.network "private_network", ip: "192.168.56.10"
    
    db.vm.provider "vmware_desktop" do |v|
      v.gui = true      # Headless mode (no popup window)
      v.memory = "1024"   # 1GB RAM
      v.cpus = 1
      v.allowlist_verified = true
    end
    
    # This runs the script to install Postgres automatically
   # db.vm.provision "shell", path: "scripts/install_db.sh"
  end

  # --- VM 2: The Application (The Kitchen) ---
  config.vm.define "app" do |app|
    app.vm.hostname = "app-server"
    app.vm.network "private_network", ip: "192.168.56.11"
    
    # Sync Folder: Maps your Mac's current folder (.) to /vagrant inside the VM
    # This lets you edit code in VS Code on Mac, and run it in Linux immediately.
    app.vm.synced_folder ".", "/vagrant"

    app.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.memory = "1024"
      v.cpus = 1
      v.allowlist_verified = true
    end

   # app.vm.provision "shell", path: "scripts/install_app.sh"
  end

  # --- VM 3: The Web Server (The Waiter) ---
  config.vm.define "web" do |web|
    web.vm.hostname = "web-server"
    web.vm.network "private_network", ip: "192.168.56.12"
    
    # Port Forwarding: Traffic to localhost:8080 on Mac -> Port 80 on VM
    web.vm.network "forwarded_port", guest: 80, host: 8080

    web.vm.provider "vmware_desktop" do |v|
      v.gui = true
      v.memory = "1024"
      v.allowlist_verified = true
    end

   # web.vm.provision "shell", path: "scripts/install_web.sh"
  end
end
