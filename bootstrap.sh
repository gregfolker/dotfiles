#!/bin/bash

set -euo pipefail

readonly GIT_REPO_URL="${GIT_REPO_URL-https://github.com/gregfolker/dotfiles}"
readonly GIT_BRANCH="${GIT_BRANCH-main}"
readonly CLONE_DIR="${CLONE_DIR-$HOME/.dotfiles}"

BREW_PKGS=(
    git
    bash
    curl
    file
    findutils
    gcc
    make
    coreutils
    wget
)

function usage() {
    cat <<EOF
Usage: ./bootstrap.sh [OPTIONS]

Install dependencies and clone dotfiles on a MacOS or Linux system. This
installs packages using Homebrew and will install Homebrew automatically
if it is not already installed and the user has sudo permissions. Can be
downloaded and executed with the convenient one liner:

    bash <(curl -fsSL https://raw.githubusercontent.com/gregfolker/dotfiles/main/bootstrap.sh)

Always inspect and verify the contents of downloaded scripts before executing them!

Prepend CLONE_DIR=/path/to/dotfiles to the bootstrap command to choose where the repository gets
cloned. The default directory is $CLONE_DIR

Default packages to be installed via brew: ${BREW_PKGS[@]}

Options:
    -h, --help          Show this help message and exit.
    -v, --verbose       Enable verbose logging.
    -m, --minimal       Perform a minimal install.
EOF
}

function update_xcode() {
    if [ ! -f "/Library/Developer/CommandLineTools/usr/bin/git" ]; then
        echo "Xcode Command Line Tools is up to date, skipping..."
        return 0
    fi

    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    softwareupdate -i -a
    rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
}

function install_homebrew() {
    HOMEBREW_PREFIX="${HOMEBREW_PREFIX-}"
    if [ -z "$HOMEBREW_PREFIX" ]; then
        case "$(uname -s)" in
        Darwin)
            HOMEBREW_PREFIX="/opt/homebrew"
            ;;
        Linux)
            HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
            ;;
        *)
            echo "Unsupported Host OS: $(uname -s)"
            exit 1
            ;;
        esac
    fi

    if command -v brew >/dev/null; then
        echo "Found $(brew --version), skipping..."
        return 0
    fi

    if [ ! -d "$HOMEBREW_PREFIX" ]; then
        if ! sudo --validate 2>/dev/null; then
            echo "WARNING: $USER does not have permissions to install Homebrew, skipping..."
            return 0
        fi
        test "$(uname -s)" == "Darwin" && update_xcode
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
}

function download_dotfiles() {
    if [ -d "$CLONE_DIR" ]; then
        echo "dotfiles already found in $CLONE_DIR, skipping..."
        return 0
    fi

    if command -v git >/dev/null; then
        git clone --recursive "$GIT_REPO_URL" -b "$GIT_BRANCH" "$CLONE_DIR"
    else
        mkdir -vp "$CLONE_DIR"
        curl -L "$GIT_REPO_URL/archive/$GIT_BRANCH.tar.gz" -o /tmp/dotfiles.tar.gz
        tar -zxf /tmp/dotfiles.tar.gz --directory "$CLONE_DIR" --strip-components=1
        rm /tmp/dotfiles.tar.gz
    fi
}

