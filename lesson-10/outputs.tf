output "ecr_repository_url" { value = module.ecr.repository_url }
output "eks_cluster_name" { value = module.eks.cluster_name }
output "database_endpoint" { value = module.rds.db_endpoint }
output "jenkins_url" { value = module.jenkins.jenkins_url }
output "argocd_url" { value = module.argo_cd.argocd_url }
