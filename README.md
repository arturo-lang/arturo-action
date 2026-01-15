<div align="center">

<h1>Setup Arturo</h1> 

### Install & use Arturo on any GitHub runner

![License](https://img.shields.io/github/license/arturo-lang/setup-arturo?style=for-the-badge) [![Build Status](https://img.shields.io/github/actions/workflow/status/arturo-lang/setup-arturo/matrix.yml?branch=main&style=for-the-badge)](https://github.com/arturo-lang/setup-arturo/actions) 
</div>

---

<!--ts-->
   * [Quick Start](#quick-start)
   * [More Examples](#more-examples)
      * [Native builds](#native-builds)
      * [Cross-platform matrix](#cross-platform-matrix)
      * [Compilation from source](#compilation-from-source)
   * [Options](#options)
   * [Supported Platforms](#supported-platforms)
   * [License](#license)
<!--te-->

---

## Quick Start

```yaml
- name: Install Arturo
  uses: arturo-lang/setup-arturo@v2
  with: 
    token: ${{ secrets.GITHUB_TOKEN }}
```

> [!NOTE]
> If all you need is to have Arturo available as part of your workflow, chances are all you'll have to do in most cases is to include the step above (^), and the action will auto-detect your runner/OS, fetch the appropriate version, etc. No configuration needed at all! 😉

> [!TIP]
> Want the single fastest runner there is, *with* Arturo enabled? Use macOS on arm64 (basically: `macos-latest`). The whole environment setup easily averages 20 seconds!

## More Examples

### Native builds

```yaml
jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Install Arturo
        uses: arturo-lang/setup-arturo@v2
        with: 
          token: ${{ secrets.GITHUB_TOKEN }}

      - name: Run script
        run: arturo script.art
```

> [!CAUTION]
> Pre-built MINI binaries on `ubuntu-22.04-arm` (ARM64) don't work well!
>
> In general, it's recommended to use the latest runners (ubuntu-latest, macos-latest, windows-latest) for best compatibility.

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
        shell: ${{ 
          (matrix.os == 'freebsd') && 'freebsd {0}' ||
          (matrix.os == 'windows') && 'msys2 {0}'   || 
                                      'bash'        }}

    steps:
      - uses: actions/checkout@v4
      
      - name: Install Arturo
        uses: arturo-lang/setup-arturo@v2
        with: 
          token: ${{ secrets.GITHUB_TOKEN }}
          os: ${{ matrix.os }}
          arch: ${{ matrix.arch }}
          mode: ${{ matrix.mode }}
      
      - name: Test
        run: arturo tests/test.art
```

### Compilation from source

```yaml
- name: Build Arturo from source
  uses: arturo-lang/setup-arturo@v2
  with: 
    token: ${{ secrets.GITHUB_TOKEN }}
    do: compile
    src: main              # or specific branch/tag/commit
    mode: full
    create_artifact: true
    artifact_version: "0.9.85"
```

## Options

| Option | Values | Default | Notes |
|--------|--------|---------|-------|
| `token` | GitHub token | *required* | Use `${{ secrets.GITHUB_TOKEN }}` |
| `do` | `fetch`, `compile` | `fetch` | Fetch nightly or compile from source |
| `from` | `latest`, `stable` | `latest` | Source repository for fetch mode |
| `mode` | `mini`, `full` | `full` | Build configuration |
| `os` | `linux`, `windows`, `macos`, `freebsd`, `web` | auto-detect | Target platform |
| `arch` | `amd64`, `arm64`, `js` | auto-detect | Target architecture |
| `support` | `standard`, `legacy` | auto-detect | For older Ubuntu systems (webkit 4.0 vs 4.1) |
| `src` | branch/tag/commit | latest | Specific Arturo version (compile mode) |
| `metadata` | string | - | Build metadata (compile mode) |
| `create_artifact` | `true`, `false` | `false` | Upload build artifact |
| `artifact_version` | string | - | Version string for artifact naming (compile mode) |
| `artifacts_only` | `true`, `false` | `false` | Skip setup, download & re-upload artifacts only (fetch mode) |

## Supported Platforms

| OS | Architecture | Mode | Runner |
|----|--------------|------|--------|
| Linux | amd64, arm64 | mini, full | ubuntu-latest, ubuntu-22.04, ubuntu-24.04-arm, ubuntu-24.04 |
| Windows | amd64 | mini, full | windows-latest |
| macOS | amd64, arm64 | mini, full | macOS-15-intel, macos-latest |
| FreeBSD | amd64 | mini, full | ubuntu-latest (via VM) |
| Web | js | mini | ubuntu-latest |

> [!NOTE] 
> ### Legacy Support
> For older Ubuntu runners (< 24.04), the action automatically detects and uses WebKit 4.0 instead of 4.1. You can also explicitly set `support: legacy` to force this behavior.

---

## License

MIT License

Copyright (c) 2019-2026 Yanis Zafirópulos (aka Dr.Kameleon)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
