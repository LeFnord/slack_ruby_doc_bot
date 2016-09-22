module SlackRubyDocBot
  module Concerns
    # get the ri documentation and format it
    class Doc
      class << self
        def call!(klass: nil, method: nil)
          return missing_klass_message if klass.nil?
          @klass = klass
          @method = method

          klass_with_method if method.present?
          whole_klass unless method.present?
          format_md_block_code

          # @documentation
        end

        private

        def missing_klass_message
          '… uups, you forgot a class or module'
        end

        def wrong_class_message
          "Nothing known about #{@klass} … did you misspelled it?"
        end

        def whole_klass
          @documentation = `ri --no-pager -f markdown #{@klass}`
        end

        def klass_with_method
          @documentation = `ri --no-pager -f markdown #{@klass}##{@method}`
        end

        def format_md_block_code
          return wrong_class_message unless @documentation.present?
          @documentation.gsub!("\n\n", "\n").gsub!('---', '```')
        end
      end
    end
  end
end
