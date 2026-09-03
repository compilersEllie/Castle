---
name: pool-product-reference
description: Answer questions about the Poolside `pool` CLI itself — installation, interactive (TUI) mode, automated (`pool exec`) mode, editor integration (`pool acp`), slash commands, keyboard shortcuts, configuration, log locations, managing MCP/ACP servers, login, troubleshooting, and update. Triggers on questions like "how do I install pool", "what slash commands do you support", "how do I add an MCP server", "where are my logs", "how do I run pool non-interactively", "how do I use pool from Zed/JetBrains/Neovim", "how do I connect pool to another agent server", "how do I configure pool", or "how do I fix a pool connection or login problem".
metadata:
  version: "0.1.3"
---

# Pool CLI

Use this skill **only** for questions about the running `pool` CLI's own capabilities. It is not for general coding help.

## How to answer

Always answer from the canonical Poolside docs. Start with the page that most directly covers the question. Do not rely on memory or invent commands and flags.

When you include links to Poolside docs in your answer, convert internal docs links such as `/cli/interactive-mode` to absolute URLs such as `https://docs.poolside.ai/cli/interactive-mode`. Use reader-facing URLs without the `.md` suffix.

### Pick the right page

Fetch the page that most directly covers the user's question. Each URL is the `.md` variant, which returns clean markdown:

| User is asking about | URL |
| --- | --- |
| Overview of pool, choosing between interfaces | `https://docs.poolside.ai/cli/pool.md` |
| Installation, auth, env vars, credential hierarchy, CI setup | `https://docs.poolside.ai/cli/install.md` |
| Interactive TUI: prompts, `@`-mentions, image context, slash commands, shortcuts, modes, thought level or effort, rewind, switching agents/models | `https://docs.poolside.ai/cli/interactive-mode.md` |
| Non-interactive one-shot runs (`pool exec`), `--unsafe-auto-allow`, resume, output formats | `https://docs.poolside.ai/cli/automated-mode.md` |
| Tool integrations, including editor setup with `pool acp`, desktop apps, coding agents, ACP-compatible clients, and local model runtimes | `https://docs.poolside.ai/tools.md` |
| Using `pool` as an ACP client for another agent server, including Claude Agent, Codex, Gemini, remote servers, or changing the default agent server | `https://docs.poolside.ai/cli/other-agent-servers.md` |
| Troubleshooting connection, authentication, session, or ACP issues | `https://docs.poolside.ai/cli/troubleshooting.md` |
| Configuration overview, including instructions, skills, permissions, sandboxes, secrets, and web access | `https://docs.poolside.ai/configure.md` |
| Adding, listing, or removing MCP servers, including `settings.yaml` configuration for stdio, HTTP, and SSE servers | `https://docs.poolside.ai/mcp-servers.md` |
| `settings.yaml` keys, `agent_servers`, and local configuration locations | `https://docs.poolside.ai/settings-file-reference.md` |
| Choosing a `pool login` method or access provider | `https://docs.poolside.ai/get-started/log-in.md` |
| Full command/flag/exit-code reference (any specific subcommand, MCP management, config paths, logs subcommands) | `https://docs.poolside.ai/cli/cli-reference.md` |

If the question spans multiple areas, fetch the most specific page first; fall back to `cli-reference.md` for missing detail.

Fetch `.md` URLs for source content, but use non-`.md` page URLs when linking users to the docs.

### How to fetch

Use the first available option:

1. **Preferred — `web_fetch`** if that tool is available in this session.
2. **Fallback — shell** if `web_fetch` is unavailable or fails:
   - `curl -sSL <url>`
   - If `curl` is missing: `wget -qO- <url>`

Both are read-only network calls and safe to run. You only need to fetch each page once per conversation unless the user moves to an unrelated area.
