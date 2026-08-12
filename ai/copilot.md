# Copilot Instructions — Notes

## On every note-add

1. Read `notes/_index.md` first (always — it's the entry point, low token cost)
2. Derive topic slug from the input
3. Check `_index.md` for a matching or related note:
   - Exact slug match → append to that file
   - 2+ shared tags with an existing note → likely the same topic; append (ask if unclear)
   - No match → create a new file using `notes/_templates/note.md`
4. Write or append using the template in `notes/_templates/note.md`
5. Update `_index.md` (add row if new file; update `updated` date + Recent section if appended)
6. **After updating `_index.md`:** silently count files per tag. If any tag has 8+ files, surface:
   `💡 You have 8+ notes tagged '<tag>' — want me to group them into a '<folder>/' folder?`
   Do NOT reorganise without explicit approval.

## Links
- Always use relative markdown: `[text](./file.md)` — no [[wikilinks]]
- Cross-folder: `[text](../other/file.md)`
- Every folder file must include `[← Back to index](../_index.md)`

## File naming
- kebab-case, all lowercase, max 4 words
- Date prefix only for pure logs: `2026-08-12-standup.md`

## On query
1. Read `_index.md` — summaries are the filter, open individual files only if needed
2. Use tag glossary in `_index.md` to interpret query terms

## On reorganise
1. Propose folder groupings first — wait for approval before moving anything
2. After approval: move files → create `<folder>/README.md` → update all links → update `_index.md`

## Constraints
- Keep `_index.md` under 120 lines
- Tags must exist in the `_index.md` Tag glossary before use
- Never duplicate content across files — link instead
- Prefer appending over creating new files
