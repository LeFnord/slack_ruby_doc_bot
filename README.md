[ ![Codeship Status for LeFnord/slack_ruby_doc_bot](https://codeship.com/projects/f1e55a50-6357-0134-29f2-0648b7df1f30/status?branch=master)](https://codeship.com/projects/175349)

# Slack Ruby Doc Bot

A Slack bot which provides ri ruby documentation.

## Setup

```
$ git clone git@github.com:LeFnord/slack_ruby_doc_bot.git
$ cd slack_ruby_doc_bot
$ ./script/setup
```

## Setup Slack API Token

Create a new Bot Integration under [services/new/bot](http://slack.com/services/new/bot)  
and note it on the next screen

## Run

```
SLACK_API_TOKEN=<your token> ./script/server
```

## Use in Slack

invite the bot into a channel
```
/invite [bot name]
```

type
```
[bot name] help
```
for available commands and usage instructions

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/LeFnord/slack_ruby_doc_bot.


## License

The gem is available as open source under the terms of the [MIT License](LICENSE).
