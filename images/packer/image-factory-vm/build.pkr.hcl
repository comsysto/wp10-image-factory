build {
  sources = [
    "source.azure-arm.vm"
  ]

  provisioner "shell" {
    inline = [
      "echo Hi!"
    ]
  }
}
