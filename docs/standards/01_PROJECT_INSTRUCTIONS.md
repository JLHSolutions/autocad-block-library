# AutoCAD-BlockBox Project Instructions

This project manages the AutoCAD-BlockBox library.

BlockBox follows the same standards and workflow used by ToolBox.

## Core Standards

- Follow ToolBox standards exactly.
- Separate Dynamic and Static blocks.
- Use semantic versioning.
- One changelog per block.
- One package-definition per block.
- GitHub tags are per block.
- Production files live in BLOCKS-Release.
- Development files live in BLOCKS-Dev.
- Never edit production files directly.
- Generate release notes.
- Generate changelog entries.
- Generate GitHub release text.
- Generate documentation updates.
- Generate Excel catalog entries.

## Release Philosophy

Development happens in BLOCKS-Dev only. Production-ready blocks are promoted to BLOCKS-Release through a controlled release workflow.

Each block is treated as its own package with its own version, changelog, documentation, package definition, and GitHub tag.
