# 📙 NMC — Command Reference Manual — run-bsh-utl

> Auto-generated on 2026-04-30 14:19:11

## Usage

```bash
./run -a <action_name>
# or with parameters:
PARAM=value ./run -a <action_name>
```

---

## Actions

### `do_detect_base_paths`

**File:** `run-bsh-utl/lib/bash/funcs/detect-base-paths.func.sh`

Framework boot helper — detects and exports BASE_PATH and
VAR_BASE_PATH. Called from run.sh main_exec before config load.

Resolution precedence (each half decided independently):
1. Explicit env var — if caller already exported, honour it.
2. Write-probe on /opt (/var) — use it if writable.
3. Fallback — $HOME/opt ($HOME/var), created on first use.

Generic — contains no project-specific names. Any run.sh-based
project gets the same behaviour.

**Examples:**

```bash
BASE_PATH=$HOME/opt ./run -a <action>        # explicit override
./run -a <action>                             # auto-detect
```

---

### `do_export_json_section_vars`

**File:** `run-bsh-utl/lib/bash/funcs/export-json-section-vars.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_flush_screen`

**File:** `run-bsh-utl/lib/bash/funcs/flush-screen.func.sh`

Clear the terminal screen and move cursor to top-left position.

---

### `do_get_description`

**File:** `run-bsh-utl/lib/bash/funcs/parse-metadata.func.sh`

Extract the first `@description` tag from a `.func.sh` file's header.
Thin wrapper around `do_parse_metadata` that strips the `description=` prefix
and returns just the first description line.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `file_path` | **required** | Path to the `.func.sh` file to inspect (positional argument) |

**Examples:**

```bash
do_get_description "src/bash/run/zip-me.func.sh"
```

---

### `do_get_params`

**File:** `run-bsh-utl/lib/bash/funcs/parse-metadata.func.sh`

Extract every `@param` tag from a `.func.sh` file's header. Used by
`do_validate_params` and `do_print_help` to build parameter tables.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `file_path` | **required** | Path to the `.func.sh` file to inspect (positional argument) |

**Examples:**

```bash
do_get_params "src/bash/run/zip-me.func.sh"
# Output: param=PROJ_PATH (required) - Project path to zip
#         param=ARCHIVE_NAME (optional) - Override default archive name
```

---

### `do_has_metadata`

**File:** `run-bsh-utl/lib/bash/funcs/parse-metadata.func.sh`

Predicate: returns 0 if the file uses the structured metadata format
(i.e. has at least one `@description` tag), 1 otherwise. Lets callers
gracefully skip legacy `.func.sh` files that pre-date the metadata
convention.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `file_path` | **required** | Path to the `.func.sh` file to test (positional argument) |

**Examples:**

```bash
if do_has_metadata "$f"; then
  do_get_description "$f"
fi
```

---

### `do_load_config`

**File:** `run-bsh-utl/lib/bash/funcs/load-config.func.sh`

Hierarchical configuration loader.
Loads proj.cnf then $USER.cnf (highest priority).
Later files overwrite earlier ones. Missing files are silently skipped.

**Examples:**

```bash
do_load_config
```

---

### `do_load_pat`

**File:** `run-bsh-utl/lib/bash/funcs/load-pat.func.sh`

Load a Personal Access Token (PAT) from a file into the

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `$1` | **required** | $1  service name: CONFLUENCE or JIRA  (required) |

**Examples:**

```bash
do_load_pat CONFLUENCE || return 11
do_load_pat JIRA       || return 11
```

---

### `do_log`

**File:** `run-bsh-utl/lib/bash/funcs/log.func.sh`

Output messages to both terminal and log file with timestamps and metadata.
Color-codes messages by type (INFO=blue, OK=green, WARNING=yellow, ERROR/FATAL=red).

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `MESSAGE` | **required** | MESSAGE (required) - Log message prefixed with type: INFO, OK, WARNING, ERROR, FATAL |

**Examples:**

```bash
do_log "INFO Starting process"
do_log "ERROR Something failed"
```

---

### `do_mac_install_bins`

**File:** `run-bsh-utl/lib/bash/funcs/mac-install-bins.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_manjaro_install_bins`

**File:** `run-bsh-utl/lib/bash/funcs/manjaro-install-bins.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_morph_dir`

**File:** `run-bsh-utl/lib/bash/funcs/morph-dir.func.sh`

Recursively morph a directory tree: replace STR_TO_SRCH with STR_TO_REPL in all text file contents, directory names, and file names.
Safe for strings containing "-": perl \Q\E quoting escapes all regex metacharacters; bash glob treats "-" as literal outside [...].

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `DIR_TO_MORPH` | **required** | DIR_TO_MORPH (required) — root directory to process recursively |
| `STR_TO_SRCH` | **required** | STR_TO_SRCH  (required) — string to search for (supports "-" and other special chars) |
| `STR_TO_REPL` | **required** | STR_TO_REPL  (required) — string to replace with |

