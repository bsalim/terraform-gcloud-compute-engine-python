provider "google" {
  credentials = file(var.credentials)
  project     = var.project
  region      = var.region
}

module "startup-scripts" {
  source  = "terraform-google-modules/startup-scripts/google"
  version = "~> 2.0"

  enable_setup_sudoers = true
}

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
       size  = "100"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    startup-script        = module.startup-scripts.content
    startup-script-custom = <<-EOF
    #!/bin/bash
    sudo apt update && sudo apt -y upgrade
    sudo apt-get install -y git build-essential zlib1g-dev libffi-dev libssl-dev openssl wget gnupg2 ca-certificates lsb-release
    sudo wget ${var.python_source_url}
    sudo tar -xzf Python-${var.python_version}.tgz
    cd Python-${var.python_version}
    sudo ./configure --enable-optimizations
    sudo make -j $(nproc)
    sudo make altinstall
    sudo getent passwd www-data || sudo useradd -r www-data
    sudo usermod -s /bin/bash www-data

    # Create www-data's .ssh directory if not exists
    sudo mkdir -p /home/www-data/.ssh
    # Generate SSH key pair directly in /home/www-data/.ssh if not exists
    sudo ssh-keygen -t rsa -N "" -f /home/www-data/.ssh/id_rsa
    # Set permissions and ownership for the private key
    sudo chmod 600 /home/www-data/.ssh/id_rsa
    sudo chown www-data:www-data /home/www-data/.ssh/id_rsa /home/www-data/.ssh/id_rsa.pub
    wget ${var.mysql_apt_config_url} -O mysql-apt-config.deb
    # Install the MySQL APT repository configuration package
    sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config.deb
    # Update the package list
    sudo apt update
    # Install MySQL server and development libraries
    sudo apt install -y libmysqlclient-dev
    # Install and configure Gunicorn
    sudo python3.12 -m pip install gunicorn supervisor
    # Install Nginx from Debian repository
    sudo apt-get install -y nginx
    # Enable and start Nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    # Clean up
    cd ..
    sudo rm -rf Python-${var.python_version} Python-${var.python_version}.tgz
    EOF
  }

  resource "null_resource" "fetch_ssh_key" {
    provisioner "file" {
      source      = "/path/to/store/ssh/keys/id_rsa"
      destination = "${path.module}/id_rsa"  # Save to a local directory
    }

    depends_on = [google_compute_instance.default]
  }

}