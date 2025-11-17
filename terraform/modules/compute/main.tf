resource "google_compute_instance" "ml_vm" {
  name         = "ml-notebook"
  machine_type = "n1-standard-8"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email  = var.service_account_email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt update && apt install -y python3-pip python3-venv git
    python3 -m venv /home/${var.user}/ml-env
    source /home/${var.user}/ml-env/bin/activate
    pip install --upgrade pip
    pip install jupyterlab pandas numpy scikit-learn tensorflow torch google-cloud-storage papermill
    # Descargar notebook desde bucket
    gsutil cp gs://${var.notebook_bucket}/notebook.ipynb /home/${var.user}/notebook.ipynb
    # Ejecutar notebook automáticamente
    papermill /home/${var.user}/notebook.ipynb /home/${var.user}/output.ipynb
    # Subir resultados a Gold
    gsutil cp /home/${var.user}/output.ipynb gs://${var.gold_bucket}/output.ipynb
  EOT

  tags = ["jupyter"]
}

resource "google_compute_firewall" "jupyter_firewall" {
  name    = "allow-jupyter"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8888"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jupyter"]
}
