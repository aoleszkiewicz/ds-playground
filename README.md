# ds-playground

Playground na eksperymenty Data Science — od matmy/statystyki, przez klasyczny ML, po DL i mini-LLMy.

## Struktura

```
foundations/         # matma w ML, statystyka            -> kernel: ds-core
classical-ml/        # klasyczny ML (islr ma wlasny env) -> kernel: ds-core / ds-islr
deep-learning/       # PyTorch, sieci, CV, audio         -> kernel: ds-dl
deep-learning/mini-llms/  # przyszle eksperymenty LLM    -> kernel: ds-llm
envs/                # 3 wspolne kernele jako uv workspace members
scripts/new-nb       # tworzy notebook z dobranym kernelspec
```

Kernele:

| Kernel    | Stos                                                                      |
|-----------|---------------------------------------------------------------------------|
| `ds-core` | numpy, scipy, pandas, sklearn, statsmodels, matplotlib, seaborn, plotly   |
| `ds-dl`   | ds-core + torch, torchvision, torchaudio, h5py                            |
| `ds-llm`  | ds-dl + transformers, datasets, tokenizers, accelerate, peft, sentencepiece |
| `ds-islr` | wyizolowany env w `classical-ml/islr/` (Python 3.14 + ISLP)               |

## Setup po sklonowaniu / po przerwie

```bash
# 1. Zbuduj wszystkie venvy workspace (numpy, torch, transformers, ...).
#    Mozesz tez wybrac tylko to czego potrzebujesz: --package ds-core
uv sync --all-packages

# 2. Zarejestruj kernele w Jupyterze (jednorazowo).
bash envs/register-kernels.sh

# 3. (Opcjonalnie, tylko dla ISLR)
cd classical-ml/islr
uv sync
uv run python -m ipykernel install --user --name ds-islr --display-name "Python (ds-islr)"
cd ../..
```

Sprawdzenie:
```bash
jupyter kernelspec list   # powinno pokazac ds-core, ds-dl, ds-llm (+ ds-islr)
```

## Dodanie nowego notebooka

Zamiast tworzyc `.ipynb` recznie i wybierac kernel klikajac w UI — uzyj skryptu, ktory dobierze kernel z kategorii:

```bash
scripts/new-nb foundations/math-in-ml/gradient-descent.ipynb
scripts/new-nb deep-learning/pytorch-book/attention.ipynb
scripts/new-nb deep-learning/mini-llms/nanogpt.ipynb
```

Plik zostanie utworzony z wpisanym `kernelspec`, wiec **JupyterLab i VS Code od razu zaladuja wlasciwy kernel — bez recznego wyboru**.

Mapowanie sciezka -> kernel jest w `scripts/new-nb` (proste `case`); dorzucenie nowej kategorii to jedna linia.

## Codzienna praca

```bash
# JupyterLab z workspace-owym env (dowolny z trzech):
uv run --package ds-dl jupyter lab

# Albo VS Code: otworz folder, otworz .ipynb -> kernel juz wybrany z metadanych.

# Dodanie nowej zaleznosci do shared-kernela:
uv add --package ds-core polars
uv add --package ds-dl  lightning
```

## Dodanie nowej kategorii

1. `mkdir nowa-kategoria/`
2. Dopisz regule w `scripts/new-nb` (case na prefix sciezki).
3. Jezeli wymaga nowego kernela: dorzuc `envs/ds-X/` z pyproject, dopisz do `tool.uv.workspace.members` w root `pyproject.toml`, dorzuc linie do `envs/register-kernels.sh`.
