# Terraform reference

Short notes for **Terraform 1.16** and the **AWS provider 6.x**. OpenTofu speaks the same language; names here follow Terraform CLI and HCP Terraform.

Each file is a cheatsheet: the idea, a pattern to copy, and the detail interviews usually probe.

## Learning path

Read the folders in order. Every folder has a `README.md` that lists its notes.

| # | Folder | After this you can |
|---|---|---|
| 00 | [`get-started`](00.get-started-with-terraform/README.md) | Install, write a root, run init/plan/apply, auth to AWS, use variables and state |
| 01 | [`HCL`](01.hashicorp-configuration-language/README.md) | Types, loops, conditions, locals, expressions, common functions |
| 02 | [`state and secrets`](02.secrets-and-remote-state/README.md) | Remote state, locking, HCP Terraform, secrets that stay out of state |
| 03 | [`modules`](03.terraform-module/README.md) | Split a config into local modules (`project/` + `modules/`) |
| 04 | [`advanced`](04.advanced-terraform/README.md) | Split state, multi-env, pin modules, CI/CD, day-2 ops |
| 05 | [`interview`](05.interview/README.md) | Answer the usual questions from memory |

## Find by topic

Shorthand `04/05` means folder `04`, file `05`.

| Looking for… | Open |
|---|---|
| Install / pin CLI | [`00/01`](00.get-started-with-terraform/01.install-terraform.md) |
| File layout (`main.tf`, lockfile) | [`00/02`](00.get-started-with-terraform/02.terraform-code-structure.md) |
| Providers | [`00/03`](00.get-started-with-terraform/03.terraform-providers.md) |
| `init` `plan` `apply` `fmt` `validate` | [`00/04`](00.get-started-with-terraform/04.working-with-terraform.md) |
| AWS credentials / OIDC | [`00/05`](00.get-started-with-terraform/05.authenticating-to-aws.md) |
| Variables and precedence | [`00/06`](00.get-started-with-terraform/06.work-with-variables.md) · [`04/11`](04.advanced-terraform/11.variables-validation-and-sensitive.md) |
| Data sources | [`00/07`](00.get-started-with-terraform/07.work-with-data-sources.md) |
| Outputs | [`00/08`](00.get-started-with-terraform/08.work-with-outputs.md) |
| State file / `state list` | [`00/09`](00.get-started-with-terraform/09.terraform-state.md) |
| User data / cloud-init | [`00/10`](00.get-started-with-terraform/10.vm-command-at-startup.md) |
| Debugging / `TF_LOG` | [`00/11`](00.get-started-with-terraform/11.troubleshooting.md) |
| Types (`list`, `map`, `object`) | [`01/01`](01.hashicorp-configuration-language/01.terraform-types.md) |
| `count` / `for_each` / `dynamic` | [`01/02`](01.hashicorp-configuration-language/02.terraform-loops.md) · [`04/08`](04.advanced-terraform/08.stable-addresses-count-and-for-each.md) |
| Conditionals | [`01/03`](01.hashicorp-configuration-language/03.conditional-expressions.md) |
| Locals | [`01/04`](01.hashicorp-configuration-language/04.terraform-locals.md) |
| Functions (`merge`, `cidrsubnet`, …) | [`01/05`](01.hashicorp-configuration-language/05.terraform-builtin-functions.md) |
| `for`, splat, `try` | [`01/06`](01.hashicorp-configuration-language/06.expressions.md) |
| S3 backend / `use_lockfile` | [`02/01`](02.secrets-and-remote-state/01.backend-and-remote-state.md) |
| HCP Terraform (`cloud` block) | [`02/02`](02.secrets-and-remote-state/02.hcp-terraform.md) |
| Secrets / ephemeral / `password_wo` | [`02/03`](02.secrets-and-remote-state/03.working-with-secrets.md) |
| Local modules | [`03`](03.terraform-module/README.md) |
| Blast radius / split state | [`04/03`](04.advanced-terraform/03.split-state-and-blast-radius.md) |
| Stack-to-stack IDs | [`04/04`](04.advanced-terraform/04.stack-communication.md) |
| `moved` / `import` / `removed` | [`04/05`](04.advanced-terraform/05.state-refactoring-moved-import.md) |
| Dev / staging / prod | [`04/06`](04.advanced-terraform/06.multi-environment-strategies.md) |
| Workspaces (CLI vs HCP) | [`04/07`](04.advanced-terraform/07.workspaces-when-and-when-not.md) |
| `lifecycle` / `depends_on` | [`04/09`](04.advanced-terraform/09.lifecycle-and-dependency-graph.md) |
| Multi-account / aliases | [`04/10`](04.advanced-terraform/10.multi-account-and-provider-aliases.md) |
| Pin versions / lockfile | [`04/12`](04.advanced-terraform/12.version-pinning-and-lockfile.md) |
| Module from Git (`ref=`) | [`04/13`](04.advanced-terraform/13.consume-modules-from-git.md) |
| CI / GitOps | [`04/16`](04.advanced-terraform/16.ci-cd-and-gitops.md) |
| `terraform test` / policy / cost | [`04/17`](04.advanced-terraform/17.testing-policy-and-cost.md) |
| Provisioners | [`04/18`](04.advanced-terraform/18.provisioners-and-terraform-data.md) |
| Terragrunt / Atmos | [`04/20`](04.advanced-terraform/20.orchestrators-terragrunt.md) |
| Anti-patterns + checklist | [`04/21`](04.advanced-terraform/21.anti-patterns-and-checklist.md) |
| Terraform vs OpenTofu vs tools | [`04/22`](04.advanced-terraform/22.ecosystem.md) |
| Interview Q&A | [`05`](05.interview/README.md) |

## How to use this repo

1. **Refreshing** — walk `00` → `05` once. Skip notes you already know.
2. **Looking something up** — use **Find by topic** above, or open a folder `README.md`.
3. **Interview day** — start at [`05.interview`](05.interview/README.md); follow the link under each answer for depth.
4. **Hands-on** — apply [`03.terraform-module/project`](03.terraform-module/project) in a sandbox AWS account.
