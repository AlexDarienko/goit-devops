# Final DevOps Project

Цей репозиторій містить фінальну інфраструктуру: AWS VPC, EKS, RDS, ECR, Jenkins, Argo CD, Prometheus та Grafana.

## Інструкція з розгортання

1.  Створіть S3 бекенд, а потім мігруйте стейт (розкоментувавши код у backend.tf):
    terraform apply -target=module.s3_backend -auto-approve
    terraform init -migrate-state

2.  Розгорніть всю інфраструктуру:

    terraform apply -auto-approve

3.  Важливо: Після розгортання скопіюйте вихідне значення database_endpoint та вставте його у файл charts/django-app/values.yaml (поле POSTGRES_HOST). Після цього зробіть git push.

    Перевірка
    Усі необхідні команди (kubectl port-forward, тощо) можна знайти в кореневому файлі завдань.
    Логін та пароль до Grafana: admin / admin.
