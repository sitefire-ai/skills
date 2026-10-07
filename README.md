# Sitefire Agent Plugin

Connect your AI coding agent to your [Sitefire](https://sitefire.ai) account for AI visibility analytics, prompt management, and content workflows — directly from your terminal or IDE.

Works with **Claude Code**, **Codex**, **Cursor**, **Gemini CLI**, and any agent that supports the [Agent Skills](https://github.com/anthropics/skills) spec or remote MCP servers.

## What's included

| Component | Purpose |
|-----------|---------|
| **MCP Server** | Auto-connects your agent to Sitefire's API (OAuth, no setup needed) |
| **Product Knowledge** | Your agent understands Sitefire's domain model, workflows, and terminology |
| **`/sitefire-prompts`** | Research, add, organize, and clean up monitored questions and topics |
| **`/sitefire-actions`** | Check existing actions and execute ready briefings |
| **`/sitefire-discover`** | Analyze visibility data and find new topics to work on |
| **`/sitefire-write-all`** | Trigger article generation for all ready briefings at once |
| **`/sitefire-traces`** | Read an agent run: its output, the files each agent wrote, the dispatch tree, and the step where a shortfall entered |
| **`/sitefire-improve-agent`** | Improve an agent from its runs: find the failure mode, edit the configuration draft, publish a revision with a note |

## Installation

**Claude Code:** add the repository as a marketplace, then install the plugin.

```bash
claude plugin marketplace add sitefire-ai/skills
claude plugin install sitefire@sitefire
```

**Other agents (Codex, Cursor, Gemini CLI):** install the skills with the Agent Skills CLI.

```bash
npx skills add sitefire-ai/skills
```

On first use, a browser window opens. Sign in to your Sitefire account and approve access.

For alternative setup methods (Claude.ai, Claude Desktop, manual MCP config), see the [full documentation](https://sitefire.ai/docs/mcp).

## Usage

Once installed, your agent automatically has access to your Sitefire data. Just ask:

- "What should we track, and which prompts need cleanup?" — researches and manages monitoring
- "How is our AI visibility?" — runs analytics overview
- "What actions do we have?" — lists existing actions with briefing status
- "What articles can we write?" — finds ready CREATE_CONTENT actions
- "What topics should we tackle next?" — discovers new opportunities

Or use the slash commands:

```
/sitefire-prompts        # Research and manage monitored prompts
/sitefire-actions        # Review and execute ready actions
/sitefire-discover       # Analyze data and find new topics
/sitefire-write-all      # Batch-trigger article generation
/sitefire-traces         # Read an agent run end to end
/sitefire-improve-agent  # Improve an agent from its runs
```

## Agent runs and configuration

If your workspace has a Sitefire agent runtime connected, the MCP server adds
two tool families.

| Family | Tools | What it does |
|--------|-------|--------------|
| `*_agent_run*` | `list_agent_runs`, `get_agent_run`, `get_agent_run_step`, `get_agent_run_file` | Read what a run did: its final message, the dispatch tree, the file timeline, and each pass over a file |
| `*_agent_config` | `get_agent_config`, `read_agent_config`, `diff_agent_config`, `edit_agent_config`, `publish_agent_config` | Read and change what the agents are told, then publish a revision with a note |

The `/sitefire-traces` and `/sitefire-improve-agent` skills drive these tools.
Read the run first, then change one layer, then publish. The agent always asks
before it publishes.

## How it works

Sitefire monitors your brand's visibility across AI models (ChatGPT, Gemini, Perplexity, DeepSeek, Google AI). When you create an **action** for a topic, Sitefire's AI agents diagnose the competitive landscape and produce a **briefing** — an actionable plan with specific recommendations. For content actions, Sitefire can also generate the article.

This plugin gives your agent the context to navigate these workflows fluently: it knows when to check existing actions vs. discover new topics, how to read briefings, and how to help you execute each action type.

## Requirements

- A Sitefire account at [app.sitefire.ai](https://app.sitefire.ai)
- An AI coding agent that supports [Agent Skills](https://github.com/anthropics/skills) or remote MCP servers

## Prompt management

Use `/sitefire-prompts` for research and monitoring setup. The [MCP guide](https://sitefire.ai/docs/mcp#manage-prompts-and-topics) explains topics versus prompts, evidence sources, optional personas, and safe editing. The connected server supplies current tool contracts; the skill adds workflow guidance rather than a second API reference.

## Data and privacy

This plugin contains Markdown skills and one MCP server entry. It has no hooks, no scripts, and no local executables. It does not read files on your computer and it does not send telemetry.

**What it connects to.** The plugin connects to one remote MCP server: `https://app.sitefire.ai/api/mcp`. Sitefire operates this server. The connection uses HTTPS and OAuth 2.1 with PKCE. You sign in with your Sitefire account. Your agent stores the access token. The plugin files contain no credentials.

**What it sends.** When your agent calls a Sitefire tool, it sends only the arguments of that call. Examples are a topic, a date range, a filter, or the text of a monitored question. The plugin does not send your conversation history.

**What it reads.** The tools return data from your Sitefire workspace: visibility metrics, topics, prompts, actions, briefings, articles, and agent runs. Your role in the workspace controls what you can read.

**What it can change.** Workspace admins can use tools that change data in Sitefire:

| Tool | Effect |
|------|--------|
| `create_action`, `add_competitor` | Creates an action or a competitor entry |
| `write_article` | Starts a Sitefire article run that uses workspace credits |
| `start_prompt_research`, `add_prompts`, `add_topics` | Starts prompt research, or adds monitored prompts and topics |
| `create_tags`, `create_personas` | Creates tags and personas |
| `update_prompts`, `update_topics`, `update_tags`, `retire_tags`, `update_personas`, `delete_personas` | Edits, archives, retires, or deletes prompts, topics, tags, and personas |
| `edit_agent_config`, `publish_agent_config` | Edits an agent configuration draft and publishes a revision |

The skills tell the agent to change data only when you ask for the change or approve a proposed change. Publishing an agent configuration always needs your explicit approval in the conversation. Viewers can only read.

**Where the data goes.** Sitefire processes the data as described in the [Sitefire privacy policy](https://sitefire.ai/data-privacy). The [terms of service](https://sitefire.ai/terms) apply. Your AI client processes tool results under the terms of that client.

## Support

- Documentation: [docs.sitefire.ai/docs/mcp](https://docs.sitefire.ai/docs/mcp)
- Contact: [sitefire.ai/contact](https://sitefire.ai/contact) or support@sitefire.ai
- Security reports: support@sitefire.ai

## License

[MIT](LICENSE)
