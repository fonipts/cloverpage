require_relative '../../../interface/code_scan'

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

    msg = ''
    reg_a1 = /(\s{0,})([\!]{0,1}={2,}|[\!\<\>]{1}={1}|[\<\>])(\s{0,})/
    reg_a2 = %r{(\s{0,})([/*\-+]={1,})(\s{0,})}
    reg_a21 = /^[\s]{0,}([\/\*-+])/
    count = 1
    read_line = @ext_content.read_line

    for line in read_line
      msg = line
      match1 = msg.match(reg_a1)
      match2 = msg.match(reg_a2)
      match21 = msg.match(reg_a21)

      if match1 && (match1[1] != ' ' || match1[3] != ' ') && !match21
        #@ext_content.modify_read_line(count - 1, msg.gsub(reg_a1, ' ' + match1[2] + ' '))
        str_rep = line.to_s.gsub!(reg_a1) do |m|
          
          ' '+ Regexp.last_match(2)+' '
        end
        @ext_content.modify_read_line(count - 1, str_rep)
        template_msg = format('file has `%<sign>s` has no equal spacing %<count>s', count: count,sign: match1[2])
        @ext_log.append(template_msg)
      end
      if match2 && (match2[1] != ' ' || match2[3] != ' ') && !match21
        str_rep = line.to_s.gsub!(reg_a2) do |m|
          
          ' '+ Regexp.last_match(2)+' '
        end
        @ext_content.modify_read_line(count - 1, str_rep)
        template_msg = format('file has ` %<sign>s ` has no equal spacing %<count>s', count: count, sign: match2[2])
        @ext_log.append(template_msg)
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
