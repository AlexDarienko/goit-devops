terraform {
  required_version = ">= 1.0"
  required_providers {
    aws        = { source = "hashicorp/aws", version = "~> 5.0" }
    helm       = { source = "hashicorp/helm", version = "~> 2.11" }
    kubernetes = { source = "hashicorp/kubernetes", version = "~> 2.23" }
    tls        = { source = "hashicorp/tls", version = "~> 4.0" }
  }
}

provider "aws" {
  region = "us-west-2"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    command     = "aws"
  }
}

module "s3_backend" {
  source      = "./modules/s3-backend"
  bucket_name = var.bucket_name
  table_name  = var.dynamo_table_name
}

module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr_block     = var.vpc_cidr_block
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  vpc_name           = var.vpc_name
}

module "ecr" {
  source       = "./modules/ecr"
  ecr_name     = var.ecr_name
  scan_on_push = true
}

module "eks" {
  source       = "./modules/eks"
  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
}

module "rds" {
  source                 = "./modules/rds"
  use_aurora             = false
  identifier             = "final-db"
  db_name                = "django_db"
  username               = "admin"
  password               = var.db_password
  allocated_storage      = var.db_allocated_storage
  vpc_id                 = module.vpc.vpc_id
  vpc_cidr_block         = var.vpc_cidr_block
  subnet_ids             = module.vpc.private_subnet_ids
  engine                 = "postgres"
  engine_version         = "13.11"
  parameter_group_family = "postgres13"
  instance_class         = "db.t3.micro"
  multi_az               = false
  db_port                = 5432
}

# Створення Kubernetes Secret з обліковими даними БД для Argo CD
resource "kubernetes_secret" "django_db_secret" {
  metadata {
    name      = "django-db-secret"
    namespace = "default"
  }
  data = {
    POSTGRES_DB       = module.rds.db_name
    POSTGRES_USER     = module.rds.username
    POSTGRES_PASSWORD = var.db_password
    POSTGRES_HOST     = split(":", module.rds.db_endpoint)[0]
    POSTGRES_PORT     = "5432"
  }
  depends_on = [module.eks, module.rds]
}

module "jenkins" {
  source            = "./modules/jenkins"
  cluster_name      = module.eks.cluster_name
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_provider_url = module.eks.oidc_provider_url
  ecr_url           = module.ecr.repository_url
  depends_on        = [module.eks]
}

module "argo_cd" {
  source     = "./modules/argo_cd"
  depends_on = [module.eks]
}

module "monitoring" {
  source     = "./modules/monitoring"
  depends_on = [module.eks]
}
