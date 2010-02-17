
require 'toycipher'
require 'test/unit'

class TestCli < Test::Unit::TestCase

  def setup
    @cli ||= File.expand_path(File.dirname(__FILE__)) + '/../script/toycipher'
    @pt ||= 'Hide the gold in the tree stump'
    @k ||= 'playfair example'
    @pf_ciphertext ||= 'BM ND ZB XD KY BE JV DM UI XM MN UV IF '
    @outfile ||= '/tmp/test_toycipher_cli.out'
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
    args = "-e '#{@pt}' -c playfair -k '#{@k}'"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal @pf_ciphertext, cli_out 
    assert_equal ToyCipher::Playfair.new.encrypt(@pt, @k), cli_out
    args =  %Q(-d "FDSDDSSS" -c playfair -k "EFF")
    cli_out = %x[#{@cli} #{args}].chomp.strip
    assert_equal true, !!cli_out.match(/could not decrypt/i)
  end

  def test_cli_out_file
    args = "-e '#{@pt}' -c playfair -k '#{@k}' -o #{@outfile}"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal '', cli_out
    assert_equal true, File.exists?(@outfile)
    assert_equal @pf_ciphertext, IO.readlines(@outfile).first.chomp
  end

end

