# CLI Reference Manual — run-bsh-utl

> Auto-generated on 2026-04-02 16:53:23 by `do_generate_manual`

## Usage

```bash
./run -a <action_name>
# or with parameters:
PARAM=value ./run -a <action_name>
```

---

## Actions

### `do_config_loader`

**File:** `lib/bash/funcs/config-loader.func.sh`

Hierarchical configuration loader.
Loads proj.cnf then $USER.cnf (highest priority).
Later files overwrite earlier ones. Missing files are silently skipped.

**Examples:**

```bash
do_load_config
```

---

### `do_flush_screen`

**File:** `lib/bash/funcs/flush-screen.func.sh`

Clear the terminal screen and move cursor to top-left position.

---

### `do_load_config`

**File:** `lib/bash/funcs/load-config.func.sh`

Hierarchical configuration loader.
Loads proj.cnf then $USER.cnf (highest priority).
Later files overwrite earlier ones. Missing files are silently skipped.

**Examples:**

```bash
do_load_config
```

---

### `do_log`

**File:** `lib/bash/funcs/log.func.sh`

Output messages to both terminal and log file with timestamps and metadata.
Color-codes messages by type (INFO=blue, OK=green, WARNING=yellow, ERROR/FATAL=red).

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `MESSAGE` | **required** | Log message prefixed with type: INFO, OK, WARNING, ERROR, FATAL |

**Examples:**

```bash
do_log "INFO Starting process"
do_log "ERROR Something failed"
```

---

### `do_os_detect`

**File:** `lib/bash/funcs/os-detect.func.sh`

Detect the current OS/shell environment and resolve tool paths.
On Git Bash (Windows), tools under the project bin/ dir are
preferred and automatically resolved with the .exe suffix.
On Linux/WSL, system tools are used as-is.

**Examples:**

```bash
do_which_os               # prints: linux | wsl | windows-gitbash
do_set_os_env             # sets OS_TYPE, EXE, WIN_BIN_DIR exports
cmd=$(do_resolve_tool curl)
do_set_sudo_vars          # sets SUDO and SUDO_YSG based on OS Returns the OS type string: linux | wsl | windows-gitbash | unknown Lightweight — safe to call from any script without side effects.
```

---

### `do_parse_args`

**File:** `lib/bash/funcs/parse-args.func.sh`

Standard helper to parse named CLI arguments (--flag value) into environment variables.
Actions can call this inside their own _args() hook to avoid boilerplate.

---

### `do_parse_metadata`

**File:** `lib/bash/funcs/parse-metadata.func.sh`

Parse structured metadata tags from action file headers.
Extracts @description, @param, @example, @output, @prereq tags.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `FILE` | **required** | Path to the .func.sh file to parse |
| `TAG` | optional | Specific tag to extract (default: all) |

**Examples:**

```bash
do_parse_metadata "src/bash/run/zip-jira-ticket.func.sh"
do_parse_metadata "src/bash/run/zip-jira-ticket.func.sh" "param" Parse all metadata from a func.sh file header Usage: do_parse_metadata <file_path> [tag_name] Outputs structured metadata to stdout
```

---

### `do_require_bin`

**File:** `lib/bash/funcs/require-bin.func.sh`

Validate that required binary/tool is installed and available on PATH.
Provides exact one-liner install commands when tools are missing.
Prevents silent failures or cryptic errors halfway through long-running actions.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `bin_names` | **required** | One or more binary names to check (positional arguments) |

**Examples:**

```bash
do_require_bin jq
do_require_bin jq curl pandoc
```

**Output:**

- Logs FATAL with install instructions for each missing tool

---

### `do_require_var`

**File:** `lib/bash/funcs/require-var.func.sh`

Validate that a required environment variable has a value.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `var_name` | **required** | Name of the variable to check |
| `var_val` | **required** | Value of the variable |

**Examples:**

```bash
do_require_var JIRA_PAT "${JIRA_PAT:-}"
```

---

### `do_resolve_dirname`

**File:** `lib/bash/funcs/resolve-dirname.func.sh`

