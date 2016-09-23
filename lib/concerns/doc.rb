require 'rack/test'

module SlackRubyDocBot
  module Concerns
    # get the ri documentation and format it
    class Doc
      class << self
        include Rack::Test::Methods

        def call!(klass: nil, method: nil)
          return missing_klass_message if klass.nil?
          @klass = decode(klass)
          @method = decode(method)

          klass_with_method if method.present?
          whole_klass unless method.present?

          format_md_block_code
        end

        private

        def decode(string)
          return if string.nil?
          CGI.unescapeHTML(string)
        end

        def missing_klass_message
          '… uups, you forgot a class or module'
        end

        def wrong_class_message
          # "Nothing known about #{@klass} … did you misspelled it?"
          message = 'Nothing known about '
          message += @klass
          message += "##{@method}" if @method
          message += ' … did you misspelled it?'

          message
        end

        def whole_klass
          @documentation = `ri --no-pager -f markdown '#{@klass}'`
        end

        def klass_with_method
          @documentation = `ri --no-pager -f markdown '#{@klass}##{@method}'`
        end

        def format_md_block_code
          return wrong_class_message unless @documentation.present?
          @documentation.include?('---') ? @documentation.gsub!("\n\n", "\n").gsub!('---', '```') : @documentation
        end
      end
    end
  end
end
