In Terraform, conditions are used to control resource creation, variable assignment, and configuration settings based on certain criteria. Terraform provides several ways to implement conditional logic in your configurations:

### 1. **Conditional Expressions**
Conditional expressions in Terraform are similar to the ternary operator in programming languages like Python or JavaScript. They allow you to select between two values depending on the result of a boolean expression.

#### Syntax
```hcl
condition ? true_value : false_value
```

#### Example
```hcl
variable "environment" {
  type    = string
  default = "production"
}

resource "aws_instance" "example" {
  ami           = var.environment == "production" ? "ami-prod" : "ami-dev"
  instance_type = "t2.micro"
}
```

In this example:
- If the `environment` variable is `"production"`, the AMI used will be `"ami-prod"`.
- Otherwise, it will use `"ami-dev"`.

### 2. **Using `count` with Conditions**
You can control whether a resource is created or not using the `count` parameter in combination with a conditional expression.

#### Example
```hcl
variable "create_instance" {
  type    = bool
  default = true
}

resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0

  ami           = "ami-123456"
  instance_type = "t2.micro"
}
```

In this example:
- If `create_instance` is `true`, one instance will be created.
- If `create_instance` is `false`, no instance will be created.

### 3. **Using `for_each` with Conditions**
`for_each` can also be used with conditional logic to dynamically decide what resources to create.

#### Example
```hcl
variable "environments" {
  type = map(string)
  default = {
    prod  = "ami-prod"
    dev   = "ami-dev"
  }
}

resource "aws_instance" "example" {
  for_each = { for key, value in var.environments : key => value if key != "dev" }

  ami           = each.value
  instance_type = "t2.micro"
}
```

In this example:
- The `for_each` loop will only include environments that are not `"dev"`, thereby skipping the creation of resources for the `"dev"` environment.

### 4. **Conditional Blocks with `dynamic`**
For more complex conditional logic, you can use the `dynamic` block to include or exclude certain blocks based on a condition.

#### Example
```hcl
resource "aws_launch_template" "example" {
  name_prefix   = "example"
  image_id      = "ami-123456"
  instance_type = "t2.micro"

  dynamic "block_device_mappings" {
    for_each = var.add_ebs ? [1] : []

    content {
      device_name = "/dev/sda1"
      ebs {
        volume_size = 30
      }
    }
  }
}
```

In this example:
- The `block_device_mappings` block is only included if `var.add_ebs` is `true`.
- If `var.add_ebs` is `false`, the block is omitted.

### 5. **Using `lookup` with Default Values**
The `lookup` function can be used to provide default values when certain conditions aren't met.

#### Example
```hcl
variable "instance_type_map" {
  type = map(string)
  default = {
    production  = "t2.large"
    development = "t2.micro"
  }
}

output "instance_type" {
  value = lookup(var.instance_type_map, var.environment, "t2.micro")
}
```

In this example:
- The `lookup` function returns the instance type based on the `environment` variable.
- If the `environment` does not exist in the map, it defaults to `"t2.micro"`.

### 6. **Null Values for Conditional Resource Attributes**
You can use `null` to conditionally omit attributes within a resource.

#### Example
```hcl
resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"

  credit_specification {
    cpu_credits = var.environment == "production" ? "unlimited" : null
  }
}
```

In this example:
- If the environment is `"production"`, the `cpu_credits` is set to `"unlimited"`.
- If not, the attribute is omitted.

### Conclusion
Conditional logic in Terraform is a powerful tool that allows you to create flexible and dynamic infrastructure configurations. By using conditional expressions, `count`, `for_each`, `dynamic` blocks, and functions like `lookup`, you can tailor your Terraform configurations to suit different environments, inputs, and scenarios.