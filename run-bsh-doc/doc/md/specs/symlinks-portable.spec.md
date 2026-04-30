# Portable symlink setup — spec

**Status:** draft (2026-04-24)
**Scope:** `run.sh` framework (primary) + every shell action that currently references `/opt/...` or `/var/...` literals (secocsiry)
**Out of scope:** Windows-only paths (already handled by the existing `WIN_BIN_DIR` / `BASE_PATH` cross-platform conventions)

---

## 1. Goal

Make the `run.sh` framework **itself** resolve the correct base-directory roots at boot — so every shell action just uses framework-provided env vars, never hardcodes `/opt` or `/var`. Concretely: `run.sh` detects and exports `BASE_PATH` (the `/opt`-equivalent root) and `VAR_BASE_PATH` (the `/var`-equivalent root) during `main_exec`, before any action runs. Shell actions consume them the same way they consume `$PROJ_PATH` today — nobody re-detects, nobody hardcodes.

This unlocks the system on:

- Non-sudo user accounts on shared / locked-down hosts.
- Cloud CI runners, throwaway dev containers, ephemeral VMs.
- Personal laptops where the user wants everything under `~/`.

On such boxes the detection falls back to `$HOME/opt` and `$HOME/var`; on the current sudo boxes it stays at `/opt` and `/var` — no observable change.

Naming note: `BASE_PATH` already exists in the project's cross-platform conventions table (CLAUDE.md) as the `/opt`-root abstraction. We reuse it. `VAR_BASE_PATH` is a new symmetric variable for the `/var` root.

## 2. Problem

Current `do_setup_symlinks` hardcodes literal absolute paths:

```bash
local -a img_specs=(
  "<REDACTED>|/alc-frw-doc/doc/img|<REDACTED>|/var/alc/alc-frw/alc-frw-doc/doc/img"
  "/opt/csi/run-bsh/run-bsh-utl/.gitignore|/doc/img|/opt/csi/run-bsh/run-bsh-utl/doc/img|/var/csi/run-bsh/run-bsh-doc/doc/img"
)
```

On a non-sudo box:
- `mkdir -p /var/...` fails with `EACCES`.
- `ln -s <target> /opt/...` fails with `EACCES`.
- `do_verify_symlinks` at boot warns about missing symlinks that cannot be created — the warnings never go away.

The same hardcoding exists in many other actions (`do_zip_proj`, `do_zip_doc_proj`, `do_setup_symlinks`, `do_verify_symlinks`, `confluence-*.func.sh` defaults, `do_require_not_utl_source`, etc.).

## 3. Design — framework-level, project-agnostic

The portability capability belongs in `run.sh` and `lib/bash/funcs/`, **not** in per-project action code. Any project that bootstraps on top of the `run.sh` "shell-actions" philosophy inherits the behaviour for free — no project-specific patching.

### 3.1 Two framework env vars

Exported by `run.sh` at boot, before any shell action runs:

| Variable | Meaning | Default on a sudo box | Default on a non-sudo box |
|---|---|---|---|
| `BASE_PATH` | Root for source/code trees (the `/opt` in `/opt/<org>/<app>/...`). Already used by the project's cross-platform convention table in CLAUDE.md — reusing the same name. | `/opt` | `$HOME/opt` |
| `VAR_BASE_PATH` | Root for runtime/generated trees (the `/var` in `/var/<org>/<app>/...`). New; symmetric to `BASE_PATH`. | `/var` | `$HOME/var` |

Every action that currently hardcodes `/opt/...` becomes `${BASE_PATH}/...`; every `/var/...` becomes `${VAR_BASE_PATH}/...`. No action re-detects — detection is a boot-time one-shot.

### 3.2 Resolution precedence (run once in `run.sh:main_exec`)

