# 📙 NMC — Command Reference Manual — run-bsh-utl

> Auto-generated on 2026-04-30 16:32:07

## Usage

```bash
./run -a <action_name>
# or with parameters:
PARAM=value ./run -a <action_name>
```

---

## Actions

### `do_config_loader`

**File:** `run-bsh-utl/lib/bash/funcs/config-loader.func.sh`

Hierarchical configuration loader.
Loads proj.cnf then $USER.cnf (highest priority).
Later files overwrite earlier ones. Missing files are silently skipped.

**Examples:**

```bash
do_load_config
```

---

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

Exports key-value pairs from a specific JSON section as environment variables.
Only string values are exported. Keys are converted to UPPERCASE.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JSON_FILE` | **required** | JSON_FILE (required) - Path to the JSON file to parse |
| `SECTION` | **required** | SECTION (required) - jq filter for the section to export (e.g., '.env.vars') |
| `SENSITIVENESS` | optional | SENSITIVENESS (optional) - If non-empty, masks values in the log output |

**Examples:**

```bash
do_export_json_section_vars "$org/dev.env.json" '.env.steps."004-aws-iam"'
```

**Prerequisites:**

- jq, perl

---

### `do_flush_screen`

**File:** `run-bsh-utl/lib/bash/funcs/flush-screen.func.sh`

Clear the terminal screen and move cursor to top-left position.

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

Installs one or more packages using Homebrew on macOS.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `PACKAGES` | **required** | PACKAGES (required) - Space-separated list of package names to install |

**Examples:**

```bash
do_mac_install_bins jq git curl
```

**Prerequisites:**

- brew

---

### `do_manjaro_install_bins`

**File:** `run-bsh-utl/lib/bash/funcs/manjaro-install-bins.func.sh`

Installs one or more packages using pacman on Manjaro Linux.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `PACKAGES` | **required** | PACKAGES (required) - Space-separated list of package names to install |

**Examples:**

```bash
do_manjaro_install_bins jq git curl
```

**Prerequisites:**

- pacman

---

### `do_os_detect`

**File:** `run-bsh-utl/lib/bash/funcs/os-detect.func.sh`

Detect the current OS/shell environment and resolve tool paths.
On Git Bash (Windows), tools under the project bin/ dir are
preferred and automatically resolved with the .exe suffix.
On Linux/WSL, system tools are used as-is.

**Examples:**

```bash
do_which_os               # prints: linux | wsl | windows-gitbash
do_set_os_env             # sets OS_TYPE, EXE, WIN_BIN_DIR exports
cmd=$(do_resolve_tool curl)
do_set_sudo_vars          # sets SUDO and SUDO_YSG based on OS
```

---

### `do_parse_args`

**File:** `run-bsh-utl/lib/bash/funcs/parse-args.func.sh`

standard helper to parse named CLI arguments (--flag value) into environment variables.
Actions can call this inside their own _args() hook to avoid boilerplate.

---

### `do_parse_ini_section_vars`

**File:** `run-bsh-utl/lib/bash/funcs/parse-ini-section-vars.func.sh`

Parses an INI configuration file section and exports key-value pairs as environment variables.
Supports skipping comments and trimming whitespace.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `CNF_FILE` | **required** | CNF_FILE (required) - Path to the INI configuration file |
| `INI_SECTION` | **required** | INI_SECTION (required) - Name of the section to parse (without brackets) |

**Examples:**

```bash
do_parse_ini_section_vars "cnf/qto.dev.host-name.cnf" "MainSection"
do_parse_ini_section_vars "$AWS_SHARED_CREDENTIALS_FILE" "profile default"
```

**Prerequisites:**

- sed, perl, comm

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
do_resolve_dirname "/some/relative/../path/file.txt"
```

---

### `do_set_vars_on_alpine`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-alpine.func.sh`

Sets environment variables specific to Alpine Linux.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_alpine
```

---

### `do_set_vars_on_centos`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-centos.func.sh`

Sets environment variables specific to CentOS Linux.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_centos
```

---

### `do_set_vars_on_debian`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-debian.func.sh`

