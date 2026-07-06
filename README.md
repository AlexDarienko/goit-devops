# goit-devops

# Lesson 5: Infrastructure as Code (Terraform)

Цей проєкт автоматизує розгортання базової інфраструктури в AWS за допомогою Terraform.

## Структура проєкту

.
├── main.tf # Головний файл конфігурації та виклику модулів
├── backend.tf # Конфігурація віддаленого стейту (S3 + DynamoDB)
├── outputs.tf # Кореневі вихідні змінні
├── modules/
│ ├── s3-backend/ # Створення бакета стейтів та таблиці блокування
│ ├── vpc/ # Мережа: VPC, Subnets, IGW, NAT, Маршрутизація
│ └── ecr/ # Контейнерний реєстр для Docker-образів
└── README.md # Документація

## Інструкція з розгортання (Bootstrap)

1. Переконайтеся, що файл `backend.tf` закоментований.
2. Виконайте ініціалізацію з локальним стейтом: `terraform init`
3. Створіть ресурси: `terraform apply`
4. Після успішного створення розкоментуйте вміст файлу `backend.tf`.
5. Виконайте міграцію локального стейту в AWS S3: `terraform init -migrate-state`

## Команди

- `terraform plan` — Перегляд змін
- `terraform apply` — Застосування конфігурації
- `terraform destroy` — Видалення інфраструктури

# Lesson 7: Kubernetes (EKS) & Helm

Цей репозиторій містить Terraform-код для підняття EKS кластера та Helm-чарт для розгортання Django-застосунку.

## Кроки:

1. `terraform init` та `terraform apply`
2. Завантаження образу Django в ECR.
3. Підключення до кластера: `aws eks update-kubeconfig --region us-west-2 --name lesson-7-eks`
4. Розгортання чарта: `helm install my-django-app ./charts/django-app`