Resolve the absolute path of the directory containing a given file/path.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `path` | **required** | File or directory path to resolve |

**Examples:**

```bash
resolve_dirname "/some/relative/../path/file.txt"
```

---

### `do_validate_params`

**File:** `lib/bash/funcs/validate-params.func.sh`

Validate required parameters declared in @param metadata tags
before an action starts. Checks that all (required) env vars are set.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `FILE` | **required** | Path to the .func.sh file whose params to validate |

**Examples:**

```bash
do_validate_params "src/bash/run/zip-jira-ticket.func.sh" Validate that all required @param env vars are set Usage: do_validate_params <func_file_path> Returns 0 if all required params are set, exits with error otherwise
```

---

### `do_bump_version`

**File:** `src/bash/run/bump-version.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_delete_page`

**File:** `src/bash/run/confluence-delete-page.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_fetch_page`

**File:** `src/bash/run/confluence-fetch-page.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_offline_fetch_page_for_update`

**File:** `src/bash/run/confluence-offline-fetch-page-for-update.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_offline_fetch_page`

**File:** `src/bash/run/confluence-offline-fetch-page.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_offline_fetch_page_metadata`

**File:** `src/bash/run/confluence-offline-fetch-page-metadata.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_offline_fetch_parent_page_tree`

**File:** `src/bash/run/confluence-offline-fetch-parent-page-tree.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_offline_search_and_fetch`

**File:** `src/bash/run/confluence-offline-search-and-fetch.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_offline_search`

**File:** `src/bash/run/confluence-offline-search.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_post_md`

**File:** `src/bash/run/confluence-post-md.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_search`

**File:** `src/bash/run/confluence-search.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_sync_to_local`

**File:** `src/bash/run/confluence-sync-to-local.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_confluence_update_page`

**File:** `src/bash/run/confluence-update-page.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_convert_md_to_jira_wiki`

**File:** `src/bash/run/convert-md-to-jira-wiki.func.sh`

Convert Markdown files in doc/md/ to JIRA wiki format using pandoc.
Creates .jira.wiki files under doc/jira/<ticket>/ directories.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | optional | Convert only files for this ticket subdirectory (default: all) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |

**Prerequisites:**

- pandoc (must support -t jira output format; pandoc >= 2.9)

**Examples:**

```bash
./run -a do_convert_md_to_jira_wiki
./run -a do_convert_md_to_jira_wiki --ticket <REDACTED>
```

**Output:**

- Creates .jira.wiki files in $PROJ_PATH/doc/jira/ preserving subdirectory structure

---

### `do_create_cicd_deployment_ticket`

**File:** `src/bash/run/create-cicd-deployment-ticket.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_create_jira_ticket`

**File:** `src/bash/run/create-jira-ticket.func.sh`

Create a JIRA ticket using the JIRA REST API.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_PAT` | **required** | Personal Access Token for JIRA authentication |
| `JIRA_PROJECT` | **required** | Project key (e.g., <REDACTED>, <REDACTED>) |
| `JIRA_SUMMARY` | **required** | Ticket summary/title |
| `JIRA_DESCRIPTION` | **required** | Ticket description (plain text or JIRA wiki markup) |
| `JIRA_ISSUE_TYPE` | optional | Issue type (default: Task) |
| `JIRA_BASE_URL` | optional | Base URL (default: https://<REDACTED>) |
| `JIRA_PRIORITY` | optional | Priority name (e.g., Major, Minor, Critical) |
| `JIRA_LINKED_TICKET` | optional | Ticket key to link (e.g., <REDACTED>) |
| `JIRA_LINK_TYPE` | optional | Link type (default: "is detailed by") |
| `JIRA_LABELS` | optional | Comma-separated labels |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--project` | `JIRA_PROJECT` |
| `--summary` | `JIRA_SUMMARY` |
| `--description` | `JIRA_DESCRIPTION` |
| `--issue-type` | `JIRA_ISSUE_TYPE` |
| `--priority` | `JIRA_PRIORITY` |
| `--linked-ticket` | `JIRA_LINKED_TICKET` |
| `--link-type` | `JIRA_LINK_TYPE` |
| `--labels` | `JIRA_LABELS` |