1. **Explicit env var** — if the caller exports `BASE_PATH` / `VAR_BASE_PATH`, use those verbatim. No detection.
2. **Pre-existing symlink** — if `$HOME/opt` exists and points at `/opt` (or vice-versa), honour that user-managed setup.
3. **Write-probe** — attempt `touch /opt/.probe-$$` (and `/var/.probe-$$`) and remove; if the probe succeeds, use `/opt` / `/var`.
4. **Fallback** — `BASE_PATH=$HOME/opt`, `VAR_BASE_PATH=$HOME/var`. Directories created at first use via `mkdir -p` (idempotent, cheap).

Each half is decided independently, so a box with writable `/var` but read-only `/opt` naturally gets `BASE_PATH=$HOME/opt; VAR_BASE_PATH=/var`.

### 3.3 Project-agnostic by construction

The framework **never** enumerates project-specific symlinks. Every project declares what it needs in its own config:

- `cnf/bash/project.conf.sh` (or a new `cnf/symlinks.sh`) declares an array of `link|target` pairs expressed in terms of `${BASE_PATH}` / `${VAR_BASE_PATH}`.
- `do_setup_symlinks` / `do_verify_symlinks` iterate over whatever the current project declared.
- The framework provides the primitives; projects provide the manifest.

This means `run-bsh-utl` declares its 4 symlinks (doc/img × 2, dat/log, dat/jira) in its own config, and a future `abc-xyz-utl` project declares a different set. The framework code is identical for both.

### 3.4 Boot sequence insertion

`run.sh:main_exec` current order:

```
do_load_functions
do_load_config
do_require_bins
do_verify_symlinks      ← already added in c19bb99
do_run_actions
```

After this spec lands:

```
do_load_functions
do_detect_base_paths    ← new; sets BASE_PATH, VAR_BASE_PATH via env
do_load_config          ← proj.cnf may now reference ${BASE_PATH} / ${VAR_BASE_PATH}
do_require_bins
do_verify_symlinks      ← now reads project's symlinks manifest
do_run_actions
```

`do_detect_base_paths` is a framework function (`lib/bash/funcs/`). It is invoked **before** `do_load_config` so that `proj.cnf` and its derivatives (`$PROJ_PATH`, `$OPT_DIR`, `$VAR_DIR`) can reference the detected bases.

## 4. Concrete transitions

### 4.1 Framework — new file `lib/bash/funcs/detect-base-paths.func.sh`

```bash
do_detect_base_paths() {
  BASE_PATH="${BASE_PATH:-$(_probe_writable_root /opt $HOME/opt)}"
  VAR_BASE_PATH="${VAR_BASE_PATH:-$(_probe_writable_root /var $HOME/var)}"
  export BASE_PATH VAR_BASE_PATH
}

# Returns the first writable candidate; creates the fallback if neither
# exists yet. Never prompts, never sudos.
_probe_writable_root() {
  local primary="$1" fallback="$2"
  if [[ -d "$primary" ]] && { : > "$primary/.probe-$$"; } 2>/dev/null; then
    rm -f "$primary/.probe-$$"
    echo "$primary"
  else
    mkdir -p "$fallback"
    echo "$fallback"
  fi
}
```

### 4.2 Framework — `run.sh:main_exec` adds one line

```bash
main_exec() {
  local args=("$@")
  do_load_functions
  do_detect_base_paths      # ← new line
  do_load_config
  do_require_bins
  do_verify_symlinks
  ...
}
```

### 4.3 Framework — `do_verify_symlinks` / `do_setup_symlinks` become manifest-driven

Replace the inline `expected=(...)` / `img_specs=(...)` arrays with a read of `${PROJ_SYMLINK_MANIFEST}` — an array the current project's config has exported. The framework code is generic; no project names anywhere.

```bash
# lib/bash/funcs/verify-symlinks.func.sh
do_verify_symlinks() {
  local -a manifest=( "${PROJ_SYMLINK_MANIFEST[@]:-}" )
  [[ ${#manifest[@]} -eq 0 ]] && return 0     # no symlinks declared → nothing to check
  # ... same validation loop as today, using manifest entries ...
}
```

### 4.4 Per-project — each project declares its symlinks in its config

For `run-bsh-utl` (adds to `cnf/bash/project.conf.sh`):

