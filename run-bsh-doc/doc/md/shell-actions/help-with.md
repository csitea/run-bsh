# 🛠️ do_help_with

**📁 File:** `src/bash/run/help-with.func.sh`

## 📝 Description
Provides a searchable help interface for all actions and functions within the orchestration repository. This utility retrieves and displays structured metadata (e.g., `@description`, `@param`, `@example`) when available, ensuring that technical guidance is easily accessible to all users.

## ⚙️ How It Works
1. **Keyword Search:** Scans the action repository for metadata tags that match the specified search term.
2. **Metadata Presentation:** Formats and displays structured information for modern actions.
3. **Legacy Fallback:** If structured metadata is absent, retrieves raw comment headers to provide basic technical context.

## 📊 Parameters
| Parameter | Required | Description |
|-----------|----------|-------------|
| `SRCH` | **Yes** | The search term or keyword to match against action names and documentation. |

## 🚀 Examples
```bash
# Search for documentation on Jira-related actions
./run -a do_help_with --search jira

# Search for documentation on zip-related actions
./run -a do_help_with --search zip
```

## 🛡️ Integrity & Validation
- **Search Scope:** Ensures comprehensive coverage across both modern and legacy action files.
- **Variable Constraints:** `SRCH` must be provided to execute the search operation.

---
*Technical Reference — CSI Orchestration*


![[help-with.png]]
