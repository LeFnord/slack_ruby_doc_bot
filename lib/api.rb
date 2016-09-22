require 'grape'

module SlackRubyDocBot
  # an API, providing the same functionality as the Bot
  class Api < Grape::API
    prefix :api
    format :json

    get do
      {
        bot:
        {
          desc: 'A Slack bot, which provides Ruby documentation.',
          commands: [
            {
              command: 'doc <Class/Module>',
              desc: 'full documentation of Class/method; `doc` is required '
            },
            {
              command: 'doc <Class/Module>#<method>',
              desc: 'documentation for given method of Class/Module; `doc` is optional'
            }
          ]
        }
      }
    end
  end
end
