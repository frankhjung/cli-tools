---
name: ansible-expert
description: Expert in Ansible playbook development, role structure, and infrastructure-as-code best practices. Use when managing YAML files in roles/ or tasks/, fixing inventory.yaml, or ensuring idempotent task design.
---

# Ansible Expert

## Overview
This skill provides specialized knowledge and workflows for developing robust, idempotent, and well-structured Ansible playbooks and roles.

## Core Workflows

### 1. Role Development & Refactoring
When creating or modifying a role, ensure it follows the standard directory structure:
- `tasks/main.yml` (Mandatory)
- `handlers/main.yml`, `vars/main.yml`, `defaults/main.yml`, `templates/`, `files/`, `meta/main.yml` (Optional)

**Action**: Use the `best-practices.md` reference to validate your role structure and variable naming.

### 2. Idempotency Check
Every task should be idempotent. If a task uses `command` or `shell`, it must include:
- `creates` or `removes` parameters, OR
- `changed_when` and `failed_when` logic.

**Action**: Review all `shell` and `command` tasks for idempotency.

### 3. Inventory & Variable Management
When dealing with host or group variables:
- Prefer `group_vars/` for shared settings.
- Use `host_vars/` for host-specific overrides.
- Ensure all hostnames in `inventory.yaml` are correctly mapped.

## Guidelines
- Always use Fully Qualified Collection Names (FQCN) (e.g., `ansible.builtin.apt` instead of `apt`).
- Use `become: true` only at the narrowest possible scope (task or role level).
- For service management, always use `handlers` to avoid redundant restarts.

## Resources

### references/
- **best-practices.md**: Detailed guide on idempotency, variable management, and task design.

### assets/
- **role-skeleton/**: Standard structure for initializing new Ansible roles.
