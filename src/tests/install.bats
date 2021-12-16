# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/install.sh
}

@test '1: test get version with 0.5.0' {
    export PARAM_VERSION="0.5.0"
    [ "$(GetVersion)" == "0.5.0" ]
}

@test '2: test get version for latest' {
    [ "$(GetVersion)" == "latest" ]
}

@test '3: test install driftctl v0.5.0' {
    export PARAM_VERSION="v0.5.0"
    Install
    [ "$(which driftctl)" == "/usr/local/bin/driftctl" ]
    [ "$(driftctl version)" == "v0.5.0" ]
}

@test '3: test install driftctl v0.16.0' {
    export PARAM_VERSION="v0.16.0"
    Install
    [ "$(which driftctl)" == "/usr/local/bin/driftctl" ]
    [ "$(driftctl version)" == "v0.16.0" ]
}

@test '3: test install driftctl latest' {
    Install
    [ "$(which driftctl)" == "/usr/local/bin/driftctl" ]
}
