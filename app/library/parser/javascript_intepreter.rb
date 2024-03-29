require_relative '../interface/code_interpreter'

class JavascriptInterpreter < CodeInterpreterInterface
  def initialize
    @read_file = nil

    @imports = []
    @content = ''
  end

  def execute
    strip_imports
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
    from_regexp = /from\s{1,}(.*?)\s{1,}import\s{1,}(.*?)\n/
    import_regexp = /import\s{1,}(.*?)\n/
    line = @read_file.read_line.join("\n") # :format_except
    str_rep = line.to_s.gsub!(from_regexp) do |m|
      @imports.append({
                        'class_func': ::Regexp.last_match(2),
                        'package': ::Regexp.last_match(1),
                        'string': m,
                        'type': 'esm'
                      })
      ''
    end
    str_rep1 = str_rep.to_s.gsub(import_regexp) do |m|
      @imports.append({

                        'class_func': ::Regexp.last_match(1),
                        'package': '-',
                        'string': m,
                        'type': 'esm'
                      })
      ''
    end

    @content = str_rep1
  end
end
