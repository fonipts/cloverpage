require_relative '../interface/code_interpreter'
require_relative '../utility/string_per_line'

class PythonInterpreter < CodeInterpreterInterface
  def initialize
    @read_file = nil

    @imports = []
    @content = ''

    @class_value = {}
    @function_value = {}
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
    from_regexp = /from\s{1,}(.*?)\s{1,}import\s{1,}(.*?)\n/
    import_regexp = /import\s{1,}(.*?)\n/
    line = @read_file.read_line.join("\n") # :format_except
    str_rep = line.to_s.gsub!(from_regexp) do |m|
      @imports.append({
                        'class_func': ::Regexp.last_match(2),
                        'package': ::Regexp.last_match(1),
                        'string': m,
                        'type': 'default'
                      })
      ''
    end
    str_rep1 = str_rep.to_s.gsub(import_regexp) do |m|
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
    class_regexp = /class\s{1,}([a-zA-Z0-9_]{1,})?(\([a-zA-Z0-9_.]{1,}\))?:/
    function_regexp = /(@[a-zA-Z0-0_]\n{1,})?\s{0,}def\s{1,}([a-zA-Z0-9_]{1,})(\([a-zA-Z0-9_.,:=]{1,}\))/

    class_name_str = ''
    for line in lines
      scan_class = line.scan(class_regexp)
      scan_function = line.scan(function_regexp)
      string_line = StringPerLine.new(line.to_s)
      count_scan = string_line.count_first_space

      if !scan_class.to_a.empty?
      # p line
      # p scan_class
      # puts count
      # puts 'scan_class'
      # class_name_str = scan_class[0][0]
      # @class_value[class_name_str] ={
      #   'func':[],
      #   'inherit': scan_class[0][1],
      #   'row': count
      # }
      elsif count_scan == 0 && class_name_str != ''

        #    puts count_scan
        #    puts count
        #    puts line
        #    puts class_name_str
        #    puts 'count_scan'
        #    class_name_str =''
        # puts count_scan
        # puts 'count_scan'
      end
      unless scan_function.to_a.empty?
        #  p line
        #  p scan_function
        #  puts 'scan_function'
      end
      count += 1
    end
    # puts @content
  end
end
