---
name: notes
description: |
  Markdown-native personal knowledge base for VS Code + GitHub Copilot.
  No Obsidian. All links are standard markdown. Optimised for low token usage
  and Copilot-queryable structure.
  
  Trigger this skill when the user:
  - Pastes rough notes, voice-to-text dumps, or bullet thoughts and wants them filed
  - Says "add a note about X", "log this", "save this thought", "file this"
  - Asks "what do I have on X", "find my notes on Y", "summarise my notes about Z"
  - Asks to reorganise, merge, or refactor the notes folder
  - Asks to create a new topic or index file
  
  Environment: VS Code + GitHub Copilot. Obsidian not available.
  Single flat-ish folder: notes/ (subfolders allowed after consolidation).
---

# Notes Skill

A structured, Copilot-friendly personal knowledge base that lives entirely in markdown.
No plugins, no Obsidian, no special renderer needed — just files and links.

---

## Folder layout

```
notes/
├── _index.md          ← master map of everything (keep this < 120 lines)
├── _templates/
│   ├── note.md        ← template for a new atomic note
│   └── folder.md      ← template for a folder README
├── <topic>.md         ← atomic notes (flat until consolidation threshold)
└── <topic>/           ← folder created after consolidation
    ├── README.md      ← folder index (auto-generated)
    └── *.md
```

**Key rule:** start flat. Only create subfolders when consolidation is triggered (see §4).

---

## 1 · Adding a new note from rough input

When the user gives rough input (brain dump, bullets, voice-to-text):

### Step 1 — Parse & classify

Extract from the input:
- **Topic** (1–4 word slug, kebab-case, e.g. `k8s-cilium-bgp`)
- **Type**: one of `concept | log | decision | reference | project | person | resource`
- **Tags**: 2–5 keywords (single words, lowercase)
- **Summary**: one sentence, ≤ 20 words
- **Body**: cleaned-up content — structured, not padded

If the topic is ambiguous, check `_index.md` for closest existing topic first.
If still ambiguous, ask the user one question only.

### Step 2 — Check for existing file

```
1. Derive topic slug from the input
2. Scan _index.md Topics table for:
   a. Exact slug match → use that file
   b. Overlapping tags (2+ shared) → candidate match, confirm with user if unclear
   c. No match → new file
   
Does a matching notes/<topic>.md exist?
  YES → append a new dated section to it (see §append-block)
  NO  → create notes/<topic>.md using the note template
```

**Default: always prefer appending over creating.** Only create a new file when there is genuinely no related existing note. When in doubt, append.

### Step 3 — Write the file

**Template: `notes/<topic>.md`**

```markdown
---
title: <Human readable title>
type: <concept|log|decision|reference|project|person|resource>
tags: [tag1, tag2, tag3]
created: YYYY-MM-DD
updated: YYYY-MM-DD
related: [./other-file.md, ./another.md]
---

# <Title>

> <One-sentence summary — ≤ 20 words>

## Context
<!-- Why this matters / where it came from -->

## Content
<!-- The actual note body -->

## Links
<!-- Only include if there are real connections -->
- [related topic](./related-topic.md)

## Log
<!-- Appended entries go here, newest last -->
```

**Append block format** (when adding to existing file):

```markdown
### YYYY-MM-DD
<!-- new content here -->
```

### Step 4 — Update `_index.md`

Add or update the entry for this topic in `_index.md`.
See §_index format below.

---

## 2 · `_index.md` format

The index is the **only file Copilot needs to read first** for any query.
Keep it scannable and under 120 lines.

```markdown
# Notes Index
<!-- Last updated: YYYY-MM-DD | Total files: N -->

## Topics

| File | Type | Tags | Summary |
|------|------|------|---------|
| [k8s-cilium-bgp](./k8s-cilium-bgp.md) | concept | k8s, cilium, networking | BGP peering setup with Cilium on k3s |
| [delta-ftx-bot](./delta-ftx-bot.md) | project | trading, python, delta | Python FVG bot on Delta Exchange |
| ... | | | |

## Folders
| Folder | Topics | Description |
|--------|--------|-------------|
| [kubernetes/](./kubernetes/README.md) | 8 | All k8s-related notes |

## Recent (last 5 updated)
- YYYY-MM-DD · [topic](./topic.md) — what changed
```

---

## 3 · Querying notes

### Visual query (you browsing manually)
1. Open `_index.md` — scan the table
2. Follow the link to the file
3. Use VS Code `Ctrl+Shift+F` to search across all `.md` files if needed

### Copilot query (AI-assisted)
Copilot reads `_index.md` first (low token cost), then fetches individual files only if needed.

