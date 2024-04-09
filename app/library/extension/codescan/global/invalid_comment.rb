require_relative '../../../interface/code_scan'

class InvalidComment < CodeScanInterface
  def initialize
    @ext_name = ''
    @ext_content = nil
    @ext_config = true
    @ext_log = []
  end

  def default_value(value)
    @ext_config = value.first
  end

  def read
    return unless @ext_config

    reg_a = comment
    reg_allow_comment = except_comment
    count = 1

    for line in @ext_content.read_line
      count_scan = line.to_s.scan(reg_a)

      if !count_scan.to_a.empty? && !(!line.to_s.scan(%r{(/)(.*?)(/)}).to_a.empty? || !line.to_s.scan(reg_allow_comment).to_a.empty?)
        template_msg = format('file has invalid comment in line %<count>s ', count: count)
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

  private

  def comment
    reg_a = %r{/{2,}(.*?)\n}
    reg_a = /\#(.*?)\n/ if ['.py', '.rb'].index @ext_content.ext_name
    reg_a
  end

  def except_comment
    reg_allow_comment = %r{/{2,}\s{0,}(:comment|:format_except)\b}
    reg_allow_comment = /(\#\s{0,}(:comment|:format_except)\b|\#\{(.*?)\})/ if ['.rb'].index @ext_content.ext_name
    reg_allow_comment = /\#\s{0,}(:comment|:format_except|noqa:|pylint:|type:)/ if ['.py'].index @ext_content.ext_name

    reg_allow_comment
  end
end
