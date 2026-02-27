# CL Ontology — Claude Code System Prompt & Orchestrator

## Project Layout

- Main development file: `src/ontology/cl-edit.owl` (OWL functional syntax, one axiom per line). **Only edit this file** (or files under `docs/`).
- ODK and ontology documentation: `docs/`
- Design patterns: `docs/patterns` and `src/patterns/dosdp-patterns/*.yaml`

## Querying the Ontology

Use grep/rg — one axiom per line makes this effective:
```bash
grep -i CL_0004177 src/ontology/cl-edit.owl          # all axioms mentioning a term
grep 'AnnotationAssertion(rdfs:label.*"neuron"' src/ontology/cl-edit.owl  # find ID by label
```
Only search `src/ontology/cl-edit.owl`. Do not waste time grepping other files or exploring the repo structure.

## OBO Guidelines

- Term ID format: `CL_NNNNNNN` (7-digit)
- New Term Requests (NTRs): IDs **must** start with `CL_99xxxxx` (see `src/ontology/cl-idranges.owl`, idrange:81)
- Each term requires: ID, label, definition with at least one xref (ideally PMID)
- Never guess CL IDs or PMIDs — use search tools to find real values
- Standard relationships: `is_a`, `part_of`, `has_part`, etc.
- Relations guide: `docs/relations_guide.md`
- Definition writing guide: `docs/LLM_prompt_guidelines_for_CL_definitions.md`

## Publications

Fetch full text: `aurelian fulltext <PMID:nnn>` (DOI or URL also work).
Cite as: `def: "..." [PMID:nnnn, doi:mmmm]`

## Other Metadata

- Link back to the issue using `term_tracker_item`
- All new terms **must** have a timestamp: `AnnotationAssertion(terms:date obo:CL_XXXXXXX "2025-04-29T13:06:36Z"^^xsd:dateTime)`
- Sign new terms: `dc:creator "GitHub Copilot"` (do not add creator when editing existing terms)
- ORCIDs go as `terms:contributor` axioms: `AnnotationAssertion(terms:contributor obo:CL_XXXXXXX <https://orcid.org/...>)`

## Obsoleting Terms

- Remove all logical axioms (SubClassOf, EquivalentClasses)
- Prefix label with "obsolete "
- Add `owl:deprecated true`
- Add replacement via `obo:IAO_0100001` if applicable, or `consider` tags
- Rewire any terms that reference the obsoleted term
- No `alt_id`s — if a user asks for a "merge", they mean obsoletion with direct replacement

## GitHub Contribution Process

- Branch naming: `issue-NNN`
- If an existing PR/branch exists for the issue, continue there
- Clear, detailed commit messages explaining what and why
- Sign commits as `GitHub Copilot`
- Create PRs with `gh pr create ...` and clear descriptions
- Use `gh` to read/write issues and PRs

## Troubleshooting

- Syntax errors: `robot convert -vvv -i cl-edit.owl -o /dev/null`
- Reasoning check: `robot reason -i cl-edit.owl -r ELK`

---

## Orchestration — Agent Delegation

This project uses specialist agents. The orchestrator (this file) chains them because Claude Code subagents cannot spawn other subagents.

### Agents

| Agent | Role |
|-------|------|
| **CL-curator-validation** | Validates proposed edits against provided references |
| **CL-curator-research** | Deep literature research and evidence gathering |
| **CL-ontologist** | Technical OWL editing of `cl-edit.owl` |
| **CL-importer** | Imports external ontology terms via OLS |

### Default Workflow (issue handling)

```
1. Spawn CL-curator-validation → validates the request against references
2. Spawn CL-ontologist → performs the edit
3. If CL-ontologist needs external terms imported:
   a. Spawn CL-importer → adds IRIs and refreshes imports
   b. Re-invoke CL-ontologist → completes the edit with imported terms
4. Commit, create PR
```

### Research Workflow (explicit request only)

**CL-curator-research is NEVER auto-spawned.** Only use it when:
- The user explicitly asks for research (e.g., "research this cell type", "do a literature review")
- An issue is labeled `research`
- The user says to use the research agent

When research is requested, it replaces validation as the first step, then continues into the default workflow:

```
1. Spawn CL-curator-research → produces research/curation report
2. Spawn CL-ontologist → performs the edit using the research report
3. If CL-ontologist needs external terms imported:
   a. Spawn CL-importer → adds IRIs and refreshes imports
   b. Re-invoke CL-ontologist → completes the edit with imported terms
4. Commit, create PR
```

### Before Making Edits

- Read the request carefully; note any nuance
- If related issues are mentioned: `gh issue view <NUMBER>`
- If a PMID is mentioned, always try to read it
- Check proposed parent terms for consistency
- For compositional terms, check `src/patterns/dosdp-patterns/*.yaml`
- Include in-line references in definitions when provided in the ticket
