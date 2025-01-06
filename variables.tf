variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] #allowing IP's 10.0.1.0 to 10.0.1.255
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24"] #allowing IP's 10.0.4.0 to 10.0.1.255
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu_central-1c"]
}

variable "instance_type" {
  default = "t2.micro" # Free
}

variable "manager_ami" {
  default = "ami-0e54671bdf3c8ed8d" # Amazon Linux 2 AMI
}

variable "worker_ami" {
  default = "ami-0e54671bdf3c8ed8d" #Amazon Linux 2 AMI
}

variable "key_pair_name" {
  default = "keypair_voting_app"
}

# Define a variable for the number of worker nodes
variable "worker_count" {
  description = "The number of worker nodes to create"
  type        = number
  default     = 2
}

