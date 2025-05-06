# my_setup

Nix configurations used to set up my development environment.

## Prerequisites
* MacOS Sequoia and higher (I've only tested it on Sequoia)
* Mac OS X command line tools (`xcode-select --install`) to clone this Git repo
* Nix with Flake Support (Download from: https://docs.determinate.systems/)

## Getting Started

```bash
git clone https://github.com/ktham/my_setup.git ~/my_setup
cd my_setup

# Run the "darwin-rebuild" executable from the "nix-darwin/nix-darwin-24.11" flake
# This will install the darwin-rebuild locally.
#
nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch

# Build the #Kevins-MacBook-Pro host config to ensure it's valid
darwin-rebuild build --flake .#Kevins-MacBook-Pro

# Build the #Kevins-MacBook-Pro host config and switch to use it
# Note: Sudo privileges are needed and you will be prompted to enter your password
darwin-rebuild switch --flake .#Kevins-MacBook-Pro
```

## License

The MIT license.

Copyright (c) 2025 Kevin Tham

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
