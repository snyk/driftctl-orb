GetVersion() {
    if [ -n "${PARAM_VERSION}" ]; then
      echo -n "${PARAM_VERSION}"
    else
      echo -n "latest"
    fi
}

Install() {
    export DCTL_NO_VERSION_CHECK="true"

    BINPATH="${HOME}/.dctlenv/bin"
    if [ ! -d "${HOME}/.dctlenv" ]; then
      git clone --depth 1 --branch v0.1.7 https://github.com/wbeuil/dctlenv ~/.dctlenv
    fi

    VERSION=$(GetVersion)
    gpg --import driftctl_pubkey.pem
    "${BINPATH}/dctlenv" use "${VERSION}"

    if [ ! -e /usr/local/bin/driftctl ]; then
      sudo ln -s "${BINPATH}/driftctl" /usr/local/bin/driftctl
    fi
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
if [[ "$_" == "$0" ]]; then
    Install
fi