**Prerequisites:**

- jq JSON processor (apt install jq)

**Examples:**

```bash
source ~/.osp/.trd/jira-pat.conf.sh
./run -a do_create_jira_ticket --project <REDACTED> --summary "Grant --description "..."
```

**Output:**

- Created ticket key and URL

---

### `do_delete_confluence_page`

**File:** `src/bash/run/delete-confluence-page.func.sh`

Delete/move Confluence pages by URL.
By default, moves pages under a trash parent page. Falls back to DELETE API.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `CONFLUENCE_URL` | optional | Full URL to a single Confluence page (one of URL or URLS required) |
| `CONFLUENCE_URLS` | optional | Space-separated list of URLs for batch operations |
| `MOVE_TO_URL` | **required** | URL of parent page to move under, or "DELETE" for API delete |
| `DRY_RUN` | optional | Set to "true" to preview without changes |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--url` | `CONFLUENCE_URL` |
| `--urls` | `CONFLUENCE_URLS` |
| `--move-to` | `MOVE_TO_URL` |
| `--dry-run` | `DRY_RUN` |

**Prerequisites:**

- CONFLUENCE_PAT or token in ~/.osp/.trd/conflu_pat.conf.sh
- jq JSON processor (apt install jq)

**Examples:**

```bash
./run -a do_delete_confluence_page --url https://<REDACTED>/spaces/TVH/pages/123/title --move-to https://<REDACTED>/spaces/TVH/pages/1385818345/XX_Poistetaan
./run -a do_delete_confluence_page --url https://<REDACTED>/pages/123/title --move-to DELETE
./run -a do_delete_confluence_page --dry-run true --url https://<REDACTED>/pages/123/title
```

---

### `do_fetch_confluence_page`

**File:** `src/bash/run/fetch-confluence-page.func.sh`

Fetch and display the textual content of a Confluence page using the REST API.
Extracts the page body (storage format) and converts HTML to readable text.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `CONFLUENCE_URL` | **required** | Full URL to the Confluence page |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--url` | `CONFLUENCE_URL` |

**Prerequisites:**

- CONFLUENCE_PAT or token in ~/.osp/.trd/conflu_pat.conf.sh
- jq JSON processor (apt install jq)
- Optional: lynx or w3m for HTML-to-text conversion (falls back to sed)

**Examples:**

```bash
./run -a do_fetch_confluence_page --url https://<REDACTED>/display/TVH/page+title
```

**Output:**

- Logs page title, space, version, last modified, and body as plain text

---

### `do_gcp_project_delete`

**File:** `src/bash/run/gcp-project-delete.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_gcp_s3_download_all`

**File:** `src/bash/run/gcp-s3-download-all.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_generate_manual`

**File:** `src/bash/run/generate-manual.func.sh`

