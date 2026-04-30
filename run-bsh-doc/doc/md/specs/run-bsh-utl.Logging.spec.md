# 📜 run-bsh-utl.Logging.spec.md — Framework Logging Specification

## 🏢 Overview
The `run-bsh` framework implements a standardized, multi-channel logging system designed for enterprise-grade auditability, debugging, and real-time observability. It ensures that every action execution is captured with consistent metadata across different environments.

---

## ⚙️ Core Components

### 1. Standardized Log Levels
The framework categorizes all messages into distinct severity levels, each with associated visual cues (colors and emojis) for terminal output.

| Level | Terminal Color | Emoji | Use Case |
| :--- | :--- | :--- | :--- |
| `FATAL` | Red | ❌ | Unrecoverable system failure; immediate exit. |
| `ERROR` | Red | ❌ | Recoverable functional error; action failure. |
| `WARNING` | Yellow | ⚠ | Unexpected behavior or configuration gap. |
| `INFO` | Blue | ℹ | General operational progress. |
| `OK` | Green | ✔ | Successful completion of a task or action. |
| `DEBUG` | Cyan | ⚙ | Detailed internal diagnostics (hidden by default in some views). |

### 2. Output Channels 🔄
Logs are simultaneously routed to three primary channels:

1.  **Interactive Console (Stdout/Stderr)**: Color-coded real-time feedback for the operator.
2.  **Persistent Daily Log**: A long-term audit trail located at `dat/log/bash/${PROJ}.${YYYYMMDD}.log`. This file aggregates all runs for a specific day.
3.  **Execution Snapshots**: Per-run output captures located in `~/var/log/${PROJ}/`.
    -   `*.out.log`: Captures stdout.
    -   `*.err.log`: Captures stderr.

---

## 🧬 Technical Specification

### 1. Standard Log Format
Every log entry follows a fixed-width, searchable format:

```text
 [LEVEL]  YYYY-MM-DD HH:MM:SS TZ [PROJECT][@HOST] [PID] [ACTION] Message...
```

- **Metadata Block**: Includes project name, host, and process ID (PID) for correlation.
- **Action Alignment**: The `START` and `STOP` keywords are automatically padded to ensure vertical alignment of the business message.

### 2. Directory Resolution Priority 🧭
The logging engine resolves the target directory in the following order:

1.  **Explicit**: `${LOG_DIR}` (if exported by caller).
2.  **Primary Audit Path**: `/var/csi/run-bsh/run-bsh-utl`.
    -   The system first checks if this directory exists.
    -   If missing, it attempts to create it.
3.  **Fallback Path**: `/opt/csi/run-bsh/run-bsh-utl/dat/log`.
    -   Used if the Primary Audit Path cannot be created or is not writable.

The log file name remains standardized as `${PROJ:-run}.$(date "+%Y%m%d").log`.

---

## 🛠️ Implementation Standards

### Developer Usage
Developers should use the `do_log` function for all output. Direct `echo` or `printf` should be avoided as they bypass the persistent audit trail.

**Correct Pattern:**
```bash
do_log "INFO START ::: Processing data"
do_log "DEBUG Current state: $state"
do_log "OK Process completed successfully"
```

### Framework Wrapping
The `run.sh` main entry point is responsible for initializing the execution log redirection:

```bash
main_exec "$@" \
  > >(tee $main_log_dir/${RUN_UNIT:-run.sh}.$ts.out.log) \
  2> >(tee $main_log_dir/${RUN_UNIT:-run.sh}.$ts.err.log)
```

---
*Technical Specification — CSI BSH Architecture Group*
