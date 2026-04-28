# Terraform Backends and remote state management

- Terraform is a `statefull` app.(It keeps track of everything it does in the cloud environment)
- When you run `terraform plan` or `terraform apply`, terraform refresh to **Update the state** will the real infrastructure.
- `terraform.tfstate` is the local state file. There is also a its backup called `terraform.tfstate.backup` in the same folder.
- This is created for **Testing** or **Development** or if you are **working alone**.

In production there are several problems working with local state file:

### 1. Concurrency
**PROBLEM**: If 2 or more people run terraform at the same time, The current changes will not be seen, AND the state file can get corrupted.

**SOLUTION**: It needs locking mechanism to avoid running into race conditions -> Store the state remotely using the correct **backend**.

### 2. Backends

#### a. Definition
- Each terraform configuration has an associated backend that defines how operations are executed and where the terraform state is stores.
- The default backend is a plain file in the current working directory.

#### b. Remote state
- With a remote state, terraform writes the state to a remote backend or data store, which can then between all members of your team.
- Terraform support storing state on many backends such as, S3, AzureRM, Consul, GCS, Kubernetes, etc... ([Documentation](https://developer.hashicorp.com/terraform/language/backend/)).

#### C. Configure S3 backend
- First ceate a bucket with `versioning` and `encryption` enabled. Note it region.
- Got to the [documentation](https://developer.hashicorp.com/terraform/language/backend/s3) and get the configuration template.

EX: **Method One**
```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

terraform {
    backend "s3" {
    bucket = "terraform-mastering-123456789123-ca-central-1-an"
    key    = "s3_backend.tfstate"
    region = "ca-central-1"
  }
 }
```

```bash
$ terraform init
```

EX: **Method two**
```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "terraform-mastering-123456789123-ca-central-1-an"
    key    = "s3_backend.tfstate"
    region = "ca-central-1"
  }
}
```

```bash
$ terraform init
```

- You can also configute the terraform block is a separated `.tf` file.

>[!WARNING]
>
> You cannot use variables in the terraform block

- We are now using the remote state.
- The local state can be deleted !

#### d. Remote state locking[DEPRECATED]

- **Remote state locking** prevents race conditions and state corruption by allowing only one user to run Terraform at a time.
>[!NOTE]
> State locking is enable by default on local state.

- Enable S3 remote state locking:

**Step1**

- Create an Amazon DynamoDB table.
- Give it a name
- Partion key MUST be `LockID` of type string, with this exact spelling and case.

**Step2**

- Set terraform to use DynamoDB Table by givieng its name.
```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
    backend "s3" {
    bucket = "terraform-mastering-123456789123-ca-central-1-an"
    dynamodb_table = "terraform_s3_backend_lock"
    key    = "s3_backend.tfstate"
    region = "ca-central-1"
  }
}
 ```

 **Step3**
 - Reconfigure the backend
```bash
terraform init -reconfigure
```

#### e. Remote state locking [UPDATED]
- Using DynamoDB is now deprecated.
- S3 now supports State locking
- In congiguration, you juste need to set `use_lockfile = true`

```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
    backend "s3" {
    bucket = "terraform-mastering-123456789123-ca-central-1-an"
    key    = "s3_backend.tfstate"
    use_lockfile = true
    region = "ca-central-1"
  }
}
```
