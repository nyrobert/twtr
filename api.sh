#!/bin/bash
#
# API lib for twtr.

readonly api_version="1.1"

api_request() {
  eval "declare -A request_params=${1#*=}"

  local request_params
  local header=$(oauth_generate_header "$(declare -p request_params)")

  echo $(curl \
    --get "${request_params[url]}" \
    --data "count=5" \
    --header "${header}" \
    --silent
  )
}
