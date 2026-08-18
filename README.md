# raud

An opinionated Arch Linux-based developer workstation.

`raud` is an experiment in building a reproducible Linux environment from a clean Arch Linux installation.

The long-term goal is to evolve it into a small developer-focused Linux distribution with its own installation flow, configuration, update mechanism, and eventually a bootable ISO.

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
├── packages/
│   ├── base.txt
│   ├── desktop.txt
│   └── dev.txt
└── config/
    ├── ghostty/
    ├── hypr/
    └── waybar/
```

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
* Add complexity only when it solves a real problem.

## Roadmap

### v0.1

Reproducible Arch-based developer workstation.

### v0.2

Improve configuration management and developer tooling.

### v0.3

Introduce a more capable `raud` CLI.

### v0.4

Updates, migrations, and rollback support.

### v1.0

Bootable installation image.

## Status

Early development. Expect things to break.
