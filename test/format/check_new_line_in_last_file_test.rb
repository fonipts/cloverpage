require 'test/unit'
require_relative '../../app/library/extension/formatscan/global/check_new_line_in_last_file'
require_relative '../../app/library/core/filesystem/scan_logs'
require_relative '../../app/library/core/filesystem/file_read'

class TestCheckNewLineInCode < Test::Unit::TestCase
  def test_simple
    file = 'test/dummy_data/valid_newline.txt'
    app_dir = Dir.pwd
    config_filename = File.join(app_dir, file)

    cls = CheckNewLineInCode.new
    scan_logs = ScanLogs.new
    file_read = FileRead.new(config_filename)
    file_read.init_read_file
    scan_logs.project_name('local_name')
    scan_logs.file_name(config_filename)
    cls.set_data(config_filename, file_read, scan_logs)
    cls.read
    assert_equal(scan_logs.logs.key?('local_name'), true)
    assert_equal(scan_logs.logs['local_name'].key?(config_filename), false)
  end

  def test_failure
    file = 'test/dummy_data/invalid_newline.txt'
    app_dir = Dir.pwd
    config_filename = File.join(app_dir, file)

    cls = CheckNewLineInCode.new
    scan_logs = ScanLogs.new
    file_read = FileRead.new(config_filename)
    file_read.init_read_file
    scan_logs.project_name('local_name')
    scan_logs.file_name(config_filename)
    cls.set_data(config_filename, file_read, scan_logs)
    cls.read
    assert_equal(scan_logs.logs.key?('local_name'), true)
    assert_equal(scan_logs.logs['local_name'].key?(config_filename), true)
    assert_equal(scan_logs.logs['local_name'][config_filename], ['file has no newline found'])
  end
end
