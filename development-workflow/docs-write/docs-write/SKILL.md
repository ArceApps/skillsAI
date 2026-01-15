---
name: docs-write
description: Write technical documentation for Android projects (Kotlin, Compose, Hilt). Focuses on clarity, MVVM architecture explanation, and "Human-readable" technical guides.
allowed-tools: Read, Write, Grep, Bash, Glob
---

# Documentation Writing Skill (Android Edition)

@./../../_shared/android-style-guide.md

## When writing documentation

### Start here

1.  **Audience:** Usually other Android developers or your future self.
2.  **Architecture:** Always respect the MVVM pattern. Explicitly mention where logic lives (ViewModel) vs where UI lives (Compose).
3.  **Dependencies:** Clarify Hilt scopes (`Singleton` vs `ViewModel`) and Room relationships.

### Writing process

**Draft:**
- Explain the **Why** before the **How**.
- Identify the input parameters (Compose) or injected dependencies (Hilt).
- Define the State (`UiState`) clearly.

**Polish:**
- Use **Bold** for UI elements (e.g., **Login Button**).
- Use `backticks` for Kotlin classes/functions (e.g., `UserViewModel`, `collectAsState`).
- Ensure code snippets are valid Kotlin.

### Common patterns (Android)

**Describing a Composable:**

```markdown
### `UserCard`

Displays user info. Handles its own expansion state but delegates clicks.

**Parameters:**
- `user`: The `User` domain object.
- `onCardClick`: Lambda triggered when tapping the card content.
```

**Describing a Flow:**

```markdown
The `usersFlow` emits updates from the Room database.
It is collected in the UI using `collectAsStateWithLifecycle()` to be lifecycle-aware.
```

### Watch out for

- **State Hoisting violations:** Don't document logic inside a Composable if it belongs in the ViewModel.
- **Obsolete XML terms:** Avoid "Fragment" or "Activity" if working purely in Compose, unless interfacing with legacy code.
- **Vague types:** Don't say "data", say "List<User>".

### Quick reference

| Write This (Español) | Not This |
| -------------------- | -------- |
| `función composable` | widget, view |
| `recopilar flujo`    | escuchar stream |
| **Pantalla de Inicio** | Screen de Inicio |
| `ViewModelScoped`    | scoped to viewmodel |
