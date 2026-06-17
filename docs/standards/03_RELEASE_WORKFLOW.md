# AutoCAD-BlockBox Release Workflow

## Standard Release Steps

1. Edit block in BLOCKS-Dev.
2. Test block in a clean drawing.
3. Confirm dynamic visibility states and attributes.
4. Update the block version.
5. Update the per-block changelog.
6. Update the package definition.
7. Promote the block to BLOCKS-Release.
8. Create release ZIP.
9. Archive the previous ZIP.
10. Create GitHub tag.
11. Generate release notes.
12. Update BlockBox-Documentation.xlsx.

## Git Tag Format

```text
<BlockName>-v<Version>
```

Examples:

```text
D_UTILITIES_MANHOLE-v2.1.0
D_UTILITIES_PEDESTAL-v1.0.0
S_UTILITIES_MANHOLE-v1.0.0
```

## Changelog Format

Newest entries go at the top.

```markdown
# D_UTILITIES_MANHOLE

## 2.1.0 - 2026-06-17

### Added

- Added 24x42 visibility state.

### Changed

- Updated attribute alignment.

### Fixed

- Corrected stretch action behavior.
```
