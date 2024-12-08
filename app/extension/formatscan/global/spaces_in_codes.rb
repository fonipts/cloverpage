require_relative '../../../support/interface/code_scan'

class SpacesInCodes < CodeScanInterface
  def initialize(name)
    @ext_name = name

    @var_action_name = nil
    @var_read_filecontent = nil
    @var_logs = nil
    @var_default_config = nil
    @var_read_filename = nil
    @read_token = []
  end

  def action_name(value)
    @var_action_name = value
  end

  def read_filecontent(content)
    @var_read_filecontent = content
    @read_token = @var_read_filecontent.read_token
    send(@ext_name) if @read_token.count > 0
  end

  def logs(cls)
    @var_logs = cls
  end

  def default_config(data)
    @var_default_config = data
  end

  def read_filename(data)
    @var_read_filename = data
  end

  def meth_trail_space
    reg_a = /(\[%:spc%\])+\[%:nwl%\]$/
    for line in @read_token
      count_scan = line[:content].scan(reg_a)
      if count_scan.length.positive?
        @var_logs.record(line[:row], 'Extra trail space found')
        @var_read_filecontent.modified_row_content(line[:row], line[:content].gsub(reg_a, "\n"))
      end
    end
  end

  def meth_eof_newline
    reg_a = /(\[%:nwl%\]){1,}$/
    last_end_file = @read_token[@read_token.length - 1]
    count_scan = last_end_file[:content].scan(reg_a)
    return unless count_scan.length.zero?

    @var_logs.record(last_end_file[:row], 'Need to add newline in the code')
    @var_read_filecontent.modified_row_content(last_end_file[:row], last_end_file[:content].to_s + "\n")
  end
  attr_reader :var_action_name
end
