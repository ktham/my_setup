# my_setup

This is the script is used to set up my development environment.


## Prerequisites
* MacOS Mojave and higher (I've only tested it on Mojave)
* Mac OS X command line tools (`xcode-select --install`)
* Ruby 2.0.0 or higher (MacOS Sierra already has it)
* *Optional* [XQuartz](https://xquartz.macosforge.org/) - for X11

## Getting Started

Simply checkout the repo and run the provision script. The script is pretty minimal and reads like a shell script. The script is also idempotent so you don't have to worry about running it multiple times.

```bash
git clone https://github.com/ktham/my_setup.git ~/my_setup
cd my_setup
./provision
```

## Customizations
### zsh
Add your own files to `~/.zshrc.d` and it will automatically be loaded.


## Code Status

[![Build Status](https://travis-ci.org/ktham/my_setup.svg?branch=master)](https://travis-ci.org/ktham/my_setup)

## License

The MIT license.

Copyright (c) 2019 Kevin Tham

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
