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