```bash
PROJ_SYMLINK_MANIFEST=(
  "${BASE_PATH}/alc/alc-frw/alc-frw-doc/doc/img|${VAR_BASE_PATH}/alc/alc-frw/alc-frw-doc/doc/img"
  "${BASE_PATH}/csi/run-bsh/run-bsh-utl/doc/img|${VAR_BASE_PATH}/csi/run-bsh/run-bsh-doc/doc/img"
  "${BASE_PATH}/csi/run-bsh/run-bsh-utl/dat/log|${VAR_BASE_PATH}/csi/run-bsh/run-bsh-utl/dat/log"
  "${BASE_PATH}/csi/run-bsh/run-bsh-utl/dat/jira|${VAR_BASE_PATH}/csi/run-bsh/run-bsh-utl/dat/jira"
)
export PROJ_SYMLINK_MANIFEST
```

A future sibling project (`abc-xyz-utl`) declares its own manifest; the framework happily iterates it.

### 4.5 Remaining callers with `/opt` / `/var` literals

`do_require_not_utl_source`, the 6 `confluence-*.func.sh` publish actions, `do_zip_proj`, `do_zip_doc_proj` and any other action with hardcoded paths all replace literals with `${BASE_PATH}` / `${VAR_BASE_PATH}`. Mechanical `sed` pass, spot-checked.

### 4.6 Pre-commit git hook — no change needed

The hook at `cnf/bash/git-hooks/pre-commit` uses `git rev-parse --show-toplevel`; it never references `/opt` or `/var` literals. Already portable.

## 5. Backwards compatibility

- On any current sudo box, `BASE_PATH` auto-detects as `/opt` and `VAR_BASE_PATH` as `/var`. **No observable change** in behaviour for any action.
- The CLAUDE.md rule "software must live under `/opt/`" is the sudo-box special case of "software must live under `${BASE_PATH}/`". The imperative is preserved; only the literal becomes a variable.
- Existing derived vars (`$OPT_DIR`, `$VAR_DIR`, `$PROJ_PATH`) that `run.sh` derives are now computed from `${BASE_PATH}` / `${VAR_BASE_PATH}` rather than hardcoded. They remain available to shell actions unchanged.
- Any tool outside `run.sh` that used `/opt/...` literally (e.g. an ad-hoc shell script a user wrote) keeps working on the sudo box, breaks on the non-sudo box — the breakage is self-announcing (`EACCES`) and the fix is to also use `${BASE_PATH}`.

## 6. Non-goals

- Not rewriting the `/opt` vs `/var` split convention (source vs runtime). Only the **root** is made configurable.
- Not replacing the canonical <REDACTED> / ysg ownership rules on sudo boxes. Those still apply where `OPT_BASE=/opt`.
- Not supporting arbitrary *mixed* project layouts (e.g. `run-bsh-utl` under `$HOME/opt` while `alc-frw-doc` lives under `/opt`). Both repos sit under the same `OPT_BASE`; if a user needs a split, they can set `OPT_BASE` at action invocation time explicitly.
- Not introducing a `$HOME/etc/...` conf path — `cnf/bash/proj.cnf` stays inside the project tree under `${OPT_BASE}/csi/run-bsh/run-bsh-utl/cnf/`.

## 7. Test plan

