variable "sample" {
  default = 100
}

variable "sample1" {
  default = "Hello, world"
}

output "sample" {
  value = var.sample
  description = "Sample output"
  }

output "sample1" {
  value = var.sample1
}

# sometimes if variable/any reference with the combination of some other string then we have to access those in ${}

output "sample-txt" {
  value = "Value of sample - ${var.sample}"
  description = "Sample output"

}