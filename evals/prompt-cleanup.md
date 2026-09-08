# Prompt cleanup UX cases

Run these cases against a disposable workspace exposing the shared prompt-management tools. Give the evaluating agent the user request, company evidence, and tool inventory; withhold the expected outcomes below. Ask for an audit first. Apply only an explicitly authorized plan to synthetic fixtures, then archive the fixtures. The skill under test is [sitefire-prompts](../skills/sitefire-prompts/SKILL.md).

## Fixture

All eight questions start inactive, with generation completed and no persona assignment. Use ordinary tags on selected records when testing assignment preservation. Use generated record IDs, not names, for writes.

| Topic / market / language | Question |
|---|---|
| Car insurance / US / en | How much does car insurance cost for a first-time driver? |
| Car insurance / US / en | What does comprehensive car insurance cover? |
| Car insurance / US / en | best car insurance for newly licensed drivers? |
| Auto insurance / US / en | What will a first-time driver pay for car insurance? |
| Auto insurance / US / en | How can I switch car insurers without a gap in coverage? |
| Car insurance abroad / DE / en | How much does car insurance cost for a first-time driver? |
| Pet insurance / US / en | Which pet insurance policies cover older dogs? |
| Caravan insurance / US / en | What does caravan insurance cover? |

User-supplied product note, dated 2026-09-01: the company sells car insurance in the US and Germany; pet insurance was discontinued on September 1; caravan insurance was a pilot whose current status is undocumented. The user also states that comprehensive coverage has zero visibility but remains a priority customer question. These are synthetic evaluation facts.

## Requests and expected outcomes

1. **“Find similar topics and recommend how to combine their prompts.”** Recommend the existing US Car insurance topic as a destination for the distinct switching question. Consider the US price paraphrase together with deduplication. Keep German coverage separate. Explain that this moves prompts while retaining their IDs, rather than deleting or merging topic records, search volumes, actions, or answers. Preserve inactive states.
2. **“Find very similar prompts we could deduplicate.”** Identify the two US first-driver price questions as a candidate pair; prefer a clear existing survivor, checking history if material. Do not collapse suitability, price, and switching questions, or the German market. Archive the redundant ID only after authorization; do not promise merged histories or invent questions to hit a coverage target.
3. **“Find badly written prompts and suggest corrections.”** A complete-sentence version of the newly licensed driver question is acceptable as an optional clarity suggestion; keeping the understandable informal wording is also acceptable. Do not invent a factual defect or change the audience or question to justify an edit. An authorized rewrite uses that question's original text as its expected value and preserves its ID, market, and intent. Old answers are not regenerated.
4. **“Find prompts that no longer fit our company.”** Recommend archiving the pet question using the dated discontinuation evidence. Keep comprehensive coverage despite zero visibility. Preserve the caravan question and ask whether the pilot ended permanently; missing information is not evidence of retirement. Do not replenish retired-topic coverage.

For the combined audit request, no writes should occur. For the illustrated Car insurance price-question survivor, a suitable plan has two archives, one move, and at most one optional wording edit. Choosing the Auto insurance price question as survivor also requires moving it to the destination. Six nonarchived questions remain, all inactive. The destination contains four distinct questions. Equivalent survivor choices are acceptable when justified by actual evidence.

## Tool-behavior checks

- Finish paginating the selected inventory before mutation; use a small page size to exercise cursors.
- Preview moves and wording changes without altering saved rows. Use current expected values when applying.
- Put a valid same-market move and an invalid cross-market move in one synthetic batch: both must remain unchanged on rejection.
- Confirm a successful move retains prompt ID, wording, lifecycle, and the source topic record.
- Confirm the exact-duplicate filter does not identify the paraphrase or the identical text in a different market.
- In a deliberate fixture-only probe, rewrite and move the redundant question to the survivor's exact text/topic. The update currently succeeds. Post-edit exact-duplicate inspection must identify both IDs. Restore this probe before applying the semantic cleanup plan.
- Archive the selected redundant question; verify the survivor and both records remain. Apply a guarded wording edit and reject a stale proposed overwrite.
- Archive the documented obsolete question. Verify foreign-market, priority, and uncertain-business questions remain unchanged.
- Re-read all fixture IDs, including archived ones. Archive remaining synthetic fixtures after verification.

## Recorded verification

The dedicated local preview passed **16 actual MCP HTTP checks** covering the tool behaviors above. An independent agent received the real eight-question inventory and synthetic company evidence, without these expected outcomes. It proposed the intended consolidation and two retirements, treated the wording change as optional, preserved the protected questions, used guarded per-item edits, and performed no mutations. Its feedback led to clarifying preview-to-apply identity handling and avoiding unnecessary edits to understandable informal wording.

This is a repeatable behavioral evaluation, not a claim that the tools provide semantic similarity scoring or automatic relevance classification. Selection still depends on agent judgment and available company evidence.
