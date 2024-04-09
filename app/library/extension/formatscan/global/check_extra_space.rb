require_relative '../../../interface/code_scan'
require_relative '../../../utility/string_per_line'

ALLOW_SIGN = ['/='].freeze

class CheckExtraSpaceInCode < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = []
    @ext_config = true
    @ext_log = []
  end

  def default_value(value); end

  def read
    return unless @ext_config

    reg_a1 = /(\s{0,})(!{0,1}={2,}|[!<>]{1}={1})(\s{0,})/
    reg_a2 = %r{(\s{0,})([/*\-+]={1,})(\s{0,})}
    reg_a21 = %r{^\s{0,}([/*-+])}
    count = 1
    read_line = @ext_content.read_line

    for line in read_line
      string_line = StringPerLine.new(line.to_s)
      group_word_encode = string_line.replace_group_word_encode
      group_word_qoute = string_line.get_group_word_qoute

      match1 = group_word_encode.match(reg_a1)
      match2 = group_word_encode.match(reg_a2)
      match21 = group_word_encode.match(reg_a21)

      if match1 && (match1[1] != ' ' || match1[3] != ' ') && !match21

        msg = line

        str_rep = group_word_encode.to_s.gsub!(reg_a1) do |_m|
          " #{Regexp.last_match(2)} "
        end
        @ext_content.modify_read_line(count - 1, string_line.replace_group_word_decode(str_rep))
        template_msg = format('file has `%<sign>s` has no equal spacing %<count>s', count: count, sign: match1[2])
        @ext_log.append(template_msg)
      end
      if match2 && (match2[1] != ' ' || match2[3] != ' ') && !match21

        msg = line
        str_rep = group_word_encode.to_s.gsub!(reg_a2) do |_m|
          " #{Regexp.last_match(2)} "
        end
        unless ALLOW_SIGN.include?(match2[2].to_s)
          @ext_content.modify_read_line(count - 1, string_line.replace_group_word_decode(str_rep))
          template_msg = format('file has ` %<sign>s ` has no equal spacing %<count>s', count: count, sign: match2[2])
          @ext_log.append(template_msg)
        end
      end
      count += 1
    end
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end
end
