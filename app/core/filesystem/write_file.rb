require_relative '../tokenize/de_token_str'

class WriteFile
  def initialize(name)
    @name = name
  end

  def clear_file
    modify_file('', 'w')
  end

  def write_content(rows)
    for row in rows
      modify_content = modify_content_template(row)
      modify_file(modify_content, 'a')
  #    puts row[:row]
  #    p modify_content.to_s
  #    puts "----"
    end

  end

  private
  def modify_file(content, attrs)
    begin
      file = File.open(@name, attrs)
      file.write(content)
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file.nil?
    end
  end
  def modify_content_template(content)
    token_str = DeTokenStr.new(content)
    token_str.convert

  end

end
