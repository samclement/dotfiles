# Working agreements

## Process

- Prefer the simplest maintainable solution. Challenge unnecessary abstractions, fallbacks, compatibility
  layers and scope expansion. Reuse existing primitives before inventing new ones.
- For non-trivial or ambiguous work, inspect the context, recommend an approach with its trade-offs, and
  get approval before editing. Small, clear fixes and already-approved work need no further gate.
- A question gets an answer. Review, report and status requests are read-only: don't edit, run
  state-changing commands or start adjacent work unless asked.
- Follow the approved scope. Ask before materially changing the approach; flag adjacent improvements
  rather than silently doing them.
- Re-check the working tree before editing: other sessions may be working in the same repo. Don't
  overwrite unrelated work.
- Delegate only bounded work with explicit inputs, scope, prohibitions, expected output and verification.
  One implementation writer by default; independent read-only review when warranted. Don't delegate
  trivial work or create role chains by default.
- For multi-session work, keep one task-specific plan or status file current (approved scope, decisions,
  paths, acceptance criteria, open questions); avoid duplicate planning or status artifacts. At a
  natural break, give a copy-pasteable prompt that resumes from a fresh session. A handoff is a map, not a substitute for reading the current code.

## Communicating

- Explain with context: what the user is trying to do, the current behaviour, the change and its impact.
  Define terms and internal labels (plan IDs, component names) on first use. Be concise, but don't
  compress terms.
- Frame design choices by the use cases they enable or constrain, how the user experience changes,
  performance and maintenance cost. Present real decisions as numbered options with trade-offs and a
  recommendation.
- Use a diagram or table for flows across components, state and lifecycles.
- On long turns, report progress (done, left, rough estimate) and say early when a task is bigger than
  it looked.
- Report the commands you ran and their results. Distinguish observed facts from assumptions; don't
  claim a check passed unless it ran.

## Design

Call out, where relevant and in proportion to the change:
- **Semantics:** what concepts, names, operations and states mean; distinguish absence, unknown,
  failure, defaults and invalid states.
- **Boundaries:** which component owns each responsibility, source of truth, lifecycle and side effect;
  what crosses each boundary and in which direction.
- **Contracts:** inputs, outputs, invariants, pre/postconditions and error behaviour; ordering,
  concurrency, idempotency and compatibility where relevant.
- **Primitives:** the smallest coherent building blocks and how they compose; prefer existing domain
  concepts over generic frameworks or boolean-heavy variations.

Surface ambiguous semantics and conflicting contracts before implementing them, and tie important
contracts to verification. The callouts clarify a
concrete design; they don't justify extra layers.

Favour architecture that is cheap to change:
1. **Right-sized components.** Start with the simplest structure that fits. Add a layer or abstraction
   when a second real use or a demonstrated maintenance cost needs it, not in anticipation. Each
   component is explainable in one sentence in the domain's vocabulary. When the design outgrows its
   shape, reshape it rather than bolt on.
2. **Strong, composable primitives.** A small set of domain types and operations with clear contracts.
   Compose them instead of adding flags, modes and near-duplicate variants.
3. **Explicit ownership.** Each piece of data has one owner and one source of truth; derived data is
   derived, never maintained by hand in a second place. Business rules live in named domain code, not in
   handlers, adapters or UI.
4. **Pure core, effects at the edges.** The core decides and does no I/O. Orchestration sequences the
   core and effects for a use case. Each adapter wraps one external dependency (network, filesystem,
   Git, clock, randomness) and translates rather than decides. Dependencies point inward.
5. **State machines for lifecycles.** Explicit states and a transition function that returns the next
   state or a named refusal, not combinations of booleans and nullable fields. Make invalid states
   unrepresentable. The transition table doubles as the test table and the diagram.

## Verification

- Classify behaviour first. Deterministic: same input, same output (parsing, rendering, validation,
  state transitions, contracts). Non-deterministic: model output, UX judgement, live timing, third-party
  behaviour.
- Verify deterministic behaviour with tools: types, linters, tests, schema and golden checks. When a rule
  in an AGENTS.md can be checked mechanically, add the check; it's cheaper than a rule to remember.
- Prefer higher-level tests through real entry points (command, handler, use case), with fakes only at
  external boundaries. Unit-test pure logic that is dense with cases, as table tests.
- A test earns its place if it can fail on a regression in code you own. No tautological tests.
- Keep non-deterministic parts thin and pass their output through deterministic validation. Verify the
  rest by sampled or human review, and say what wasn't verified.
- Run every check you tell the operator to run. Don't weaken a test to get a pass.

## Changes and docs

- No compatibility shims, fallbacks or translation layers unless asked. Prefer one-way migrations and
  deleting the old path; report what a change deletes as well as what it adds.
- Don't leave workarounds in place to reach green; surface the design problem.
- One canonical page per topic; link, don't copy. Docs describe what is. Status pages are overwritten,
  not extended: change what moved, delete what the change made false.

## Notify the operator

Use the `notify-operator` skill (enabled from `~/.claude/skills/` in `settings.json`, so
`/skill:notify-operator` always works) at the end of every turn that finishes work, fails, or stops for
the operator's input, a confirmation or a question. One notification per such turn, never for
intermediate steps, and never a Secret value in it (the topic is public).
