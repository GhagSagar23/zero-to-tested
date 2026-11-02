#!/usr/bin/env python3
"""Emit data/case_studies.json to stdout for osaudit provenance wrapping."""
import json, pathlib, sys
p = pathlib.Path(__file__).resolve().parent.parent / "data" / "case_studies.json"
data = json.loads(p.read_text())
data.pop("provenance", None)
json.dump(data, sys.stdout, indent=2)
