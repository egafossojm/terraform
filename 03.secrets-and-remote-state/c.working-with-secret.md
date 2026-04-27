# Secrets In terraform

### 1. AWS Secret Manager
1. Create a database secret in your AWS account
- call the secret **db_secrets** for example.
- In plaintext the secret should look like:
```json
{
    "username": "user",
    "password": "pass"
}
```
- In terraform configuration, add a data source for your secret and use it set db user and password.
```tf
data "aws_secretsmanager_secret_version" "creds"{
  secret_id = "db_secrets"
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}

resource "aws_db_instance" "default" {
  allocated_storage = 10
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.micro"
  db_name = "mydb"
  username = local.db_creds.username
  password = local.db_creds.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot = true
  
}
```

### 2. Hashicorp Vault