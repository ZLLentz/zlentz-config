# Path Environments
export ORIG_PATH="${PATH}"
export ORIG_LD_LIBRARY_PATH="${LD_LIBRARY_PATH}"
export ORIG_PYTHONPATH="${PYTHONPATH}"

reset_path() {
  export PATH="${orig_path}"
}


