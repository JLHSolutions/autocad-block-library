# AutoCAD-BlockBox

AutoCAD-BlockBox is the managed block library for Cannon Construction AutoCAD standards. It follows the same development, release, versioning, and documentation concepts used in the ToolBox LISP project.

## Purpose

BlockBox keeps AutoCAD blocks organized, documented, versioned, and ready for release. It separates development blocks from production blocks and separates Dynamic blocks from Static blocks.

## Core Standards

- Development files live in `BLOCKS-Dev`.
- Production files live in `BLOCKS-Release`.
- Production files are never edited directly.
- Dynamic and Static blocks are separated.
- Every block gets its own package definition.
- Every block gets its own changelog.
- Every released block uses semantic versioning.
- GitHub tags are created per block.
- Release notes are generated for every published block version.
- Documentation and catalog entries are updated with each release.

## Folder Structure

```text
BLOCKS-Dev
│
├── .gitignore
├── README.md
├── CHANGELOG.md
│
├── dynamic
├── static
│
├── package-definitions
├── changelogs
│
├── docs
├── tools
│
└── releases
    ├── current
    └── archive
```

## Dynamic Blocks

Dynamic blocks are stored under:

```text
dynamic/<category>/<block-name>/
```

Example:

```text
dynamic/utilities/D_UTILITIES_MANHOLE/
```

Dynamic block names should use this format:

```text
D_CATEGORY_NAME
```

Example:

```text
D_UTILITIES_MANHOLE
D_UTILITIES_PEDESTAL
D_TRAFFIC_SIGN
```

## Static Blocks

Static blocks are stored under:

```text
static/<category>/<block-name>/
```

Static block names should use this format:

```text
S_CATEGORY_NAME
```

Example:

```text
S_UTILITIES_MANHOLE
S_UTILITIES_PEDESTAL
S_TRAFFIC_SIGN
```

Static blocks are used for consultant/client sharing when dynamic block intelligence should not be included.

## Standard Block Folder

Each block should eventually follow this structure:

```text
<BlockName>
│
├── <BlockName>.dwg
├── README.md
├── preview.png
│
├── versions
└── export
```

## Package Definitions

Package definitions live in:

```text
package-definitions
```

One JSON file per block:

```text
D_UTILITIES_MANHOLE.json
D_UTILITIES_PEDESTAL.json
S_UTILITIES_MANHOLE.json
```

## Changelogs

Per-block changelogs live in:

```text
changelogs
```

One changelog per block:

```text
D_UTILITIES_MANHOLE.md
D_UTILITIES_PEDESTAL.md
S_UTILITIES_MANHOLE.md
```

The top-level `CHANGELOG.md` tracks library-level changes and release history.

## Versioning

BlockBox uses semantic versioning:

```text
MAJOR.MINOR.PATCH
```

Examples:

```text
1.0.0
1.1.0
1.1.1
2.0.0
```

### PATCH

Use for minor fixes that do not change expected block behavior.

Examples:

- Corrected linework.
- Fixed attribute alignment.
- Updated documentation.
- Replaced preview image.

### MINOR

Use for backward-compatible improvements.

Examples:

- Added visibility states.
- Added optional attributes.
- Added new standard sizes.
- Improved geometry while preserving existing behavior.

### MAJOR

Use for breaking changes or major rebuilds.

Examples:

- Renamed attributes.
- Rebuilt dynamic parameters/actions.
- Changed visibility state structure.
- Changed insertion behavior.
- Replaced the block with a new standard.

## Git Tag Format

Tags are per block:

```text
<BlockName>-v<Version>
```

Examples:

```text
D_UTILITIES_MANHOLE-v1.0.0
D_UTILITIES_PEDESTAL-v1.2.0
S_UTILITIES_MANHOLE-v1.0.0
```

## Release Workflow

Typical release flow:

1. Update block in `BLOCKS-Dev`.
2. Test in AutoCAD.
3. Update package definition.
4. Update per-block changelog.
5. Update top-level `CHANGELOG.md` if needed.
6. Build release ZIP.
7. Copy/promote to release location.
8. Archive previous release ZIP.
9. Create Git tag.
10. Generate GitHub release text.
11. Update BlockBox documentation workbook/catalog.

## Release Output

Development release output:

```text
BLOCKS-Dev/releases/current
BLOCKS-Dev/releases/archive
```

Main distribution/load location:

```text
../releases/current
../releases/archive
```

## Production Rule

Never edit production files directly.

All changes start in `BLOCKS-Dev`, then get promoted to `BLOCKS-Release` through the release process.
