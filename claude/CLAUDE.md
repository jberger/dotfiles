# Working with Joel — preferences

Cross-project working preferences. Project-specific mechanics (build/release
commands, infra, framework choices) live in that project's memory, not here.

## Process
- **Feature branches, almost always.** Isolate work on a branch. When ready,
  rebase then merge with a descriptive `--no-ff` merge commit. Small fixes may
  be made to main when the work can easily be contained in one commit.
- **Check in before releasing/deploying.** I own the version-bump decision and
  lean toward modest bumps (a small feature can be a patch, not a minor). Use
  the project's own release convention/flags rather than a hardcoded version
  string.
- **Talk decisions through over rigid multiple-choice.** I'd rather discuss and
  reframe a question than pick from a constrained menu. Offer a recommendation,
  but leave room.
- **Verify against reality, not a synthetic harness.** A quick real/interactive
  check beats an elaborate automated diagnostic; if a harness contradicts a
  sound first-principles theory, suspect the harness.
- **Don't wave off failures as "transient."** Name a plausible mechanism or
  investigate — a fail-then-pass on a step with nothing in flight is a real
  (often racy) bug.
- **Stay on stock, official tooling.** Prefer documented scaffolders/CLIs and
  their flags over workarounds or patched templates; e.g. bump Node via nvm
  rather than working around a version limit.
- **Be precise about data sources** (e.g. dev vs. production) before drawing
  conclusions.
- **Prefer GitOps for infra** — write manifests/config to commit rather than
  applying changes directly, unless a project explicitly authorizes direct
  deploys.

## Code & data taste
- **DRY and unix-philosophy** — small, focused units with one job and clean
  interfaces — but not dogmatically: a component isn't automatically DRYer, and
  avoid config/props-bags.
- **Normalized, self-documenting schema** — a single source of truth, with an
  eye towards joinability for complex queries
- **Prefer Human-readable slugs in URLs, rather than ids**
  (`/manufacturers/royal`, not `/…/45`).
- **Strong API Design** RESTful is first and foremost. APIs should consider
  paths as nouns; a resource is a thing. Actions should be HTTP VERBS or else
  POST requests with arguments.
- **Deep nesting is a code smell** - when in large if/else paths consider a
  dispatch table. If most of a function's body exists inside of an if-block
  consider returning early from a negated-if instead. Etc.
- **Use descriptive variable and function names, always** - self-documenting
  code starts with descriptive names.

## Product / UX & naming
- **Reason from the visitor's intent** — lead with what they came for; put
  "explore related" affordances after; surface counts so a choice isn't a dead
  end.
- **Care about naming connotation** and catch real-world collisions before
  committing to a name.
- **Notice visual detail** — spacing and layout should read as intentional.

## External services
- **Be a good citizen** — route through a polite client with an honest
  User-Agent, low concurrency, and record-once/replay-forever fixtures; prefer
  caching HTML responses over live-hammering community-run services.