**Examples:**

```bash
DIR_TO_MORPH=src/workflows/workflow-01 STR_TO_SRCH=workflow-01 STR_TO_REPL=workflow-02 ./run -a do_morph_dir
DIR_TO_MORPH=src/sql/td/<REDACTED> STR_TO_SRCH=<REDACTED> STR_TO_REPL=<REDACTED> ./run -a do_morph_dir
```

**Prerequisites:**

- perl find file grep

---

### `do_parse_args`

**File:** `run-bsh-utl/lib/bash/funcs/parse-args.func.sh`

Standard helper to parse named CLI arguments (--flag value) into environment variables.
Actions can call this inside their own _args() hook to avoid boilerplate.

---

### `do_parse_ini_section_vars`

**File:** `run-bsh-utl/lib/bash/funcs/parse-ini-section-vars.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_parse_metadata`

**File:** `run-bsh-utl/lib/bash/funcs/parse-metadata.func.sh`

Parse structured metadata tags from action file headers.
Extracts @description, @param, @example, @output, @prereq tags.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `FILE` | **required** | FILE (required) - Path to the .func.sh file to parse |
| `TAG` | optional | TAG (optional) - Specific tag to extract (default: all) |

**Examples:**

```bash
do_parse_metadata "src/bash/run/zip-jira-ticket.func.sh"
do_parse_metadata "src/bash/run/zip-jira-ticket.func.sh" "param"
```

---

### `do_require_bin`

**File:** `run-bsh-utl/lib/bash/funcs/require-bin.func.sh`

Validate that required binary/tool is installed and available on PATH.
Provides exact one-liner install commands when tools are missing.
Prevents silent failures or cryptic errors halfway through long-running actions.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `bin_names` | **required** | bin_names (required) - One or more binary names to check (positional arguments) |

**Examples:**

```bash
do_require_bin jq
do_require_bin jq curl pandoc
```

---

### `do_require_not_utl_source`

**File:** `run-bsh-utl/lib/bash/funcs/require-not-utl-source.func.sh`

Hard guard — refuses any source path that resolves under the
private run-bsh-utl project tree. Wired into every Confluence
publish action so run-bsh-utl content can NEVER reach the
Alchemists Confluence space.

run-bsh-utl is personal automation / consulting tooling; it is
explicitly excluded from team-shared publishing targets.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `PATH_ARG` | **required** | PATH_ARG (required) absolute path to validate |

**Examples:**

```bash
do_require_not_utl_source "$doc_md_base"
```

---

### `do_require_var`

**File:** `run-bsh-utl/lib/bash/funcs/require-var.func.sh`

Validate that a required environment variable has a value.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `var_name` | **required** | var_name (required) - Name of the variable to check |
| `var_val` | **required** | var_val (required) - Value of the variable |

**Examples:**

```bash
do_require_var JIRA_PAT "${JIRA_PAT:-}"
```

---

### `do_resolve_dirname`

**File:** `run-bsh-utl/lib/bash/funcs/resolve-dirname.func.sh`

Resolve the absolute path of the directory containing a given file/path.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `path` | **required** | path (required) - File or directory path to resolve |

**Examples:**

```bash
resolve_dirname "/some/relative/../path/file.txt"
```

---

### `do_resolve_tool`

**File:** `run-bsh-utl/lib/bash/funcs/os-detect.func.sh`

Resolve a tool name to the correct binary for the current OS.
On Windows Git Bash this checks the project `bin/<tool>.exe` first, then
falls back to the system `<tool>.exe`. On Linux/WSL/macOS the name is
returned unchanged.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `tool` | **required** | Tool name to resolve (positional argument, e.g. `zip`, `curl`) |

**Examples:**

```bash
local zip_cmd; zip_cmd=$(do_resolve_tool zip)
"$zip_cmd" -r archive.zip ./src
```

---

### `do_set_os_env`

**File:** `run-bsh-utl/lib/bash/funcs/os-detect.func.sh`

Sets and exports `OS_TYPE`, `EXE`, and `WIN_BIN_DIR` based on the host OS.
On Windows Git Bash it also prepends the project `bin/` directory to PATH
so locally vendored `.exe` tools are discovered first. Safe to call once
during framework bootstrap.

**Outputs (exported):**

| Variable | Description |
|----------|-------------|
| `OS_TYPE` | One of: `linux`, `wsl`, `windows-gitbash`, `macos`, `unknown` |
| `EXE` | `.exe` on Windows Git Bash, empty otherwise |
| `WIN_BIN_DIR` | Path to the project `bin/` directory |

**Examples:**

```bash
do_set_os_env
echo "Running on $OS_TYPE"
```