function create_symlinks() {
    local source_file=
    local target_file=
    for filename in .{aliases,functions,env,tmux.conf,vimrc,virc}; do
        source_file="$CLONE_DIR/$filename"
        target_file="$HOME/$filename"
        if [ -f "$target_file" ] && [ ! -w "$target_file" ]; then
            echo "$USER does not have permissions to modify $target_file, skipping..."
            continue
        fi
        ln -svfF "$source_file" "$target_file"
    done

    XDG_CONFIG_HOME="${XDG_CONFIG_HOME-$HOME/.config}"
    test ! -d "$XDG_CONFIG_HOME" && mkdir -vp "$XDG_CONFIG_HOME"
    ln -svfF "$(realpath "$CLONE_DIR/nvim")" "$XDG_CONFIG_HOME/nvim"
    ln -svfF "$(realpath "$CLONE_DIR/git")" "$XDG_CONFIG_HOME/git"

    test ! -d ~/.local/bin && mkdir -vp ~/.local/bin
    find "$CLONE_DIR/bin/" -type f -print0 | while IFS= read -r -d '' source_file; do
        if [ -x "$source_file" ]; then
            target_file="$HOME/.local/bin/$(basename "$source_file")"
            ln -svfF "$source_file" "$target_file"
        fi
    done

    {
        echo
        echo "# Added by $CLONE_DIR/bootstrap.sh"
        echo "test -r ~/.env && . ~/.env"
        echo "test -r ~/.aliases && . ~/.aliases"
        echo "test -r ~/.functions && . ~/.functions"
        echo "test -r ~/.cargo/env && . ~/.cargo/env"
    } >>~/."$(basename "$SHELL")"rc

    if [ "$(basename "$SHELL")" == "zsh" ]; then
        # enable autocompletion for git commands in zsh
        {
            echo
            echo "# Added by $CLONE_DIR/bootstrap.sh"
            echo "autoload -Uz compinit && compinit"
        } >>~/.zshrc
    fi
}

function configure_git() {
    if ! command -v git >/dev/null; then
        echo "Git is not installed, skipping..."
        return 0
    fi

    if [ ! -f ~/.gitconfig.user ]; then
        local git_user_name=
        local git_user_email=
        if [[ -t 0 ]]; then
            read -rp "Enter your name for git commits: " git_user_name
            read -rp "Enter your email for git commits: " git_user_email
        else
            git_user_name="$USER"
            git_user_email="$USER@$(hostname -f)"
        fi
        {
            echo "# Added by $CLONE_DIR/bootstrap.sh"
            echo "[user]"
            echo "    name = $git_user_name"
            echo "    email = $git_user_email"
        } >~/.gitconfig.user
        echo "Git user information written to ~/.gitconfig.user"
    fi
}

function install_rust() {
    # https://rust-lang.org/tools/install/
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable --no-modify-path
}

function main() {
    local minimal=
    while [[ $# -gt 0 && $1 =~ ^- && $1 != "--" ]]; do
        case $1 in
        -h | --help)
            usage
            exit
            ;;
        -v | --verbose)
            set -o xtrace
            export PS4='+ ${BASH_SOURCE:-}:${FUNCNAME[0]:-}:L${LINENO:-}: '
            ;;
        -m | --minimal)
            minimal=1
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
        esac
        shift
    done

    echo "Bootstrapping dotfiles..."

    echo "Installing Homebrew..."
    install_homebrew

    if command -v brew >/dev/null; then
        brew config
        echo "Installing packages..."
        brew update && brew upgrade && brew install "${BREW_PKGS[@]}"
    fi

    echo "Downloading dotfiles..."
    download_dotfiles

    if command -v brew >/dev/null; then
        if [ -z "$minimal" ]; then
            if ! brew bundle check --file="$CLONE_DIR/Brewfile" >/dev/null 2>&1; then
                # TODO: The version of homebrew in GitHub actions encounters a circular dependency on
                # libtiff and webp. Since we do not need these for anything, just force uninstall them
                # before running brew bundle
                #
                # https://github.com/Homebrew/homebrew-core/pull/287031
                # https://github.com/Homebrew/homebrew-core/pull/287032
                brew uninstall --ignore-dependencies --force libtiff webp
                echo "Installing goodies..."
                brew bundle --file="$CLONE_DIR/Brewfile" || true
                install_rust
            fi
        fi
    fi

    echo "Creating symlinks..."
    create_symlinks

    echo "Configuring git..."
    configure_git

    echo "Bootstrap complete. Re-load your environment for changes to take effect."
}

main "$@"
