---
name: configure-sandbox
description: Guide users through configuring local sandboxing in workspace and/or global settings YAML. Use when users ask to enable sandboxing, configure sandboxing, choose read-only vs read-write sandboxing, set network policy, inspect sandbox settings, or update .poolside/settings.local.yaml or global settings.
metadata:
  version: "0.1.1"
---

# Configure Sandboxing

Guide the user through configuring local sandboxing for pool.

## Goal

Help the user choose and write a `sandbox:` configuration in one or both of:

- Workspace-local settings: `<workspace>/.poolside/settings.local.yaml`
- Shared workspace settings: `<workspace>/.poolside/settings.yaml`
- Global user settings: the Poolside user config `settings.yaml` (use the path already used by the codebase or CLI when available)

Prefer workspace-local settings for project-specific choices. Prefer global settings for defaults the user wants across many workspaces.

## Use questions when possible

If the `question` tool is available, use it to guide setup instead of guessing. Ask concise questions such as:

1. **Scope**: configure this workspace only, global defaults, or both?
2. **Sandbox mode**:
   - **Filesystem sandboxing** (`read-only`): workspace is mounted read-only; agent changes are staged for review before applying.
   - **Shell sandboxing** (`read-write`): tools run in a container, but workspace writes apply directly to local files.
3. **Image**: use the default image or provide an existing image tag?
4. **Network policy**: unrestricted, block all, allow-list only, or leave unchanged?
5. **Environment/secrets/mounts**: any environment variables, named secrets, or extra host paths to expose?

If `question` is unavailable, explain the choices and ask the user to pick before editing files unless they already gave enough detail.

## Configuration model

pool enables local sandboxing when a loaded settings file contains a top-level `sandbox:` object. Settings are merged from lower to higher priority:

1. Global user settings
2. Shared workspace settings (`.poolside/settings.yaml`)
3. Local workspace settings (`.poolside/settings.local.yaml`)

Higher-priority scalar fields override lower-priority values. `env_vars` are merged by key. `network` and `filesystem` are replacement-style sections when specified at a higher priority.

## Important defaults

- If `sandbox:` is absent everywhere, the sandbox is disabled.
- If `sandbox:` is present but `filesystem.workspaces.access` is omitted, workspace access defaults effectively to `read-write` (**shell sandboxing**).
- Use `read-only` for **filesystem sandboxing**.
- Use `read-write` for **shell sandboxing**.
- If `image` is omitted, pool uses its built-in default local sandbox image, currently `ubuntu:22.04`. Specify `image` only when the user wants a different existing image tag.
- If `network` is omitted or policy is `unsafe-allow-all`, network access is unrestricted.

## YAML reference

### Minimal filesystem sandboxing for one workspace

Write to `<workspace>/.poolside/settings.local.yaml`:

```yaml
sandbox:
  filesystem:
    workspaces:
      access: read-only
```

### Minimal shell sandboxing

```yaml
sandbox:
  filesystem:
    workspaces:
      access: read-write
```

### With an explicit image

Use an existing image tag. If omitted, pool defaults to `ubuntu:22.04`. Do not create a Dockerfile unless the user specifically asks for one outside this skill.

```yaml
sandbox:
  image: ubuntu:24.04
  filesystem:
    workspaces:
      access: read-only
```

### Network policies

Unrestricted network (explicit):

```yaml
sandbox:
  network:
    policy: unsafe-allow-all
```

Block network egress:

```yaml
sandbox:
  network:
    policy: off
```

Allow-list domains and CIDRs:

```yaml
sandbox:
  network:
    policy: allow-list
    egress:
      allowed_domains:
        - github.com
        - api.example.com
      allowed_cidrs:
        - 10.0.0.0/8
```

### Environment variables, secrets, and mounts

```yaml
sandbox:
  env_vars:
    NODE_ENV: development
  secrets:
    - GITHUB_TOKEN
  filesystem:
    workspaces:
      access: read-only
    mounts:
      - host: /absolute/host/path
        sandbox: /mnt/data
        access: read-only
```

Notes:

- `env_vars` values are literal strings stored in settings; do not write secret values there.
- `secrets` names refer to secrets pool's secret store can provide. Do not ask the user to reveal secret values.
- `filesystem.mounts[].host` and `filesystem.mounts[].sandbox` should be absolute paths.
- Mount access is `read-only` or `read-write`.

## Editing workflow

1. Inspect existing relevant settings files before editing:
   - `<workspace>/.poolside/settings.local.yaml`
   - `<workspace>/.poolside/settings.yaml`
   - global `settings.yaml` when configuring global defaults
2. Preserve unrelated settings and formatting where practical.
3. Create the `.poolside/` directory if writing workspace settings and it does not exist.
4. Merge or update only the `sandbox:` section needed for the user's choices.
5. Avoid duplicating keys in YAML.
6. Do not overwrite user settings wholesale unless the file only contains obsolete sandbox content and the user agreed.
7. After editing, summarize:
   - Which file(s) changed
   - Effective sandbox mode
   - Image choice
   - Network policy
   - Any secrets, env vars, or mounts configured

## Verification

Sandbox configuration is loaded when a session is created. After editing settings, tell the user to start a new session (with `/new`) before checking the effective state.

In the new session, suggest running:

```text
/sandbox
```

`/sandbox` reports the effective sandbox state, selected image, network policy, and configuration sources used for that session. If the user runs `/sandbox` in the old session, it may still show the previous state because the sandbox was already initialized.

If the user wants to test behavior, use the new session so tool execution uses the updated sandbox configuration.
