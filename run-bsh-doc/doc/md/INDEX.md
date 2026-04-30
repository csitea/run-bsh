# run-bsh-utl Documentation Index

Welcome to the **run-bsh-utl** documentation. This project provides a minimalist Bash bootstrap for running modular actions in software projects.

## 📚 Core Guides

- [📘 SYG — Framework System Guide](run-bsh-utl.SYG.md) `STATUS: DONE` — Architecture, lifecycle, and configuration hierarchy.
- [📗 DEV — Developer Implementation Guide](run-bsh-utl.DEV.md) `STATUS: DONE` — Standards, action creation, hooks, and testing.
- [📙 NMC — Command Reference Manual](run-bsh-utl.NMC.md) `STATUS: DONE` — Detailed reference for all `do_*` actions and library functions.

## 🛠️ Specialized Documentation

- [📁 Directory Structure](DIRECTORY_STRUCTURE.md) `STATUS: DONE` — The required layout for projects using `run-bsh`.
- [📜 Standalone Scripts](SCRIPTS.md) `STATUS: DONE` — Utility scripts located in `src/bash/scripts/`.
- [💡 Core Concepts](CORE_CONCEPTS.md) `STATUS: DONE` — Fundamental principles of the action-runner pattern.

## 📝 Specifications

- [🔗 Portable Symlinks](specs/symlinks-portable.spec.md) `STATUS: DONE` — Technical specification for host-agnostic symlink management.
- [📜 Logging System](specs/run-bsh-utl.Logging.spec.md) `STATUS: DONE` — Technical specification for standardized multi-channel logging.
- [⚙️ Configurability](specs/run-bsh-utl.Configurability.spec.md) `STATUS: DONE` — Technical specification for hierarchical configuration and overrides.
- [🏷️ Metadata System](specs/run-bsh-utl.Metadata.spec.md) `STATUS: TODO` — Technical specification for action header tagging and automated processing.

## 🚀 Quick Start

To run an action:
```bash
./run -a <action_name>
```

Example:
```bash
./run -a do_print_help
```

To search for help on a specific topic:
```bash
./run -a do_help_with --search <keyword>
```
---
*CSI Architecture & Engineering*
