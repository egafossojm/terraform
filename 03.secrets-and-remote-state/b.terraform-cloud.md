# Terraform cloud
This is a good alternative to Amazon S3 to keep your state file secured and shared with your team.

## Step1: Sign up for a free terraform cloud account
- Got to https://app.terraform.io/login/new
- Fill the Username, Email and Password and hit `Create Terraform account`.
- Activate your account by the link sent to your Email
- Log into your terraform account.

## Step2: Create or Join an Organization
You can join an existing organization if someone has invited you.

Let's create one:
- Go to `Organozations` and hit `+ Create organization`
- Choose between `Business` and `Personal` organization type.
- Give the organization a name and **Create organization**(The name must be uniq)

## Step3: Understand Terraform Workspaces 
- The persistent data stored in a backend, belongs to a workspace.
- By default terraform starts with a single workspace named `default`.
- If you never specified a workspace, Then you are working in the default workspace.
- The default workspace cannot be deleted.
- There are backends (like Terraform cloud), that support multiple name worspaces

View the current workspace
```bash
$ terraform workspace show
default
```

## Step4: Add Terraform Cloud to your local configuration

**1. Add the configuration block**
```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  cloud {
    organization = "terraform-zero-to-mastery" # Must alreasy exist
    workspaces {
      name = "DevOps-Prod"
    }
  }
}
```
>[!NOTE]
>
> - No problem if the workspace does not already exist. But if it exists, Should not contains any state file.
> - `cloud bock` and `backend block` cannot exist together.
> - Unlike local Terraform, which uses the **default** workspace by default, Terraform Cloud requires you to explicitly define a workspace.

**2. Authenticate to Terraform Cloud**
- Got to the terminal and run 
```bash
$ terraform login
```
- Answer **yes** to prompt to proceed
- A new browser window will be automatically opened to terraform cloud
- Generate token(Give it a **Description** and an **Expiration time**)
- Copy the generated token and paste it in the console prompt to continue(For security, the pasted token will not be shown in the console, just press Enter to continue)
- You now have access to terraform backend (The prompt will show **Welcome to HCP Terraform!**)

>[!NOTE]
>
> This has created a json file with the credentials in the user home directory:
> ```bash
> $ cat ~/.terraform.d/credentials.tfrc.json 
> {
>   "credentials": {
>     "app.terraform.io": {
>       "token": "TOKEN_SECRET"
>     }
>   }
> }
>
> - This token provides acces to your terraform cloud organisation

**3. Initialize Terraform cloud and providers**
```bash
$ terraform init
Initializing HCP Terraform...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/template from the dependency lock file
- Using previously-installed hashicorp/aws v6.41.0
- Using previously-installed hashicorp/template v2.2.0

HCP Terraform has been successfully initialized!
```
- You can now run terraform plan and terraform apply, and the state file will be stored in terraform cloud.

**4. Configure AWS Credentials in Terraform Cloud**

>[!NOTE]
>
> Terraform is now configured for remote execution on Terraform Cloud. Ensure that the necessary Cloud credentials and permissions are configured within the workspace."

**Method 1: Set Access Keys**

- Go to *Terraform Cloud > Workspaces > Workspace-Name > Variables > Add variable*
- **Select variable category** : Environment variable
- **Key** : AWS_ACCESS_KEY_ID
- **Value** : AWS_ACCESS_KEY_ID_VALUE
- Same for AWS_SECRET_ACCESS_KEY and AWS_DEFAULT_REGION.

**Method 2: Set up AWS dynamic credentials** (RECOMMENDED)

- Go to AWS Console
- Create the OIDC Identity Provider in AWS(Provider URL: https://app.terraform.io, Audience: **aws.workload.identity**)
- Create the IAM Role with the Trust Policy below
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::123456789012:oidc-provider/app.terraform.io"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "app.terraform.io:aud": "aws.workload.identity"
        },
        "StringLike": {
          "app.terraform.io:sub": "organization:YOUR_ORG_NAME:project:YOUR_PROJECT:workspace:YOUR_WORKSPACE:run_phase:*"
        }
      }
    }
  ]
}
```
- YOUR_PROJECT is **Default Project** by default. you can set yours.
- Add required permissions to the role 
- Go to *Terraform Cloud > Workspaces > Workspace-Name > Variables*
- Configure Terraform Cloud Environment Variables(`TFC_AWS_PROVIDER_AUTH`=`true`, `TFC_AWS_RUN_ROLE_ARN`=`arn:aws:iam::123456789012:role/YourTerraformRoleName`


