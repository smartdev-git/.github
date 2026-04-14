param(
  [Parameter(Mandatory = $true)]
  [string]$Org
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

  gh api -X PATCH "repos/$repoFullName" -f has_issues=true | Out-Null

  foreach ($label in $labels) {
    gh label create $label.Name --repo $repoFullName --color $label.Color --description $label.Description --force | Out-Null
  }
}