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
