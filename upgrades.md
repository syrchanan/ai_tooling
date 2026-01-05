# Dockerfile Upgrade Plan

This document outlines a prioritized, actionable plan to improve the efficiency, maintainability, and security of your development container. Each section includes rationale and step-by-step instructions.

---

## 1. Combine RUN Steps and Reduce Layers

**Rationale:**  
Fewer layers mean smaller images and faster builds.

**Steps:**
- Merge all related `RUN` commands into a single block using `&&` to chain commands.
- Ensure cleanup (e.g., `rm -rf /var/lib/apt/lists/*`) is done in the same block as installation.

---

## 2. Use Multi-stage Builds (If Applicable)

**Rationale:**  
Keeps the final image minimal by excluding build-only dependencies.

**Steps:**
- Add a build stage for compiling or installing tools.
- In the final stage, copy only the necessary binaries/files from the build stage.

---

## 3. Pin Package Versions

**Rationale:**  
Ensures reproducible builds and avoids unexpected breakages.

**Steps:**
- Specify versions for `apt-get` packages (where possible) and Python packages.

---

## 4. Switch to uv for Python Package Management

**Rationale:**  
`uv` is faster and more reliable than `pip`.

**Steps:**
- Install `uv` in the Dockerfile.
- Replace `pip install ...` with `uv pip install ...` for all Python dependencies.
- Update documentation and scripts to use `uv`.
- If `uv` environment is already created in workspace, install the packages used in the requirements file and/or the preload packages.

---

## 6. Copy Host Credentials and Keys at Runtime

**Rationale:**  
Avoids baking secrets into images and allows for easier credential rotation.

**Steps:**
- Use Docker volumes or bind mounts to inject credentials at container start.
- For git: mount `~/.gitconfig` and `~/.ssh` from host to container.
- For goose: mount key files or set environment variables via `docker run -e`.
- Document the required mounts and environment variables in your README.

---

## 7. Parameterize User and Repo Setup

**Rationale:**  
Makes the image reusable for different users/projects.

**Steps:**
- Use `ARG` for user name, email, and repo URL.
- Set these as environment variables or use them in setup scripts.

---

## 9. Minimize Global Python Installs

**Rationale:**  
Keeps the global environment clean and avoids conflicts.

**Steps:**
- Only install essential tools globally (e.g., `ipython`, `uv`).
- For project dependencies, use `uv` or `venv` in the project directory.
- Document this workflow for users.

---

## 10. Modularize Welcome Message

**Rationale:**  
Easier to update and maintain.

**Steps:**
- Move the welcome banner and cheatsheet logic into a separate script (e.g., `/home/developer/welcome.sh`).
- Source this script from `.bashrc`.
- Store cheatsheet content in a markdown or text file for easy editing.

---

## 11. Improve Healthcheck Script

**Rationale:**  
Provides better diagnostics for container health.

**Steps:**
- Expand `/home/developer/healthcheck.sh` to check for:
  - Python, Goose, and other key tools
  - Network connectivity
  - Disk space
- Output actionable messages if checks fail.

---

## 12. Drop Privileges Where Possible

**Rationale:**  
Improves security.

**Steps:**
- Continue running as the non-root developer user.
- Only grant sudo if absolutely necessary.
- Review permissions on sensitive files and directories.

---

## 13. Modularize for R/Julia Support

**Rationale:**  
Prepares for future extensibility.

**Steps:**
- Structure Dockerfile with clear sections for Python, R, and Julia.
- Use build arguments or scripts to enable/disable language support.
- Document how to add R/Julia and preload packages from `renv` or `Project.toml`.

---

## Appendix: Example .dockerignore

For each upgrade, test the build and document any changes in the README. This plan will help you maintain a robust, efficient, and secure development environment.