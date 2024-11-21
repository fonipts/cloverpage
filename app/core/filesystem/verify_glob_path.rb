require 'colorize'

class VerifyGlobPath
  def initialize(dir)
    @dir = dir

    @is_valid_glob = false
    @glob_path = ''
    loader
  end

  def is_path_glob_format
    @is_valid_glob
  end

  attr_reader :glob_path

  private

  def loader
    match1 = @dir.match(/[*?]{1,}/)
    @is_valid_glob = true if match1

    @glob_path = if @is_valid_glob == true
      @dir.gsub(/[*?]{0,}\.(\{[a-zA-Z,]{1,}\}|[a-zA-Z,]{1,})/, '**')
      else
        File.join(@dir, '**')
      end
  end
end
