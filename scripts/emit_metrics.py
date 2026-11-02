#!/usr/bin/env python3
"""Emit data/metrics.json to stdout for osaudit provenance wrapping."""
import json, pathlib, sys
p = pathlib.Path(__file__).resolve().parent.parent / "data" / "metrics.json"
data = json.loads(p.read_text())
data.pop("provenance", None)
assert data["test_to_source_ratio"] == round(data["test_lines"] / data["source_lines"], 2)
json.dump(data, sys.stdout, indent=2)
