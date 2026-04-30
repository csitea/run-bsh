# 📘 SYG — Framework System Guide — run-bsh-utl

## 🏢 Executive Overview
The **run-bsh minimalistic framework** is a portable, self-discovering action runner designed to bootstrap software projects. It provides a standardized execution environment for shell-based automation, emphasizing modularity, structured metadata, and ease of use across different project layers (Infrastructure, Web UI, Utils).

---

## ⚙️ Core Architecture

### 1. Execution Lifecycle
The framework follows a strict, predictable sequence to ensure consistency:

1.  **Variable Initialization**: Detects project paths (`PROJ_PATH`, `BASE_PATH`, etc.) and system context (`USER`, `HOST_NAME`).
2.  **Function Discovery**: Scans `lib/bash/funcs/` and `src/bash/run/` for `*.func.sh` files.
3.  **Registration**: Dynamically sources action files and maps `kebab-case.func.sh` filenames to `do_snake_case` functions in a lookup table.
4.  **Configuration Loading**: Loads hierarchical configs (see below).
5.  **Execution Stack**:
    -   **Argument Parsing**: Runs `do_{action}_args` (if defined) for decentralized flag parsing.
    -   **Parameter Validation**: Validates required `@param` environment variables.
    -   **Pre-Hook**: Executes `do_{action}_pre` for environment setup.
    -   **Main Action**: Executes the primary `do_action` function.
    -   **Post-Hook**: Executes `do_{action}_post` for cleanup (guaranteed execution).

### 2. Configuration Hierarchy 🛡️
`run-bsh` implements a two-tier configuration model to separate project defaults from personal overrides.

| Priority | Location | Description |
| :--- | :--- | :--- |
| **Low** | `cnf/bash/proj.cnf` | Default settings shared by the team. |
| **High** | `cnf/bash/${USER}.cnf` | Personal overrides (e.g., local paths, private keys). |

### 3. Path Discovery Logic 🧭
The framework automatically detects its location within the standardized CSI directory structure:
- `PROJ_PATH`: Root of the current project.
- `BASE_PATH`: Top-level directory (e.g., `/opt`).
- `ORG_APP_PATH`: Directory containing the related sub-projects (e.g., `/opt/csi/csi-wpb`).

---

## 🚀 Execution Flow Matrix

| Stage | Mechanism | Purpose |
| :--- | :--- | :--- |
| **Discovery** | `do_load_functions` | Identifies modular `do_*` functions via filename convention. |
| **Validation** | `do_validate_params` | Enforces mandatory parameters via `@param` header tags. |
| **Logging** | `do_log` | Standardized output with timestamps and severity levels. |
| **Hooks** | `execute_step` | Wraps action execution with pre/post hooks. |
| **Error Handling**| `error_handler` | Global trap for command failures with detailed diagnostics. |

---

## 📊 Logging & Observability
Standardized logging ensures auditability and easier debugging:

-   **Standard Log**: `dat/log/bash/${PROJ}.${YYYYMMDD}.log`
-   **Execution Log**: `~/var/log/${PROJ}/${RUN_UNIT}.${ts}.out.log`
-   **Error Log**: `~/var/log/${PROJ}/${RUN_UNIT}.${ts}.err.log`

---

## 🧬 Replication & Propagation
One of the core strengths of `run-bsh` is its ability to propagate changes across the CSI ecosystem:
- **From Base**: Pulling common utilities or configurations into a project.
- **To Base**: Pushing improvements or new generic functions back to the template.

*Technical Specification — CSI Architecture Group*
