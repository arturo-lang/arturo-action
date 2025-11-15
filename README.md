<div align="center">

<h1>Arturo @ction</h1> 

### Install & use Arturo on any GitHub runner

![License](https://img.shields.io/github/license/arturo-lang/arturo-action?style=for-the-badge) [![Build Status](https://img.shields.io/github/actions/workflow/status/arturo-lang/arturo-action/test.yml?branch=main&style=for-the-badge)](https://github.com/arturo-lang/arturo-action/actions) 
</div>

---

## Quick Start

Minimal setup:

```yaml
- name: Install Arturo
  uses: arturo-lang/arturo-action@main
  with: 
    token: ${{ secrets.GITHUB_TOKEN }}
```

With specific options:

```yaml
- name: Install Arturo
  uses: arturo-lang/arturo-action@main
  with: 
    token: ${{ secrets.GITHUB_TOKEN }}
    mode: mini
    arch: arm64
```

## Examples

### "Native" build

> [!TIP]
> The action auto-detects your runner and builds the appropriate (full) version. > No configuration needed for basic usage! :wink

```yaml
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Install Arturo
        uses: arturo-lang/arturo-action@main
        with: 
          mode: mini
          token: ${{ secrets.GITHUB_TOKEN }}

      - name: Run script
        run: arturo script.art
```

### Cross-platform matrix

```yaml
jobs:
  test:
    runs-on: ${{ 
      (matrix.os == 'windows')                         && 'windows-latest' || 
      (matrix.os == 'macos' && matrix.arch == 'arm64') && 'macos-latest'   || 
      (matrix.os == 'macos')                           && 'macOS-15-intel' || 
                                                          'ubuntu-latest'  }}
    strategy:
      matrix:
        include: 
          - {os: linux,   arch: amd64, mode: full}
          - {os: linux,   arch: arm64, mode: mini}
          - {os: windows, arch: amd64, mode: full}
          - {os: macos,   arch: amd64, mode: full}
          - {os: macos,   arch: arm64, mode: full}
          - {os: freebsd, arch: amd64, mode: full}
          - {os: web}
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Install Arturo
        uses: arturo-lang/arturo-action@main
        with: 
          token: ${{ secrets.GITHUB_TOKEN }}
          os: ${{ matrix.os }}
          arch: ${{ matrix.arch }}
          mode: ${{ matrix.mode }}
      
      - name: Test
        run: arturo tests/test.art
```

## Options

| Option | Values | Default | Notes |
|--------|--------|---------|-------|
| `token` | GitHub token | *required* | Use `${{ secrets.GITHUB_TOKEN }}` |
| `mode` | `mini`, `full`, `safe`, `docgen` | `full` | Build configuration |
| `os` | `linux`, `windows`, `macos`, `freebsd`, `web` | auto-detect | Target platform |
| `arch` | `amd64`, `arm64` | auto-detect | Target architecture |
| `webkit` | `40`, `41` | `41` | WebKit version (Linux/FreeBSD full builds) |
| `src` | branch/tag/commit | latest | Specific Arturo version |
| `metadata` | string | - | Build metadata |

## Supported Platforms

| OS | Architecture | Mode | Runner |
|----|--------------|------|--------|
| Linux | amd64, arm64 | mini, full | ubuntu-latest, ubuntu-22.04 |
| Windows | amd64 | mini, full | windows-latest |
| macOS | amd64, arm64 | mini, full | macOS-15-intel, macos-latest |
| FreeBSD | amd64 | mini, full | ubuntu-latest (VM) |
| Web | - | - | ubuntu-latest |

---

### License

MIT License - Copyright (c) 2019-2025 Yanis Zafirópulos (Dr.Kameleon)