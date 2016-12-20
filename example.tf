variable "region" {
  default = "europe-west1-c" // We're going to need it in several places in this config
}

provider "google" {
  credentials = "${file("account.json")}"
  project     = "gearup-153112"
  region      = "${var.region}"
}
 
resource "google_compute_instance" "test" {
  count        = 1 // Adjust as desired
  name         = "test${count.index + 1}" // yields "test1", "test2", etc. It's also the machine's name and hostname
  machine_type = "f1-micro" // smallest (CPU &amp; RAM) available instance
  zone         = "${var.region}" // yields "europe-west1-d" as setup previously. Places your VM in Europe
 
  disk {
    image = "debian-7-wheezy-v20160301" // the operative system (and Linux flavour) that your machine will run
  }
 
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP - leaving this block empty will generate a new external IP and assign it to the machine
    }
  }
}
 
