resource "oci_core_instance" "public_compute" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.instance_ad - 1].name
  compartment_id      = var.compartment_ocid
  display_name        = "My Public Compute Instance"
  shape               = var.instance_shape

  shape_config {
    ocpus = var.instance_ocpus
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.pub_subnet.id
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ol_images.images[0].id
  }

  metadata = {
    ssh_authorized_keys = join("\n", var.ssh_public_keys)
    user_data = base64gzip(templatefile("cloud-config-template.yml", {}))
  }
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "ol_images" {
  compartment_id   = var.compartment_ocid
  operating_system = "Oracle Linux"
  shape            = var.instance_shape
  sort_by          = "TIMECREATED"
  sort_order       = "DESC"
}