Sets environment variables specific to Debian Linux.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_debian
```

---

### `do_set_vars_on_fedora`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-fedora.func.sh`

Sets environment variables specific to Fedora Linux.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_fedora
```

---

### `do_set_vars_on_mac`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-mac.func.sh`

Sets environment variables specific to macOS.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_mac
```

---

### `do_set_vars_on_manjaro`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-manjaro.func.sh`

Sets environment variables specific to Manjaro Linux.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_manjaro
```

---

### `do_set_vars_on_suse`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-suse.func.sh`

Sets environment variables specific to SUSE Linux.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_suse
```

---

### `do_set_vars_on_ubuntu`

**File:** `run-bsh-utl/lib/bash/funcs/set-vars-on-ubuntu.func.sh`

Sets environment variables specific to Ubuntu Linux.
Currently sets the HOST_NAME environment variable.

**Examples:**

```bash
do_set_vars_on_ubuntu
```

---

### `do_split_mod_path`

**File:** `run-bsh-utl/lib/bash/funcs/split-mod-path.func.sh`

Splits an absolute path into its module-root, project-kind and
in-module relative path. The module dir basename follows the
convention "${APP}-${PROJ_KIND}" (e.g. run-bsh-utl, where
APP=run-bsh, PROJ_KIND=utl).

Exports four globals on success:
PROJ_NAME      basename of the module dir         (run-bsh-utl)
PROJ_KIND      trailing token after APP-          (utl)
PROJ_ROOT      absolute path of the module dir    (/opt/csi/run-bsh/run-bsh-utl)
PROJ_REL_PATH  path inside the module             (src/bash/foo.sh; empty when PATH == module root)

**Examples:**

```bash
do_split_mod_path "run-bsh" "/opt/csi/run-bsh/run-bsh-utl/src/bash/foo.sh"
```

---

### `do_suse_install_bins`

**File:** `run-bsh-utl/lib/bash/funcs/suse-install-bins.func.sh`

Installs one or more packages using zypper on SUSE Linux.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `PACKAGES` | **required** | PACKAGES (required) - Space-separated list of package names to install |

**Examples:**

```bash
do_suse_install_bins jq git curl
```

**Prerequisites:**

- zypper

---

### `do_ubuntu_install_bins`

**File:** `run-bsh-utl/lib/bash/funcs/ubuntu-install-bins.func.sh`

Installs one or more packages using apt-get on Ubuntu Linux.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `PACKAGES` | **required** | PACKAGES (required) - Space-separated list of package names to install |

**Examples:**

```bash
do_ubuntu_install_bins jq git curl
```

**Prerequisites:**

- apt-get

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

### `do_zip_me`

**File:** `run-bsh-utl/lib/bash/funcs/zip-me.func.sh`

Zips the current directory into a zip file named after the directory.
The zip file is created in the parent directory.
Excludes common development directories: .git, .terraform, .venv, node_modules.

**Examples:**

```bash
do_zip_me
```

**Prerequisites:**

- zip

---

### `do_cat_files_for_ai`

**File:** `run-bsh-utl/src/bash/run/cat-files-for-ai.func.sh`

Concatenate files matching a glob pattern from source directories
into a single log file for AI processing.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_DIRS` | **required** | SRC_DIRS (required) - Space-separated source directory paths. |
| `INCLUDE_FILE_GLOB` | **required** | INCLUDE_FILE_GLOB (required) - Include file glob pattern. |
| `EXCLUDE_REGEX` | optional | EXCLUDE_REGEX (optional) - Exclude regex pattern. |

**Examples:**

```bash
SRC_DIRS="/path1 /path2" INCLUDE_FILE_GLOB='*.yml' EXCLUDE_REGEX='travis' ./run -a do_cat_files_for_ai
```

---

### `do_clone_app_as_new_app`

**File:** `run-bsh-utl/src/bash/run/clone-app-as-new-app.func.sh`

