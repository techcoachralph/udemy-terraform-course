variable "number" {
  description = "A number to check"
  type        = number
}

output "is_greater_than_ten" {
  value = greaterthan(var.number, 10)
}
