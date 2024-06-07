variable "sample" {
  default = 100
}

variable "sample1" {
  default = "Hello, world"
}

output "sample" {
  value = var.sample
}

output "sample1" {
  value = var.sample1
}

# sometimes if variable/any reference with the combination of some other string then we have to access those in ${}

output "sample-txt" {
  value = "Value of sample and sample1- ${var.sample} - ${var.sample1}"

}

# Variable data types
# 1. string
# 2. integer
# 3. float
# 4. boolean
# 5. list
# 6. map
# 7. null
# 8. unknown

# In Terraform
# 1. Plain string
# 2. list
# 3. map

# plain string
variable "course" {
  default = "Devops Training"
}

# list of variable
variable "courses" {
  default = [
    "Devops",
    "Navien",
    "python",
  ]
}

# map of variable
variable "courses_details" {
  default = {
    Devops= {
      name = "Devops"
      timings="10am"
      location="Bangalore"
      description="Learn Devops"

    }
    Aws= {
      name = "AWS"
      timings="10am"
      location="Bangalore"
      description="Learn AWS"

    }
    }
  }

output "courses" {
  value = var.courses[1]
}

output "course_details" {
  value = var.courses_details["Devops"]
}



