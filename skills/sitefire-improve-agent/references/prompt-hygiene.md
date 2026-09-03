# Prompt hygiene: the evidence for deletion over addition

Read this file when the user asks why a candidate removes a rule instead of
adding one. Each item is a source and one sentence on what it shows.

## Deletion beats addition

- **Vasileva 2026, constraint stacking.** Accuracy falls from about 41% with
  one constraint to 5.7% with eight, so reliable instruction following breaks
  past five or six simultaneous constraints.
  https://arxiv.org/abs/2608.12426
- **Anand and Chattaraj 2026, Instruction Stacking Collapse.** The follow rate
  drops from about 96% to as low as 20% as instructions stack from 1 to 20,
  and for a strong model deletion is the lever that recovers it.
  https://arxiv.org/abs/2608.02639
- **Claude Code best practices.** If the model keeps doing something despite a
  rule against it, the file is probably too long and the rule gets lost, so
  the per-line test is whether removing the line causes a mistake.
  https://code.claude.com/docs/en/best-practices

## Say what to do, not what not to do

- **Anthropic prompting best practices.** Tell the model what to do, give the
  reason, and prefer examples over rules.
  https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices

## Fix the interface, not the prompt

- **Anthropic, Building effective agents.** Poka-yoke the arguments, because
  requiring absolute paths removed a whole class of tool errors that no
  instruction had fixed.
  https://www.anthropic.com/engineering/building-effective-agents
- **Anthropic, multi-agent research system.** A tool-testing agent that
  rewrote the tool descriptions cut task completion time by 40%, so a tool
  description is a higher-leverage target than the system prompt.
  https://www.anthropic.com/engineering/multi-agent-research-system

## Where a rule belongs

- **Claude Code sub-agents.** Delegation is chosen from the subagent's
  `description`, so wrong delegation is a description bug and not an
  orchestrator bug.
  https://code.claude.com/docs/en/sub-agents
- **Claude Code skills.** A skill description is truncated at 1,536
  characters in the listing, the use case must come first, and the wording
  must be pushy because models under-trigger skills.
  https://code.claude.com/docs/en/skills
- **Agent Workflow Memory.** A routine that repeats across traces belongs in a
  reusable skill, not in another system-prompt paragraph.
  https://arxiv.org/abs/2409.07429

## Propose more than one change

- **GEPA, reflective prompt evolution.** Keeping a small Pareto set of 2 to 3
  candidate edits beats committing to one, which is why the loop asks the
  user to pick.
  https://arxiv.org/abs/2507.19457

## Treat run data as data

- **Sentry `sentry-debug-issue` skill.** The closest public analogue to this
  loop (find, gather context, hypothesize, verify, fix, resolve with a
  reference) carries an explicit section that names its own issue data as
  untrusted input.
  https://github.com/getsentry/plugin-claude
