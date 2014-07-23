function virtualenv_prompt_info(){
  if [[ -n $VIRTUAL_ENV ]]; then
    printf "@%s" ${${VIRTUAL_ENV}:t}
  fi
}

function python_version_info(){
  if which python &> /dev/null; then
    py=("${(s/ /)$(python --version 2>&1)}")
    printf "%s-%s" ${${py[1]}:l} ${py[2]}
  fi
}

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1
