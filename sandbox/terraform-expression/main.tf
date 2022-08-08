
provider "null" {}

output "json" {
  value = jsondecode(
    jsonencode(
      {
        "foo" : "bar",
      }
    )
  )
}

output "heredoc" {
  value = <<-EOT
    def foo():
      return "bar"
  EOT
}

output "format" {
  value = format("Hello, %s!", "World")
}

output "merge" {
  value = merge(
    {
      foo = "bar"
    },
    {
      fizz = "buzz"
    }
  )
}

output "sensitive" {
  value = sensitive("foo")

  sensitive = true
}

output "file" {
  value = file("./README.md")
}
