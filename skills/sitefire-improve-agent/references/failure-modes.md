# Failure mode to layer

Read this file at step 4 of the loop. Find the row that matches the trace
signature. The row names the layer to change, one good change, and the change
to reject.

## Contents

1. General failure modes
2. Quality-shaped failure modes
3. Triage of a failed step
4. Ten diagnostic questions

## 1. General failure modes

| Failure mode | Trace signature | Layer to change | Good change | Bad change |
|---|---|---|---|---|
| Missing domain fact | The agent guesses, or asks a question the configuration answers | Context file or skill reference | Add the fact with its source | "Never assume the schema" |
| Skill not triggered | The correct procedure exists, the agent improvised | Skill description: use case first, be pushy | Add trigger phrases and example requests | "Always use skill X" in the system prompt |
| Wrong delegation | The wrong subagent ran, or none ran | Subagent description | Name the situations and the boundary against its siblings | Tell the orchestrator to "delegate correctly" |
| Wrong tool chosen | A generic tool ran where a specialist exists | Tool description, and prune the tool set | State the boundaries. Delete overlapping tools | "Do not use grep for this" |
| Wrong tool arguments | The same call repeats with retries | Tool schema | Change the argument so the mistake is impossible | "Remember to pass absolute paths" |
| Tool output too large | The context fills. Early instructions drop out | Tool implementation, or just-in-time context | Paginate, return identifiers, summarize on the server | "Be concise when reading files" |
| Instruction ambiguity | The agent asks what the configuration answers | Instructions | A positive rule, its reason, and one example | Add "IMPORTANT" to the same line |
| Over-constraint | The rule exists and was ignored. The field is long | Instructions: delete | Cut to the smallest high-signal set | Add another clause |
| Repeated workflow done wrong | The same procedure runs in a different order each run | A new skill | Write the routine with a checkable end state | Paste the procedure into the system prompt |
| Must-happen-every-time action | An advisory rule holds in about 80% of runs | A deterministic hook | A PreToolUse or Stop hook | Repeat the rule in three places |
| Model too weak for the step | Reasoning errors, not knowledge errors | `model` on that subagent only | Raise the model for that subagent | "Think carefully" |
| No stopping signal | The agent stops on "looks done", or it loops | Verification | Give it a pass or fail check | "Be thorough" |

## 2. Quality-shaped failure modes

These are the modes that a Sitefire operator meets most, because the usual
start is an output that is not good enough, not an error.

| Failure mode | Layer to change | Good change |
|---|---|---|
| Thin or generic output | A context file or an example | Add the missing source material, or one worked example |
| Wrong tone or voice | A skill, or an example in the instructions | Show two paragraphs in the right voice. Do not add a rule |
| Missed brand or product fact | A context file | Add the fact where the writer reads it |
| Briefing or structure ignored | The instruction altitude, or the subagent got a summary instead of the source | Pass the source. State the structure once, positively |
| Factual drift | A source the agent never fetched, so a tool or a context file | Make the source reachable, or required at that step |
| Too-long output | Instructions: delete | Remove the conflicting length rules. State one target |
| A good run turned bad after a revision | The revision itself | Read the revision diff first. Revert or narrow that change |

## 3. Triage of a failed step

If a step failed, put it in one of three classes. The split comes from
Arize's trajectory evaluations.

| Class | Question | Layer |
|---|---|---|
| Tool selection | Did it pick the right tool? | Tool description, or the tool set |
| Tool invocation | Did it pass the right arguments? | Tool schema |
| Tool response handling | Did it use the result correctly? | Instructions, or the model |

Path convergence is the fourth check: count the steps taken against the
shortest path. Many extra steps point to a missing procedure, so to a skill.

Source: https://arize.com/docs/ax/evaluate/evaluators/trace-and-session-evals/trace-level-evaluations/agent-trajectory-evaluations

## 4. Ten diagnostic questions

Ask one or two of these when the trace is ambiguous. Each answer points at a
layer.

1. Was this output wrong, or just not what you wanted?
2. What must the agent have done at this exact step?
3. Was the information it needed available anywhere?
4. Is this rare, or every run?
5. Must this happen every single time, with no exceptions? (A yes means a
   hook, not an instruction.)
6. Is there an existing skill, tool, or subagent that must have handled it?
7. Has this configuration ever worked? What changed: prompt, model, or tools?
8. Which existing rule can we delete to make room?
9. What check can catch this automatically?
10. Is the failure knowledge, reasoning, or discipline? (Knowledge points to a
    context file. Reasoning points to the model. Discipline points to a hook.)

## Method behind the loop

The loop is error analysis, from Hamel Husain's write-up.

1. Sample representative traces. 30 is the floor. About 100 is a useful
   guardrail.
2. Open coding: one free-text note per trace. Note only the **first**
   shortfall. Later ones are cascade.
3. Axial coding: cluster the notes into a taxonomy. Count each cluster.
4. Iterate until new traces stop showing new modes.
5. Criteria drift (Shankar, EvalGen): grading the outputs is what defines the
   criteria. Do not ask the user for success criteria up front. Derive them
   from the outputs, then confirm.

Sources:
https://hamel.dev/blog/posts/evals-faq/why-is-error-analysis-so-important-in-llm-evals-and-how-is-it-performed.html
and https://arxiv.org/abs/2404.12272
