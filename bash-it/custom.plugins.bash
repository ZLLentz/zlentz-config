# Path Environments
# Unfortunately my work requires conflicting setups for different things, most
# notably EPICS, which overuses environment variables, and python, which has
# some broken setups that kill firefox. This is my workaround so I don't
# waste time debugging PATH bugs.
envname() {
  export ENVNAME="$1"
}

_orig_env_reset() {
  envname "-"
}

_full_env_reset() {
  alias reset_env='_orig_env_reset'
  reset_env
}


conda_env() {
  reset_env
  export PRE_ENV_PATH="${PATH}"
  pathmunge "${HOME}/conda/bin"
  envname conda
  if [ ! -z "$1" ]; then
    source activate "$1"
  fi
  alias reset_env='_conda_env_reset'
}

_conda_env_reset() {
  source deactivate
  export PATH="${PRE_ENV_PATH}"
  _full_env_reset
}