Auto-generate a CLI reference manual from structured @metadata tags.
Produces a Markdown document covering all available actions, their
parameters, examples, and prerequisites.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `MANUAL_OUTPUT` | optional | Output file path (default: doc/md/CLI-REFERENCE.md) |
| `MANUAL_FORMAT` | optional | Output format: md or txt (default: md) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--output` | `MANUAL_OUTPUT` |
| `--format` | `MANUAL_FORMAT` |

**Examples:**

```bash
./run -a do_generate_manual
./run -a do_generate_manual --output /tmp/cli-ref.md
```

**Output:**

- Markdown file with full CLI reference documentation

---

### `do_git_relay_lin_post_bundle`

**File:** `src/bash/run/git-relay-lin-post-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_git_relay_lin_pull_bundle`

**File:** `src/bash/run/git-relay-lin-pull-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_git_relay_lin_push_bundle`

**File:** `src/bash/run/git-relay-lin-push-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_git_relay_pull_bundle`

**File:** `src/bash/run/git-relay-pull-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_git_relay_push_bundle`

**File:** `src/bash/run/git-relay-push-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_git_relay_win_post_bundle`

**File:** `src/bash/run/git-relay-win-post-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_git_relay_win_pull_bundle`

**File:** `src/bash/run/git-relay-win-pull-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_git_relay_win_push_bundle`

**File:** `src/bash/run/git-relay-win-push-bundle.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_help_with`

**File:** `src/bash/run/help-with.func.sh`

Search for help on a topic across function files.
Displays structured metadata (@description, @param, @example) when available,
falls back to raw comment headers for legacy files.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `SRCH` | **required** | The search keyword to match against action names and descriptions |

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

### `do_jira_add_label`

**File:** `src/bash/run/jira-add-label.func.sh`

Add a label to a JIRA ticket using the JIRA REST API.
When adding PREPROD_DB_GO, automatically removes PREPROD_DB_FAILED and PREPROD_DB_DEPLOYED first.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | **required** | JIRA ticket key (e.g., <REDACTED>) |
| `LABEL` | **required** | Label name to add (e.g., PREPROD_DB_GO) |
| `GIT_BRANCH` | optional | Git branch name for configuration-based lookup |
| `JIRA_PAT` | optional | JIRA Personal Access Token (loaded from $JIRA_PAT_FILE) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |
| `--label` | `LABEL` |
| `--branch` | `GIT_BRANCH` |

**Prerequisites:**

- jq JSON processor (apt install jq)
- curl for HTTP requests

**Examples:**

```bash
./run -a do_jira_add_label --ticket <REDACTED> --label PREPROD_DB_GO
./run -a do_jira_add_label --ticket <REDACTED> --label PREPROD_DB_GO
```

**Output:**

- Logs OK/FAIL with HTTP status code

---

### `do_jira_bind_synapse_tests`

**File:** `src/bash/run/jira-bind-synapse-tests.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_convert_md_to_wiki`

**File:** `src/bash/run/jira-convert-md-to-wiki.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_create_dba_ticket`

**File:** `src/bash/run/jira-create-dba-ticket.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_create_synapse_tests`

**File:** `src/bash/run/jira-create-synapse-tests.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_create_ticket`

**File:** `src/bash/run/jira-create-ticket.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_fetch_ticket_content`

**File:** `src/bash/run/jira-fetch-ticket-content.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_list_attachments`

**File:** `src/bash/run/jira-list-attachments.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_mark_dod_ticket_done`

**File:** `src/bash/run/jira-mark-dod-ticket-done.func.sh`

*⚠ Legacy format — no structured metadata available.*

Given a developer story ticket, automatically find and complete the

---

### `do_jira_mark_prod_tasks_done`

**File:** `src/bash/run/jira-mark-prod-tasks-done.func.sh`

*⚠ Legacy format — no structured metadata available.*

Given a developer story ticket, automatically find and complete the

---

### `do_jira_mark_sit_ticket_done`

**File:** `src/bash/run/jira-mark-sit-ticket-done.func.sh`

*⚠ Legacy format — no structured metadata available.*

Given a developer story ticket, automatically find and complete the

---

### `do_jira_mark_uat_ticket_done`

**File:** `src/bash/run/jira-mark-uat-ticket-done.func.sh`

Automatically find and complete the UAT ticket linked to a dev story.
Traverses links: Dev Story -> Solution DoD -> UAT Ticket.
Marks all checklist items in UAT description as Done (/) and transitions to Done.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | **required** | Developer story ticket key (e.g., <REDACTED>) |
| `UAT_TICKET` | optional | Direct UAT ticket key (skips link traversal if provided) |
| `JIRA_PAT` | optional | JIRA Personal Access Token (loaded from $JIRA_PAT_FILE) |
| `DRY_RUN` | optional | Traces the chain without applying changes (set to 1) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |
| `--uat-ticket` | `UAT_TICKET` |

**Prerequisites:**

- jq JSON processor (apt install jq)
- curl for HTTP requests

**Examples:**

```bash
JIRA_TICKET=<REDACTED> ./run -a do_mark_uat_ticket_done
DRY_RUN=1 JIRA_TICKET=<REDACTED> ./run -a do_mark_uat_ticket_done
```

**Output:**

- Logs showing link chain traversal and UAT ticket updates

---

### `do_jira_offline_fetch_activity_stream`

**File:** `src/bash/run/jira-offline-fetch-activity-stream.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_attachments`

**File:** `src/bash/run/jira-offline-fetch-attachments.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_create_ticket_context`

**File:** `src/bash/run/jira-offline-fetch-create-ticket-context.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_dba_tickets`

**File:** `src/bash/run/jira-offline-fetch-dba-tickets.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_dod_ticket_state`

**File:** `src/bash/run/jira-offline-fetch-dod-ticket-state.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_prd_summary_data`

**File:** `src/bash/run/jira-offline-fetch-prd-summary-data.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_prod_tasks_state`

**File:** `src/bash/run/jira-offline-fetch-prod-tasks-state.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_sit_ticket_state`

**File:** `src/bash/run/jira-offline-fetch-sit-ticket-state.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_ticket_comments`

**File:** `src/bash/run/jira-offline-fetch-ticket-comments.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_ticket_content`

**File:** `src/bash/run/jira-offline-fetch-ticket-content.func.sh`

Fetch full JIRA ticket content and save as a self-contained JSON file.
Optimized for offline analysis by developers on restricted machines.
Includes summary, description, comments, links, attachments, and changelog.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | **required** | JIRA ticket key or space-separated list of keys |
| `JIRA_BASE_URL` | optional | JIRA base URL (default: https://<REDACTED>) |
| `JIRA_PAT` | optional | JIRA Personal Access Token (loaded from $JIRA_PAT_FILE) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |
| `--url` | `JIRA_BASE_URL` |

**Prerequisites:**

- jq JSON processor (apt install jq)
- python3 for JSON restructuring
- curl for HTTP requests

**Examples:**

```bash
JIRA_TICKET=<REDACTED> ./run -a do_jira_offline_fetch_ticket_content
./run -a do_jira_offline_fetch_ticket_content --ticket "<REDACTED> <REDACTED>"
```

**Output:**

- JSON snapshot in dat/jira/ticket-content/

---

### `do_jira_offline_fetch_ticket_description`

**File:** `src/bash/run/jira-offline-fetch-ticket-description.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_ticket_labels`

**File:** `src/bash/run/jira-offline-fetch-ticket-labels.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_ticket_map`

**File:** `src/bash/run/jira-offline-fetch-ticket-map.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_uat_ticket_state`

**File:** `src/bash/run/jira-offline-fetch-uat-ticket-state.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_fetch_upload_attachments_state`

**File:** `src/bash/run/jira-offline-fetch-upload-attachments-state.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_offline_search_and_fetch`

**File:** `src/bash/run/jira-offline-search-and-fetch.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_post_md`

**File:** `src/bash/run/jira-post-md.func.sh`

*⚠ Legacy format — no structured metadata available.*

Post a markdown file as a JIRA comment (converts to JIRA wiki format)

---

### `do_jira_post_prd_summary`

**File:** `src/bash/run/jira-post-prd-summary.func.sh`

*⚠ Legacy format — no structured metadata available.*

Auto-generate and post a PRD deployment summary comment to a JIRA

---

### `do_jira_post_wiki`

**File:** `src/bash/run/jira-post-wiki.func.sh`

*⚠ Legacy format — no structured metadata available.*

Post pre-formatted JIRA wiki content as a comment

---

### `do_jira_status_add`

**File:** `src/bash/run/jira-status-add.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_status_archive`

**File:** `src/bash/run/jira-status-archive.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_status_open`

**File:** `src/bash/run/jira-status-open.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_status_refresh`

**File:** `src/bash/run/jira-status-refresh.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_status_report`

**File:** `src/bash/run/jira-status-report.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_ticket_map`

**File:** `src/bash/run/jira-ticket-map.func.sh`

*⚠ Legacy format — no structured metadata available.*

Given a developer story ticket, return a complete map of ALL

---

### `do_jira_update_description`

**File:** `src/bash/run/jira-update-description.func.sh`

*⚠ Legacy format — no structured metadata available.*

Update the description of a JIRA ticket using a markdown file.

---

### `do_jira_upload_attachments`

**File:** `src/bash/run/jira-upload-attachments.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_jira_zip_ticket`

**File:** `src/bash/run/jira-zip-ticket.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_post_md_to_confluence`

**File:** `src/bash/run/post-md-to-confluence.func.sh`

Post markdown files as Confluence child pages under a given parent page.
Converts MD to Confluence storage format (XHTML) and creates/updates pages.
Idempotent: existing pages with the same title are updated, not duplicated.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `PARENT_CONFLUENCE_URL` | **required** | Full URL to the parent Confluence page |
| `MD_FILE` | optional | Single markdown file to post (one of MD_FILE or MD_DIR required) |
| `MD_DIR` | optional | Directory of markdown files (posts all *.md, skips internal config files) |
| `EXCLUDE_PATTERN` | optional | Regex to exclude internal config files from posting |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--parent-url` | `PARENT_CONFLUENCE_URL` |
| `--file` | `MD_FILE` |
| `--dir` | `MD_DIR` |
| `--exclude` | `EXCLUDE_PATTERN` |

