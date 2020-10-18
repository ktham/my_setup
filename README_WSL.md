# Setting Up WSL on Surface Pro X

TODO for the future: Create idempotent bootstrap script

## Installation
Enable WSL in Windows features
Download Ubuntu from MS Store

## Set Up

```
sudo apt dist-upgrade
sudo apt-get install -y unzip
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
```

Add the following to shell profile, e.g. `~/.bashrc`

```
export PATH="$HOME/.tfenv/bin:$PATH"
export TFENV_ARCH=arm64
```

```
tfenv install 0.14.0-beta1
tfenv use 0.14.0-beta1
```
