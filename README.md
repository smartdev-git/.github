# Smartdev GitHub Defaults

This repository centralizes the default community health files for `smartdev-git`.

## Bug reporting

Use the `Bug report` form from any repository that does not define its own local templates.

Issues created from the shared bug form will:
- use the `bug` issue type
- apply the `bug` and `needs-triage` labels
- be added to the `Smartdev Bug Triage` project

Project URL: https://github.com/orgs/smartdev-git/projects/1

## Team backlog

General team backlog tasks do not go here.

Use the private backlog repository instead:
- https://github.com/smartdev-git/team-backlog

Those tasks feed the `Smartdev Team Backlog` project:
- https://github.com/orgs/smartdev-git/projects/2

## Base labels

- `bug`
- `needs-triage`
- `blocked`
- `duplicate`

## Future repositories and repo renames

The shared issue form already applies automatically to future repositories unless they define their own local templates.

To keep labels and `has_issues=true` aligned for newly created repositories or renamed repositories, this repo includes the workflow `Sync org issue standards`.

## Required secret

Add the repository secret `SMARTDEV_ORG_ADMIN_TOKEN` in `smartdev-git/.github`.

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

## Running the sync

The workflow runs every day and can also be launched manually.

Manual options:
- normal run: applies labels and enables Issues where needed
- dry run: prints the intended changes without modifying repositories