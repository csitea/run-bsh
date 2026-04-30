# 📘 SYG — Framework System Guide — run-bsh-utl

## 🏢 Executive Overview
The **run-bsh minimalistic framework** is a portable, self-discovering action runner designed to bootstrap software projects. It provides a Standardized execution environment for shell-based automation, specifically designed for modular enterprise tasks.

---

## ⚙️ Core Architecture

### 1. Execution Lifecycle
The framework follows a strict execution sequence initiated by `run.sh`:

1.  **Variable Initialization (`do_set_vars`)**: Detects absolute paths (`BASE_PATH`, `ORG_PATH`, `APP_PATH`, `PROJ_PATH`) and the canonical building blocks `ORG`, `APP`, `PROJ`, `PROJ_KIND` (path-derived; `ORG`/`APP`/`PROJ_KIND` honour env overrides). Also exports `USER`, `HOST_NAME`. See [DIRECTORY_STRUCTURE.md](DIRECTORY_STRUCTURE.md).
2.  **Function Registration (`do_load_functions`)**: Scans `lib/bash/funcs/` and `src/bash/run/` for `*.func.sh`, sourcing them and building an associative map (`_func_to_file`) for $O(1)$ lookup.
3.  **Path Discovery (`do_detect_base_paths`)**: Resolves system-wide base paths.
4.  **Configuration Loading (`do_load_config`)**: Sources hierarchical configuration files (see below).
5.  **Requirement Checks (`do_require_bins`, `do_verify_symlinks`)**: Ensures essential system tools and symlinks are present.
6.  **Action Dispatching (`do_run_actions` → `execute_step`)**:
    -   **Argument Hook**: Executes `do_{action}_args` if defined.
    -   **Metadata Flag Mapping**: Automatically maps CLI `--flags` to environment variables based on `@arg` tags in the action header.
    -   **Parameter Validation**: Runs `do_validate_params` to enforce required `@param` environment variables.
    -   **Pre-Hook**: Executes `do_{action}_pre` for setup.
    -   **Primary Action**: Executes the `do_{action}` function.
    -   **Post-Hook**: Executes `do_{action}_post` for cleanup. **Guaranteed execution** even if the main action fails.

### 2. Configuration Hierarchy 🛡️
`run-bsh` implements a two-tier configuration model located in `cnf/bash/`:

| Priority | Filename | Scope |
| :--- | :--- | :--- |
| **Low** | `proj.cnf` | Project-wide defaults. |
| **High** | `${USER}.cnf` | Personal overrides (highest priority). |

### 3. Decentralized Parameter Parsing ⌨️
The framework supports two modes of argument handling:
- **Automated**: The `run.sh` core automatically extracts `--flag value` pairs and exports them as environment variables if they are declared in the action's `@arg` header metadata.
- **Manual**: Actions can implement a `do_{action}_args` hook and use the `do_parse_args` helper (which converts `--my-arg` to `MY_ARG`) or custom logic.

---

## 🚀 Execution Flow Matrix

| Stage | Mechanism | Purpose |
| :--- | :--- | :--- |
| **Discovery** | `do_load_functions` | Identifies modular `do_*` functions via filename convention. |
| **Mapping** | `_func_to_file` | Maps function names to source files for rapid lookup. |
| **Security** | `do_validate_params` | Enforces mandatory parameters via `@param` header tags. |
| **Logging** | `do_log` | Standardized output with timestamps and severity levels. |
| **Hooks** | `execute_step` | Orchestrates the `_args` → `_pre` → `main` → `_post` flow. |

---

## 📊 Logging & Observability
Standardized logging ensures auditability and easier debugging:

-   **Level-based logging**: `INFO`, `DEBUG`, `WARNING`, `ERROR`, `FATAL`, `OK`.
-   **standard Log**: `dat/log/bash/${PROJ}.${YYYYMMDD}.log`
-   **Execution Log**: `~/var/log/${PROJ}/${RUN_UNIT}.${ts}.out.log` (stdout) and `.err.log` (stderr).

---
*Technical Specification — CSI BSH Architecture Group*
