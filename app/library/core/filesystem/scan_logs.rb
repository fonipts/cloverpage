class ScanLogs
  def initialize
    @logs = []
  end

  def append(data)
    @logs.append(data)
  end

  attr_reader :logs
end
