#!/bin/bash
#
# OAuth lib for twtr.

# $1 array request params
#
# return string
oauth_generate_header() {
  eval "declare -A request_params=${1#*=}"

  oauth_params=$(oauth_collect_params)
  eval "declare -A oauth_params=${oauth_params#*=}"

  local request_params
  local oauth_params
  local oauth_str

  oauth_params["oauth_signature"]=$(oauth_generate_signature \
    "$(declare -p request_params)" \
    "$(declare -p oauth_params)" \
  )

  oauth_str=$(oauth_generate_str "$(declare -p oauth_params)" "\""  ", ")

  echo "Authorization: OAuth ${oauth_str}"
}

# return array
oauth_collect_params() {
  declare -A params

  local params
  local signature_method="HMAC-SHA1"
  local version="1.0"

  params["oauth_consumer_key"]="${consumer_key}"
  params["oauth_nonce"]=$(oauth_generate_nonce)
  params["oauth_signature_method"]="${signature_method}"
  params["oauth_timestamp"]=$(date +%s)
  params["oauth_token"]="${access_token}"
  params["oauth_version"]="${version}"

  echo $(declare -p params)
}

# $1 array request params
# $2 array oauth params
#
# return string
oauth_generate_signature() {
  declare -A signature_params

  eval "declare -A request_params=${1#*=}"
  eval "declare -A oauth_params=${2#*=}"

  local request_params
  local oauth_params
  local signature_params
  local signature_str
  local signing_key
  local key

  for key in "${!request_params[@]}"; do
    if [[ "${key}" != "method" ]] && [[ "${key}" != "url" ]]; then
      signature_params["${key}"]="${request_params[$key]}"
    fi
  done

  for key in "${!oauth_params[@]}"; do
    signature_params["${key}"]="${oauth_params[$key]}"
  done

  signature_str=$(oauth_generate_str "$(declare -p signature_params)" ""  "&")
  signature_str=$(printf "%s&%s&%s" \
    "${request_params[method]}" \
    $(percent_encode "${request_params[url]}") \
    $(percent_encode "${signature_str}") \
  )

  signing_key=$(printf "%s&%s" \
    $(percent_encode "${consumer_secret}") \
    $(percent_encode "${access_secret}") \
  )

  echo -n "${signature_str}" \
    | openssl dgst -sha1 -hmac "${signing_key}" -binary \
    | base64
}

# $1 array  params
# $2 string value enclose character
# $3 string separator
#
# return string
oauth_generate_str() {
  eval "declare -A params=${1#*=}"

  local i=0
  local key
  local key_encoded
  local value_encoded
  local params
  local params_keys
  local params_str

  for key in "${!params[@]}"; do
    params_keys["${i}"]="${key}"
    (( i++ ))
  done

  params_keys=($(printf '%s\n' "${params_keys[@]}" | sort))

  i=0

  for key in "${params_keys[@]}"; do
    (( i++ ))

    key_encoded=$(percent_encode "${key}")
    value_encoded=$(percent_encode "${params[$key]}")

    params_str+="${key_encoded}=$2${value_encoded}$2"

    if [[ "${i}" -ne "${#params_keys[@]}" ]]; then
      params_str+="$3"
    fi
  done

  echo "${params_str}"
}

# return string
oauth_generate_nonce() {
  echo $(date +%s | sha256sum | base64 | head -c 32)
}

# RFC 3986, Section 2.1.
#
# $1 string value
#
# return string
percent_encode() {
  echo $(python -c "import urllib, sys; print urllib.quote(sys.argv[1], safe='')" "$1")
}
