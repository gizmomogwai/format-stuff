require "format/stuff/version"

module Format
  module Stuff
    def count(l, stuff)
      stuff
        .map { |s| l.scan(s).size }
        .reduce(:+)
    end

    def count_tmp_indent(l, tmp_indent)
      (tmp_indent.map{ |i| l.match(i) ? 1 : 0} + [0])
        .reduce(:+)
    end

    #def ruby_open
    #  ["def", "begin", "(", "[", "{"]
    #end
    #def ruby_close
    #  ["end", ")", "]", "}"]
    #end
    #def ruby_tmp_indent
    #  [/^\./, /^\|\|/, /^&&/]
    #end
    def gradle_open
      ["{"]
    end
    def gradle_close
      ["}"]
    end

    def run_format(data, output, indent, open=['(', '[', '{'], close=[')', ']', '}'], tmp_indent=[])
      indent_level = 0
      data.each_line do |l|
        l.strip!
        # STDERR.puts "working on '#{l}'"
        opening = count(l, open)
        # STDERR.puts "opening #{opening}"
        closing = count(l, close)
        # STDERR.puts "closing #{closing}"
        old_indent_level = indent_level
        indent_level = indent_level + opening - closing
        prefix =
          if indent_level > old_indent_level
            indent * old_indent_level
          else
            indent * indent_level
          end
        tmp_indent_level = count_tmp_indent(l, tmp_indent)
        # STDERR.puts "tmp_indent #{tmp_indent_level}"
        # STDERR.puts "prefix '#{prefix}'"
        prefix = prefix + (indent * tmp_indent_level)
        # STDERR.puts "prefix '#{prefix}'"
        output.puts((prefix + l).rstrip)
      end
      output.close
    end
  end
end
