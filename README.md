# dotfiles

Personal dotfiles for Linux and macOS.

## Installing

```console
bash <(curl https://raw.githubusercontent.com/gregfolker/dotfiles/main/bootstrap.sh -sSf)
```

This will prompt you for your Git user/email. If you do not want to be prompted
(e.g., non-interactive environments), prepend `GIT_AUTHOR_NAME` and
`GIT_AUTHOR_EMAIL` to the start of the command.

```console
GIT_AUTHOR_NAME="Jane Doe" GIT_AUTHOR_EMAIL="jdoe@example.com" \
    bash <(curl https://raw.githubusercontent/gregfolker/dotfiles/main/bootstrap.sh -sSf)
```

> [!WARNING]
> This is a destructive action. Please ensure files have been backed up prior
> to running this if you want the previous configuration saved. You will not
> be prompted y/N before files are overwritten.
