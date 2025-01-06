terraform {
  required_providers {
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}
# 1. Create EC2 instances
resource "aws_instance" "manager_node" {
  ami             = var.manager_ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.manager_node.name]
  # key_name = var.key_pair_name

  tags = {
    Name = "Manager Node"
  }

  user_data = file("userdata/manager-user-data.yaml")
}

data "template_file" "worker-user-data" {
  template = file("userdata/worker-user-data.yaml")
  vars = {
    manger_private_ip = aws_instance.manager_node.private_ip
  }
  depends_on = [
  aws_instance.manager_node]
}


# 2. Create Multiple Worker Nodes
resource "aws_instance" "worker_node" {
  count         = var.worker_count
  ami           = var.worker_ami
  instance_type = var.instance_type
  security_groups = [
    aws_security_group.worker_node.name,
  ]
  # key_name = var.key_pair_name

  tags = {
    Name = "Worker Node ${count.index + 1}"
  }

  user_data = base64encode(data.template_file.worker-user-data.rendered)
}
