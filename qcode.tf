terraform {
  #Plugin upcloud
  required_providers {
    upcloud = {
      source = "UpCloudLtd/upcloud"
      version = "1.0.0"
    }
  }
}

provider "upcloud" {
  #Credenciales upcloud
  username = "user"
  password = "pass"
}


resource "upcloud_server" "qcode" {
  #System hostname
  hostname = "qcode.co"

  #Availability zone
  zone = "nl-ams1"

  #Number of CPUs and memory in GB
  plan = "1xCPU-1GB"

  storage_devices {
    #System storage device size
    size = 25

    #Template UUID for Ubuntu 20.04
    storage = "01000000-0000-4000-8000-000030200200"

    # Storage device typeC
    tier   = "maxiops"
    action = "clone"
  }

  #Network interfaces
  network_interface {
    type = "public"
  }

  network_interface {
    type = "utility"
  }


  #Configuring connection details
  connection {
    # The server public IP address
    host        = self.network_interface[0].ip_address
    type        = "ssh"
    user        = "root"
  }
}