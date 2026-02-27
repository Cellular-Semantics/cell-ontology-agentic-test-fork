# Agentic Development Notes

Meta-instructions for developing and configuring the agentic environment for CL editing. These are **not** operational instructions — they describe how the system is built and tested.

## Overview

This repository is a fork of the Cell Ontology. The aim is to develop an agentic environment to edit the cell ontology using AI agents.

You are an expert at generating and configuring agentic environments using MCPs, skills, subagents and orchestration. You are also an expert in bio-ontology development (OBO, OWL) and biocuration.

## Runtime Environments

Agentic sessions can run in three contexts:

### 1. GitHub Copilot

Agents triggered by @-mention on issues (e.g., assigning `@CL-curator-research`). Source of truth for agent definitions: `.github/agents/*.md`.

### 2. Claude Code on GitHub Actions (dragon-ai-agent)

[dragon-ai-agent](https://github.com/dragon-ai-agent) is a bot account created by @cmungall / @monarch-initiative / @geneontology. It runs Claude Code headless on GitHub Actions, triggered by `@dragon-ai-agent please <request>` mentions on issues, PRs, and comments.

**How it works** (based on the [Uberon workflow](https://github.com/obophenotype/uberon/tree/master/.github/workflows/ai-agent.yml)):

- **Trigger**: `@dragon-ai-agent please <prompt>` in an issue/comment/PR by an authorized user (listed in `.github/ai-controllers.json`)
- **Workflow**: A `check-mention` job validates the mention, then `respond-to-mention` runs Claude Code headless with the extracted prompt
- **Invocation**: Claude Code is installed via `npm install -g @anthropic-ai/claude-code` and run with:
  ```bash
  claude -p "<prompt>" --permission-mode bypassPermissions --output-format stream-json --verbose
  ```
- **Environment**: The workflow installs ROBOT, obo-scripts, aurelian, and Python tools. Git is configured as `Dragon-AI Agent`. Branches are named `dragon_ai_agent_<issue_number>`.
- **Control**: The prompt is free-form text extracted from the mention. Claude Code reads `CLAUDE.md` for project-level instructions and has access to `.claude/agents/` for specialist agents. Tool restrictions can be added via `claude_args` flags (`--allowedTools`, `--disallowedTools`).

**For CL**: To use specific agents, include instructions in the prompt, e.g.:
```
@dragon-ai-agent please Use the CL-curator-research agent to research the cell type in issue #123
```

See also: [anthropics/claude-code-action](https://github.com/anthropics/claude-code-action) for the official GitHub Action (alternative to the custom headless approach used by dragon-ai-agent).

### 3. Claude Code locally

`CLAUDE.md` defines orchestration. Run `scripts/sync-agents.sh` to generate `.claude/agents/` from `.github/agents/`.

## Agent Sync

`.github/agents/` is the source of truth (Copilot format). `.claude/agents/` is generated (Claude Code format). The sync script (`scripts/sync-agents.sh`) transforms frontmatter:

- Model names: `Claude Sonnet 4.5` → `sonnet`, `Claude Haiku 3.5` → `haiku`, `Claude Opus 4.6` → `opus`
- Strips `handoffs:` block (Copilot-specific)
- Preserves `name:` and `description:`
- Copies markdown body unchanged

Generated files are in `.gitignore`.

## Testing Challenges

- **Locally**: The root `CLAUDE.md` is the operational orchestrator. Meta/dev instructions live here in `docs/agentic_development.md` to avoid bleeding into operational sessions.
- **On GitHub**: Testing requires the default branch, so changes can't be tested from GitHub issues until merged.

## MCP Configuration

- `.mcp.json` — Claude Code (root-level)
- `.vscode/mcp.json` — VS Code / Copilot
- Both should have: `artl-mcp`, `ols4` (prod URL: `www.ebi.ac.uk`), `playwright`