Fork a run.sh-based app to a brand-new APP name in one shot.
Copies SRC_APP_PATH -> TGT_APP_PATH, drops the source's .git,
renames every inner module dir from ${src-app}-<kind> to
${tgt-app}-<kind>, morphs both kebab and snake_case occurrences
of the app name across all text files, re-points the `run`
symlinks, and (optionally) git-init's + force-pushes to
GIT_REMOTE.

Refuses to overwrite an existing TGT_APP_PATH.
ORG/APP/PROJ/PROJ_KIND of the new app are derived automatically
by run.sh from the new path layout — no config file edits.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_APP_PATH` | **required** | SRC_APP_PATH (required) - Existing app dir (e.g. /opt/csi/run-bsh) |
| `TGT_APP_PATH` | **required** | TGT_APP_PATH (required) - New app dir to create; must NOT exist |
| `GIT_REMOTE` | optional | GIT_REMOTE   (optional) - SSH/HTTPS URL. If set, init + force-push. |

**Examples:**

```bash
SRC_APP_PATH=/opt/csi/run-bsh TGT_APP_PATH=/opt/csi/doc-gen \
GIT_REMOTE=git@github.com:csitea/doc-gen.git \
./run -a do_clone_app_as_new_app
```

---

### `do_clone_dir_from_src_proj`

**File:** `run-bsh-utl/src/bash/run/clone-dir-from-src-proj.func.sh`

rsync a sub-directory from a source app's same-kind module into
the local target module.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `TGT_PATH` | **required** | TGT_PATH (required) - Path inside the target module. |
| `SRC_ORG` | **required** | SRC_ORG (required) - Source organization name. |
| `SRC_APP` | **required** | SRC_APP (required) - Source application name. |
| `SKIP_GLOBS` | optional | SKIP_GLOBS (optional) - Space-separated glob patterns to exclude. |
| `RSYNC_DELETE_OFF` | optional | RSYNC_DELETE_OFF (optional) - If set, rsync will not use --delete. |

**Examples:**

```bash
TGT_PATH=/opt/csi/csi-wpb/csi-wpb-utl/src/bash/ SRC_ORG=bas SRC_APP=bas-wpb ./run -a do_clone_dir_from_src_proj
```

---

### `do_clone_dir_to_tgt_proj`

**File:** `run-bsh-utl/src/bash/run/clone-dir-to-tgt-proj.func.sh`

rsync a sub-directory from the local source module to the
same-kind module in the target app.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_PATH` | **required** | SRC_PATH (required) - Path inside the source module. |
| `TGT_ORG` | **required** | TGT_ORG (required) - Target organization name. |
| `TGT_APP` | **required** | TGT_APP (required) - Target application name. |
| `SKIP_GLOBS` | optional | SKIP_GLOBS (optional) - Space-separated glob patterns to exclude. |
| `RSYNC_DELETE_OFF` | optional | RSYNC_DELETE_OFF (optional) - If set, rsync will not use --delete. |

**Examples:**

```bash
SRC_PATH=/opt/bas/bas-wpb/bas-wpb-utl/src/bash/ TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_dir_to_tgt_proj
```

---

### `do_clone_file_from_src_proj`

**File:** `run-bsh-utl/src/bash/run/clone-file-from-src-proj.func.sh`

Copy a single file from a source app's same-kind module into
the local target module at TGT_PATH.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `TGT_PATH` | **required** | TGT_PATH (required) - Path to the target file. |
| `SRC_ORG` | **required** | SRC_ORG (required) - Source organization name. |
| `SRC_APP` | **required** | SRC_APP (required) - Source application name. |

**Examples:**

```bash
TGT_PATH=/opt/csi/csi-wpb/csi-wpb-utl/src/bash/run.sh SRC_ORG=bas SRC_APP=bas-wpb ./run -a do_clone_file_from_src_proj
```

---

### `do_clone_file_to_tgt_proj`

**File:** `run-bsh-utl/src/bash/run/clone-file-to-tgt-proj.func.sh`

