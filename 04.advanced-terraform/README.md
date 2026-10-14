# 04 — Advanced Terraform

Syntax and modules are behind you. Here the hard problems are **state boundaries**, **environments**, **reuse**, and **change**.

Read in order. Each note assumes the previous ones.

| File | Topic |
|---|---|
| [`01.huge-infra-mental-model.md`](01.huge-infra-mental-model.md) | Terraform as a desired-state compiler |
| [`02.module-design-and-reuse.md`](02.module-design-and-reuse.md) | Building-block vs pattern vs root |
| [`03.split-state-and-blast-radius.md`](03.split-state-and-blast-radius.md) | One apply = one state |
| [`04.stack-communication.md`](04.stack-communication.md) | Pass IDs between stacks |
| [`05.state-refactoring-moved-import.md`](05.state-refactoring-moved-import.md) | `moved`, `import`, `removed` |
| [`06.multi-environment-strategies.md`](06.multi-environment-strategies.md) | Dev / staging / prod layouts |
| [`07.workspaces-when-and-when-not.md`](07.workspaces-when-and-when-not.md) | CLI workspaces vs directories |
| [`08.stable-addresses-count-and-for-each.md`](08.stable-addresses-count-and-for-each.md) | Why maps keep state stable |
| [`09.lifecycle-and-dependency-graph.md`](09.lifecycle-and-dependency-graph.md) | `lifecycle`, `depends_on`, checks |
| [`10.multi-account-and-provider-aliases.md`](10.multi-account-and-provider-aliases.md) | Multi account / multi region |
| [`11.variables-validation-and-sensitive.md`](11.variables-validation-and-sensitive.md) | Validation, `sensitive`, precedence |
| [`12.version-pinning-and-lockfile.md`](12.version-pinning-and-lockfile.md) | Pin CLI, providers, modules |
| [`13.consume-modules-from-git.md`](13.consume-modules-from-git.md) | `git::...?ref=vX.Y.Z` |
| [`14.version-control-best-practices.md`](14.version-control-best-practices.md) | Repo layout, what to commit |
| [`15.git-submodules-vs-terraform-source.md`](15.git-submodules-vs-terraform-source.md) | Submodules are not module `source` |
| [`16.ci-cd-and-gitops.md`](16.ci-cd-and-gitops.md) | Plan on PR, apply on merge |
| [`17.testing-policy-and-cost.md`](17.testing-policy-and-cost.md) | `terraform test`, lint, policy, cost |
| [`18.provisioners-and-terraform-data.md`](18.provisioners-and-terraform-data.md) | Provisioners as last resort |
| [`19.performance-and-day2-operations.md`](19.performance-and-day2-operations.md) | Fast plans, import, rollback |
| [`20.orchestrators-terragrunt.md`](20.orchestrators-terragrunt.md) | Terragrunt / Atmos |
| [`21.anti-patterns-and-checklist.md`](21.anti-patterns-and-checklist.md) | What not to do + checklist |
| [`22.ecosystem.md`](22.ecosystem.md) | Terraform, OpenTofu, tooling |

Earlier foundations: [modules](../03.terraform-module/README.md), [remote state](../02.secrets-and-remote-state/README.md).

Next: [`05.interview`](../05.interview/README.md).
