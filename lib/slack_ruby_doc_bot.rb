require 'slack-ruby-bot'
require 'concerns/doc'

module SlackRubyDocBot
  # the Bot itself
  class Bot < SlackRubyBot::Bot
    # provides the help text which would be returned by calling: [bot name] help
    help do
      title 'Ruby doc bot'
      desc 'Lets you search for Ruby method documentations'

      command 'doc <Class/Module>#<method>' do
        desc "\nDocuments the given method of a Class/Module, separated by `#`, `doc` is optional"
      end

      command 'doc <Class/Module>' do
        desc "\nDocuments the given Class/Module, `doc` is required"
      end
    end

    # implements a generic command for <Class/Module>#<method>
    match(/^(doc\s*)*(?<klass>([[:upper:]]\w+)(::\w+)*)#(?<method>.+?)$/) do |client, data, match|
      documentation = SlackRubyDocBot::Concerns::Doc.call!(klass: match[:klass], method: match[:method])

      client.say(channel: data.channel, text: documentation, mrkdwn: true)
    end

    # implements a generic command for doc <Class/Module>
    match(/^doc (?<klass>[[:upper:]]\w+(::\w+)*)$/) do |client, data, match|
      documentation = SlackRubyDocBot::Concerns::Doc.call!(klass: match[:klass])

      client.say(channel: data.channel, text: documentation, mrkdwn: true)
    end
  end
end
