---
name: create-plan
description: Architect Agent. Analyzes requirements and creates a strategic "Unified Task Document" (TASK-XXX.md). Use ONLY for initializing new tasks. For updating progress, use 'changelog-logger'.
allowed-tools: Read, Write, Run Command
---

# Task Architect (Plan Creator)

This skill is the **Architect**. It analyzes the codebase and requirements to create a comprehensive Strategy Document.

## When to Use

- "Create a plan to implement feature X."
- "I want to start working on the Undo system."
- "Initialize task for refactoring."

## Workflow

### 1. Analysis Phase
- Read relevant source code files to understand the context.
- Identify architectural patterns (MVVM, Hilt, etc.).
- Check `development-workflow/_shared/android-style-guide.md`.

### 2. Creation Phase
- Generate a **new file** in `tasks/` following the naming convention: `TASK-YYYY-XXX-[name].md`.
- Use the **Unified Template** structure (Objective, Plan, Empty Log).

### 3. Strategy Definition
- **Objective:** Clear "What" and "Why".
- **Plan:** Broken down into atomic, checkable steps.
- **Risks:** Pre-identify potential blockers (threading, state loss, etc.).

## Output Template

(See `references/unified-task-template.md`)

```markdown
# TASK-YYYY-XXX: [Name]
...
## 2. 🧠 Plan de Ejecución
- [ ] Step 1
...
## 3. 📝 Bitácora de Trabajo
(Empty initial state)
```

## Critical Rules

1.  **Do Not Log:** Do not fill the Bitácora. That is for the `task-logger` skill.
2.  **Do Not Code:** You output a Plan (.md), not source code.
3.  **Validate:** Run `./.forge/skills/create-plan/validate-plan.sh` on the new file.