# dotfiles

Personal dotfiles for Linux and macOS.

## Installing

Get the source code using `git`.

```console
git clone --recursive https://github.com/gregfolker/dotfiles ~/.dotfiles
```

If the target host doesn't have `git`, you can use `curl` instead.

```console
mkdir -p ~/.dotfiles \
    && cd ~/.dotfiles \
    && curl -L -O https://github.com/gregfolker/dotfiles/archive/main.tar.gz \
    && tar -zxf main.tar.gz -directory . --strip-components=1 \
    && rm main.tar.gz
```

Use `make` to setup symlinks from `$HOME` to where the source code was placed.

```console
cd ~/.dotfiles && make install
```

Change `~/.dotfiles` to where the dotfiles were cloned if it was different.

> [!WARNING]
> `make install` is a destructive action. Please ensure files have been backed up prior
> to running this if you want the previous configuration saved.
