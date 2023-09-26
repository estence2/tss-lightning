#!/usr/bin/env zsh

read -p "Enter cluster number or enter to skip: " cluster
  #if cluster blank
  if [[ -z $cluster ]]; then
    open -n -a "Google Chrome" --args "https://app.datadoghq.com/dashboard/vai-kde-xkm/kafka-status?from_ts=1682629766462&to_ts=1682633366462&live=true"
  else
    open -n -a "Google Chrome" --args "https://app.datadoghq.com/dashboard/vai-kde-xkm/kafka-status?tpl_var_escluster%5B0%5D=c$cluster&from_ts=1682629766462&to_ts=1682633366462&live=true"
  fi
  echo "
Opening DataDog Kafka dashboard..."