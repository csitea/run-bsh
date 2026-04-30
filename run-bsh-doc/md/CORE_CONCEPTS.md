# Core Concepts

`run-bsh` is built around the idea of a central entry point (`run.sh`) that dynamically loads and executes "actions" defined in modular shell scripts.

## The `run.sh` Entry Point

The `run.sh` script is the main orchestrator. It performs the following steps:
1. **Environment Setup:** Sets up global variables like `PROJ_PATH`, `ORG_APP_PATH`, etc.
2. **Function Loading:** Sources all `*.func.sh` files from `lib/bash/funcs/` and `src/bash/run/`.
3. **Action Dispatching:** Identifies the requested actions from the `--actions` (or `-a`) flag and executes them.

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
