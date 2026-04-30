# run-bsh-utl Documentation Index

Welcome to the **run-bsh-utl** documentation. This project provides a minimalist Bash bootstrap for running modular actions in software projects.

## 📚 Core Guides

- [📘 SYG — Framework System Guide](run-bsh-utl.SYG.md) — Architecture, lifecycle, and configuration hierarchy.
- [📗 DEV — Developer Implementation Guide](run-bsh-utl.DEV.md) — Standards, action creation, hooks, and testing.
- [📙 NMC — Command Reference Manual](run-bsh-utl.NMC.md) — Detailed reference for all `do_*` actions and library functions.

## 🛠️ Specialized Documentation

- [📁 Directory Structure](DIRECTORY_STRUCTURE.md) — The required layout for projects using `run-bsh`.
- [📜 Standalone Scripts](SCRIPTS.md) — Utility scripts located in `src/bash/scripts/`.
- [💡 Core Concepts](CORE_CONCEPTS.md) — Fundamental principles of the action-runner pattern.

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
