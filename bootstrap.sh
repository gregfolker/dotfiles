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
	local src=
	local dst=
	while IFS='' read -r -d '' dotfile; do
		src="$(realpath "$dotfile")"
		dst="$HOME/$(basename "$dotfile")"
		if [ -f "$dst" ] && [ ! -w "$dst" ]; then
			echo "$USER does not have permissions to modify $dst, skipping..."
			continue
		fi
		ln -svF "$src" "$dst"
	done < <(find "$CLONE_DIR" -maxdepth 1 -name ".*" -type f -not -name ".gitignore" -not -name ".mdl*" -print0)
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
				echo "Installing goodies..."
				brew bundle --file="$CLONE_DIR/Brewfile"
			fi
		fi
	fi

	echo "Creating symlinks..."
	create_symlinks

	echo "Bootstrap complete."
}

main "$@"
