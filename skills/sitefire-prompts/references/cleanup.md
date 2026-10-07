# Review and improve monitored prompts

Treat “find”, “audit”, and “recommend” as review requests. For an authorized cleanup, apply the concrete changes within the user's scope; ask only about unresolved business intent or choices the user has not authorized. Report the affected questions, proposed survivor or destination, reason, and uncertain cases before changing them.

Inspect the full requested scope with `list_topics` and paginated `list_prompts`, including inactive prompts where relevant. Finish pagination before mutating; cursors are not a frozen snapshot. Search is literal, not semantic: use broad inventory reads to discover similar wording. Inspect selected IDs with `detail: full` for editable prior values. Compare questions in the context of their topic, market, intent, audience, and monitoring purpose. A shared noun or low visibility score is not enough to remove a question.

## Consolidate similar topics

Group candidate topics by customer need, then inspect their questions. Consolidate only when the topics serve the same need in the same country and language. Keep related but distinct needs separate; a shared tag can organize them without moving questions. Choose an existing destination with an accurate search-term name and useful coverage, rather than renaming topics to a common internal label.

Use `update_prompts` to move selected completed prompt IDs to that destination, with their current topic IDs as expected prior values. Review duplicate questions using the next section before moving: reassignment can create exact duplicates, and edits do not automatically reject or merge them. Preserve each prompt's monitoring state and other assignments unless changing them is part of the request. Re-read both topics and report the resulting useful coverage.

This consolidates monitoring, not topic records: there is no topic-merge tool. Existing prompt IDs and answers remain; topic-level reporting can change with reassignment. SEO measurements and linked actions are not combined or transferred. Leave the source topic record in place and account for any prompts that still belong there. Do not generate replacement questions to perform a move.

## Deduplicate very similar questions

Use `issues: exact_duplicates` as one starting point. It finds normalized exact matches within a topic and market, not paraphrases or duplicates across topics. Inspect the wider selected inventory for semantic overlap.

Two prompts are redundant only when they ask for essentially the same answer for the same customer need and market. Preserve differences that matter: price versus suitability, first purchase versus switching, geographic restrictions, or a deliberate audience/persona experiment. Do not collapse these to meet a target count.

Choose a survivor based on clear wording, fit, relevant answer history, and the user's monitoring intent. Inspect `list_answers` when history affects that choice. Archive the redundant IDs with `update_prompts`; preserve their history rather than deleting or claiming to combine answers. Carry over useful ordinary tags only when appropriate, using additive assignments; do not copy legacy categories or the derived On-brand label as ordinary tags. If the chosen survivor is inactive while the retired duplicate was active, decide explicitly whether monitoring should continue on it; activation still consumes capacity. Archiving clears sentiment tracking, so continuing that experiment on a survivor needs an explicit choice too. Flag any loss of distinct coverage instead of inventing paraphrases to get back to three.

## Improve badly written questions

Flag questions that cannot stand alone, contain unclear references, combine unrelated questions, use keyword fragments that fail to express a clear question, or introduce an unsupported or leading premise. Customer language can be informal and still useful. Preserve the original language, intent, market, and meaningful constraints; do not rewrite merely to sound more polished or to insert the company's brand.

Show original wording, proposed wording, and the defect being corrected. Use per-prompt `update_prompts` items for different rewrites, with each original text as its expected prior value. Edit completed prompts; report pending or failed generation separately. Check whether a proposed rewrite duplicates another question before applying it.

A wording edit keeps the prompt ID and existing answers; those answers were generated from the older wording. If the proposal changes the underlying question or business intent, treat it as a replacement: add the new question through the appropriate creation flow and archive the old one only within the authorized scope. Do not describe an edit as rerunning past answers.

## Retire questions that no longer fit

Use `get_setup_status` for initial company context, then establish current company scope from evidence the user provided or authorized you to read: current offerings, supported markets, intended customers, customer-call notes, CRM records, or stated priorities. Identify the evidence and its date where available. Existing monitoring is not proof that the company still offers something, and lack of a brand mention or poor visibility is not proof of irrelevance.

Recommend archiving when the evidence establishes that a product, market, or customer need is no longer in scope. Use inactive when the user intends a temporary pause. Keep uncertain candidates in the review and ask the specific business question needed to decide; do not infer discontinuation from missing data. Archive selected IDs with `update_prompts` and verify the resulting states; archiving does not cancel work already queued. Retired topics do not need their coverage replenished.

## Apply and verify

Preview the selected changes with `dry_run`, then apply the authorized changes using the tool's request-identity and expected-value contract. A batch is atomic; a workflow spanning multiple calls is not. Keep dependent operations in order, re-read between them, and report completed work if a later batch fails. On a stale-value or market mismatch rejection, inspect the conflict and revise the plan rather than changing identities blindly. Inspect for duplicates after moves or wording edits as well as before them. Verify survivor/destination IDs, wording, states, and assignments afterward; preserve unselected prompts and use the retry guidance in the parent skill.
