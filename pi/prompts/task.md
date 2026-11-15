---
description: Work on one tk task from its brief
argument-hint: "<task id>"
---
Work on task $1. Start from its brief, not from earlier conversation.

1. Run `tk brief $1` and read it. If it fails, or the task is `done` or `cancelled`, stop and say so. If it is `ready`, run `tk claim $1`; if that is refused as `after-unmet`, stop and say what it waits on.
2. Change only files in the brief's scope. Read the code you need, by line range where you can; notes may be older than the code, so check them against it. Ask before anything the brief lists under "confirm with the operator first".
3. Add a note with `tk note $1 "<text>"` only for what the next session needs: a decision and why, a dead end, what's left when you stop. No progress updates.
4. If you need a decision you cannot make from the brief, ask one question and wait. If you cannot finish, note what's left and run `tk release $1 --reason "<why>"`.
5. Finish with `tk done $1`: it refuses changes outside the scope and runs every check. Then report once. As a subagent, report `{task, summary, followups}`: a summary of at most 400 characters (what changed, what was not verified) and things you noticed outside the scope. Otherwise report what the brief lists under "report at the end".
