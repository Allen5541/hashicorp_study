packer {
  required_plugins {
    googlecompute = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

variable project_id {}

variable image_name {}

variable image_description {}

variable ssh_username {}

variable zone {}

variable source_image_family {}

variable account_file {}

variable image_family {}

source "googlecompute" "minikube_ubuntu" {
  account_file        = var.account_file
  project_id          = var.project_id
  image_family        = var.image_family
  image_name          = var.image_name
  image_description   = var.image_description
  source_image_family = var.source_image_family
  ssh_username        = var.ssh_username
  zone                = var.zone
}

build {
  sources = ["sources.googlecompute.minikube_ubuntu"]

  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update",
      "sudo apt-get upgrade -y"
    ]
  }

  # Install GCP CLI
  provisioner "shell" {
    inline = [
      "echo Installing Google Cloud SDK CLI",
      "echo \"deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main\" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list",
      "sudo apt-get install -y apt-transport-https ca-certificates gnupg",
      "curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -",
      "sudo apt-get update && sudo apt-get -y install google-cloud-sdk",
      "gcloud --version"
    ]
  }

  # Install brew
  provisioner "shell" {
    inline = [
      "echo Installing Brew",
      "/bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"",
      "echo 'eval \"$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)\"' >> /home/ubuntu/.profile",
      "sudo apt-get install -y build-essential"
    ]
  }

  # Install Docker
  provisioner "shell" {
    inline = [
      "echo Installing Docker",
      "sudo apt-get update -y",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo chmod 666 /var/run/docker.sock"
    ]
  }

  # Install Minikube
#  provisioner "shell" {
#    inline = [
#      "echo Installing minikube",
#      "brew install minikube"
#    ]
#  }
}