Copy a single file from the local source module to the same-kind
module in the target app.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_PATH` | **required** | SRC_PATH (required) - Path to the source file. |
| `GIT_MSG` | **required** | GIT_MSG (required) - The commit message for the target repository. |
| `TGT_ORG` | **required** | TGT_ORG (required) - Target organization name. |
| `TGT_APP` | **required** | TGT_APP (required) - Target application name. |
| `PROJ_KIND_OVERRIDE` | optional | PROJ_KIND_OVERRIDE (optional) - Override the derived project kind. |

**Examples:**

```bash
SRC_PATH=/path/to/file GIT_MSG="msg" TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_file_to_tgt_proj
```

---

### `do_clone_git_changes`

**File:** `run-bsh-utl/src/bash/run/clone-git-changes.func.sh`

Mirror git changes between two commits from the current module
into a same-kind module in the target app.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_COMMIT_HASH` | **required** | SRC_COMMIT_HASH (required) - The source commit hash. |
| `TGT_COMMIT_HASH` | **required** | TGT_COMMIT_HASH (required) - The target commit hash to diff against. |
| `TGT_ORG` | **required** | TGT_ORG (required) - Target organization name. |
| `TGT_APP` | **required** | TGT_APP (required) - Target application name. |

**Examples:**

```bash
SRC_COMMIT_HASH=abc TGT_COMMIT_HASH=def TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_git_changes
```

---

### `do_clone_proj_from_bas`

**File:** `run-bsh-utl/src/bash/run/clone-proj-from-bas.func.sh`

Alias of do_clone_proj_from_src_proj kept for historical reasons.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `TGT_PATH` | **required** | TGT_PATH (required) - Path to the local target module root. |
| `SRC_ORG` | **required** | SRC_ORG (required) - Source organization name. |
| `SRC_APP` | **required** | SRC_APP (required) - Source application name. |

**Examples:**

```bash
TGT_PATH=/opt/org/org-app/org-app-utl SRC_ORG=bas SRC_APP=bas-wpb ./run -a do_clone_proj_from_bas
```

---

### `do_clone_proj_from_src_proj`

**File:** `run-bsh-utl/src/bash/run/clone-proj-from-src-proj.func.sh`

Pull the same-kind project from a source app (SRC_ORG/SRC_APP)
into the local target module root TGT_PATH.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `TGT_PATH` | **required** | TGT_PATH (required) - Path to the local target module root. |
| `SRC_ORG` | **required** | SRC_ORG (required) - Source organization name. |
| `SRC_APP` | **required** | SRC_APP (required) - Source application name. |
| `SKIP_GLOBS` | optional | SKIP_GLOBS (optional) - Space-separated glob patterns to exclude. |
| `RSYNC_DELETE_OFF` | optional | RSYNC_DELETE_OFF (optional) - If set, rsync will not use --delete. |

**Examples:**

```bash
TGT_PATH=/opt/org/org-app/org-app-utl SRC_ORG=bas SRC_APP=bas-wpb ./run -a do_clone_proj_from_src_proj
```

---

### `do_clone_proj_to_tgt_proj`

**File:** `run-bsh-utl/src/bash/run/clone-proj-to-tgt-proj.func.sh`

