require_relative '../tokenize/en_str_token'

class ReadFile
  def initialize(file_loc)
    @file_loc = file_loc
    @list_content = []
    @reference_obj = {}
    @file_type = 'r:UTF-8'
  end

  def raw_read
    @list_content
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

  def delete_row_content(row)

     @list_content.clone.each do |ob_key, ob_val|

        if ob_key[:row] == row
          @list_content.delete(ob_key)
        end
      end
 
   end
 
   def modified_row_content(row,content)
    counter = 0
    @list_content.each do |ob_key, ob_val|

      if ob_key[:row] == row
        #
        ob_key[:content] = content
        #@list_content[row -1] = ob_key
      end
      counter +=1
    end

 
   end
 
   def reference_obj_value
     @reference_obj
   end
  private

  def loader(type)
    f_line = File.open(@file_loc, @file_type)
    counter = 1
    f_line.each_line do |line|
      if type == 'ord'
        @list_content.append({
                               "row": counter,
                               "content": line
                             })

      elsif type == 'strip_qoute'
        cnvt = EnStrToken.new(line)
        convert_strip_qoute = cnvt.convert_strip_qoute

        @list_content.append({
                               "row": counter,
                               "content": convert_strip_qoute['word'.to_sym],
                               "reference_key": convert_strip_qoute['ref_key'.to_sym]
                             })
      else
        cnvt = EnStrToken.new(line)

        @list_content.append({
                               "row": counter,
                               "content": cnvt.convert
                             })

      end
      counter += 1
    end
  end

end
