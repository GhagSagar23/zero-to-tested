#!/usr/bin/env bash
# verify-metrics.sh
#
# Documents how each number in the data/ files was obtained.
# This script cannot run against the production codebase (private repo),
# but it records the exact commands used so a reviewer can verify the
# methodology and spot-check the data files in this repo.
#
# All commands assume CWD is the root of the Flutter project.

set -euo pipefail

echo "=== Source metrics (data/metrics.json) ==="
echo "source_files:"
echo "  find lib/ -name '*.dart' -not -name '*.g.dart' | wc -l"

echo "source_lines:"
echo "  find lib/ -name '*.dart' -not -name '*.g.dart' | xargs wc -l | tail -1"

echo ""
echo "=== Test metrics (data/metrics.json) ==="
echo "test_files:"
echo "  find test/ -name '*_test.dart' | wc -l"

echo "test_invocations:"
echo "  flutter test 2>&1 | grep -oP '^\+\K[0-9]+'"

echo "test_lines:"
echo "  find test/ -name '*.dart' | xargs wc -l | tail -1"

echo ""
echo "=== Coverage (data/metrics.json, data/coverage-summary.txt) ==="
echo "Raw coverage:"
echo "  flutter test --coverage"
echo "  lcov --summary coverage/lcov.info"

echo "Filtered coverage:"
echo "  lcov --remove coverage/lcov.info <patterns from data/exclusion-patterns.txt> -o coverage/filtered.info"
echo "  lcov --summary coverage/filtered.info"

echo ""
echo "=== Excluded files (data/exclusion-patterns.txt) ==="
echo "Count files matching exclusion patterns:"
echo "  for pattern in \$(grep -v '^#' data/exclusion-patterns.txt | grep -v '^\$'); do"
echo "    find lib/ -path \"\$pattern\" | wc -l"
echo "  done"
echo "  Plus: find lib/core/location_engine/ -name '*.dart' | wc -l  (FFI, not instrumented by lcov)"

echo ""
echo "=== Lint rules (data/lint-rules.csv) ==="
echo "Count and list:"
echo "  grep -r 'extends DartLintRule' packages/zontra_lints/lib/ | wc -l"
echo "  Public version: https://pub.dev/packages/kx_lints"
echo "Design-system rules: grep -c 'design-system' data/lint-rules.csv"
echo "Testability rules:   grep -c 'testability' data/lint-rules.csv"

echo ""
echo "=== Ratios ==="
echo "test_to_source_ratio: test_lines / source_lines = 53354 / 104886 = 0.51"
echo "phone_auth_ratio:     390 / 233 = 1.67"
echo "cubit_coverage:       28 / 50 = 0.56"

echo ""
echo "=== File sizes (data/file-sizes.csv) ==="
echo "Per-file line counts:"
echo "  wc -l <file>  # for each file listed in data/file-sizes.csv"
echo ""
echo "FFI bindings total:"
echo "  find lib/core/location_engine/ -name '*.dart' | xargs wc -l | tail -1"
echo ""
echo "DI wiring total (3 files):"
echo "  wc -l lib/core/di/service_locator.dart lib/core/di/service_locator_cubits.dart lib/core/di/service_locator_announcements.dart"
echo ""
echo "EmployeeShiftCubit tests (4 files):"
echo "  find test/ -path '*employee_shift*' -name '*_test.dart' | xargs wc -l"

echo ""
echo "=== Cubit inventory (data/cubit-inventory.csv) ==="
echo "Production cubits:"
echo "  find lib/ -name '*_cubit.dart' ! -name '*.g.dart' | wc -l"
echo ""
echo "Cubit test files:"
echo "  find test/ -name '*cubit_test.dart' | wc -l"
echo ""
echo "Untested cubits (set difference):"
echo "  comm -23 <(find lib/ -name '*_cubit.dart' ! -name '*.g.dart' -exec basename {} .dart \; | sort) \\"
echo "           <(find test/ -name '*cubit_test.dart' -exec basename {} _test.dart \; | sort)"

echo ""
echo "=== Test infrastructure (data/test-infrastructure.json) ==="
echo "Helper files:"
echo "  find test/helpers/ -name '*.dart' | wc -l"
echo "  find test/helpers/ -name '*.dart' | xargs wc -l | tail -1"
echo ""
echo "Integration tests:"
echo "  find integration_test/ -name '*.dart' -not -path '*/test_helper/*' | wc -l"
echo "  find integration_test/ -name '*.dart' -not -path '*/test_helper/*' | xargs wc -l | tail -1"

echo ""
echo "=== Case study evidence (data/case-studies.json) ==="
echo "Case 2 tracking tests before/after:"
echo "  git log --stat <PR #402 merge commit> -- test/  # diff shows added test files"
echo ""
echo "Case 6 fakeAsync timings (from commit message 25865ef):"
echo "  git show 25865ef --format='%B' --no-patch"
echo "  # Message records: riders_service_test 15.3s->~0, otp_controller_test 6.4s->~0, suite 34s->22s"

echo ""
echo "=== Golden comparator threshold ==="
echo "  grep 'diffPercent' test/flutter_test_config.dart"
echo "  # 0.5% pixel diff tolerance"