**Prerequisites:**

- CONFLUENCE_PAT or token in ~/.osp/.trd/conflu_pat.conf.sh
- jq JSON processor (apt install jq)
- Optional: pandoc for high-quality markdown conversion (falls back to sed)

**Examples:**

```bash
./run -a do_post_md_to_confluence --parent-url https://<REDACTED>/spaces/TVH/pages/123/<REDACTED> --dir doc/md/<REDACTED>
./run -a do_post_md_to_confluence --parent-url https://<REDACTED>/spaces/TVH/pages/123/<REDACTED> --file doc/md/<REDACTED>/<REDACTED>.ANL.ppd.md
```

**Output:**

- Logs created/updated page URLs and summary counts

---

### `do_post_md_to_jira`

**File:** `src/bash/run/post-md-to-jira.func.sh`

Post a markdown file as a JIRA comment (converts to JIRA wiki format).

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | **required** | JIRA ticket ID (e.g., <REDACTED>) |
| `MD_FILE` | **required** | Path to markdown file to post |
| `JIRA_PAT` | optional | JIRA Personal Access Token (loaded from ~/.osp/.trd/jira-pat.conf.sh if not set) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |
| `--file` | `MD_FILE` |

**Examples:**

```bash
./run -a do_post_md_to_jira --ticket <REDACTED> --file doc/md/<REDACTED>/analysis.md
```

