require_relative '../tokenize/en_token_str'

class ReadFile
  def initialize(file_loc)
    @file_loc = file_loc
    @list_content = []
    @reference_obj = {}
  end

  def read_token
    @list_content = []
    loader(nil)
    @list_content
  end

  def read
    @list_content = []
    loader('ord')
    @list_content
  end

  def read_strip_qoute
    @list_content = []
    loader('strip_qoute')
    @list_content
  end

  private

  def loader(type)
    f_line = File.open(@file_loc, 'r:UTF-8')
    counter = 1
    f_line.each_line do |line|
      if type == 'ord'
        @list_content.append({
                               "row": counter,
                               "content": line
                             })

      elsif type == 'strip_qoute'
        cnvt = EnTokenStr.new(line)
        convert_strip_qoute = cnvt.convert_strip_qoute

        @list_content.append({
                               "row": counter,
                               "content": convert_strip_qoute['word'.to_sym],
                               "reference_key": convert_strip_qoute['ref_key'.to_sym]
                             })
      else
        cnvt = EnTokenStr.new(line)

        @list_content.append({
                               "row": counter,
                               "content": cnvt.convert
                             })

      end
      counter += 1
    end
  end

  def reference_obj_value
    @reference_obj
  end
end