Push the local source module SRC_PATH to a same-kind module in
the target app (TGT_ORG/TGT_APP).

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_PATH` | **required** | SRC_PATH (required) - Path to the local source module. |
| `TGT_ORG` | **required** | TGT_ORG (required) - Target organization name. |
| `TGT_APP` | **required** | TGT_APP (required) - Target application name. |
| `SKIP_GLOBS` | optional | SKIP_GLOBS (optional) - Space-separated glob patterns to exclude. |
| `RSYNC_DELETE_OFF` | optional | RSYNC_DELETE_OFF (optional) - If set, rsync will not use --delete. |

**Examples:**

```bash
SRC_PATH=/opt/bas/bas-wpb/bas-wpb-wui TGT_ORG=csi TGT_APP=csi-wpb ./run -a do_clone_proj_to_tgt_proj
```

---

### `do_git_setup_hooks`

**File:** `run-bsh-utl/src/bash/run/git-setup-hooks.func.sh`

Symlink every hook from cnf/git/hooks/ into .git/hooks/, so that
a fresh clone immediately picks up the canonical pre-commit
(and any other hooks added later under the same dir).
Idempotent: if a hook is already correctly linked, no-op.
Searches for the source dir in repo_root/run-bsh-utl/cnf/git/hooks
first (this project), falling back to repo_root/cnf/git/hooks
(downstream layout) and $PROJ_PATH/cnf/git/hooks.

**Examples:**

```bash
./run -a do_git_setup_hooks
```

---

### `do_hello_world`

**File:** `run-bsh-utl/src/bash/run/hello-world.func.sh`

A simple hello world script for testing the framework.

**Examples:**

```bash
./run -a do_hello_world
```

---

### `do_help_to_history`

**File:** `run-bsh-utl/src/bash/run/help-to-history.func.sh`

Extracts bash commands from README.md code blocks and appends
them to the bash history file.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `PROJ_PATH` | optional | PROJ_PATH (optional) - The path to the project containing the README.md. |

**Examples:**

```bash
PROJ_PATH=/path/to/project ./run -a do_help_to_history
```

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

Creates a morphed clone of a source module by renaming strings
and directory/file paths.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_MODULE` | **required** | SRC_MODULE (required) - The name of the source module. |
| `TGT_MODULE` | **required** | TGT_MODULE (required) - The name of the target module. |

**Examples:**

```bash
SRC_MODULE=run.sh TGT_MODULE=foo-bar ./run -a do_morph_module
```

---

### `do_morph_path`

**File:** `run-bsh-utl/src/bash/run/morph-path.func.sh`

Search-and-replace a token across both file contents and file
names within a target directory tree. Skips .git, node_modules,
.venv and any patterns listed in cnf/lst/${PROJ}.exclude.lst.
Binary files are not edited (filtered via `grep -I`); they are
still renamed if their filename matches.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `STR_TO_SRCH` | **required** | STR_TO_SRCH (required) - The string to search for (literal, regex-quoted). |
| `STR_TO_REPL` | **required** | STR_TO_REPL (required) - The string to replace with. |
| `TGT_PATH` | **required** | TGT_PATH    (required) - The target directory path to morph in. |

**Examples:**

```bash
STR_TO_SRCH=run-bsh STR_TO_REPL=doc-gen TGT_PATH=/opt/csi/doc-gen \
./run -a do_morph_path
```

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

Prints the usage instructions and dynamically lists all
available actions in the framework.

**Examples:**

```bash
./run -a do_print_usage
```

---

### `do_ssh_key_pair_gen`

**File:** `run-bsh-utl/src/bash/run/ssh-key-pair-gen.func.sh`

Generates an RSA SSH key pair for the organization and
application with no passphrase.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `ORG` | **required** | ORG (required) - The organization name. |
| `APP` | **required** | APP (required) - The application name. |

**Examples:**

```bash
ORG=myorg APP=myapp ./run -a do_ssh_key_pair_gen
```

**Prerequisites:**

- expect utility.

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

### `do_unzip_deploy`

**File:** `run-bsh-utl/src/bash/run/unzip-deploy.func.sh`

