param(
  [Parameter(Mandatory = $true)]
  [string]$Org,
  [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$labels = @(
  @{ Name = 'bug'; Color = 'D73A4A'; Description = 'Something is not working' },
  @{ Name = 'needs-triage'; Color = 'FBCA04'; Description = 'Needs initial triage before assignment' },
  @{ Name = 'blocked'; Color = 'B60205'; Description = 'Work is blocked by an external dependency or decision' },
  @{ Name = 'duplicate'; Color = 'CFD3D7'; Description = 'This issue or pull request already exists' }
)

$repos = gh api --paginate "orgs/$Org/repos?type=all&per_page=100" | ConvertFrom-Json

foreach ($repo in $repos) {
  if ($repo.archived -or $repo.disabled) {
    continue
  }

  $repoFullName = "$Org/$($repo.name)"
  Write-Host "Syncing $repoFullName"

  if ($DryRun) {
    if ($repo.has_issues -ne $true) {
      Write-Host "[dry-run] would enable Issues on $repoFullName"
    }
  }
  elseif ($repo.has_issues -ne $true) {
    gh api -X PATCH "repos/$repoFullName" -f has_issues=true | Out-Null
  }

  foreach ($label in $labels) {
    if ($DryRun) {
      Write-Host "[dry-run] would upsert label '$($label.Name)' on $repoFullName"
      continue
    }

    gh label create $label.Name --repo $repoFullName --color $label.Color --description $label.Description --force | Out-Null
  }
}