**Output:**

- Comment ID and direct URL to the posted comment

---

### `do_post_wiki_to_jira`

**File:** `src/bash/run/post-wiki-to-jira.func.sh`

Post pre-formatted JIRA wiki content as a comment to a JIRA ticket.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | **required** | JIRA ticket ID |
| `WIKI_CONTENT` | **required** | Pre-formatted JIRA wiki markup string |
| `JIRA_PAT` | optional | JIRA Personal Access Token (loaded from ~/.osp/.trd/jira-pat.conf.sh if not set) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |
| `--content` | `WIKI_CONTENT` |

**Examples:**

```bash
./run -a do_post_wiki_to_jira --ticket <REDACTED> --content "h2.
```

**Output:**

- Logs OK/FAIL for the comment post

---

### `do_print_help`

**File:** `src/bash/run/print-help.func.sh`

Display help/usage information for the run.sh framework.
Lists all available actions with their descriptions from metadata tags.

**Examples:**

```bash
./run --help
./run -a do_print_help
```

---

### `do_run_py_xml_parser`

**File:** `src/bash/run/run-py-xml-parser.func.sh`

Execute the Python XML parser on a specified XML file.

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `FILE` | `(optional)` |
| `DEMO` | `(optional)` |

**Prerequisites:**

- python3 installed on PATH

**Examples:**

```bash
./run -a run-py-xml-parser --file my_data.xml
./run -a run-py-xml-parser --demo
```

