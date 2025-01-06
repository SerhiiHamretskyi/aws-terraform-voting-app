
# Security group for Manager Node
resource "aws_security_group" "manager_node" {
  name        = "manager-node-sg"
  description = "Security group for Docker Swarm Manager Node"

  tags = {
    Name = "Docker Swarm Manager Node Security Group"
  }
}

# Security group for Worker Node
resource "aws_security_group" "worker_node" {
  name        = "worker-node-sg"
  description = "Security group for Docker Swarm Worker Node"

  tags = {
    Name = "Docker Swarm Worker Node Security Group"
  }
}

# Allow SSH access to Manager Node
resource "aws_security_group_rule" "manager_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.manager_node.id
}

# Allow SSH access to Worker Node
resource "aws_security_group_rule" "worker_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.worker_node.id
}

# Manager Node: Allow Swarm management traffic from Worker Nodes
resource "aws_security_group_rule" "manager_ingress_from_worker_2377" {
  type                     = "ingress"
  from_port                = 2377
  to_port                  = 2377
  protocol                 = "tcp"
  security_group_id        = aws_security_group.manager_node.id
  source_security_group_id = aws_security_group.worker_node.id
}

# Worker Node: Allow Swarm management traffic from Manager Nodes
resource "aws_security_group_rule" "worker_ingress_from_manager_2377" {
  type                     = "ingress"
  from_port                = 2377
  to_port                  = 2377
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_node.id
  source_security_group_id = aws_security_group.manager_node.id
}

# Manager Node: Allow Gossip protocol from Worker Nodes
resource "aws_security_group_rule" "manager_ingress_from_worker_7946_tcp" {
  type                     = "ingress"
  from_port                = 7946
  to_port                  = 7946
  protocol                 = "tcp"
  security_group_id        = aws_security_group.manager_node.id
  source_security_group_id = aws_security_group.worker_node.id
}

resource "aws_security_group_rule" "manager_ingress_from_worker_7946_udp" {
  type                     = "ingress"
  from_port                = 7946
  to_port                  = 7946
  protocol                 = "udp"
  security_group_id        = aws_security_group.manager_node.id
  source_security_group_id = aws_security_group.worker_node.id
}

resource "aws_security_group_rule" "manager_ingress_from_worker_8080_tcp" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.manager_node.id
  source_security_group_id = aws_security_group.worker_node.id
}


# Worker Node: Allow Gossip protocol from Manager Nodes
resource "aws_security_group_rule" "worker_ingress_from_manager_7946_tcp" {
  type                     = "ingress"
  from_port                = 7946
  to_port                  = 7946
  protocol                 = "tcp"
  security_group_id        = aws_security_group.worker_node.id
  source_security_group_id = aws_security_group.manager_node.id
}

resource "aws_security_group_rule" "worker_ingress_from_manager_7946_udp" {
  type                     = "ingress"
  from_port                = 7946
  to_port                  = 7946
  protocol                 = "udp"
  security_group_id        = aws_security_group.worker_node.id
  source_security_group_id = aws_security_group.manager_node.id
}

# Manager Node: Allow Data Plane communication from Worker Nodes
resource "aws_security_group_rule" "manager_ingress_from_worker_4789" {
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
  security_group_id        = aws_security_group.manager_node.id
  source_security_group_id = aws_security_group.worker_node.id
}

# Worker Node: Allow Data Plane communication from Manager Nodes
resource "aws_security_group_rule" "worker_ingress_from_manager_4789" {
  type                     = "ingress"
  from_port                = 4789
  to_port                  = 4789
  protocol                 = "udp"
  security_group_id        = aws_security_group.worker_node.id
  source_security_group_id = aws_security_group.manager_node.id
}

# Allow HTTP traffic on Worker Node
resource "aws_security_group_rule" "worker_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.worker_node.id
}

# Allow traffic on port 81 for custom app (if needed)
resource "aws_security_group_rule" "worker_custom_app" {
  type              = "ingress"
  from_port         = 81
  to_port           = 81
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.worker_node.id
}

# Allow all outbound traffic for Manager Node
resource "aws_security_group_rule" "manager_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.manager_node.id
}

# Allow all outbound traffic for Worker Node
resource "aws_security_group_rule" "worker_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.worker_node.id
}
