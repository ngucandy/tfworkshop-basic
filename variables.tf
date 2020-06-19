variable "region" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "fingerprint" {}
variable "compartment_ocid" {}

variable "vcn_cidr" {
    default = "10.0.0.0/16"
}
variable "instance_ad" {
    default = "2"
}
variable "instance_shape" {
    default = "VM.Standard.E3.Flex"
}
variable "instance_ocpus" {
    default = "1"
}
variable "ssh_public_keys" {
    type = list(string)
}