---

### `do_save_tmux_output`

**File:** `src/bash/run/save-tmux-output.func.sh`

Capture all tmux pane scrollback history into a single log file.
Copies to clipboard and clears panes for the next session.
Automatically skips internal tool panes.

**Prerequisites:**

- tmux running with active panes
- clip.exe (WSL) or xclip (Linux) for clipboard

**Examples:**

```bash
./run -a do_save_tmux_output
```

**Output:**

- Creates ~/var/log/log.log (or VAR_DIR/log/log.log on WSL)
- Previous log rotated to log.<timestamp>.log
- Content copied to system clipboard

---

### `do_search_confluence`

**File:** `src/bash/run/search-confluence.func.sh`

Search Confluence pages by text using the CQL search API.
Returns a clean list of matching pages with title, space, URL, and last modified date.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `CONFLUENCE_SEARCH` | **required** | The search term (text to find in page content/titles) |
| `CONFLUENCE_SEARCH_LIMIT` | optional | Max results to return (default: 25) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--search` | `CONFLUENCE_SEARCH` |
| `--limit` | `CONFLUENCE_SEARCH_LIMIT` |

**Prerequisites:**

- CONFLUENCE_PAT or token in ~/.osp/.trd/conflu_pat.conf.sh
- jq JSON processor (apt install jq)

**Examples:**

```bash
./run -a do_search_confluence --search "ETL pipeline"
./run -a do_search_confluence --search "<REDACTED>" --limit 10
```

**Output:**

- Logs each matching page: title, space key, page URL, last modified date

---

### `do_slack_fetch_recent_msgs`

**File:** `src/bash/run/slack-fetch-recent-msgs.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_slack_post_msg`

**File:** `src/bash/run/slack-post-msg.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_slack_post_thread`

**File:** `src/bash/run/slack-post-thread.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_slack_setup_mac`

**File:** `src/bash/run/slack-setup-mac.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_slack_upload_file_to_thread`

**File:** `src/bash/run/slack-upload-file-to-thread.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_test_config`

**File:** `src/bash/run/test-config.func.sh`

Test action to verify configuration loading and overrides.

**Examples:**

```bash
./run -a do_test_config
```

**Output:**

- Logs the value of OVERRIDE_VAR (or "not_set" if unloaded)

---

### `do_test_custom_args`

**File:** `src/bash/run/test-custom-args.func.sh`

Example action using custom getopts parsing logic.

---

### `do_test_hooks`

**File:** `src/bash/run/test-hooks.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_test_hooks.post`

**File:** `src/bash/run/test-hooks.post.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_test_hooks.pre`

**File:** `src/bash/run/test-hooks.pre.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_test_named_args`

**File:** `src/bash/run/test-named-args.func.sh`

Test action for decentralized named argument parsing. Each action now defines its own parsing logic in an _args hook

---

### `do_test_py_xml_parser`

**File:** `src/bash/run/test-py-xml-parser.func.sh`

Run all Python tests for the XML parser module.
Discovers and executes all test_*.py and run_tests.py files
under src/python/xml-parser/tests/ using unittest.

**Prerequisites:**

- python3 installed on PATH

**Examples:**

```bash
./run -a do_test_py_xml_parser
```

**Output:**

- Test results with pass/fail counts per test method

---

### `do_update_confluence_page`

**File:** `src/bash/run/update-confluence-page.func.sh`

Update an existing Confluence page's content from a markdown file.
Unlike post-md-to-confluence (which creates child pages), this updates a specific page by URL.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `CONFLUENCE_URL` | **required** | Full URL to the Confluence page to update |
| `MD_FILE` | **required** | Markdown file with the new content |
| `NEW_TITLE` | optional | Override the page title (default: uses first # heading from MD) |
| `DRY_RUN` | optional | Set to "true" to show what would be updated without changing |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--url` | `CONFLUENCE_URL` |
| `--file` | `MD_FILE` |
| `--title` | `NEW_TITLE` |
| `--dry-run` | `DRY_RUN` |

**Prerequisites:**

