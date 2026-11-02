#!/usr/bin/env python3
"""Emit data/test_infrastructure.json to stdout for osaudit provenance wrapping."""
import json, pathlib, sys
p = pathlib.Path(__file__).resolve().parent.parent / "data" / "test_infrastructure.json"
data = json.loads(p.read_text())
data.pop("provenance", None)
json.dump(data, sys.stdout, indent=2)
