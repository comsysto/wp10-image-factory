build {
  sources = [
    "source.azure-arm.vm"
  ]

  provisioner "file" {
    source      = "images/packer/image-factory-vm/scripts/setup-vm.sh"
    destination = "/tmp/setup.sh"
  }

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    
    inline = [
      "chmod +x /tmp/setup.sh",
      "/tmp/setup.sh"
    ]
  }
}
