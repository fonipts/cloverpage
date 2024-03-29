class StringPerLine
  def initialize(data)
    @data = data
  end

  def count_first_space
    lines = @data.gsub(/\n/, '').split('')
    reg_a = /\s\n/
    non_stop = true
    counter = 0
    for line in lines
      reg_line = line.scan(reg_a)
      non_stop = false if reg_line.empty?
      counter += 1 if non_stop
    end
    counter
  end
end
