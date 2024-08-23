variable "sample" {
  default = 100
}

variable "sample1" {
  default = "Hello, world"
}

# You declare the variable and if you need the output we should give like variable.sample so here below
output "sample" {
  value = var.sample
}

output "sample1" {
  value = var.sample1
}

# sometimes if variable/any reference with the combination of some other string then
#  we have to access those in ${}

output "sample-txt" {
  value = "Value of sample and sample1- ${var.sample} - ${var.sample1}"  # String + variable

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
# list starts with a index value
output "courses" {
  value = var.courses[1]
}

# If i need details of a particular course i will mention Aws or Devops.
output "course_details" {
  value = var.courses_details["Aws"]
}

# In Map to retrieve the details
output "course_timing" {
  value = var.courses_details["Aws"]["timings"]
}



variable "env" {}

output "env" {
  value = var.env
}

variable "url" {}

output "url" {
  value = var.url
}



