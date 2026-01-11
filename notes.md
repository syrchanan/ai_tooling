## R

When R is installed, I want to be sure to also preload any packages by checking for a local renv setup.

## Python

When Python is installed, I want to be sure to also preload any packages by checking for a local requirements.txt or pyproject.toml.

## Julia

When Julia is installed, I want to be sure to also preload any packages by checking for a local Project.toml.


# Working Notes

- initial dockerfile without goose was working for python
- added goose install with custom unpack/install migration to known file location for PATH
- changed goose env var to write keys to file, not use keyring

# TODOs

- [ ] add more goose helpers to the welcome message
- [ ] switch to uv for python package manager
- [ ] if keys are on local machine, copy them into the container on build