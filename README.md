<div align="center">

<h1>Arturo @ction</h1> 

### Easily install & use Arturo on any GitHub runner/OS<br><br>![License](https://img.shields.io/github/license/arturo-lang/arturo-action?style=for-the-badge) [![Build Status](https://img.shields.io/github/actions/workflow/status/arturo-lang/arturo-action/test.yml?branch=main&style=for-the-badge)](https://github.com/arturo-lang/arturo-action/actions) 
</div>

---
 
<!--ts-->
   * [How do I use it?](#how-do-i-use-it)
      * [More options](#more-options)
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

Based on the runner, the action will compile and setup the appropriate, native *full* version of Arturo:

| runner | binary |
|--------|--------|
| ubuntu-latest | amd64 / Linux |
| macos-12 | amd64 / macOS |
| macos-latest | arm64 (M1) / macOS |
| windows-latest | amd64 / Windows |

#### More options

| option | description |
|--------|-------------|
| mode   | this can be either `full`, `mini`, `safe`, `docgen`, `web` (default: `full`) |
| arch   | the target architecture (default: `native`) - the main use is to compile for `arm64` on Linux |

------

### License

MIT License

Copyright (c) 2019-2024 Yanis Zafirópulos (aka Dr.Kameleon)

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