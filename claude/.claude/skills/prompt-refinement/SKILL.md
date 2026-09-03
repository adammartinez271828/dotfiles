---
name: prompt-refinement
description: Convert vague requests into compact TCRO prompts with phase-specific constraints. Used by research, specify, plan, and work workflows.
metadata:
  category: model-invoked
  version: 2.0.0-questions
  tags: prompting, tcro, requirements, workflow
---

Default output: return the refined prompt only. Before refining, ask as many clarifying questions as necessary to remove ambiguity — batch them (use AskUserQuestion when available) rather than asking one at a time, and only stop asking once every remaining unknown is a reversible detail you can infer.

# Prompt refinement

Convert the request into TCRO:

- **Task**: observable objective.
- **Context**: relevant repository, user, or system facts.
- **Requirements**: constraints, acceptance criteria, and non-goals.
- **Output**: artifact, schema, destination, and length.

Do not add personas, stakes, challenge language, generic reasoning instructions, or confidence scores.

## Phase requirements

### Research

Specify the question, scope, source types, evidence standard, and desired depth. Default output is a short finding summary plus citations or a named report file.

### Specify

Define users, behavior, interfaces, edge cases, compatibility, and acceptance criteria. Exclude implementation choices unless they are constraints.

### Plan

Define the source spec, implementation boundaries, dependency order, verification commands, and completion criteria.

### Work

Define the exact change, allowed scope, required tests, verification commands, and handoff output. Include a non-goal for likely scope creep.

## Refinement rules

1. Preserve explicit user wording where it carries intent.
2. Infer reversible details from repository context.
3. Ask whenever a missing answer would change the task's objective, scope, architecture, security, compatibility, interfaces, acceptance criteria, or any irreversible behavior — there is no cap on the number of questions. Group related questions together; prefer concrete options over open-ended asks.
4. Replace vague terms with measurable checks.
5. Remove duplicated context and optional prose.

## Template

```text
Task: <observable objective>
Context: <required facts>
Requirements:
- <constraint or acceptance criterion>
- Non-goal: <excluded scope>
Output: <artifact/schema/length>
Verify: <checks>
```
