# Smartdev GitHub Defaults

This repository centralizes the default community health files for `smartdev-git`.

## Backlog intake

Operational work items no longer live in this repository.

Use the private backlog repository instead:
- https://github.com/smartdev-git/team-backlog

That repository is now the single intake point for:
- bugs
- tasks
- features

Those items feed the `Smartdev Team Backlog` project:
- https://github.com/orgs/smartdev-git/projects/2

This repository only keeps the shared standards and redirects the issue chooser to `team-backlog`.

## Base labels

- `bug`
- `needs-triage`
- `blocked`
- `duplicate`

## Future repositories and repo renames

To keep base labels and `has_issues=true` aligned for newly created repositories or renamed repositories, this repo includes the workflow `Sync org issue standards`.

## Required secret

Add `SMARTDEV_ORG_ADMIN_TOKEN` as either:
- a repository secret in `smartdev-git/.github`
- an organization secret shared with `smartdev-git/.github`

Recommended token type:
- classic personal access token

Recommended scopes:
- `repo`
- `read:org`

Why these scopes:
- `repo` lets the workflow update repository settings and labels across private repositories.
- `read:org` lets the workflow enumerate current repositories in the organization, so new repos and renamed repos are picked up automatically.

Where to add it:
- `smartdev-git/.github` -> `Settings` -> `Secrets and variables` -> `Actions` -> `New repository secret`

If you prefer an organization secret:
- `smartdev-git` organization -> `Settings` -> `Secrets and variables` -> `Actions`
- grant access to the `.github` repository

## Running the sync

The workflow runs every day and can also be launched manually.

Manual options:
- normal run: applies labels and enables Issues where needed
- dry run: prints the intended changes without modifying repositories

## Troubleshooting

If the workflow fails in `Validate admin token`:
- `Missing SMARTDEV_ORG_ADMIN_TOKEN`: the secret is not configured for the `.github` repository context.
- `Invalid SMARTDEV_ORG_ADMIN_TOKEN`: the secret exists but GitHub CLI could not authenticate with it.
- `Insufficient token access`: the token authenticated, but it cannot list organization repositories. Check `repo`, `read:org`, and any required SSO authorization.
