resource "aws_iam_role" "eks_cluster" {
  name = "eks_cluster"

# Ensure that the AmazonEKSCluterPolicy managed policy is attachedto the aws_iam_role
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# This policy providers K8S the permissions it requires to manage resource on your behalf.
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role       = aws_iam_role.eks_cluster.name
}

# This policy allows Amazon Elastic Container Servic for K8S to create and manage the necessary resources to operate EKS Clusters.
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
 role       = aws_iam_role.eks_cluster.name
}

# Ensure that the AmazonEKSWorkerNodePolicy and AmazonEC2ContainerRegistryReadOnly managed policies are attached to the roles.

resource "aws_iam_role" "eks_nodes" {
  name = "eks_node_group"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
 role       = aws_iam_role.eks_nodes.name
}

# This policy providers the Amazon VPC CNI plugin the permission it requires to modify the ip address configuration your EKS worker nodes.
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
 role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role       = aws_iam_role.eks_nodes.name
}