# Ansible Best Practices

## Idempotency
- **Always use `changed_when: false`** for tasks that don't change the system (e.g., `command: whoami`).
- **Use `creates` or `removes`** with `command`/`shell` modules to skip execution if the file already exists/doesn't exist.
- **Avoid shell** unless necessary; use specialized modules (e.g., `apt`, `template`, `file`).

## Variable Management
- Use `group_vars/` for settings shared by multiple hosts.
- Use `host_vars/` for host-specific overrides.
- Prefix role variables with the role name (e.g., `nginx_port`).
- Store secrets in Ansible Vault.

## Task Design
- Use Fully Qualified Collection Names (FQCN) like `ansible.builtin.apt`.
- Use `become: true` only where needed, not globally if possible.
- Group related tasks into roles.
- Use `handlers` for service restarts to avoid redundant restarts.

## Directory Structure
Follow the standard Ansible role structure:
- `tasks/main.yml`: Main entry point for tasks.
- `handlers/main.yml`: Handlers, such as service restarts.
- `defaults/main.yml`: Default variables for the role.
- `vars/main.yml`: Other variables for the role.
- `files/`: Files to be deployed via `copy`.
- `templates/`: Jinja2 templates to be deployed via `template`.
- `meta/main.yml`: Role metadata, including dependencies.
