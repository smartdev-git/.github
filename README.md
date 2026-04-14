# Smartdev GitHub Defaults

This repository centralizes the default community health files for `smartdev-git`.

## Bug reporting

Use the `Bug report` form from any repository that does not define its own local templates.

Issues created from the shared bug form will:
- use the `bug` issue type
- apply the `bug` and `needs-triage` labels
- be added to the `Smartdev Bug Triage` project

Project URL: https://github.com/orgs/smartdev-git/projects/1

## Base labels

- `bug`
- `needs-triage`
- `blocked`
- `duplicate`

## Future repositories and repo renames

The shared issue form already applies automatically to future repositories unless they define their own local templates.

To keep labels and `has_issues=true` aligned for newly created repositories or renamed repositories, this repo includes the workflow `Sync org issue standards`.

To enable that workflow, add the repository secret `SMARTDEV_ORG_ADMIN_TOKEN` in `smartdev-git/.github` with a token that can manage private repositories in `smartdev-git`.