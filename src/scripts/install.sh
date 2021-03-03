GetDownloadUrl() {
    BASE_URL="https://github.com/cloudskiff/driftctl/releases/latest/download"
    if [ -n "${PARAM_VERSION}" ]; then
        BASE_URL="https://github.com/cloudskiff/driftctl/releases/download/${PARAM_VERSION}"
    fi
    echo "${BASE_URL}"
}

Install() {
    DCTL_NO_VERSION_CHECK="true"
    BASE_URL=$(GetDownloadUrl)
    KEY="${PARAM_GOOS}_${PARAM_GOARCH}"
    echo "Downloading from ${BASE_URL}/driftctl_${KEY}"
    curl -sL "${BASE_URL}/driftctl_${KEY}" -o "driftctl_${KEY}"
    curl -sL "${BASE_URL}/driftctl_SHA256SUMS" -o driftctl_SHA256SUMS
    curl -sL "${BASE_URL}/driftctl_SHA256SUMS.gpg" -o driftctl_SHA256SUMS.gpg
    sha256sum --ignore-missing -c driftctl_SHA256SUMS
    chmod +x "driftctl_${KEY}"
    mv "driftctl_${KEY}" "${PARAM_PATH}/driftctl"
    echo "Installed version $("${PARAM_PATH}"/driftctl version)"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
if [[ "$_" == "$0" ]]; then
    Install
fi
