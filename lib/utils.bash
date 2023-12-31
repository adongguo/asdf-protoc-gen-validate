#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/bufbuild/protoc-gen-validate"
TOOL_NAME="protoc-gen-validate"
TOOL_TEST="protoc-gen-validate --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if protoc-gen-validate is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# Change this function if protoc-gen-validate has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	url="$GH_REPO/releases/download/v${version}/protoc-gen-validate_${version}_$(get_platform)_$(get_arch).tar.gz"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -C - "$url" || fail "Could not download $url"
}

get_platform() {
  local os=$(uname)
  if [[ "${os}" == "Darwin" ]]; then
    echo "darwin"
  elif [[ "${os}" == "Linux" ]]; then
    echo "linux"
  else
    echo >&2 "unsupported os: ${os}" && exit 1
  fi
}

get_arch() {
  local os=$(uname)
  local arch=$(uname -m)
  # On ARM Macs, uname -m returns "arm64", but in protoc releases this architecture is called "aarch_64"
  if [[ "${os}" == "Darwin" && "${arch}" == "arm64" ]]; then
    # echo "aarch_64"
    echo "arm64"
  elif [[ "${os}" == "Linux" && "${arch}" == "aarch64" ]]; then
    # echo "aarch_64"
    echo "x86_64"
  else
    echo "${arch}"
  fi
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		echo "* install_path $install_path"
		echo "* ASDF_DOWNLOAD_PATH $ASDF_DOWNLOAD_PATH"
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

#		local tool_cmd
#		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
#		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."
#
		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
