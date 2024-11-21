require_relative '../../app/core/filesystem/verify_glob_path'
require 'test/unit'
require 'fileutils'

class TestCheckGlobFormat < Test::Unit::TestCase
  def test_simple
    pwd = '/test'
    proj_dir = File.join(pwd, 'path')
    proj_dir_glob1 = File.join(pwd, 'path/*')
    proj_dir_glob2 = File.join(pwd, 'path/*.jpg')
    proj_dir_glob3 = File.join(pwd, '**/*.{jpg,png,gif}')
    proj_dir_glob4 = File.join(pwd, '?????.jpg')

    verify_path1 = VerifyGlobPath.new(proj_dir)
    verify_path2 = VerifyGlobPath.new(proj_dir_glob1)
    verify_path3 = VerifyGlobPath.new(proj_dir_glob2)
    verify_path4 = VerifyGlobPath.new(proj_dir_glob3)
    verify_path5 = VerifyGlobPath.new(proj_dir_glob4)

    assert_equal(verify_path1.is_path_glob_format, false)
    assert_equal(verify_path2.is_path_glob_format, true)
    assert_equal(verify_path3.is_path_glob_format, true)
    assert_equal(verify_path4.is_path_glob_format, true)
    assert_equal(verify_path5.is_path_glob_format, true)

    assert_equal(verify_path1.glob_path, File.join(pwd, 'path/**'))
    assert_equal(verify_path2.glob_path, File.join(pwd, 'path/*'))
    assert_equal(verify_path3.glob_path, File.join(pwd, 'path/**'))
    assert_equal(verify_path4.glob_path, File.join(pwd, '**/**'))
    assert_equal(verify_path5.glob_path, File.join(pwd, '**'))
  end

  def test_failure; end
end
