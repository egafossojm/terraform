# Terrraform modules

## Why terraform modules
With compolex configurations, Issues courls arrive:
- Updates may cause problems in different parts of your configuration.
- You will repeat parts of your configuration. (EX: Dev, Staging and prod). 
- Sharing part of your configuration implies copy and paste, This results to errors

Modules will:
- Orginize configuration
- Encapsulate configuration
- Re-use configuration
- Provide consistency
- Ensure best practices

## What is Terraform module
- It is a concept who helps with DRY (Do not Repeat Yourself)
- It is like functions in programming languages
- **A terraform module** is a set of configuration files in a single directory.
- They are the key to writing reusable, maintenanble and testable Terraform code.
- The directory in which you run `terraform plan` or `terraform apply` is considered as the **Root Module**.
- Modules imported in the root module are called **Child modules**.

## Types of modules
### 1. Local modules
- Local modules are loaded in the local file system.
- They are generally created by yourself or your team members.
- They are organized and encapsulated in your code.

### 2. Romote modules
- Remote modules are loaded from a remote source such as **Terraform registry**.
- They are created and maintained by Hashicrop, Its partners or by a third party.

### 3. Notes about modules

> [!NOTE]
>
> It is good practice to start building everything as a module, create libraries of modules to share with your team and Start thinking from the begining of your entire infrastructure as collections of reusable modules.


>[!NOTE]
>
> - If `required_providers` block is not added in the child module configuration, the child module will inherit the root module configurations by default.
> - It is good practice to specify in each child module its required providers for compatibility.
> - Any time you import a module into the root module, you should run `terraform init`




