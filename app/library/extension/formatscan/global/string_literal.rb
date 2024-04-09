require_relative '../../../interface/code_scan'
require_relative '../../../utility/string_per_line'

class StringLiteral < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = nil
    @ext_config = 'single_qoute'
    @ext_log = []
  end

  def default_value(value)
    @ext_config = value.first
  end

  def read
    # return unless qoute_type.key?(@ext_config.to_sym)
    regexp_single_qoute = /(')(.*)(')/
    regexp_double_qoute = /(")(.*?)(")/
    readline = @ext_content.read_line.join("")
    p readline.scan(regexp_single_qoute)
    puts "-----"
    p readline.scan(regexp_double_qoute)
  end
  def read_old
    qoute_type = {
      'single_qoute': {
        'value': '\'',
        "reg_start_match": /^'/,
        "search_match": /(")(.*?)([^\\^=]{0,}")/

      },
      'double_qoute': {
        'value': '"',
        "reg_start_match": /^"/,
        "search_match": /(')(.*?)([^\\^=]{0,}')/

      }
    }

    return unless qoute_type.key?(@ext_config.to_sym)

    reg_allow_comment = %r{/{2,}\s{0,}(:format_except)\b}
    reg_allow_comment = /\#\s{0,}(:format_except)\b/ if ['.py', '.rb'].index @ext_content.ext_name

    count = 1
    reg_a = qoute_type[@ext_config.to_sym][:search_match]
    for line in @ext_content.read_line
      string_line = StringPerLine.new(line.to_s)
      group_word_encode = string_line.replace_group_word_encode

      match1 = group_word_encode.scan(reg_a)

      if !match1.empty? && group_word_encode.to_s.scan(%r{(/)(.*?)(/)}).to_a.empty? && group_word_encode.to_s.scan(reg_allow_comment).to_a.empty?
        str_rep = group_word_encode.to_s.clone.gsub!(reg_a) do |m|
          m.to_s.gsub(/^['"]/,
                      qoute_type[@ext_config.to_sym][:value]).to_s.gsub(/['"]$/,qoute_type[@ext_config.to_sym][:value])
        end
        valid_counter = 0

        for mv in match1
          valid_counter += 1 if mv[0].match(qoute_type[@ext_config.to_sym][:reg_start_match])
        end
        if valid_counter != match1.count
          template_msg = format('file literal string is invalid %<count>s, use the `%<literal>s`',
                                count: count,
                                literal: @ext_config)
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
