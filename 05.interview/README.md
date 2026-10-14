# 05 — Interview refresh

Answer in a few sentences. Follow the link when you need the full note. Terraform **1.16** unless a feature says otherwise.

## Language

**What does Terraform do?**
It builds a dependency graph from HCL, diffs that graph against state and the live APIs, and makes the live APIs match the config.
→ [`04/01`](../04.advanced-terraform/01.huge-infra-mental-model.md)

**Resource vs data source?**
A resource is created and tracked in state. A data source is a read. Address: `aws_vpc.main` vs `data.aws_ami.al2023`.
→ [`00/07`](../00.get-started-with-terraform/07.work-with-data-sources.md)

**Variable vs local vs output?**
Variable: caller input. Local: a name computed inside the module (`local.name`). Output: exported to the caller or the CLI.
→ [`00/06`](../00.get-started-with-terraform/06.work-with-variables.md) · [`01/04`](../01.hashicorp-configuration-language/04.terraform-locals.md) · [`00/08`](../00.get-started-with-terraform/08.work-with-outputs.md)

**Variable precedence, highest first?**
`-var` / `-var-file` / HCP Terraform variables → `*.auto.tfvars` → `terraform.tfvars.json` → `terraform.tfvars` → `TF_VAR_*` → `default`.
→ [`00/06`](../00.get-started-with-terraform/06.work-with-variables.md)

**Why does `for_each` beat `count` for a list of users?**
`count` addresses are indexes. Inserting in the middle renumbers later objects and plans replacements. `for_each` addresses are keys (`aws_iam_user.this["ada"]`).
→ [`01/02`](../01.hashicorp-configuration-language/02.terraform-loops.md) · [`04/08`](../04.advanced-terraform/08.stable-addresses-count-and-for-each.md)

**When is `count` still right?**
A single optional resource: `count = var.enabled ? 1 : 0`.

**What is a splat?**
`aws_instance.web[*].id` turns a list of objects into a list of that attribute. Empty when `count` is 0.
→ [`01/06`](../01.hashicorp-configuration-language/06.expressions.md)

**Can I write my own function?**
No. Use locals, `templatefile`, or a provider-defined function (`provider::aws::...`, 1.8+).
→ [`01/05`](../01.hashicorp-configuration-language/05.terraform-builtin-functions.md)

## State and change

**Why does state exist?**
So Terraform knows which real object belongs to which address, and can refresh attributes without guessing from names.
→ [`00/09`](../00.get-started-with-terraform/09.terraform-state.md)

**What happens if I rename a resource and apply?**
Terraform plans destroy + create. Add a `moved` block in the same change. `terraform state mv` is the CLI form.
→ [`04/05`](../04.advanced-terraform/05.state-refactoring-moved-import.md)

**How do I adopt a bucket that already exists?**
Write the `resource` block and an `import` block (`to` + `id`), plan, apply, then delete the `import` block. 1.16 allows `import` inside modules.
→ [`04/05`](../04.advanced-terraform/05.state-refactoring-moved-import.md)

**How do I stop managing an object without deleting it?**
`removed { from = ... lifecycle { destroy = false } }` (1.7+), or `terraform state rm`.

**Does `sensitive` keep a password out of state?**
No. It redacts CLI output. Ephemeral values (1.10) and write-only arguments such as `password_wo` (1.11) stay out of state. Bump `password_wo_version` to rotate.
→ [`02/03`](../02.secrets-and-remote-state/03.working-with-secrets.md)

**How do I roll back?**
Revert the Git commit and apply that config. Restoring an old state file is break-glass. A destroyed database comes back from a backup, not from Git.
→ [`04/19`](../04.advanced-terraform/19.performance-and-day2-operations.md)

## Production shape

**How do you isolate dev and prod?**
One directory (one state) per environment, often one AWS account per environment. CLI workspaces share a directory and make the wrong apply easy.
→ [`04/06`](../04.advanced-terraform/06.multi-environment-strategies.md) · [`04/07`](../04.advanced-terraform/07.workspaces-when-and-when-not.md)

**How do stacks share a VPC id?**
Pass it as a variable, publish it to SSM, or read one or two outputs with `terraform_remote_state` (that also grants read access to the other state).
→ [`04/04`](../04.advanced-terraform/04.stack-communication.md)

**How do you version a module?**
Tag `v1.2.0` and set `source = "git::...?ref=v1.2.0"`. `ref=main` changes under you. The lockfile does not pin modules.
→ [`04/13`](../04.advanced-terraform/13.consume-modules-from-git.md) · [`04/12`](../04.advanced-terraform/12.version-pinning-and-lockfile.md)

**What do you commit?**
`.tf`, `.terraform.lock.hcl`, non-secret tfvars. Never `.terraform/`, `*.tfstate`, plan files, or credentials.
→ [`04/14`](../04.advanced-terraform/14.version-control-best-practices.md)

**What does CI do?**
PR: `fmt -check`, `validate`, lint, policy, `plan`. Merge: `apply` that plan for that root, with OIDC. One apply per state key.
→ [`04/16`](../04.advanced-terraform/16.ci-cd-and-gitops.md)

**What is drift?**
The cloud no longer matches state. Scheduled `terraform plan -detailed-exitcode` surfaces it (exit 2 = changes).

**Why avoid provisioners?**
They shell out during apply; the plan cannot show the result; a failed script leaves a half-configured machine. Prefer user data / cloud-init.
→ [`04/18`](../04.advanced-terraform/18.provisioners-and-terraform-data.md) · [`00/10`](../00.get-started-with-terraform/10.vm-command-at-startup.md)

**`depends_on` vs an attribute reference?**
`vpc_id = aws_vpc.main.id` orders the graph and passes the value. `depends_on` is for a hidden dependency.
→ [`04/09`](../04.advanced-terraform/09.lifecycle-and-dependency-graph.md)

**lifecycle arguments?**
`create_before_destroy`, `prevent_destroy`, `ignore_changes`, `replace_triggered_by`.
→ [`04/09`](../04.advanced-terraform/09.lifecycle-and-dependency-graph.md)

## One-liners

| Prompt | Answer | Deeper |
|---|---|---|
| Locking on S3 today | `use_lockfile = true`. DynamoDB locking is legacy. | [`02/01`](../02.secrets-and-remote-state/01.backend-and-remote-state.md) |
| Two people apply together | Backend lock blocks the second. | [`02/01`](../02.secrets-and-remote-state/01.backend-and-remote-state.md) |
| `-target` | Unblocks one address. Follow with a full plan. | [`04/09`](../04.advanced-terraform/09.lifecycle-and-dependency-graph.md) |
| `apply -replace=...` | Recreate one address (replaced `taint`). | [`00/04`](../00.get-started-with-terraform/04.working-with-terraform.md) |
| Backend and variables | `backend` takes literals only. | [`02/01`](../02.secrets-and-remote-state/01.backend-and-remote-state.md) |
| God module | Flags for VPC+EKS+app. Split by blast radius. | [`04/02`](../04.advanced-terraform/02.module-design-and-reuse.md) |
| OpenTofu | Fork of 1.5.x, MPL. Same HCL for interviews. | [`04/22`](../04.advanced-terraform/22.ecosystem.md) |
| Orchestrator | DRY roots and apply order. Does not replace modules. | [`04/20`](../04.advanced-terraform/20.orchestrators-terragrunt.md) |

Production checklist: [`04/21`](../04.advanced-terraform/21.anti-patterns-and-checklist.md). Topic index: [root README](../README.md).
