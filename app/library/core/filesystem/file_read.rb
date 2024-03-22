class FileRead
  def initialize(filename)
    @list_content = []
    @clone_list_content = []
    @list_index_delete = []
    @filename = filename
  end

  def init_read_file
    @list_content = []
    @clone_list_content = []
    f = File.open(@filename, 'r')

    f.each_line do |line|
      @list_content.append(line)
    end
    @clone_list_content = @list_content.clone

    f.close
  end

  def init_write_file
    reference = 0
    counter = -1
    line_counter = 0
    row_count = 0
    for k in @list_index_delete
      if counter + 1 == k
        counter += 1

      else
        line_counter = row_count
        reference = k
        counter = k
      end
      row_count += 1

      @clone_list_content.delete_at(reference - line_counter)
    end

    File.write(@path_join_file, @clone_list_content.join(''), mode: 'w')
  end

  def read_line
    @clone_list_content
  end

  def modify_read_line(index, content)
    @clone_list_content[index] = content
  end

  def append_read_line(content)
    @clone_list_content.append(content)
  end

  def delete_at_read_line(index)
    @list_index_delete.append(index)
  end

  def exists
    File.exist?(@path_join_file)
  end

  attr_reader :path_join_file, :filename
end