**Prompt patterns that work well:**
```
@workspace summarise my notes on kubernetes networking
@workspace what decisions have I logged about trading bots?
@workspace find notes tagged with "observability"
@workspace what's related to cilium in my notes?
```

**To make queries cheaper:**
- Keep frontmatter tags consistent (no synonyms — pick one: `k8s` not `kubernetes` AND `k8s`)
- Keep summaries accurate — Copilot uses them to decide which files to open
- Keep `_index.md` current

---

## 4 · Consolidation (folder creation)

**Trigger:** automatically checked on every note-add (zero extra cost — Copilot already read `_index.md`).
Also triggered manually: "reorganise my notes" or "consolidate notes".

**Threshold:** 8+ files in the Topics table sharing the same tag → suggest consolidation.

### Auto-check on every note-add

After updating `_index.md`, silently count files per tag.
If any tag hits 8+, surface exactly this message and stop — do not reorganise without approval:

```
💡 You have 8+ notes tagged `<tag>` — want me to group them into a `<folder>/` folder?
```

If the user says yes, proceed with the process below. If no, skip and note the threshold
can be raised by updating this file.

### Manual reorganisation process

1. Group files by dominant tag from `_index.md`
2. Propose groupings to user before doing anything:
   ```
   Proposed folders:
   - kubernetes/   → 9 files (tags: k8s, cilium, k3s, helm)
   - trading/      → 6 files (tags: delta, btc, pinescript, fvg)
   - sre/          → 4 files (tags: observability, dynatrace, grafana)
   
   Rename suggestions (if needed):
   - "k8s-notes" folder → "kubernetes"
   
   Proceed? (yes / adjust)
   ```
3. On approval:
   - Create `notes/<folder>/`
   - Move files
   - Create `notes/<folder>/README.md` (folder index, same table format as `_index.md`)
   - Update all `related:` frontmatter links in moved files
   - Update `_index.md` Folders section
   - Remove moved files from `_index.md` Topics table (they're now under Folders)

### Folder README template

```markdown
# <Folder Name>
<!-- Last updated: YYYY-MM-DD | Files: N -->

> <One sentence on what this folder covers>

| File | Type | Tags | Summary |
|------|------|------|---------|
| [file](./file.md) | type | tags | summary |

[← Back to index](../_index.md)
```

---

## 5 · Linking convention

Since Obsidian `[[wikilinks]]` don't render in VS Code without plugins, use **standard relative markdown links** everywhere:

```markdown
[topic name](./topic.md)          ← same folder
[topic name](../other/file.md)    ← cross-folder
[Back to index](../_index.md)     ← always include in folder files
```

In frontmatter `related:` field, always use relative paths:
```yaml
related: [./cilium-bgp.md, ../trading/delta-bot.md]
```

---

## 6 · File naming rules

| Rule | Example |
|------|---------|
| kebab-case, all lowercase | `k8s-cilium-bgp.md` |
| Max 4 words | `delta-fvg-bot.md` not `my-delta-exchange-futures-fvg-trading-bot.md` |
| Date prefix only for pure logs | `2026-08-12-standup.md` |
| No spaces, no special chars | ✓ |

---

## 7 · Token efficiency rules

These exist so Copilot doesn't burn context reading irrelevant files:

1. `_index.md` is the **entry point** — always read this first, never skip it
2. Summaries in `_index.md` must be accurate — they are Copilot's filter
3. Keep individual note files under 200 lines where possible; split if larger
4. Tags must be from a **controlled vocabulary** — add new tags to a `## Tag glossary` in `_index.md`
5. Don't duplicate content across files — use links instead
6. Frontmatter is machine-readable metadata — don't put prose there

---

## 8 · Copilot session setup (recommended)

Add this to your VS Code workspace instructions (`.github/copilot-instructions.md`):

```markdown
# Copilot Instructions — Notes

When I ask about my notes or ask you to add a note:
1. Read notes/_index.md first (always)
2. Open individual files only when the summary in the index isn't enough
3. To add a note: classify the input, check for existing topic file, create or append, update _index.md
4. Links must be relative markdown links — no [[wikilinks]]
5. Follow the note template in notes/_templates/note.md
6. Keep notes/_index.md under 120 lines — summarise, don't dump
```

---

## 9 · Quick reference

| Action | What to say |
|--------|-------------|
| Add a note | "Add a note: <rough text>" |
| Query | "@workspace find notes about X" |
| Consolidate | "Reorganise my notes" |
| See all topics | Open `notes/_index.md` |
| Find a file | `Ctrl+P` → type topic name |
| Full-text search | `Ctrl+Shift+F` → search term |
| Rename a folder | "Rename the X folder to Y" |
