class ScanLogs
  def initialize
    @logs = []
  end

  def append(data)
    @logs.append(data)
  end

  def getLogs
    @logs
  end
end
