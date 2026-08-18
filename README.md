# raud

An opinionated Arch Linux-based developer workstation.

`raud` is an experiment in building a reproducible Linux environment from a clean Arch Linux installation.

The long-term goal is to evolve raud into a small developer-focused Linux distribution with its own installation flow, configuration model, update mechanism, and eventually a bootable ISO.

## v0.1

The goal of `v0.1` is intentionally small:

```text
Clean Arch Linux
      ↓
git clone raud
      ↓
./install.sh
      ↓
reboot
      ↓
ready developer workstation
```

### Current stack

* Arch Linux
* Hyprland
* Waybar
* Ghostty
* Wofi
* Zsh as the interactive shell
* Bash for system scripts
* PipeWire
* NetworkManager
* Docker
* Java 21
* Kubernetes tooling
* Neovim

## Project structure

```text
raud/
├── README.md
├── install.sh
├── bin/
│   └── raud
├── patterns/
│   ├── base.txt
│   ├── desktop.txt
│   └── dev.txt
└── config/
    ├── ghostty/
    ├── hypr/
    └── waybar/
```

The structure will evolve as raud gains support for Forge configuration, Patterns, Rites, and updates.

## Language

raud uses a small and consistent vocabulary inspired by forging, machinery, and industrial systems.

| Concept               | raud term |
| --------------------- | --------- |
| Distribution          | raud      |
| Build system          | Forge     |
| Machine configuration | Pattern   |
| Package sets          | Patterns  |
| Migration             | Rite      |
| Health check          | Doctor    |
| Host / machine        | Forge     |

The vocabulary is part of the project architecture rather than decoration. New concepts should reuse this language where it makes sense instead of introducing generic or inconsistent naming.

Examples:

```text
raud doctor
raud forge

patterns/base.txt
patterns/desktop.txt
patterns/dev.txt

rites/001-initial-setup.sh
```

The aesthetic should remain subtle: industrial, mechanical, and forge-inspired.

raud should remain a standalone Linux project rather than directly borrowing names, terminology, or lore from existing fictional universes.

## Installation

`v0.1` expects an existing minimal Arch Linux installation with:

* internet access
* a non-root user
* `sudo`
* `git`

Clone the repository:

```bash
git clone <repository-url>
cd raud
```

Run the installer:

```bash
./install.sh
```

After installation, reboot and verify the environment:

```bash
raud doctor
```

## Principles

* Keep the base system simple.
* Prefer official Arch packages.
* Avoid unnecessary dependencies.
* Installation should be repeatable and idempotent.
* User shell configuration must not affect system tooling.
* Automate decisions instead of documenting manual setup steps.
* Treat configuration as reproducible state.
* Prefer explicit conventions over hidden magic.
* Add complexity only when it solves a real problem.
* Keep raud terminology consistent across code, CLI, and documentation.

## Roadmap

### v0.1

Reproducible Arch-based developer workstation.

```text
Clean Arch
    ↓
raud installer
    ↓
Patterns
    ↓
configured workstation
    ↓
raud doctor
```

### v0.2

Introduce a stronger configuration model based on Patterns and improve developer tooling.

### v0.3

Expand the `raud` CLI and introduce the Forge abstraction.

### v0.4

Add Rites for migrations, updates, and rollback support.

### v1.0

Bootable raud installation image.

## Status

Early development. Expect things to break.
