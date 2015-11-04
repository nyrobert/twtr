# twtr

Simple command line Twitter application entirely written in shell script. 

## Requirements

* Bash >= 4.0
* cURL
* [jq](https://stedolan.github.io/jq)

## Installation

1. Create a new application on [Twitter Apps](https://apps.twitter.com)
2. Create `.config` file for Twitter keys and tokens
3. Save your consumer key (API key) as `consumer_key` in the `.config` file
4. Save your consumer secret (API secret) as `consumer_secret` in the `.config` file
5. [Generate an OAuth access token for the application](https://dev.twitter.com/oauth/overview/application-owner-access-tokens)
6. Save your access token as `access_token` in the `.config` file
7. Save your access token secret as `access_secret` in the `.config` file
8. Give permission to execute the application: `chmod u+x twtr`

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

## Usage

First of all, this project is an experiment for learning and testing shell 
scripting possibilities therefore it covers only a small part of the Twitter
API.

Display home timeline:

  ```shell
  ./twtr      
  ```

Send status update:

  ```shell
  ./twtr -u "Hello bello!"
  ```

## Screenshots
![Home timeline](https://raw.githubusercontent.com/nyrobert/twtr/master/screenshots/timeline.png)

## License

This project is licensed under the terms of the [MIT License (MIT)](LICENSE).
