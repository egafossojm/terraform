# Advanced Terraform

This chapter is about **writing and deploying huge infrastructure**.

The earlier chapters taught syntax, state, secrets, and modules. Here the hard problems are different:

- **State blast radius** (one apply should not touch the whole company)
- **Multi environment** (dev / staging / prod without copy-paste disasters)
- **Code reuse** (modules as a library, not a god file)
- **Version control** (how Git, tags, and CI fit with Terraform)
- **Day-2 operations** (rename, import, upgrade, rollback)

## How to read this folder

Read the files **in order**. Each lesson assumes the previous ones.

| File | Topic |
|---|---|
| `01.huge-infra-mental-model.md` | How Terraform really works at scale |
| `02.module-design-and-reuse.md` | Design reusable modules (not god modules) |
| `03.split-state-and-blast-radius.md` | Split state so one apply cannot break everything |
| `04.stack-communication.md` | How stacks pass IDs to each other |
| `05.state-refactoring-moved-import.md` | Rename, import, remove without recreate |
| `06.multi-environment-strategies.md` | Dev / staging / prod layouts |
| `07.workspaces-when-and-when-not.md` | CLI workspaces vs directories |
| `08.stable-addresses-count-and-for-each.md` | Why `for_each` + maps keep state stable |
| `09.lifecycle-and-dependency-graph.md` | `lifecycle`, `depends_on`, checks |
| `10.multi-account-and-provider-aliases.md` | Multi account / multi region |
| `11.variables-validation-and-sensitive.md` | Typed inputs, validation, secrets in variables |
| `12.version-pinning-and-lockfile.md` | Pin Terraform, providers, modules |
| `13.consume-modules-from-git.md` | Use module GitHub repos with `ref=` |
| `14.version-control-best-practices.md` | Repo layout, branches, what to commit |
| `15.git-submodules-vs-terraform-source.md` | When `git submodule add` is (not) the tool |
| `16.ci-cd-and-gitops.md` | Plan on PR, apply on merge |
| `17.testing-policy-and-cost.md` | `terraform test`, lint, policy, cost |
| `18.provisioners-and-terraform-data.md` | Why provisioners are last resort |
| `19.performance-and-day2-operations.md` | Fast plans, import, rollback |
| `20.orchestrators-terragrunt.md` | Terragrunt / Atmos when roots explode |
| `21.anti-patterns-and-checklist.md` | What not to do + a target skeleton |

>[!NOTE]
>
> You already learned local modules in `04.terrform-module` and remote state in `03.secrets-and-remote-state`. This chapter **reuses** those ideas and shows how they change when the infra is large.
