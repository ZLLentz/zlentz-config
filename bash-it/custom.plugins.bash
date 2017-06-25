# Path Environments
# Unfortunately my work requires conflicting setups for different things, most
# notably EPICS, which overuses environment variables, and python, which has
# some broken setups that kill firefox. This is my workaround so I don't
# waste time debugging PATH bugs.
_set_if_input() {
  if [ -z "$2" ]; then
    export "$1"=""
  else
    export "$1"="$2"
  fi
}

set_envname() {
  _set_if_input "ENVNAME" "$1"
}

set_env_reset() {
  _set_if_input "ENVRESET" "$1"
}

export ENVPATHRESTORE="PATH"
register_env_path() {
  export "ENVPATHRESTORE"="$ENVPATHRESTORE $1";
}

env_path_save() {
  for envpath in $ENVPATHRESTORE
  do
    export "PRE_ENV_$envpath"="${!envpath}"
  done
}

env_path_save

env_path_restore() {
  for envpath in $ENVPATHRESTORE
  do
    var="PRE_ENV_$envpath"
    export "$envpath"="${!var}"
  done
}

reset_env() {
  if [ ! -z "$ENVRESET" ]; then
    eval "$ENVRESET"
  fi
	env_path_restore
  set_envname
  set_env_reset
}

export MY_CONDA_BIN="${HOME}/conda/bin"
conda_env() {
  reset_env
  env_path_save
  pathmunge "${MY_CONDA_BIN}"
  set_envname conda
  if [ ! -z "$1" ]; then
    source activate "$1"
  fi
  set_env_reset "_conda_env_reset"
}

_conda_env_reset() {
  source deactivate
}
