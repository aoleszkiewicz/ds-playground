#!/usr/bin/env bash
# Rejestruje 3 wspolne kernele Jupyter dla workspace ds-playground.
# Wymaga uv >=0.5 i wykonania `uv sync --all-packages` z root repo.
set -euo pipefail

cd "$(dirname "$0")/.."

uv run --package ds-core  python -m ipykernel install --user --name ds-core --display-name "Python (ds-core)"
uv run --package ds-dl    python -m ipykernel install --user --name ds-dl   --display-name "Python (ds-dl)"
uv run --package ds-llm   python -m ipykernel install --user --name ds-llm  --display-name "Python (ds-llm)"

echo
echo "Zarejestrowane kernele:"
jupyter kernelspec list
