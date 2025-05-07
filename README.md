# my_setup

Nix configurations used to set up my development environment.

## Prerequisites
* MacOS Sequoia or higher (I've only tested it on Sequoia)
* Git via MacOS command line tools (`xcode-select --install`) in order to clone this Git repo
* Nix via the Nix installer from Determinate Systems
  - Use it without the --determinate flag to install upstream Nix from nixos.org
  - Determinate's Nix installer includes an automated uninstaller whereas manual uninstallation of Nix on macOS is a (complex process)[https://nix.dev/manual/nix/2.18/installation/uninstall#macos]

## Getting Started

Note: The instructions assume that the hostname of the system is `Kevins-MacBook-Pro`

If that's not the case, in `flake.nix`, where you see,
`darwinConfigurations."Kevins-MacBook-Pro"` replace `"Kevins-MacBook-Pro"` with
the output of `scutil --get LocalHostName`.

```bash
git clone https://github.com/ktham/my_setup.git ~/my_setup
cd my_setup

# Run the "darwin-rebuild" executable from the "nix-darwin/nix-darwin-24.11"
# flake. This will install the darwin-rebuild locally.
nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake \
.#Kevins-MacBook-Pro

# Build the #Kevins-MacBook-Pro host config to ensure it's valid
darwin-rebuild build --flake .#Kevins-MacBook-Pro

# Build the #Kevins-MacBook-Pro host config and switch to use it
# Note: Sudo privileges are needed, a password prompt will appear.
darwin-rebuild switch --flake .#Kevins-MacBook-Pro
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