- CONFLUENCE_PAT or token in ~/.osp/.trd/conflu_pat.conf.sh
- jq JSON processor (apt install jq)
- Optional: pandoc for markdown conversion (falls back to sed)

**Examples:**

```bash
./run -a do_update_confluence_page --url https://<REDACTED>/spaces/TVH/pages/123/title --file doc/md/<REDACTED>/<REDACTED>.SUM.md
./run -a do_update_confluence_page --dry-run true --url https://<REDACTED>/pages/123/title --file doc/md/file.md
```

**Output:**

- Logs updated page URL and version number

---

### `do_upload_attachments_to_jira`

**File:** `src/bash/run/upload-attachments-to-jira.func.sh`

Upload file(s) as attachments to a JIRA ticket using the JIRA REST API.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | **required** | Ticket key (e.g., <REDACTED>) |
| `ATTACHMENT_FILES` | optional | Space-separated list of file paths (one of FILES or DIR required) |
| `ATTACHMENT_DIR` | optional | Directory to upload from (used with ATTACHMENT_GLOB) |
| `ATTACHMENT_GLOB` | optional | Glob pattern for files in ATTACHMENT_DIR (default: *) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |
| `--files` | `ATTACHMENT_FILES` |
| `--dir` | `ATTACHMENT_DIR` |
| `--glob` | `ATTACHMENT_GLOB` |

**Prerequisites:**

- JIRA_PAT Personal Access Token (loaded from ~/.osp/.trd/jira-pat.conf.sh)

**Examples:**

```bash
./run -a do_upload_attachments_to_jira --ticket <REDACTED> --files "/path/file1.pdf
./run -a do_upload_attachments_to_jira --ticket <REDACTED> --dir /path/to/dir --glob "*.pdf"
```

**Output:**

- Logs upload status per file (success/failure with attachment ID)

---

### `do_zip_dat`

**File:** `src/bash/run/zip-dat.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_zip_doc`

**File:** `src/bash/run/zip-doc.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_zip_jira_ticket`

**File:** `src/bash/run/zip-jira-ticket.func.sh`

Create a timestamped zip file containing all files related to a JIRA ticket.
Finds all files with the ticket ID in their path or filename and packages
them for delivery.

**Parameters:**

| Variable | Required | Description |
|----------|----------|-------------|
| `JIRA_TICKET` | **required** | The JIRA ticket ID (e.g., <REDACTED>) |
| `ZIP_EXCLUDE_DATA` | optional | Set to 1 to exclude *.json and *.out files |
| `ZIP_SLIM` | optional | Set to 1 to exclude data files AND test result artifacts |
| `NO_BASH` | optional | Set to 1 to exclude bash scripts (*.sh, *.bash) |
| `NO_PYTHON` | optional | Set to 1 to exclude python scripts (*.py) |

**Named Arguments:**

| Flag | Variable |
|------|----------|
| `--ticket` | `JIRA_TICKET` |
| `--exclude-data` | `ZIP_EXCLUDE_DATA` |
| `--slim` | `ZIP_SLIM` |
| `--no-bash` | `NO_BASH` |
| `--no-python` | `NO_PYTHON` |

**Prerequisites:**

- zip command available on PATH

**Examples:**

```bash
./run -a do_zip_jira_ticket --ticket <REDACTED>
./run -a do_zip_jira_ticket --exclude-data 1 --ticket <REDACTED>
./run -a do_zip_jira_ticket --slim 1 --ticket <REDACTED>
./run -a do_zip_jira_ticket --no-bash 1 --no-python 1 --ticket <REDACTED>
```

**Output:**

- Creates /mnt/c/Temp/var/<TICKET>.<timestamp>.zip
- Displays both Unix and Windows paths to the zip file

---

### `do_zip_project`

**File:** `src/bash/run/zip-project.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

### `do_zip_src`

**File:** `src/bash/run/zip-src.func.sh`

*⚠ Legacy format — no structured metadata available.*

---

## Summary

- **Total actions:** 107
- **With structured metadata:** 34
- **Legacy (untagged):** 73
