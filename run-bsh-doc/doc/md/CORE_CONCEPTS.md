# Core Concepts

`run-bsh` is built around the idea of a central entry point (`run.sh`) that dynamically loads and executes "actions" defined in modular shell scripts.

## Environment Initialization

The framework automatically derives project metadata from its location in the filesystem. This is handled by the `do_set_vars` function in `run.sh`.

### Key Naming Conventions

The system expects a canonical layout: `${BASE_PATH}/${ORG}/${APP}/${PROJ}`.
Typically `PROJ` is named `${APP}-${PROJ_KIND}`.

| Variable | Derived From | Example |
| :--- | :--- | :--- |
| `BASE_PATH` | The root installation directory. | `/opt` |
| `ORG` | The organization name. | `csi` |
| `APP` | The application or project suite name. | `run-bsh` |
| `PROJ` | The specific sub-project name. | `run-bsh-utl` |
| `PROJ_KIND` | The suffix of `PROJ` after `APP-`. | `utl` |

### Path Variables

The following absolute paths are also exported:
- `PROJ_PATH`: Root of the current sub-project.
- `APP_PATH`: Parent directory containing all sub-projects for the application.
- `ORG_PATH`: Directory containing all applications for the organization.
- `VAR_DIR`: standardized location for persistent data and logs (typically `/var` or `$BASE_PATH/../var`).

Any of `ORG`, `APP`, or `PROJ_KIND` can be overridden by exporting the variable before invocation.


## Actions (`do_*`)

An action is a Bash function whose name starts with `do_`. By convention, an action named `do_my_action` should be defined in a file named `my-action.func.sh`.

### Loading Convention
The loader converts kebab-case filenames to snake_case function names:
`my-cool-action.func.sh` → `do_my_cool_action`

## Hooks

The framework supports `pre` and `post` hooks for every action.
- **Pre-hook:** If a function named `do_action_name_pre` exists, it is executed before `do_action_name`.
- **Post-hook:** If a function named `do_action_name_post` exists, it is executed after `do_action_name`, even if the main action fails (unless a fatal error occurs).

## Metadata Tags

`run-bsh` supports structured metadata in function file headers using `@` tags. These tags are used for documentation and validation.

| Tag | Description |
| :--- | :--- |
| `@description` | A brief description of the action or function. |
| `@param` | Defines a parameter, usually an environment variable. Format: `VAR_NAME (required\|optional) - Description`. |
| `@arg` | Maps a command-line flag to an environment variable. Format: `--flag VAR_NAME`. |
| `@example` | Provides a usage example. |
| `@prereq` | Lists binary or environment prerequisites. |
| `@output` | Describes the output of the function. |
| `@see` | References related actions or documentation. |

## Parameter Validation

If an action has `@param` tags marked as `(required)`, the framework automatically validates that the corresponding environment variables are set before executing the action.

## Logging

The `do_log` function provides a standardized way to log messages with different levels: `INFO`, `DEBUG`, `WARNING`, `ERROR`, `FATAL`, `OK`. Logs are displayed on the screen and written to a file in `dat/log/bash/`.


![[CORE_CONCEPTS.png]]
