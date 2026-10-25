# From 0% to Tested

Companion repo for _"From 0% to Tested: Unit-Testing Flutter Apps with Heavy Platform Integration"_ (Ghag, 2026).

**Paper:** [PDF](https://github.com/GhagSagar23/zero-to-tested/releases/download/v1.0/main.pdf)
**Lint rules:** [kx_lints on pub.dev](https://pub.dev/packages/kx_lints)
**Author:** Sagar Ghag, Kryonex Labs

## What this is

The paper reports on testing a 104,886-line production Flutter app (Firebase, FFI to Rust, SharedPreferences) from zero tests to 2,583 across 292 files. It covers a coverage-exclusion policy, mock-boundary patterns, 17 custom lint rules, and six cases where tests caught production bugs.

The production codebase is private. This repo holds the paper source, the data behind the paper's empirical claims, and the commands used to produce them.

## Repo layout

```
paper/          LaTeX source and bibliography
data/           Metrics, exclusion patterns, lint rule inventory, coverage summary
scripts/        Documents how each number was obtained
```

## Verifying the numbers

`data/metrics.json` contains every number from the paper's Table 3. `scripts/verify-metrics.sh` records the exact commands used to produce each one. The script can't run against the private codebase, but it makes the methodology auditable.

Coverage exclusion patterns (`data/exclusion-patterns.txt`) are copied verbatim from the project Makefile. The lint rules (`data/lint-rules.csv`) list all 17 by name, severity, and category; the public package is [`kx_lints`](https://pub.dev/packages/kx_lints) (named `zontra_lints` internally).

PR and commit references in the paper (e.g., PR #421, commit `2641276`) point to the private repo and can't be verified externally. These account for roughly 10-15% of the paper's empirical claims.

## License

Code and scripts: MIT. Paper text: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
