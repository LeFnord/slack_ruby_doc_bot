$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'slack_ruby_doc_bot'
require 'api'

Thread.abort_on_exception = true

Thread.new do
  begin
    SlackRubyDocBot::Bot.run
  rescue StandardError => e
    STDERR.puts "ERROR: #{e}"
    STDERR.puts e.backtrace
    raise e
  end
end

run SlackRubyDocBot::Api
