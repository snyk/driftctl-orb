# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/install.sh
}

@test '1: test download url with given version' {
    # Mock environment variables or functions by exporting them (after the script has been sourced)
    export PARAM_VERSION="v0.4.0"

    result=$(GetDownloadUrl)
    [ "$result" == "https://github.com/cloudskiff/driftctl/releases/download/v0.4.0" ]
}

@test '2: test download url for latest' {
    result=$(GetDownloadUrl)
    [ "$result" == "https://github.com/cloudskiff/driftctl/releases/latest/download" ]
}

@test '3: test install' {
    export PARAM_VERSION="v0.4.0"
    export PARAM_PATH="/tmp"
    export PARAM_GOOS="linux"
    export PARAM_GOARCH="amd64"
    OUT=$(Install)
    echo $OUT | grep 'driftctl_linux_amd64: OK'
    echo $OUT | grep 'Installed version v0.4.0'
    echo $OUT | grep 'Downloading from https://github.com/cloudskiff/driftctl/releases/download/v0.4.0/driftctl_linux_amd64'
    result=$(/tmp/driftctl version)
    [ "$result" == "v0.4.0" ]
}

teardown() {
    rm /tmp/driftctl || true
    rm driftctl_linux_amd64 || true
    rm driftctl_SHA256SUMS || true
    rm driftctl_SHA256SUMS.gpg || true
}
