<div align="center">

<h1>Arturo @ction</h1> 

### Easily install & use Arturo on any GitHub runner/OS<br><br>![License](https://img.shields.io/github/license/arturo-lang/arturo-action?style=for-the-badge) [![Build Status](https://img.shields.io/github/actions/workflow/status/arturo-lang/arturo-action/test.yml?branch=main&style=for-the-badge)](https://github.com/arturo-lang/arturo-action/actions) 
</div>

---
 
<!--ts-->
   * [How do I use it?](#how-do-i-use-it)
      * [Supported platforms](#supported-platforms)
      * [Option reference](#option-reference)
   * [License](#license)
<!--te-->

---

### How do I use it?

The most barebones configuration would be:

```yaml
- name: Install Arturo
  uses: arturo-lang/arturo-action@main
  with: 
      token: ${{ secrets.GITHUB_TOKEN }}
```

This will compile and setup the *full* version of Arturo for your target platform.

For more control, specify the OS, architecture, and mode:

```yaml
- name: Install Arturo
  uses: arturo-lang/arturo-action@main
  with: 
      token: ${{ secrets.GITHUB_TOKEN }}
      os: linux
      arch: amd64
      mode: full
```

#### Supported platforms

The action supports the following operating systems and architectures:

| OS | Architecture | Mode | Notes |
|----|--------------|------|-------|
| linux | amd64, arm64, arm, x86 | mini, full, safe, docgen | WebKit 4.0 (ubuntu-22.04) or 4.1 (ubuntu-latest) for full mode |
| windows | amd64 | mini, full | |
| macos | amd64, arm64 | mini, full | |
| freebsd | amd64 | mini, full | WebKit 4.0 or 4.1 for full mode |
| web | web | mini | Compiles to JavaScript |

To use the action, specify the appropriate `runs-on` in your workflow:

```yaml
runs-on: ${{ 
    (matrix.os == 'linux' && matrix.webkit == '40')     && 'ubuntu-22.04'   || 
    (matrix.os == 'windows')                            && 'windows-latest' || 
    (matrix.os == 'macos' && matrix.arch == 'arm64')    && 'macos-latest'   || 
    (matrix.os == 'macos')                              && 'macOS-15-intel' || 
                                                           'ubuntu-latest'  }}
```

#### Option reference

| option | description | default |
|--------|-------------|---------|
| os | Target operating system: `linux`, `windows`, `macos`, `freebsd`, `web` | `linux` |
| arch | Target architecture: `amd64`, `arm64`, `arm`, `x86` | `amd64` |
| mode | Build mode: `full`, `mini`, `safe`, `docgen`, `web` | `full` |
| webkit | WebKit version for Linux/FreeBSD full builds: `40`, `41` | `40` |
| src | Specific Arturo version/branch/commit to build | (latest) |
| metadata | Embeddable build metadata | (empty) |
| token | GitHub token (required) | - |

------

### License

MIT License

Copyright (c) 2019-2025 Yanis Zafirópulos (aka Dr.Kameleon)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.