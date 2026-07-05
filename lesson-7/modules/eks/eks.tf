
# IAM Role
resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-cluster-role"
  assume_role_policy = jsonencode({ Version = "2012-10-17", Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "eks.amazonaws.com" } }] })
}
resource "aws_iam_role_policy_attachment" "cluster_policy" { policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"; role = aws_iam_role.cluster.name }

# ClusterK8s
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  vpc_config { subnet_ids = var.subnet_ids }
  depends_on = [aws_iam_role_policy_attachment.cluster_policy]
}

# IAM Role
resource "aws_iam_role" "node" {
  name = "${var.cluster_name}-node-role"
  assume_role_policy = jsonencode({ Version = "2012-10-17", Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" } }] })
}
resource "aws_iam_role_policy_attachment" "node_policy" { policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"; role = aws_iam_role.node.name }
resource "aws_iam_role_policy_attachment" "cni_policy" { policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"; role = aws_iam_role.node.name }
resource "aws_iam_role_policy_attachment" "ecr_policy" { policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"; role = aws_iam_role.node.name }

# Node Group
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.subnet_ids
  instance_types  = ["t3.medium"] # Мінімальний рекомендований для EKS
  scaling_config {
    desired_size = 2
    max_size     = 6
    min_size     = 2
  }
  depends_on = [aws_iam_role_policy_attachment.node_policy, aws_iam_role_policy_attachment.cni_policy, aws_iam_role_policy_attachment.ecr_policy]
}
