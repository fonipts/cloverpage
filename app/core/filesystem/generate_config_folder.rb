require 'fileutils'

class GenerateConfigFolder
  def initialize(dir)
    @dir = dir
    @folder = '.clover'
    @join_path = File.join(@dir, @folder)
  end

  def deploy
    return unless File.directory?(@join_path) == false

    FileUtils.mkdir_p @join_path
    FileUtils.mkdir_p File.join(@join_path, 'plugin')
    FileUtils.mkdir_p File.join(@join_path, 'logs')
  end
end
