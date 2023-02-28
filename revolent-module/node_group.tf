resource "aws_eks_node_group" "main" {
  count           = length(module.vpc.azs)
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.project_name}-${module.vpc.azs[count.index]}-${var.environment}"
  node_role_arn   = aws_iam_role.node_group.arn
  subnet_ids      = [module.vpc.private_subnets[count.index]]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Note: t3.small allows upto 11 pods
  # Usable pods = 11 - 4 = 7
  instance_types = var.node_group_instance_types

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name        = "${var.project_name}-${module.vpc.azs[count.index]}-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_iam_role" "node_group" {
  name = "${var.project_name}-node-group-${var.environment}"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  tags = {
    Name        = "${var.project_name}-node-group-${var.environment}"
    Environment = var.environment
  }
}

# This policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters.
resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node_group.name
}

# This policy provides the Amazon VPC CNI Plugin (amazon-vpc-cni-k8s) 
# the permissions it requires to modify the IP address configuration on your EKS worker nodes.
# This permission set allows the CNI to list, describe, and modify Elastic Network Interfaces on your behalf.
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node_group.name
}

# Provides read-only access to Amazon EC2 Container Registry repositories.
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group.name
}

# Provides read-only access to Amazon EC2 Container Registry repositories.
resource "aws_iam_role_policy_attachment" "AmazonDynamoDBAccess" {
  policy_arn = aws_iam_policy.dynamodb-access.arn
  role       = aws_iam_role.node_group.name
}
