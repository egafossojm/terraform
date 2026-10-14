# 02 — State and secrets

Where state lives, how it locks, and how secrets stay out of Git and state.

| File | Topic |
|---|---|
| [`01.backend-and-remote-state.md`](01.backend-and-remote-state.md) | S3 backend, `use_lockfile`, migrate |
| [`02.hcp-terraform.md`](02.hcp-terraform.md) | `cloud` block, workspaces, OIDC |
| [`03.working-with-secrets.md`](03.working-with-secrets.md) | `sensitive` vs ephemeral vs `password_wo` |

Local `terraform.tfstate` is for a solo lab. Production needs a remote backend before a second person runs `apply`.

Next: [`03.terraform-module`](../03.terraform-module/README.md).