---

### `do_set_sudo_vars`

**File:** `run-bsh-utl/lib/bash/funcs/os-detect.func.sh`

Sets and exports `SUDO` and `SUDO_YSG` so scripts can prefix privileged
commands portably across boxes where the relay user may or may not exist.
The fallback when `RELAY_USER` (default `ysg`) is not provisioned is
critical: without it every `${SUDO_YSG} <cmd>` would expand to
`sudo -u ysg <cmd>` and fail with "unknown user" on hosts that use a
different primary account.

| Situation | `SUDO` | `SUDO_YSG` |
|-----------|--------|------------|
| Already root | empty | empty |
| Linux/WSL + `RELAY_USER` exists | `sudo` | `sudo -u ${RELAY_USER}` |
| Linux/WSL + `RELAY_USER` missing | `sudo` | empty (run as current user) |
| Windows Git Bash | empty | empty |

**Examples:**

```bash
do_set_sudo_vars
${SUDO_YSG} bash -c "cd /opt/proj && git pull"
```

---

### `do_set_vars_on_alpine`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-alpine.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_set_vars_on_centos`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-centos.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_set_vars_on_debian`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-debian.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_set_vars_on_fedora`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-fedora.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_set_vars_on_mac`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-mac.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_set_vars_on_manjaro`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-manjaro.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_set_vars_on_suse`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-suse.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_set_vars_on_ubuntu`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-ubuntu.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_suse_install_bins`

**File:** `run-bsh-utl/lib/bash/funcs/suse-install-bins.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_ubuntu_install_bins`

**File:** `run-bsh-utl/lib/bash/funcs/ubuntu-install-bins.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_validate_params`

**File:** `run-bsh-utl/lib/bash/funcs/validate-params.func.sh`

Validate required parameters declared in @param metadata tags
before an action starts. Checks that all (required) env vars are set.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `FILE` | **required** | FILE (required) - Path to the .func.sh file whose params to validate |

**Examples:**

```bash
do_validate_params "src/bash/run/zip-jira-ticket.func.sh"
```

---

### `do_verify_symlinks`

**File:** `run-bsh-utl/lib/bash/funcs/verify-symlinks.func.sh`

Boot-time symlink health check. Called from run.sh between
do_require_bins and do_run_actions.

Reads the project's symlink manifest from PROJ_SYMLINK_MANIFEST,
an array of "link|target" pairs declared in the project's
cnf/bash/project.conf.sh (or similar). Generic — contains no
project-specific paths or names.

Silent when all symlinks are correct. Warns (never aborts) on
missing/wrong/dangling — the user is told to run
./run -a do_setup_symlinks to repair.

Never mutates the filesystem at boot. Boot stays fast and
non-surprising; repairs are an explicit user action.

---

### `do_which_os`

**File:** `run-bsh-utl/lib/bash/funcs/os-detect.func.sh`

Lightweight OS detection — prints one of `linux`, `wsl`,
`windows-gitbash`, `macos`, or `unknown`. No side effects; safe to call
from any script. Used internally by `do_set_os_env`, `do_set_sudo_vars`,
and `do_resolve_tool`, but also useful in user actions that need to
branch on host OS.

**Examples:**

```bash
case "$(do_which_os)" in
  windows-gitbash) echo "running under MSYS/MINGW" ;;
  wsl)             echo "running under WSL" ;;
  linux|macos)     echo "native unix" ;;
esac
```

---

### `do_zip_me`

**File:** `run-bsh-utl/lib/bash/funcs/zip-me.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_cat_files_for_ai`

**File:** `run-bsh-utl/src/bash/run/cat-files-for-ai.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_hello_world`

**File:** `run-bsh-utl/src/bash/run/hello-world.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_help_to_history`

**File:** `run-bsh-utl/src/bash/run/help-to-history.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_help_with`

**File:** `run-bsh-utl/src/bash/run/help-with.func.sh`

Search for help on a topic across function files.
Displays structured metadata (@description, @param, @example) when available,
falls back to raw comment headers for legacy files.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRCH` | **required** | SRCH (required) - The search keyword to match against action names and descriptions |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--search` | `SRCH` |

**Examples:**

```bash
./run -a do_help_with --search zip
./run -a do_help_with --search jira
./run -a do_help_with --search confluence
```

---

### `do_morph_dir`

**File:** `run-bsh-utl/src/bash/run/morph-dir.func.sh`

Recursively morph a directory tree: replace STR_TO_SRCH with STR_TO_REPL in all text file contents, directory names, and file names.
Safe for strings containing "-": perl \Q\E quoting escapes all regex metacharacters; bash glob treats "-" as literal outside [...].

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `DIR_TO_MORPH` | **required** | DIR_TO_MORPH (required) — root directory to process recursively |
| `STR_TO_SRCH` | **required** | STR_TO_SRCH  (required) — string to search for (supports "-" and other special chars) |
| `STR_TO_REPL` | **required** | STR_TO_REPL  (required) — string to replace with |

