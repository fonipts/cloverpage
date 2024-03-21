class ScanLogs
  def initialize
    @logs = []
  end

  def append(data)
    @logs.append(data)
  end

  def logs
    @logs
  end
end
