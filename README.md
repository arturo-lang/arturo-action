<div align="center">

<h1>Arturo @ction</h1> 

### Install & use Arturo on any GitHub runner

![License](https://img.shields.io/github/license/arturo-lang/arturo-action?style=for-the-badge) [![Build Status](https://img.shields.io/github/actions/workflow/status/arturo-lang/arturo-action/matrix.yml?branch=main&style=for-the-badge)](https://github.com/arturo-lang/arturo-action/actions) 
</div>

---

## Quick Start

```yaml
- name: Install Arturo
  uses: arturo-lang/arturo-action@main
  with: 
    token: ${{ secrets.GITHUB_TOKEN }}
```

> [!TIP]
> If all you need is to have Arturo available as part of your workflow, chances are all you'll ever need in most cases is to include the step above (^), and the action will auto-detect your runner/OS, fetch the appropriate version, etc.  No configuration needed at all! 😉

## More Examples

### "Native" build

```yaml
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Install Arturo
        uses: arturo-lang/arturo-action@main
        with: 
          token: ${{ secrets.GITHUB_TOKEN }}

      - name: Run script
        run: arturo script.art
```

> [!CAUTION]
> Right now, every possible combination of runner/mode will work natively, except for `ubuntu-22.04-arm` (ARM64) + MINI mode!

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

    defaults:
      run:
      shell: ${{ (matrix.os == 'windows') && 'msys2 {0}' || 
                                             'bash'      }}

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

MIT License

Copyright (c) 2019-2025 Yanis Zafirópulos (aka Dr.Kameleon)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