Unzip a project archive (built from /) and rsync its contents
back to their original absolute paths under DEPLOY_ROOT.
The zip is expected to contain paths relative to / — e.g.
opt/csi/run-bsh/run-bsh-utl/src/bash/run/foo.sh
The archive is extracted to /tmp/unzip_deploy_<timestamp>/,
then the following is run:
rsync -rl --delete /tmp/unzip_deploy_<ts>/ <DEPLOY_ROOT>/
so every file lands at its original absolute path.
On success the temp dir is removed automatically.
On failure it is kept for inspection.
Set KEEP_TMP=1 to always retain it (useful after DRY_RUN).

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `ZIP_FILE` | **required** | ZIP_FILE    (required) - Path to the zip archive to deploy |
| `DEPLOY_ROOT` | optional | DEPLOY_ROOT (optional) - Root to deploy into (default: /) |
| `DRY_RUN` | optional | DRY_RUN     (optional) - Set to 1 to show what would change without writing |
| `KEEP_TMP` | optional | KEEP_TMP    (optional) - Set to 1 to keep /tmp/unzip_deploy_<ts>/ after success |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--zip-file` | `ZIP_FILE` |
| `--deploy-root` | `DEPLOY_ROOT` |
| `--dry-run` | `DRY_RUN` |
| `--keep-tmp` | `KEEP_TMP` |

**Examples:**

```bash
ZIP_FILE=/media/usb/samsung-usb/var/csi/run-bsh/run-bsh-all/dat/zip/run-bsh-utl.3.6.4.zip ./run -a do_unzip_deploy
ZIP_FILE=/var/csi/run-bsh/run-bsh-all/dat/zip/run-bsh-utl.3.6.4.zip DRY_RUN=1 ./run -a do_unzip_deploy
ZIP_FILE=... DEPLOY_ROOT=/mnt/staging ./run -a do_unzip_deploy
ZIP_FILE=... KEEP_TMP=1 ./run -a do_unzip_deploy
```

**Prerequisites:**

- unzip rsync

---

### `do_zip_proj`

**File:** `run-bsh-utl/src/bash/run/zip-proj.func.sh`

Unified zip action — zip any SRC_DIR into /var/<org>/<org>-<app>/<org>-<app>-all/dat/zip/
Derives <org> and <org>-<app> from path segments (position 2 and 3 after /).
Works for /opt/<org>/<org>-<app>, /opt/<org>/<org>-<app>/<proj>,
/var/<org>/<org>-<app>/<variant>, etc.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRC_DIR` | **required** | SRC_DIR           (required) absolute path to zip |
| `DST_DIR` | optional | DST_DIR           (optional) override output dir — default: /var/<org>/<app>/<app>-all/dat/zip |
| `EXCLUDE_FILE_GLOB` | optional | EXCLUDE_FILE_GLOB (optional) extra zip exclusion glob(s); whitespace- or colon-separated. |
| `Patterns` | optional | Patterns are passed to `zip -x` and augment the built-in exclusions. |
| `Non-anchored` | optional | Non-anchored patterns (no leading `*` or `/`) are auto-prefixed with `*/` |
| `so` | optional | so they match anywhere in the tree (e.g. `.git/*` → `*/.git/*`). |

**Examples:**

```bash
SRC_DIR=<REDACTED> ./run -a do_zip_proj                                       # → /var/alc/alc-frw/alc-frw-all/dat/zip/alc-frw.<ver>.<ts>.zip
SRC_DIR=/var/alc/alc-frw/alc-frw-doc ./run -a do_zip_proj                           # → /var/alc/alc-frw/alc-frw-all/dat/zip/alc-frw-doc.<ts>.zip
SRC_DIR=/opt/csi/run-bsh ./run -a do_zip_proj                                       # → /var/csi/run-bsh/run-bsh-all/dat/zip/run-bsh.<ver>.<ts>.zip
SRC_DIR=/opt/csi/run-bsh/run-bsh-utl ./run -a do_zip_proj                           # → /var/csi/run-bsh/run-bsh-all/dat/zip/run-bsh-utl.<ver>.<ts>.zip
SRC_DIR=/var/csi/run-bsh/run-bsh-dat ./run -a do_zip_proj                           # → /var/csi/run-bsh/run-bsh-all/dat/zip/run-bsh-dat.<ts>.zip
SRC_DIR=/var/csi/run-bsh/run-bsh-doc ./run -a do_zip_proj                           # → /var/csi/run-bsh/run-bsh-all/dat/zip/run-bsh-doc.<ts>.zip
SRC_DIR=<REDACTED> DST_DIR=/tmp/zips ./run -a do_zip_proj                     # → /tmp/zips/alc-frw.<ver>.<ts>.zip
SRC_DIR=$(pwd) EXCLUDE_FILE_GLOB='.git/*' ./run -a do_zip_proj                      # exclude .git/ in addition to the defaults
SRC_DIR=$(pwd) EXCLUDE_FILE_GLOB='secrets/* *.pem dat/cache/*' ./run -a do_zip_proj # multiple patterns (whitespace-separated)
```

**Prerequisites:**

- zip unzip perl

---



![[run-bsh-utl.NMC.png]]
