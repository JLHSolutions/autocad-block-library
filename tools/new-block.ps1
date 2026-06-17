param(
    [Parameter(Mandatory=$true)]
    [string]$BlockName,

    [Parameter(Mandatory=$true)]
    [ValidateSet("Dynamic", "Static")]
    [string]$Type,

    [Parameter(Mandatory=$true)]
    [string]$Category,

    [Parameter(Mandatory=$true)]
    [string]$Family,

    [string]$Version = "1.0.0",

    [string]$Status = "Development",

    [string]$Description = "TODO: Add block description.",

    [string]$DisplayName = "",

    [switch]$CreateStaticPlaceholder
)

$ErrorActionPreference = "Stop"

# Root should be BLOCKS-Dev
$Root = Split-Path -Parent $PSScriptRoot

$TypeFolder = $Type.ToLower()
$CategoryFolder = $Category.ToLower().Replace(" ", "-")

$BlockFolder = Join-Path $Root "$TypeFolder\$CategoryFolder\$BlockName"
$ExportFolder = Join-Path $BlockFolder "export"
$VersionsFolder = Join-Path $BlockFolder "versions"

# Templates live here:
$TemplateFolder = Join-Path $Root "docs\templates"

$ReadmeTemplate = Join-Path $TemplateFolder "BLOCK_README_TEMPLATE.md"
$ChangelogTemplate = Join-Path $TemplateFolder "BLOCK_CHANGELOG_TEMPLATE.md"
$PackageTemplate = Join-Path $TemplateFolder "BLOCK_PACKAGE_TEMPLATE.json"

$ChangelogOut = Join-Path $Root "changelogs\$BlockName.md"
$PackageOut = Join-Path $Root "package-definitions\$BlockName.json"
$ReadmeOut = Join-Path $BlockFolder "README.md"

$Today = Get-Date -Format "yyyy-MM-dd"

if ([string]::IsNullOrWhiteSpace($DisplayName)) {
    $DisplayName = $BlockName.Replace("_", " ")
}

if ($Type -eq "Dynamic") {
    $StaticBlockName = $BlockName -replace "^D_", "S_"
    $DynamicSourceBlock = ""
    $StaticDynamicNotes = "This dynamic block is the source block. Static deliverable versions may be generated from this block."
}
else {
    $StaticBlockName = ""
    $DynamicSourceBlock = $BlockName -replace "^S_", "D_"
    $StaticDynamicNotes = "This static block is intended for external sharing or protected deliverables."
}

foreach ($file in @($ReadmeTemplate, $ChangelogTemplate, $PackageTemplate)) {
    if (!(Test-Path $file)) {
        throw "Missing template file: $file"
    }
}

New-Item -ItemType Directory -Force -Path $BlockFolder | Out-Null
New-Item -ItemType Directory -Force -Path $ExportFolder | Out-Null
New-Item -ItemType Directory -Force -Path $VersionsFolder | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Root "changelogs") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Root "package-definitions") | Out-Null

$PreviewPath = Join-Path $BlockFolder "preview.png"
if (!(Test-Path $PreviewPath)) {
    New-Item -ItemType File -Force -Path $PreviewPath | Out-Null
}

$Replacements = @{
    "{{BLOCK_NAME}}"            = $BlockName
    "{{DISPLAY_NAME}}"          = $DisplayName
    "{{VERSION}}"               = $Version
    "{{CATEGORY}}"              = $Category
    "{{FAMILY}}"                = $Family
    "{{CATEGORY_FOLDER}}"       = $CategoryFolder
    "{{BLOCK_TYPE}}"            = $Type
    "{{BLOCK_TYPE_FOLDER}}"     = $TypeFolder
    "{{STATUS}}"                = $Status
    "{{DATE}}"                  = $Today
    "{{DESCRIPTION}}"           = $Description
    "{{VISIBILITY_STATES}}"     = "- TODO: Add visibility states."
    "{{ATTRIBUTES}}"            = "- TODO: Add attributes."
    "{{NOTES}}"                 = "TODO: Add block notes."
    "{{STATIC_BLOCK_NAME}}"     = $StaticBlockName
    "{{DYNAMIC_SOURCE_BLOCK}}"  = $DynamicSourceBlock
    "{{STATIC_DYNAMIC_NOTES}}"  = $StaticDynamicNotes
}

function Apply-Template {
    param(
        [string]$TemplatePath,
        [string]$OutputPath
    )

    $content = Get-Content $TemplatePath -Raw

    foreach ($key in $Replacements.Keys) {
        $content = $content.Replace($key, $Replacements[$key])
    }

    Set-Content -Path $OutputPath -Value $content -Encoding UTF8
}

Apply-Template -TemplatePath $ReadmeTemplate -OutputPath $ReadmeOut
Apply-Template -TemplatePath $ChangelogTemplate -OutputPath $ChangelogOut
Apply-Template -TemplatePath $PackageTemplate -OutputPath $PackageOut

if ($CreateStaticPlaceholder -and $Type -eq "Dynamic") {
    $StaticFolder = Join-Path $Root "static\$CategoryFolder\$StaticBlockName"

    New-Item -ItemType Directory -Force -Path $StaticFolder | Out-Null
    New-Item -ItemType Directory -Force -Path (Join-Path $StaticFolder "export") | Out-Null
    New-Item -ItemType Directory -Force -Path (Join-Path $StaticFolder "versions") | Out-Null

    Write-Host "[OK] Static placeholder created: $StaticFolder"
}

Write-Host ""
Write-Host "[OK] BlockBox block created:"
Write-Host "     $BlockFolder"
Write-Host ""
Write-Host "[OK] README:"
Write-Host "     $ReadmeOut"
Write-Host ""
Write-Host "[OK] Changelog:"
Write-Host "     $ChangelogOut"
Write-Host ""
Write-Host "[OK] Package definition:"
Write-Host "     $PackageOut"
Write-Host ""
Write-Host "Next:"
Write-Host "1. Put the DWG here:"
Write-Host "   $BlockFolder\$BlockName.dwg"
Write-Host "2. Replace preview.png with a real preview image."
Write-Host "3. Review README, changelog, and package JSON."