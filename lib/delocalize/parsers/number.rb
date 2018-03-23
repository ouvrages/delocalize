# TODO Rethink: Shouldn't this return numbers instead of reformatted strings?
module Delocalize
  module Parsers
    class Number
      # Parse numbers removing unneeded characters and replacing decimal separator
      # through I18n. This will return a valid Ruby Numeric value (as String).
      def parse(value)
        return value unless value.is_a?(String)

        separator, delimiter = I18n.t([:separator, :delimiter], :scope => :'number.format')
        result = value.gsub(delimiter, '').gsub(separator, '.')

        unless (other_separators = I18n.t(:delocalize_delimiters, :scope => :'number.format', default: '')).empty?
          result = result.gsub(/[#{Regexp.escape(other_separators)}]/, '')
        end

        result
      end
    end
  end
end
