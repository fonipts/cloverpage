class StringPerLine
  def initialize(data)
    @data = data
  end

  def count_first_space
    lines = @data.gsub(/\n/, '').split('')
    non_stop = true
    counter = 0
    for line in lines
      if non_stop == true && (line != ' ')
        non_stop = false
      end
      counter += 1 if non_stop
    end
    counter = 0 if non_stop
    counter
  end

  def get_group_word_qoute
    rows = @data.split('')
    reg_a = /['"]/
    record_word = []
    temp_chars = []
    temp_key_char = ''
    for row in rows

      temp_chars.append(row) if temp_key_char != '' && row != temp_key_char
      reg_row = row.scan(reg_a)
      unless reg_row.empty?
        if row == temp_key_char

          record_word.append(temp_chars.join(''))
          temp_chars = []
          temp_key_char = ''
        elsif temp_key_char == ''
          temp_key_char = row
        end

      end
    end
    record_word
  end

  def replace_group_word_encode
    rows = @data
    group_words = get_group_word_qoute
    count = 1
    reg_a = /^(\s{1,})$/
    for group_word in group_words
      reg_group_word = group_word.scan(reg_a)
      if reg_group_word.empty?
        rows = rows.gsub(group_word, "#@#{count}@#") # :format_except
        count += 1
      end

    end

    rows
  end

  def replace_group_word_decode(data)
    rows = data
    group_words = get_group_word_qoute
    count = 1
    for group_word in group_words
      rows = rows.gsub("#@#{count}@#", group_word) # :format_except
      count += 1
    end

    rows
  end
end
