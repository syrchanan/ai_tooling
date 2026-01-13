#!/bin/bash
set -e

# Load any libs needed ----

# Python: requirements.txt and pyproject.toml (recursive)
find /workspace -type f -name "requirements.txt" -exec uv pip install -r {} \;
find /workspace -type f -name "pyproject.toml" -exec sh -c 'uv pip install "$(dirname \"{}\")"' \;

# R: renv.lock (recursive)
find /workspace -type f -name "renv.lock" -exec sh -c 'Rscript -e "if (!requireNamespace(\"renv\", quietly=TRUE)) install.packages(\"renv\"); renv::restore()" --project="$(dirname \"{}\")"' \;

# Julia: Project.toml (recursive)
find /workspace -type f -name "Project.toml" -exec sh -c 'julia --project="$(dirname \"{}\")" -e "using Pkg; Pkg.instantiate()"' \;