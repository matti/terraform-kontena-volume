resource "null_resource" "start" {
  provisioner "local-exec" {
    command = "echo depends_id=${var.depends_id}"
  }
}

locals {
  driver_opts_or_none = "${length(var.driver_opts) == 0 ?
    ""
    :
    "${join(" ", formatlist("--driver-opt %s", var.driver_opts))}"
    }"
}

resource "null_resource" "kontena_volume" {
  depends_on = ["null_resource.start"]

  provisioner "local-exec" {
    command = <<EOF
kontena volume create \
--driver ${var.driver} \
${local.driver_opts_or_none} \
--scope ${var.scope} \
${var.name}
EOF
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "kontena volume rm --force ${var.name}"
  }
}
