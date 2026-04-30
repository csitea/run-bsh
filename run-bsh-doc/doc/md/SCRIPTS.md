# Standalone Scripts

This page documents utility scripts located in `src/bash/scripts/` that are not part of the primary action runner.

## commit-msg
**File:** `run-bsh-utl/src/bash/scripts/commit-msg`

### Description
Enforces JIRA-style ticket IDs as a suffix in git commit messages.

### Parameters
```text
COMMIT_MSG_FILE (required) - Path to the file containing the commit message.
```

### Examples
```bash
commit-msg .git/COMMIT_EDITMSG
```

---

## enable-www-data.sh
**File:** `run-bsh-utl/src/bash/scripts/enable-www-data.sh`

### Description
Enables OS login for the www-data user, sets home directory, and configures permissions.

### Parameters
```text
WWW_PASSWORD (required) - The password to set for the www-data user.
```

### Examples
```bash
sudo ./enable-www-data.sh "your_secure_password"
```

---

## git-pull-rebase-all.sh
**File:** `run-bsh-utl/src/bash/scripts/git-pull-rebase-all.sh`

### Description
Recursively finds and updates all git repositories in the parent directory using rebase.

### Examples
```bash
./git-pull-rebase-all.sh
```

---

## install-all-wp-plugins.sh
**File:** `run-bsh-utl/src/bash/scripts/install-all-wp-plugins.sh`

### Description
Unzips and activates a predefined list of WordPress plugins using WP-CLI.

### Examples
```bash
./install-all-wp-plugins.sh
```

---

## start-wpp-dev.sh
**File:** `run-bsh-utl/src/bash/scripts/start-wpp-dev.sh`

### Description
Starts PHP-FPM and Nginx services for the WordPress development environment.

### Examples
```bash
./start-wpp-dev.sh
```

---



![[SCRIPTS.png]]
