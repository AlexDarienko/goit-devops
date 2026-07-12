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

# Lesson 8-9: CI/CD Pipeline (Jenkins + ArgoCD)

## Як застосувати Terraform:

1. Оновіть `modules/argo_cd/charts/values.yaml` та `Jenkinsfile` - вставте свій GitHub репозиторій та AWS Account ID.
2. `terraform init -backend=false`
3. `terraform apply -target=module.s3_backend`
4. Розкоментуйте `backend.tf`, виконайте `terraform init -migrate-state`
5. `terraform apply`

## Як перевірити Jenkins job:

1. Отримайте пароль: `kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo`
2. Отримайте URL: `kubectl get svc -n jenkins`
3. Створіть Pipeline Job, вкажіть шлях до репозиторію та файлу `Jenkinsfile`.
4. Запустіть Build. Kaniko збере образ і запушить в ECR, а потім Git-агент оновить `values.yaml`.

## Як побачити результат в Argo CD:

1. Отримайте пароль ArgoCD: `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
2. Отримайте URL: `kubectl get svc -n argocd argocd-server`
3. Відкрийте UI. Ви побачите Application `django-app`, який автоматично підтягнув новий тег образу з Git і розгорнув його в кластері.

# Lesson 10: Гнучкий модуль для баз даних (RDS / Aurora)

## Опис модуля `rds`

Модуль призначений для розгортання баз даних у AWS із підтримкою двох режимів роботи. Він інкапсулює у собі створення Security Groups, Subnet Groups та кастомних Parameter Groups.

### Приклад використання у `main.tf`

```hcl
module "rds" {
  source                 = "./modules/rds"
  use_aurora             = false
  identifier             = "lesson-10-db"
  db_name                = "django_db"
  username               = "admin"
  password               = "SuperSecretPassword123!"
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

Як змінити тип бази даних
	1.	Звичайна RDS PostgreSQL: Встановіть use_aurora = false, engine = "postgres", parameter_group_family = "postgres13".
	2.	AWS Aurora PostgreSQL: Встановіть use_aurora = true, engine = "aurora-postgresql", parameter_group_family = "aurora-postgresql13".
	3.	RDS MySQL: Встановіть use_aurora = false, engine = "mysql", parameter_group_family = "mysql8.0", db_port = 3306.
Опис змінних
•	use_aurora (bool) — Ключова змінна логіки.
•	identifier (string) — Унікальний ідентифікатор для інстансу та супутніх ресурсів.
•	db_name, username, password (string) — Базові кредо для бази даних.
•	engine, engine_version (string) — Тип рушія БД та його версія.
•	parameter_group_family (string) — Визначає сімейство параметрів.
•	vpc_cidr_block (string) — Використовується для налаштування Ingress Security Group.
```
