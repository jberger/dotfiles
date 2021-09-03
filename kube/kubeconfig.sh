#!/bin/bash

if test -f "${HOME}/.kube/config"
then
  export KUBECONFIG=$KUBECONFIG:"${HOME}/.kube/config"
fi

CONFDIR="${HOME}/.kube/config.d"
if test -d "$CONFDIR"
then
  for f in "$CONFDIR"/*.yaml
  do 
    if test -f "${f}"
    then
      export KUBECONFIG=$KUBECONFIG:"${f}"
    fi
  done
fi
