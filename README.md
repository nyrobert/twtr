# twtr

Simple command line Twitter client written in shell script. 

## Requirements

* Bash >= 4.0
* cURL
* [jq](https://stedolan.github.io/jq)

## Installation

1. Create a new app on [Twitter Apps](https://apps.twitter.com)
2. Create `.config` file for Twitter keys and tokens.
3. Save your consumer key (API key) as `consumer_key` in the `.config` file.
4. Save your consumer secret (API secret) as `consumer_secret` in the `.config` file.

Your `.config` file should look like this:

  ```shell
  # API keys
  consumer_key="xvz1evFS4wEEPTGEFPHBog"
  consumer_secret="kAcSOqF21Fu85e7zjz7ZN2U4ZRhfV3WpwPAoE3Z7kBw"
  
  # personal keys
  access_token="370773112-GmHxMAgYyLbNEtIKZeRNFsMKPR9EyMZeS9weJAEb"
  access_secret="LswwdoUaIvS8ltyTt5jkRh4J50vUPVVHtR2YPi5kE"
  ```

Keep the "consumer secret" a secret. Do not share your "access token secret" with anyone.

## Features

First of all, this is project is an experiment for learning and testing shell 
scripting possibilities. The client offers the following features:

* home timeline
* update current status

## License

This project is licensed under the terms of the [MIT License (MIT)](LICENSE).
