#!/usr/bin/env bash
# verify-metrics.sh
#
# Documents how each number in data/metrics.json was obtained.
# This script cannot run against the production codebase (private repo),
# but it records the exact commands used so a reviewer can verify the
# methodology and spot-check the data files in this repo.
#
# All commands assume CWD is the root of the Flutter project.

set -euo pipefail

echo "=== Source metrics ==="
echo "source_files:"
echo "  find lib/ -name '*.dart' -not -name '*.g.dart' | wc -l"

echo "source_lines:"
echo "  find lib/ -name '*.dart' -not -name '*.g.dart' | xargs wc -l | tail -1"

echo ""
echo "=== Test metrics ==="
echo "test_files:"
echo "  find test/ -name '*_test.dart' | wc -l"

echo "test_invocations:"
echo "  flutter test 2>&1 | grep -E '^\+[0-9]+ .* All tests passed' (count from runner output)"

echo "test_lines:"
echo "  find test/ -name '*.dart' | xargs wc -l | tail -1"

echo ""
echo "=== Coverage ==="
echo "Raw coverage:"
echo "  flutter test --coverage"
echo "  lcov --summary coverage/lcov.info"

echo "Filtered coverage:"
echo "  lcov --remove coverage/lcov.info <patterns from data/exclusion-patterns.txt> -o coverage/filtered.info"
echo "  lcov --summary coverage/filtered.info"

echo ""
echo "=== Excluded files ==="
echo "Count files matching exclusion patterns:"
echo "  for pattern in \$(cat data/exclusion-patterns.txt | grep -v '^#'); do"
echo "    find lib/ -path \"\$pattern\" | wc -l"
echo "  done"
echo "  Plus: find lib/core/location_engine/ -name '*.dart' | wc -l  (FFI, not instrumented by lcov)"

echo ""
echo "=== Lint rules ==="
echo "Count and list:"
echo "  grep -r 'extends DartLintRule' packages/zontra_lints/lib/ | wc -l"
echo "  Public version: https://pub.dev/packages/kx_lints"

echo ""
echo "=== Test-to-source ratio ==="
echo "  test_lines / source_lines = 53354 / 104886 = 0.51"
