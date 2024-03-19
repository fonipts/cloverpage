require_relative '../../../interface/code_scan'

class CheckExtraSpaceInCode < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = []
    @ext_config = nil
    @ext_log = []
  end

  def setData(name, content, config, log)
    @ext_name = name
    @ext_content = content
    @ext_config = config.first
    @ext_log = log
  end

  def read
    return unless @ext_config

    msg = ''
    list_trail_space = []
    reg_a = /[=,{}]\s{1,}/
    reg_a1 = /\b(\s{0,})(={1,})(\s{0,})\b/

    count_scan = 0
    count = 1

    getReadLine = @ext_content.getReadLine

    for line in getReadLine
      msg = line

      if msg.match(reg_a1)

        split_equal = msg.split(reg_a1)
        puts msg
        p msg.split('')
        puts count
        puts @ext_name
        row_c = 0
        count_space = 0
        for line_s in split_equal
          # puts "----"
          # p split_equal[row_c].split
          # puts split_equal[row_c]
          # puts @ext_name
          # puts "----"
          if split_equal[row_c] == ''
            split_equal[row_c] = ' '

            count_scan += 1
          end

          if split_equal[row_c] == ' '
            count_space += 1
          else

            #   count_space = 0
          end

          row_c += 1
        end

        # puts msg
        msg = split_equal.join('')
        # puts msg
        # puts "@@@"

      end
      # count_scan = line.scan(reg_a)

      if count_scan > 0
        #   puts line
        #   p count_scan
        #   puts @ext_name
        #   puts count
        #   puts "@@@"
        # @ext_content.setModifyReadLine( count - 1  , msg)
        # template_msg ="file `%s` trail white space at line %s"% [@ext_name,count]
        # @ext_log.append(template_msg)
      end

      count += 1
    end
  end
end
