$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Errors = New-Object System.Collections.Generic.List[string]

function Add-ValidationError {
  param([string]$Message)
  $Errors.Add($Message) | Out-Null
}

function Get-RepoFiles {
  Get-ChildItem -Path $Root -Recurse -File -Force |
    Where-Object { $_.FullName -notmatch "\\.git\\" }
}

$Files = @(Get-RepoFiles)

foreach ($File in $Files) {
  if ($File.Length -eq 0) {
    Add-ValidationError "Empty file: $($File.FullName.Substring($Root.Length + 1))"
  }
}

$TextFiles = $Files | Where-Object {
  $_.Extension -in @(".md", ".mdc", ".yml", ".yaml", ".ps1", ".svg", ".txt") -or
  $_.Name -in @("LICENSE", "SECURITY.md", "CONTRIBUTING.md", "README.md", "DISTRIBUTION.md", "CHANGELOG.md", "BRAND.md")
}

$ForbiddenPatterns = @(
  ("utm" + "_source"),
  "chatgpt\.com",
  "\u00F0",
  "\u00C3",
  "\u00C2"
)

foreach ($File in $TextFiles) {
  $Relative = $File.FullName.Substring($Root.Length + 1)
  $Content = Get-Content -LiteralPath $File.FullName -Raw -Encoding UTF8

  foreach ($Pattern in $ForbiddenPatterns) {
    if ($Content -match $Pattern) {
      Add-ValidationError "Forbidden pattern '$Pattern' in $Relative"
    }
  }

  if ($File.Extension -in @(".md", ".mdc")) {
    $FenceCount = ([regex]::Matches($Content, '```')).Count
    if ($FenceCount % 2 -ne 0) {
      Add-ValidationError "Unbalanced code fences in $Relative"
    }
  }

  if ($File.Extension -eq ".svg") {
    if ($Content -match "(?i)<script|onload=|onclick=|javascript:") {
      Add-ValidationError "Unsafe SVG content in $Relative"
    }
  }

  $Lines = $Content -split "`r?`n"
  for ($i = 0; $i -lt $Lines.Count; $i++) {
    $Line = $Lines[$i]
    if ($Line -match "(?i)(baixe|download|acesse).*(dump|dados pessoais reais|forum criminoso|foruns criminosos)" -and $Line -notmatch "(?i)nao|do not") {
      Add-ValidationError "Unsafe dump/personal-data instruction in ${Relative}:$($i + 1)"
    }
  }
}

$MarkdownFiles = $Files | Where-Object { $_.Extension -in @(".md", ".mdc") }

foreach ($File in $MarkdownFiles) {
  $Relative = $File.FullName.Substring($Root.Length + 1)
  $Content = Get-Content -LiteralPath $File.FullName -Raw -Encoding UTF8
  $Matches = [regex]::Matches($Content, '!?\[[^\]]*\]\(([^)]+)\)')

  foreach ($Match in $Matches) {
    $Target = $Match.Groups[1].Value.Trim()
    if ($Target -match "^(https?:|mailto:|#)") {
      continue
    }
    if ($Target -match "^\s*$") {
      continue
    }

    $TargetPath = ($Target -split "#")[0]
    if ($TargetPath -match "^\s*$") {
      continue
    }

    $TargetPath = [System.Uri]::UnescapeDataString($TargetPath)
    $BaseDir = Split-Path -Parent $File.FullName
    $Resolved = Join-Path $BaseDir $TargetPath

    if (-not (Test-Path -LiteralPath $Resolved)) {
      Add-ValidationError "Broken internal link in $Relative -> $Target"
    }
  }
}

$SkillPath = Join-Path $Root "skills/supply-chain-audit/SKILL.md"
if (-not (Test-Path -LiteralPath $SkillPath)) {
  Add-ValidationError "Missing skill file: skills/supply-chain-audit/SKILL.md"
} else {
  $SkillLines = (Get-Content -LiteralPath $SkillPath -Encoding UTF8 | Measure-Object -Line).Lines
  if ($SkillLines -gt 500) {
    Add-ValidationError "SKILL.md is too long: $SkillLines lines"
  }
}

$RequiredFiles = @(
  "assets/logo.svg",
  "assets/banner.svg",
  "assets/social-preview.svg",
  "BRAND.md",
  "CHANGELOG.md",
  "DISTRIBUTION.md",
  ".github/workflows/validate-markdown.yml",
  ".github/PULL_REQUEST_TEMPLATE.md"
)

foreach ($Required in $RequiredFiles) {
  if (-not (Test-Path -LiteralPath (Join-Path $Root $Required))) {
    Add-ValidationError "Missing required file: $Required"
  }
}

if ($Errors.Count -gt 0) {
  Write-Host "Content validation failed:" -ForegroundColor Red
  foreach ($ErrorItem in $Errors) {
    Write-Host "- $ErrorItem" -ForegroundColor Red
  }
  exit 1
}

Write-Host "Content validation passed." -ForegroundColor Green
