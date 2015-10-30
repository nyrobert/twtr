#!/bin/bash
#
# Config lib for twtr.

readonly config_file=./.config

config_load() {
  if [[ -f "${config_file}" ]] && [[ -r "${config_file}" ]]; then
    . "${config_file}"

    config_check

    readonly consumer_key
    readonly consuner_secret
    readonly access_token
    readonly access_secret
  else
    error_handler "Config file not found"
  fi
}

config_check() {
  if [[ -z "${consumer_key}" ]]; then
    error_handler "Consumer key (API key) not found"
  elif [[ -z "${consumer_secret}" ]]; then
    error_handler "Consumer secret (API secret) not found"
  elif [[ -z "${access_token}" ]]; then
    error_handler "Access token not found"
  elif [[ -z "${access_secret}" ]]; then
    error_handler "Access secret not found"
  fi
}
