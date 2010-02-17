
require 'toycipher'
require 'test/unit'

class TestCLI < Test::Unit::TestCase

  def setup
    @cli = File.expand_path(File.dirname(__FILE__)) + '/../script/toycipher'
  end

  def teardown
  end

  def test_cli_help
    assert_equal true, !!%x[#{@cli} -h].grep(/usage/i)
    
  end
  
  def test_cli_no_args
    # spills to stderr
    #assert_equal true, !!%x[#{@cli}].grep(/expected one of/i)
  end

  def test_cli_caesar
    args = "-e 'foobar' -c caesar -k2"
    assert_equal "HQQDCT", %x[#{@cli} #{args}].chomp
  end

  def test_cli_playfair
    pt = 'Hide the gold in the tree stump'
    k = 'playfair example'
    args = "-e '#{pt}' -c playfair -k '#{k}'"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal 'BM ND ZB XD KY BE JV DM UI XM MN UV IF ', cli_out 
    assert_equal ToyCipher::Playfair.new.encrypt(pt, k), cli_out
    args =  %Q(-d "FDSDDSSS" -c playfair -k "EFF")

    cli_out = %x[#{@cli} #{args}].chomp.strip
    assert_equal true, !!cli_out.match(/could not decrypt/i)
  end

end

