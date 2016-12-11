require "format/stuff/version"

module Format
  module Stuff
    def count(l, stuff)
      stuff
        .map { |s| l.count(s) }
        .reduce(:+)
    end

    def run_format(data, output, indent)
      open = ['(', '[', '{']
      close = [')', ']', '}']

      indent_level = 0
      data.each_line do |l|
        l.strip!
        opening = count(l, open)
        closing = count(l, close)
        old_indent_level = indent_level
        indent_level = indent_level + opening - closing

        prefix =
          if indent_level > old_indent_level
            indent * old_indent_level
          else
            indent * indent_level
          end
        output.puts((prefix + l).rstrip)
      end
      output.close
    end
  end
end
