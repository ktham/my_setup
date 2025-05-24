# my_setup

Nix configurations used to set up my development environment.

## Prerequisites
* MacOS Sequoia or higher (15.4+) on Apple Silicon
* Git via MacOS command line tools (`xcode-select --install`) in order to clone this Git repo
* Nix (>= 2.28.3) via the [Nix installer from Determinate Systems](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer)
  - Omit the `--determinate` flag to install upstream Nix over Determinate Nix
  - Determinate's installation [can survive MacOS upgrades](https://determinate.systems/posts/nix-survival-mode-on-macos/)
  - Determinate's installation also includes an automated uninstaller whereas manual uninstallation of Nix on macOS is a (complex process)[https://nix.dev/manual/nix/2.18/installation/uninstall#macos]

## Getting Started

My Nix configuration makes the following assumptions:
* The username is `kevintham`
* The OS and architecture is `aarch64-darwin` (i.e. MacOS on Apple Silicon)

```bash
git clone https://github.com/ktham/my_setup.git ~/my_setup
cd my_setup

# This command uses the "darwin-rebuild" executable from the
# "nix-darwin/nix-darwin-24.11" flake since we don't have this executable
# locally yet.
#
# This will build the #ktham-mac host configuration and switch to using it.
nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake \
.#ktham-mac
```

For subsequent updates, you can invoke the `darwin-rebuild` command directly:
```
# Build the #ktham-mac host configuration to ensure it's valid
darwin-rebuild build --flake .#ktham-mac

# Build the #ktham-mac host configuration and switch to use it
# Note: Sudo privileges are needed, a password prompt will appear.
sudo darwin-rebuild switch --flake .#ktham-mac
```

## Uninstallation

```
# Run the nix-darwin uninstaller
nix --extra-experimental-features "nix-command flakes" run \
nix-darwin#darwin-uninstaller

# Remove nix-darwin file left behind under our nix-profile bin directory
sudo rm ~/.nix-profile/bin/darwin-rebuild

# Remove nix using Determinate's Nix uninstaller
/nix/nix-installer uninstall
```

## License

The MIT license.

Copyright (c) 2025 Kevin Tham

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
