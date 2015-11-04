#!/bin/bash
#
# API lib for twtr.

readonly api_version="1.1"

# $1 array request params
#
# return string JSON encoded API response
api_request() {
  eval "declare -A request_params=${1#*=}"

  local request_params
  local header=$(oauth_generate_header "$(declare -p request_params)")
  local data=$(api_generate_data_str "$(declare -p request_params)")

  if [[ "${request_params[method]}" = "GET" ]]; then
    echo $(curl \
      --get "${request_params[url]}" \
      --data "${data}" \
      --header "${header}" \
      --silent
    )
  elif [[ "${request_params[method]}" = "POST" ]]; then
    echo $(curl \
      --request "POST" "${request_params[url]}" \
      --data "${data}" \
      --header "${header}" \
      --silent
    )
  else
    error_handler "Invalid API request method"
  fi
}

# $1 array request params
#
# return string
api_generate_data_str() {
  eval "declare -A request_params=${1#*=}"

  local i=0
  local request_params
  local key
  local value_encoded
  local data_str

  unset request_params["method"]
  unset request_params["url"]

  for key in "${!request_params[@]}"; do
    (( i++ ))

    value_encoded=$(percent_encode "${request_params[$key]}")

    data_str+="${key}=${value_encoded}"

    if [[ "${i}" -ne "${#request_params[@]}" ]]; then
      data_str+="&"
    fi
  done

  echo "${data_str}"
}
