# dotfiles

Personal dotfiles for Linux and macOS.

## Installing

```console
bash <(curl https://raw.githubusercontent.com/gregfolker/dotfiles/main/bootstrap.sh -sSf)
```

To choose where the dotfiles get cloned, prepend `CLONE_DIR` to the start of
the command.

```console
CLONE_DIR=/path/to/dotfiles bash <(curl https://raw.githubusercontent.com/gregfolker/dotfiles/main/bootstrap.sh -sSf)
```

The default location is `~/.dotfiles`. Add the `--help` flag to the above
command to get more details about what will be installed on the host.

> [!WARNING]
> This is a destructive action. Please ensure files have been backed up prior
> to running this if you want the previous configuration saved. You will not
> be prompted y/N before files are overwritten.
