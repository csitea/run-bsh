# 📗 DEV — Developer Implementation Guide — run-bsh-utl

## 🏗️ Development standards
To maintain consistency and portability, contributors must follow these standards when extending the `run-bsh-utl` project.

---

## 🛠️ Implementing a New Action

### 1. File & Function Convention
-   **Filename**: `kebab-case.func.sh` (e.g., `morph-dir.func.sh`)
-   **Function Name**: `do_snake_case` (e.g., `do_morph_dir`)
-   **Location**:
    -   `src/bash/run/`: For executable actions called via `./run -a ...`
    -   `lib/bash/funcs/`: For reusable library functions.

### 2. Structured Metadata
Every action MUST include a metadata header to enable automated help, validation, and documentation generation.

```bash
#!/bin/bash
#------------------------------------------------------------------------------
# @description Precise description of the action's purpose.
# @param VAR_NAME (required|optional) - Description of the variable.
# @arg --flag-name VAR_NAME - Mapping for named CLI arguments.
# @example ./run -a do_my_action --flag value
# @prereq List of required binaries (e.g., jq, curl, perl).
#------------------------------------------------------------------------------
```

---

## ⌨️ Named Arguments & Parameter Handling
The framework supports decentralized argument parsing. Actions should implement an `_args` hook to map CLI flags to environment variables.

### standard Helper
```bash
do_my_action_args() {
  # Automatically maps --flags to variables based on @arg tags in the header
  do_parse_args "$@"
}
```

### Manual Parsing (Alternative)
```bash
do_my_action_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --my-flag) export MY_VAR="$2"; shift 2 ;;
      *) shift ;;
    esac
  done
}
```

---

## 🔄 Lifecycle Hooks
Hooks allow separating setup and teardown from the core business logic.

-   **Pre-Hook**: `do_{action}_pre` — use for starting services, creating tunnels, or preparing temp dirs.
-   **Post-Hook**: `do_{action}_post` — use for cleanup, stopping services. **Always runs**, even if the main action fails.

---

## 🛡️ Robustness Patterns

### Entry-Point Validation
Always validate your environment at the start of your `do_*` function:

```bash
do_my_action() {
  # 1. Require Binaries
  do_require_bin perl find grep || return $?

  # 2. Validate Required Variables (if not using do_validate_params)
  do_require_var MY_REQUIRED_VAR "${MY_REQUIRED_VAR:-}"

  # 3. Main Logic...
}
```

### Path Resolution
Never use relative paths like `../../`. Always use exported global variables:
- `${PROJ_PATH}`, `${APP_PATH}`, `${ORG_PATH}`
- `${BASE_PATH}`, `${VAR_DIR}`

For parsing complex paths (e.g., in replication or deployment actions), use the framework helper:
```bash
do_split_mod_path "run-bsh" "$target_path"
# Provides: $PROJ_NAME, $PROJ_KIND, $PROJ_ROOT, $PROJ_REL_PATH
```


### Return Codes
-   **0**: Successful completion.
-   **11**: Recoverable functional error (triggers standardized error logging).
-   **Non-zero**: Fatal system errors.

---

## 🧪 Testing Requirements
Every new action must be accompanied by a test script in `src/bash/tests/`:
- **Format**: `{action-name}.tst.sh`
- **Runner**: `bash src/bash/tests/run-all-tests.sh`

---
*Developer Handbook — CSI Engineering*


![[run-bsh-utl.DEV.png]]
