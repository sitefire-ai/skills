---
name: sitefire-prompts
description: Research, add, organize, and clean up monitored Sitefire prompts and topics. Use to decide what to track, consolidate topics, deduplicate or improve questions, retire irrelevant monitoring, manage tags/status, or run deliberate persona experiments. Use sitefire-discover for content-action opportunities from visibility data.
---

# Manage Sitefire prompts

Use the server's shared instructions and current tool contracts. The [prompt-management guide](https://sitefire.ai/docs/mcp#manage-prompts-and-topics) owns the product explanation and selection guidance; do not recreate its parameter schemas here.

Start by inspecting the relevant setup with `list_topics` and `list_prompts`. Follow pagination when the user's scope exceeds one page. Keep lifecycle and generation state separate: an active prompt can still be generating. Discover labels and optional personas through `list_filter_values`.

For “what should we track?”, check existing runs with `get_prompt_research`. Reuse suitable completed research; otherwise start the authorized business area and market through `start_prompt_research`. Keep its request identity and run ID, follow the suggested polling interval, and review recommendations before adopting selected IDs through `add_prompts`. Starting or completing research is not activation. Research run discovery works in a later conversation.

Choose a coherent set of useful questions, accounting for ready and pending coverage and capacity. Apply the server's 3–7 recommendation as guidance, not a quota to fill with paraphrases. Personas are experimental; do not turn missing assignments into cleanup work.

When the user supplies exact customer questions, use manual `add_prompts`. Keep their wording and distinguish supplied evidence from proposed questions. Do not imply that research accessed CRM records or call notes unless those sources were actually provided or read. `add_topics` is the quick-generation alternative for known subjects; its existing-topic default skips. Request an explicit increment only when more questions are intended.

For topic consolidation, duplicate review, wording improvements, or retiring irrelevant monitoring, read [the cleanup workflows](references/cleanup.md). Use `manage_tags` for label definitions. Topic renaming through `update_topics` changes the search-volume basis; prefer a tag for an internal label. Stop topic monitoring by archiving its prompts. Use experimental `manage_personas` only when requested, following its delete preview and confirmation contract.

A preview does not consume its request identity: apply the reviewed business changes with the same `request_id` and `dry_run: false`. Keep that applied input and identity unchanged when retrying an uncertain apply. A new identity means new intent. Do not turn a conflict, failed generation, or unknown tracking overlay into an automatic new batch. Inspect the returned state and take the tool's recovery path. Re-read saved prompt IDs to verify texts, topics, states, and assignments; report pending work separately from completed changes.
