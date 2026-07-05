# goit-devops

# Lesson 7: Kubernetes (EKS) & Helm

Цей репозиторій містить Terraform-код для підняття EKS кластера та Helm-чарт для розгортання Django-застосунку.

## Кроки:

1. `terraform init` та `terraform apply`
2. Завантаження образу Django в ECR.
3. Підключення до кластера: `aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks`
4. Розгортання чарта: `helm install my-django-app ./charts/django-app`
