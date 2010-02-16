
#require 'toycipher'
require 'test/unit'

class TestCLI < Test::Unit::TestCase

  def setup
    @cli = File.expand_path(File.dirname(__FILE__)) + '/../scripts/toycipher'
  end

  def teardown
  end

  # TODO
  def test_cli_caesar
    args = "-e 'foobar' -c caesar -k2"
    assert_equal %x[#{@cli} #{args}].chomp, "HQQDCT"
  end

end

