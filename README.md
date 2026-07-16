# Final DevOps Project

Ця архітектура повністю відповідає production-стандартам:

- **Безпека:** Відсутність паролів у Helm, використання `Kubernetes Secrets` для підключення до RDS, налаштовано EKS Security Groups. Паролі передаються через схований `terraform.tfvars`. ECR URL передається автоматично через Jenkins JCasC (Global variables).
- **Стійкість:** Pod Probes переведено на `tcpSocket` для запобігання CrashLoopBackOff при 404 помилках Django.
- **Повний Стек:** Інтегровано VPC, EKS, RDS, ECR, Jenkins, ArgoCD, Prometheus, Grafana.

## 📝 Крок 1. Підготовка Terraform Backend

Оскільки `backend.tf` має бути розкоментованим, виконайте ініціалізацію локально і відразу створіть бакет S3.
_Увага: у файлі `main.tf` вже повністю налаштовано генерацію Kubernetes Secret (`django-db-secret`), який бере дані прямо з `module.rds` і використовується в Deployment._

1. **Тимчасово закоментуйте** весь блок `backend "s3"` у файлі `backend.tf`.
2. Виконайте:
   ```bash
   terraform init
   terraform apply -target=module.s3_backend -auto-approve
   	1.	Розкоментуйте блок backend "s3" у backend.tf.
   	2.	Мігруйте стейт у хмару:
   terraform init -migrate-state
   ```

🚀 Крок 2. Розгортання інфраструктури 1. Відформатуйте код:
terraform fmt -recursive
terraform validate

    2.	Розгорніть усю інфраструктуру:

terraform apply -auto-approve

🔄 Крок 3. Налаштування CI/CD та Запуск 1. Запуште згенеровані файли на ваш GitHub репозиторій. 2. Підключіться до Jenkins:
kubectl port-forward svc/jenkins 8080:8080 -n jenkins

(Пароль адміністратора можна отримати: kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo) 3. Обов'язково додайте ваші GitHub Credentials у Jenkins (ID: github-creds). 4. Створіть та запустіть Pipeline з файлу Django/Jenkinsfile.

📊 Крок 4. ArgoCD та Моніторинг
ArgoCD автоматично підхопить новий тег, який Jenkins запушить у репозиторій, і оновить поди. 1. Перевірка стану кластера:
kubectl get all -n jenkins
kubectl get all -n argocd
kubectl get all -n monitoring

    2.	Підключення до Grafana:

kubectl port-forward svc/grafana 3000:80 -n monitoring
