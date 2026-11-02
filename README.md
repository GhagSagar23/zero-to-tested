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
data/           Metrics, exclusion patterns, lint rule inventory, coverage summary,
                per-file line counts, cubit inventory, case study data, test infrastructure
scripts/        Documents how each number was obtained
osaudit.toml    Open-science audit configuration (ASSERT-KTH/osaudit)
```

## Data files

| File | Contents | Backs |
|------|----------|-------|
| `data/metrics.json` | Aggregate metrics from Table 3 + cubit/helper/integration counts | ~20 numbers |
| `data/file-sizes.csv` | Per-file line counts for every file cited by name | ~20 numbers |
| `data/cubit-inventory.csv` | All 50 production Cubits with tested/untested status | Cubit coverage claims |
| `data/case-studies.json` | Six case studies with quantitative details | Case study numbers |
| `data/test-infrastructure.json` | Helper files, integration tests, fakeAsync benchmarks, FFI/DI breakdowns | ~15 numbers |
| `data/coverage-summary.txt` | lcov summary output (raw + filtered) | Coverage percentages |
| `data/exclusion-patterns.txt` | Makefile LCOV_REMOVE_PATTERNS verbatim | Exclusion policy |
| `data/lint-rules.csv` | All 17 lint rules by name, severity, category | Lint rule claims |

## Verifying the numbers

`scripts/verify-metrics.sh` records the exact commands used to produce each data file. The script can't run against the private codebase, but it makes the methodology auditable.

Coverage exclusion patterns (`data/exclusion-patterns.txt`) are copied verbatim from the project Makefile. The lint rules (`data/lint-rules.csv`) list all 17 by name, severity, and category; the public package is [`kx_lints`](https://pub.dev/packages/kx_lints) (named `zontra_lints` internally).

PR and commit references in the paper (e.g., PR #421, commit `2641276`) point to the private repo and can't be verified externally. Case study timing values (Case 6) are evidenced by commit message `25865ef` which records the before/after runtimes.

## License

Code and scripts: MIT. Paper text: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
