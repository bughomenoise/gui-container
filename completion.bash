#!/bin/bash


function _gui-container {
  local _COMMANDS="create delete" 

  declare -A _PODMAN=(
    ["create"]="$(podman images --format '{{ .Repository}}:{{ .Tag }}')"
    ["delete"]="$(podman ps -a --format '{{ .Names }}')"
  )

  COMPREPLY=()

  local current_w=${COMP_WORDS[COMP_CWORD]}
  
  if [ "$COMP_CWORD" -eq 1 ] ; then
    COMPREPLY=("$( compgen -W "${_COMMANDS}" -- "$current_w")")
  elif [ "$COMP_CWORD" -eq 2 ] ; then
    COMPREPLY=("$( compgen -W "${_PODMAN[${COMP_WORDS[1]}]}" -- "$current_w")")
  fi
}

complete -F _gui-container gui-container
