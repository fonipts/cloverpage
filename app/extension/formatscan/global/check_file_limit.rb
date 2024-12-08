require_relative '../../../support/interface/code_scan'

class CheckFileLimit < CodeScanInterface
  def initialize(name)
    hash = { meth_max_len: 600, meth_row_char_limit: 100 }
    @ext_name = name

    @var_action_name = nil
    @var_read_filecontent = nil
    @var_logs = nil
    @var_default_config = hash[@ext_name.to_sym]
    @var_read_filename = nil
  end

  def action_name(value)
    @var_action_name = value
  end

  def read_filecontent(content)
    @var_read_filecontent = content
    @read_token = @var_read_filecontent.read
    send(@ext_name) if @read_token.count.positive?
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

  def meth_max_len
    @var_logs.record(@read_token.count, 'Your file exceed at max len in row' + @var_default_config.to_s) if @read_token.count > @var_default_config
  end

  def meth_row_char_limit
    for line in @read_token
      if line[:content].length > @var_default_config
        @var_logs.record(line[:row],
                         'String length per row exceed max len ' + line[:content].length.to_s + '/' + @var_default_config.to_s)
      end
    end
  end
  attr_reader :var_action_name
end
