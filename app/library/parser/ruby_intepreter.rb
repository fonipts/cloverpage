require_relative '../interface/code_interpreter'

class RubyInterpreter < CodeInterpreterInterface
  def initialize
    @read_file = nil

    @imports = []
    @content = ''
  end

  def execute
    strip_imports
    strip_class_function
  end

  attr_reader :imports

  def export; end

  def global; end

  def class_script; end

  def function_script; end

  def set_data(_name, read_file, _log)
    @read_file = read_file
  end

  private

  def strip_imports
    require_relative_regexp = /require_relative\s{1,}(.*?)\s{0,}\n/
    require_regexp = /require\s{1,}(.*?)\s{0,}\n/
    line = @read_file.read_line.join("\n") # :format_except
    str_rep = line.to_s.gsub!(require_relative_regexp) do |m|
      @imports.append({
                        'class_func': '-',
                        'package': ::Regexp.last_match(1),
                        'string': m,
                        'type': 'default'
                      })
      ''
    end
    str_rep1 = str_rep.to_s.gsub(require_regexp) do |m|
      @imports.append({

                        'class_func': ::Regexp.last_match(1),
                        'package': '-',
                        'string': m,
                        'type': 'default'
                      })
      ''
    end

    @content = str_rep1
  end

  def strip_class_function
    lines = @content.split("\n") # :format_except
    count = 1
    class_regexp = /class\s{1,}([a-zA-Z0-9_]{1,})?(<[a-zA-Z0-9_.]{1,})?/
    for line in lines
      scan_class = line.scan(class_regexp)
      next if scan_class.to_a.empty?

      p line
      p scan_class
      puts 'line'
    end
  end
end
