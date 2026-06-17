# AutoCAD-BlockBox Standards

## Naming Convention

Dynamic blocks use the prefix `D_`.

Example:

```text
D_UTILITIES_MANHOLE
D_UTILITIES_PEDESTAL
D_TRAFFIC_SIGN
```

Static blocks use the prefix `S_`.

Example:

```text
S_UTILITIES_MANHOLE
S_UTILITIES_PEDESTAL
S_TRAFFIC_SIGN
```

## Required Block Files

Each block should have:

```text
<BlockName>.dwg
README.md
preview.png
```

Each block should also have:

```text
package-definitions/<BlockName>.json
changelogs/<BlockName>.md
```

## Versioning

Use semantic versioning:

```text
MAJOR.MINOR.PATCH
```

PATCH: small fixes or documentation updates.

MINOR: new visibility states, added geometry, non-breaking attribute improvements.

MAJOR: breaking changes, renamed attributes, rebuilt dynamic behavior, or incompatible changes.

## Production Rule

Never edit files directly in BLOCKS-Release.

Make changes in BLOCKS-Dev, test the block, then promote the release.
