# 📜 run-bsh-utl.Configurability.spec.md — Framework Configurability Specification

## 🏢 Overview
The `run-bsh` framework employs a hierarchical, shell-based configuration system designed to balance shared team defaults with flexible personal overrides. It leverages the native sourcing capabilities of Bash to provide a performant and extensible environment.

---

## ⚙️ Core Architecture

### 1. Hierarchical Override Model
Configuration is resolved by sourcing files in a specific order of increasing priority. Later declarations overwrite earlier ones.

| Priority | Location | Target File | Scope |
| :--- | :--- | :--- | :--- |
| **1 (Low)** | `cnf/bash/` | `proj.cnf` | Shared project-wide defaults. |
| **2 (High)** | `cnf/bash/` | `${USER}.cnf` | Personal overrides (e.g., `ysg.cnf`). |

### 2. Variable Precedence Matrix
The system respects external overrides provided at invocation time. The effective value of a variable is determined by:

1.  **CLI Flags**: Mapped to variables via `@arg` tags or `do_parse_args` (Highest).
2.  **Environment Variables**: Explicitly exported before or during `./run` execution.
3.  **User Configuration**: Values defined in `${USER}.cnf`.
4.  **Project Configuration**: Values defined in `proj.cnf` (Lowest).

---

## 🧬 Technical Implementation

### 1. The Configuration Loader (`do_load_config`)
The loader is responsible for identifying and sourcing the appropriate files. It silently skips missing files to allow for optional user configurations.

```bash
# Core resolution logic
local config_files=("proj.cnf" "${USER:-}.cnf")
for cnf_file in "${config_files[@]}"; do
  source "$conf_dir/$cnf_file"
done
```

### 2. Secret Management (PATs)
Sensitive tokens (like JIRA or Confluence PATs) are managed through a specialized loader (`do_load_pat`) that supports two secure formats:
- **Shell Export**: Sourcing a file containing `export VAR="val"`.
- **Raw Token**: Reading the first line of a file and exporting it directly.

This allows users to keep secrets in files outside of version control (e.g., `~/.osp/.trd/jira-pat.conf.sh`).

### 3. Extended Data Support
While Bash scripts are the primary configuration format, the framework provides helper functions for alternative structures:
- **INI Sections**: `do_parse_ini_section_vars` for parsing specific sections of INI files.
- **JSON Sections**: `do_export_json_section_vars` for extracting variables from JSON structures.
- **Lists**: Shared `.lst` files in `cnf/lst/` for batch project operations.

---

## 🛠️ Usage Standards

### Defining Variables
Variables in configuration files should use the `${VAR:-default}` pattern if they intend to allow upstream overrides, or simple assignments for mandatory framework settings.

### Portability
All paths defined in configurations MUST use the framework's global path variables to ensure host-agnostic behavior:
- `${PROJ_PATH}`
- `${BASE_PATH}`
- `${VAR_DIR}`

---
*Technical Specification — CSI BSH Architecture Group*
