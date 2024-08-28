variable "class" {
  default= "devops"
}

# Print the class in capital letters
output "class" {
  value = upper(var.class)
}

variable "fruits" {
  default= ["apple", "banana", "orange"]
}

output "fruits_count" {
  value = length(var.fruits)
}

variable "classes" {
  default = {
    devops = {
      class_name = "DevOps"
      members    = ["Alice", "Bob", "Charlie"]
    }
    aws = {
      name="aws"
    }
  }
}

output "devops_topics"{
  value = var.classes["devops"]["members"]
}

output "aws_topics" {
  value = lookup(lookup(var.classes, "aws", null), "members", "no members" )
}

# Print the fruits in reverse order
output "reversed_fruits" {
  value = [for fruit in var.fruits : fruit] | reverse
}


variable "numbers" {
  default= [1, 2, 3, 4, 5]
}

# Print the sum of the numbers
output "sum_of_numbers" {
  value = sum(var.numbers)
}

variable "person" {
  default = {
    name    = "John Doe"
    age     = 30
    address = {
      street = "123 Main St"
      city   = "New York"
      state  = "NY"
      zip    = "12345"
    }
    hobbies = ["reading", "painting", "cooking"]
  }

  # Print the person's name
  output "person_name" {
    value = var.person.name
  }

  # Print the person's address
  output "person_address" {
    value = "${var.person.address.street}, ${var.person.address.city}, ${var.person.address.state}, ${var.person.address.zip}"
  }

  # Print the person's hobbies
  output "person_hobbies" {
    value = var.person.hobbies
  }

  # Print the person's age
  output "person_age" {
    value = var.person.age
  }

  # Print the person's hobbies in reverse order
  output "person_hobbies_reversed" {
    value = [for hobby in var.person.hobbies : hobby] | reverse
  }
}

