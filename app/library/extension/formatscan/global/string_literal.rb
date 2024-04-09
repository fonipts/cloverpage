require_relative '../../../interface/code_scan'
require_relative '../../../utility/string_per_line'
require_relative '../../../utility/string_literal_util'
require_relative '../../../utility/crypt'

QOUTE_TYPE = {
  'single_qoute': {},
  'double_qoute': {}
}.freeze

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
    return unless QOUTE_TYPE.key?(@ext_config.to_sym)

    uniq_id_str = uniqid(8)
    readline = @ext_content.read_line.join("<!$#{uniq_id_str}$!>")
    string_line_cls = StringLiteralUtil.new(readline.to_s)
    row = string_line_cls.endode_string_literal(@ext_config.to_sym.to_s)
    row_data = row[:data].split("<!$#{uniq_id_str}$!>")
    if @ext_config == 'single_qoute'
      raw_type = 'double_qoute'
      reg_allowed = /([`'\\]{1,})/
    end
    if @ext_config == 'double_qoute'
      raw_type = 'single_qoute'
      reg_allowed = /([`"\\]{1,})/
    end
    raw_list_reg = []

    for key, _ in row[:ref][raw_type]

      raw_list_reg.append(key.to_s)
    end

    return unless raw_list_reg.count.positive?

    reg_str = "\{@(#{raw_list_reg.join('|')})@\}"
    count = 1
    for key in row_data

      match1 = key.scan(Regexp.new(reg_str))
      for keym in match1
        keym_content = row[:ref][raw_type][keym[0]].to_s

        count_reg_allowed = keym_content.to_s.scan(reg_allowed)

        next unless count_reg_allowed.to_a.empty?

        monitor_lang(count, keym_content)

      end
      count += 1
    end
  end

  def set_data(name, content, log)
    @ext_name = name
    @ext_content = content
    @ext_log = log
  end

  private

  def monitor_lang(count, content)
    is_validated = true
    if ['.rb'].index @ext_content.ext_name
      reg_str =  /\#\{(.*?)\}/
      scan_count = content.scan(reg_str)

      is_validated = false if scan_count.count.positive?
    end

    return unless is_validated

    template_msg = "file literal string is invalid #{count}, use the #{@ext_config}"
    @ext_log.append(template_msg)
  end
end
