require_relative '../tokenize/en_token_str'

class ReadFile
  def initialize(file_loc)
    @file_loc = file_loc
    @list_content = []
    loader
  end

  def count_row
    @list_content.count
  end

  def read_token
    @list_content
  end

  def loader
    f_line = File.open(@file_loc, 'r:UTF-8')
    f_line.each_line do |line|
      cnvt = EnTokenStr.new(line)
      # puts cnvt.convert

      @list_content.append(cnvt.convert)
    end
  end

  def modify_file; end
end
