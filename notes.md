# Positron Specific Implementation

- This IDE only has devcontainers and images as an early preview, so building them out requires manual work.

- **Options:**
  - Per [here](https://positron.posit.co/remote-ssh.html), remote-ssh can be used to connect to a server that is already running, so it may be possible to use Docker entirely.
  - Per [here](https://github.com/posit-dev/positron/issues/4691#issuecomment-3638058002), there is an option in the dailies to use devcontainers, but this is not yet in stable.

- **Caveats for the second option:**
  - musl-based Linux distributions (such as Alpine) are not supported; the container must be running a version of Linux already supported by Positron.
  - Only single-container configurations are supported (no Docker Compose).
  - No tools or templates are supplied for creating or authoring `devcontainer.json` files.
  - Only one container is supported per project.
  - Docker volumes are not supported, only regular mounts.
  - In the MRU, dev containers show up with the remote rather than local path (e.g. `/workspaces/foo`).
  - Container management features (see/attach to running containers) are not available when inside a container.

Sounds like I need to use a base image with Ubuntu v20+ then build from there...  

Or at least not musl-based, need glibc-based; here is the [Docker docs about that split](https://docs.docker.com/dhi/core-concepts/glibc-musl/).

- For python, `python-latest` seems ok, since it uses `trixie`
- For R, ...
- For Julia, ...

# Other Notes

## Git

Include git by default, and configure for the user?

Maybe eventually try to parameterize with build args to set user.name and user.email?
And also a repo URL to clone on first run if provided?

## Goose

I prob want to try to parameterize the image building, so I can do versions with and without Goose.

Actually, maybe I install by default and then the creds are just not there unless the user adds them?

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