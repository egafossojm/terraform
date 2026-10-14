# 03 — Modules

A module is a directory of `.tf` files you call like a function. The directory you apply is the root. Every `module` block pulls in a child.

Modules give you one implementation of a VPC or a service, called from dev and prod with different arguments.

```text
03.terraform-module/
  modules/vpc/         # child
  modules/ec2/         # child
  modules/iam-users/   # child
  project/             # root (main.tf calls the three modules)
```

## Call a local module

```hcl
module "vpc1" {
  source         = "../modules/vpc"
  vpc_cidr_block = var.vpc1_cidr_block
  web_subnet     = var.vpc1_web_subnet
  enable_dns     = var.vpc1_enable_dns
}

module "my_vm" {
  source             = "../modules/ec2"
  instance_type      = var.instance_type
  vpc_subnet_id      = module.vpc1.subnet_id
  security_group_id  = module.vpc1.default_sg_id
}
```

`terraform init` after you add or change a `source`. Outputs of the child are `module.vpc1.subnet_id`.

## Layout of a child

| File | Role |
|---|---|
| `versions.tf` | `required_providers` for this module |
| `variables.tf` | The module's arguments. No defaults on values that must differ per caller. |
| `main.tf` | Resources |
| `outputs.tf` | IDs and ARNs the caller needs |
| `README.md` | What it creates and an example `module` block |

A child with no `required_providers` inherits the root's providers. Declare them in the child anyway so the module documents which providers it needs.

## Sources

| Source | Example |
|---|---|
| Local path | `source = "../modules/vpc"` |
| Registry | `source = "terraform-aws-modules/vpc/aws"` plus `version = "~> 5.0"` |
| Git tag | `source = "git::https://github.com/org/terraform-aws-vpc.git?ref=v1.2.0"` |

Git sources, pinning, and why a Git submodule is the wrong tool:
[`04/13`](../04.advanced-terraform/13.consume-modules-from-git.md) · [`04/15`](../04.advanced-terraform/15.git-submodules-vs-terraform-source.md).

## Design in one page

- One module, one job. A module that creates the VPC, the cluster, and the app becomes a single blast radius.
- Roots stay thin: backend, provider, variables, module calls.
- `backend` blocks stay in the root. A shared module must not pick the state location.
- Pin remote modules. A local path is fine inside one repo while the team is small.
- Publish outputs that are a contract (`vpc_id`, `private_subnet_ids`). Callers should not reach into `module.vpc.aws_vpc.this`.

Design rules for large estates: [`04/02`](../04.advanced-terraform/02.module-design-and-reuse.md).

Previous: [`02.secrets-and-remote-state`](../02.secrets-and-remote-state/README.md). Next: [`04.advanced-terraform`](../04.advanced-terraform/README.md).
