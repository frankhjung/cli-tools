---
name: ansible-programmer
description: >-
  Develop, refactor, test, and review Ansible roles and playbooks. Enforces
  idempotency, declarative infrastructure, Debian FHS compliance, and strict
  Ansible best practices.
---

Guide Ansible development using modern declarative infrastructure practices,
strict idempotency, and clean playbook structures.

## Architectural & Playbook Best Practices

- **Idempotency is Non-Negotiable:** All tasks must report `changed: false` on
  subsequent runs when the system is already in the desired state.
- **Handlers for Side Effects:** Never restart services directly in task
  blocks. Use `notify` triggers to run handlers (e.g. service restart or
  reload) only when configuration files change.
- **Explicit Desired State:** Specify `state: present`, `state: started`, or
  appropriate explicit parameters rather than relying on implicit defaults.
- **Loop Hygiene:** Use `loop_control.label` when looping over complex
  dictionaries to keep output concise and avoid leaking sensitive data.
- **Sensitive Data:** Use `no_log: true` on tasks handling passwords, keys, or
  vault variables.
- **Variables & Namespacing:** Use `roles/<role>/vars/main.yaml` for role-owned
  constants and `roles/<role>/defaults/main.yaml` for override-friendly
  fallbacks. Prefix variables with the role name (e.g. `role_setting_name`).

## Native Modules Over Shell Scripts

- **Avoid Imperative Shells:** Never use `ansible.builtin.shell` or
  `ansible.builtin.command` when a native Ansible module exists. Shell scripts
  break idempotency, bypass diff mode, and cannot be monitored reliably.
- **Declarative Alternatives:**
  - File management: `ansible.builtin.file` (avoid `chmod`, `chown`, `mkdir`)
  - Content deployment: `ansible.builtin.copy` or `ansible.builtin.template`
  - Web downloads: `ansible.builtin.get_url` or `ansible.builtin.uri`
  - In-place file edits: `ansible.builtin.lineinfile` or `blockinfile`
  - System packages: `ansible.builtin.apt` (avoid raw `apt-get` or `dpkg`)
- **Unavoidable CLI Commands:** If a tool lacks a native module, use
  `ansible.builtin.command` rather than `ansible.builtin.shell`. You must
  specify idempotency parameters:
  - `changed_when`: Define exact conditions under which changes occurred.
  - `creates` / `removes`: Specify file sentinels to prevent repeat runs.
  - `failed_when`: Handle expected CLI return codes explicitly.

## Project Integration (Example: ansible-debian)

When developing for this repository or similar Debian environments:

- **Baseline Assumptions:** Assume only the following core roles are present:
  `packages`, `pre_tasks`, `ssh`, `system`, and `user`. Manage all other
  dependencies, directories, and groups explicitly within the role.
- **Debian Standards:** Adhere strictly to the Debian Filesystem Hierarchy
  Standard (FHS). Manage daemons natively via `ansible.builtin.systemd`.
- **Targeting & Entrypoints:** The primary playbook is `site.yaml`, targeted
  via `make` (which runs `ansible-playbook -e "target=$(uname -n)" site.yaml`).
- **Conditional Roles:** Guard optional roles using inventory group checks
  (e.g. `when: "'docker' in group_names"`).
- **Rollback Roles:** If requested, provide matching removal roles (e.g.
  `roles/<role>_remove`) that purge packages, delete configs, and stop services.
- **File Extensions:** Always use `.yaml` extensions consistently (not `.yml`).

## Testing, Tooling & Workflow

- **Linting & Validation:** Run `make lint` before finalising changes. This
  validates playbook syntax, runs `ansible-lint`, and checks role invariants
  via `tools/list_role_diffs.py`.
- **Execution & Tagging:** Maintain meaningful task names and tags for
  selective execution (`make tags tags=<role>`) and task resumption
  (`make resume task="<task name>"`).
- **Idempotency Testing:** Verify roles by running the playbook twice. The
  second pass must return zero changes (`changed=0`).

## Review & Output Contract

When reviewing or refactoring Ansible code, organise output into:

1. **Summary:** Architectural overview and scope of changes.
2. **Idempotency & State:** Verification of idempotency, handler use, and
   absence of uncontrolled shell commands.
3. **Best Practices:** Use of FQCNs, variable namespacing, and Debian FHS.
4. **Tooling & Quality:** Diagnostics from `make lint` and `ansible-lint`.
5. **Suggested Code / Diff:** Idiomatic, declarative Ansible YAML.

## Resources

- Ansible Documentation: [Ansible Docs](https://docs.ansible.com/)
- Galaxy User Guide: [Galaxy-NG Community][galaxy-guide]
- Dictionary: [Macquarie Dictionary](https://www.macquariedictionary.com.au/)

[galaxy-guide]:
https://docs.ansible.com/projects/galaxy-ng/en/latest/community/userguide.html