| # | Scenario | Expected |
|---|---|---|
| 1 | Current sudo box, no env override | `OPT_BASE=/opt`, `VAR_BASE=/var`; every action runs as today |
| 2 | `OPT_BASE=$HOME/opt VAR_BASE=$HOME/var ./run -a do_setup_symlinks` | Creates `$HOME/opt/...` + `$HOME/var/...` trees, symlinks + `.gitignore` entries land inside them |
| 3 | Fresh non-sudo user, no env vars, `/opt` unwritable | Auto-detect falls back to `$HOME/opt` / `$HOME/var`; `do_setup_symlinks` completes without sudo |
| 4 | `do_verify_symlinks` on a freshly-provisioned non-sudo box after step 3 | Silent (all symlinks valid) |
| 5 | `do_confluence_publish_alc_frw_api1` with non-sudo `OPT_BASE` | Publishes from `$HOME/opt/alc/...`; `do_require_not_utl_source` still rejects `$HOME/opt/csi/run-bsh/run-bsh-utl` paths |
| 6 | `do_zip_proj` on non-sudo `OPT_BASE`, symlinks pointing into `$HOME/var/...` | Zip stores symlinks as links (zip `-y`); post-zip audit still rejects any binary under `doc/img/` |
| 7 | Mixed: `OPT_BASE=/opt` but `VAR_BASE=$HOME/var` (split) | Works — symlinks point from `/opt/.../doc/img` to `$HOME/var/.../doc/img` |

## 8. Migration plan

Five phases; each phase independently mergeable.

| Phase | Change | Risk |
|---|---|---|
| 1 | This spec (no code) | None |
| 2 | Add `OPT_BASE`, `VAR_BASE`, `do_detect_opt_base`, `do_detect_var_base` to `proj.cnf` + `lib/bash/funcs/detect-base-paths.func.sh`. **No call sites changed.** | Low — adds unused variables |
| 3 | Parameterize `do_setup_symlinks`, `do_verify_symlinks`, `do_require_not_utl_source` | Low — covered by tests 1–4 |
| 4 | Audit + parameterize `confluence-*.func.sh`, `zip-proj.func.sh`, `zip-doc-proj.func.sh`, any other hardcoded `/opt/...` or `/var/...` in `src/bash/run/` | Medium — many files; mechanical sed pass then spot-check |
| 5 | Validate end-to-end on a real non-sudo box (fresh RHEL/Ubuntu user, no sudo). Document any remaining gaps. | High — first real deployment on non-sudo |

## 9. Open questions

- **Auto-detection cost.** `do_detect_opt_base` writes a probe file on every `./run` invocation if `OPT_BASE` isn't already exported. Cache the result in an env var after the first run, or cache to `$HOME/.cache/run-bsh-utl/base-paths`. Cheap either way; decide during phase 2.
- **Relocation of `$HOME/.jira/`, `$HOME/.gcp/`, `$HOME/.ssh/` credential paths.** These are already under `$HOME` and portable; no change.
- **`/home/<USER>/opt` vs `$HOME/opt`.** They're equivalent in practice. Spec uses `$HOME/opt` because it's shell-portable; documentation can show `/home/<USER>/opt` for user-facing clarity.
- **Symlink permanence when `$HOME` rotates.** If the user's home dir moves (e.g. NFS migration), the `.gitignore`-anchored paths are project-relative (`/doc/img`, not `$HOME/...`), so nothing in git breaks. Only the `$HOME/var/...` target dirs need re-creating; `do_setup_symlinks` is idempotent — one invocation fixes it.
- **Handling `git-relay`.** The relay flow writes through `$HOME/.gcp/.bnc/` and the GCS bucket — both already portable. No changes from this spec needed.

## 10. Acceptance criteria

The portable-base implementation is accepted when all of:

1. On the current `csi` box, `./run -a do_setup_symlinks` and all confluence / jira / zip actions behave identically to the pre-spec baseline.
2. On a non-sudo RHEL/Ubuntu user account with only `$HOME` write access, running `./run -a do_setup_symlinks` creates the symlinks under `$HOME/opt` and `$HOME/var` without any sudo prompt or `EACCES`.
3. On that same non-sudo box, `./run -a do_confluence_publish_alc_frw_api1` in dry-run mode enumerates all 12 sections correctly using the `$HOME<REDACTED>` base.
4. `do_require_not_utl_source` still refuses a path under `${OPT_BASE}/csi/run-bsh/run-bsh-utl` regardless of whether `${OPT_BASE}` is `/opt` or `$HOME/opt`.
5. No active hardcoded `/opt/` or `/var/` path survives in `src/bash/run/*.func.sh` outside of comments/examples.


![[symlinks-portable.spec.png]]
