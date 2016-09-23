require 'rack/test'

module SlackRubyDocBot
  module Concerns
    # get the ri documentation and format it
    class Doc
      class << self
        # public method which would be called elsewhere
        #
        # klass - The String representation of the class or module to document
        # method - The String representation of the method to document
        def call!(klass: nil, method: nil)
          return missing_klass_message if klass.nil?
          @klass = decode(klass)
          @method = decode(method)

          klass_with_method if method.present?
          whole_klass unless method.present?

          format_md_block_code
        end

        private

        # decode string, they come www_url_encoded in
        #
        # string - The String to unescape
        def decode(string)
          return if string.nil?
          CGI.unescapeHTML(string)
        end

        # provides missing klass message, later it could I18n
        def missing_klass_message
          '… uups, you forgot a class or module'
        end

        # same here, but for a missing class or module
        def wrong_class_message
          message = 'Nothing known about '
          message += @klass
          message += "##{@method}" if @method
          message += ' … did you misspelled it?'

          message
        end

        # get the ri documentation for the class/module
        def whole_klass
          @documentation = `ri --no-pager -f markdown '#{@klass}'`
        end

        # get ri documentation for a specified method
        def klass_with_method
          @documentation = `ri --no-pager -f markdown '#{@klass}##{@method}'`
        end

        # makes the output a little bit nicer ;)
        def format_md_block_code
          return wrong_class_message unless @documentation.present?
          @documentation.include?('---') ? @documentation.gsub!("\n\n", "\n").gsub!('---', '```') : @documentation
        end
      end
    end
  end
end