**Examples:**

```bash
DIR_TO_MORPH=src/workflows/workflow-01 STR_TO_SRCH=workflow-01 STR_TO_REPL=workflow-02 ./run -a do_morph_dir
DIR_TO_MORPH=src/sql/td/<REDACTED> STR_TO_SRCH=<REDACTED> STR_TO_REPL=<REDACTED> ./run -a do_morph_dir
```

**Prerequisites:**

- perl find file grep

---

### `do_morph_module`

**File:** `run-bsh-utl/src/bash/run/morph-module.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_morph_path`

**File:** `run-bsh-utl/src/bash/run/morph-path.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_open_app_projects_in_tmux`

**File:** `run-bsh-utl/src/bash/run/open-app-projects-in-tmux.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_print_help`

**File:** `run-bsh-utl/src/bash/run/print-help.func.sh`

Display help/usage information for the run.sh framework.
Lists all available actions with their descriptions from metadata tags.

**Examples:**

```bash
./run --help
./run -a do_print_help
```

---

### `do_print_usage`

**File:** `run-bsh-utl/src/bash/run/print-usage.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_push_all_app_repos`

**File:** `run-bsh-utl/src/bash/run/push-all-app-repos.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_dir_from_src_proj`

**File:** `run-bsh-utl/src/bash/run/clone-dir-from-src-proj.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_dir_to_tgt_proj`

**File:** `run-bsh-utl/src/bash/run/clone-dir-to-tgt-proj.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_file_from_src_proj`

**File:** `run-bsh-utl/src/bash/run/clone-file-from-src-proj.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_file_to_tgt_proj`

**File:** `run-bsh-utl/src/bash/run/clone-file-to-tgt-proj.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_git_changes`

**File:** `run-bsh-utl/src/bash/run/clone-git-changes.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_proj_from_bas`

**File:** `run-bsh-utl/src/bash/run/clone-proj-from-bas.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_proj_from_src_proj`

**File:** `run-bsh-utl/src/bash/run/clone-proj-from-src-proj.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_clone_proj_to_tgt_proj`

**File:** `run-bsh-utl/src/bash/run/clone-proj-to-tgt-proj.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_scan_to_list_file`

**File:** `run-bsh-utl/src/bash/run/scan-to-list-file.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_ssh_key_pair_gen`

**File:** `run-bsh-utl/src/bash/run/ssh-key-pair-gen.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_split_mod_path`

**File:** `run-bsh-utl/lib/bash/funcs/split-mod-path.func.sh`

Splits an absolute path into its module-root, project-kind, and in-module
relative path. Module dirs follow the convention `${APP}-${PROJ_KIND}`
(e.g. `run-bsh-utl`, where `APP=run-bsh`, `PROJ_KIND=utl`). On success
exports four globals — `PROJ_NAME`, `PROJ_KIND`, `PROJ_ROOT`,
`PROJ_REL_PATH` — used by the `do_clone_*` family to derive target paths.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `app` | **required** | App prefix to anchor on (positional, e.g. `run-bsh`) |
| `path` | **required** | Absolute path inside (or at) a module dir (positional) |

**Outputs (exported):**

| Variable | Description |
|----------|-------------|
| `PROJ_NAME` | basename of the module dir (e.g. `run-bsh-utl`) |
| `PROJ_KIND` | trailing token after `${app}-` (e.g. `utl`) |
| `PROJ_ROOT` | absolute path of the module dir |
| `PROJ_REL_PATH` | path inside the module (empty when `path == module root`) |

**Examples:**

```bash
do_split_mod_path "run-bsh" "/opt/csi/run-bsh/run-bsh-utl/src/bash/foo.sh"
echo "$PROJ_KIND"      # → utl
echo "$PROJ_REL_PATH"  # → src/bash/foo.sh
```

---

### `do_test_config`

**File:** `run-bsh-utl/src/bash/run/test-config.func.sh`

Test action to verify configuration loading and overrides.

**Examples:**

```bash
./run -a do_test_config
```

---

### `do_test_custom_args`

**File:** `run-bsh-utl/src/bash/run/test-custom-args.func.sh`

Example action using custom getopts parsing logic.

---

### `do_test_hooks`

**File:** `run-bsh-utl/src/bash/run/test-hooks.func.sh`

Main action for hook testing

---

### `do_test_named_args`

**File:** `run-bsh-utl/src/bash/run/test-named-args.func.sh`

Test action for decentralized named argument parsing.

---

### `do_zip_all_projects`

**File:** `run-bsh-utl/src/bash/run/zip-all-projects.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

