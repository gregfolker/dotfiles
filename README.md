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

## Troubleshooting

### Error setting certificate file `/etc/pki/tls/certs/ca-bundle.crt`

This error can happen on Ubuntu/Debian systems. For some reason, when
making requests to GitHub the OS tries to find SSL certificates at
the RedHat path instead of the Ubuntu path (Despite being on a Ubuntu
system). The easiest way to resolve this is to create a symbolic link so
the certificate file is where it is expected to be.

```console
sudo mkdir -vp /etc/pki/tls/certs/
sudo ln -svfF /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt
```
