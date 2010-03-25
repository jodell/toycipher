
require 'toycipher'
require 'test/unit'
require 'fileutils'

class TestCli < Test::Unit::TestCase

  SHMOO_ANS_1 = <<-SHMOO
OYETLZZZZBNZTTZRUWTPAHXOANNOEEAZCRHEZYZIZATEZZZHTTZZCIEEASDTZSLEKQALKRADYIODBLMY
KOZTEZOHYRZCOZFETZROLETZTETUSZNTAZEYEMBZTKZWEZYAOZRZHNMRTADRDOTCFMELMYQCLDQHTRCY
AUPYVNNAOOTRZYIDZTASLZSCEZISSZTHECRZPOUHOESHANOVZTENEGEZZIOZRYRWLRALEELDQHTRCYET
YZRZEOLVUKHYBOGZHONEZTZRZCNZAGEESIZIOUTAZZOASOUEGHSOAZMWIDLSIYZHLBZSALEECGQDCAIY
ZRECRTYEZEEPUUUOOZSZTETEOOUMGRDZAPKSNSZDMIMTYWZZEETZTRBHZZLTSQATTSQOSTSOZHVYPODL
SHMOO

  SHMOO_CT = <<-SHMOO
VFLASGGGGIUGAAGYBDAWHOEVHUUVLLHGJYOLGFGPGHALGGGOAAGGJPLLHZKAGZSLRXHSRYHKFPVKISTF
XBMGRMBULEMPBMSRGMEBYRGMGRGHFMAGNMRLRZOMGXMJRMLNBMEMUAZEGNQEQBGPSZRYZLDPYQDUGEPL
BVQZWOOBPPUSAZJEAUBTMATDFAJTTAUIFDSAQPVIPFTIBOPWAUFOFHFAAJPASZSXMSBMFFMERIUSDZFU
QRJRWGDNMCZQTGYRZGFWRLRJRUFRSYWWKARAGMLSRRGSKGMWYZKGSREOAVDKAQRZDTRKSDWWUYIVUSAQ
KCPNCEJPKPPAFFFZZKDKEPEPZZFXRCOKLAVDYDKOXTXEJHKKPPEKECMSKKWEDBLEEDBZDEDZKSGJAZOW
SHMOO

  TF = {
    :out_f => '/tmp/test_toycipher_cli.out',
    :shmoocon2010_1 => '/tmp/shmoocon2010_1'
  }.freeze

  def setup
    @cli ||= File.expand_path(File.dirname(__FILE__)) + '/../script/toycipher'
    @pt ||= 'Hide the gold in the tree stump'
    @k ||= 'playfair example'
    @k2 ||= 'foo bar'
    @pf_ciphertext  ||= 'BM ND ZB XD KY BE JV DM UI XM MN UV IF '
    @pf_ciphertext2 ||= 'CM EG UG GH AJ CJ PU CG UA KB KX UN JU '
  end

  def teardown
    TF.each { |k, f| FileUtils.rm f if File.exists?(f) }
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
    #assert_equal "HQQDCT", %x[#{@cli} #{args}].chomp
  end

  def test_cli_playfair
    args = "-e '#{@pt}' -c playfair -k '#{@k}'"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal @pf_ciphertext, cli_out 
    assert_equal ToyCipher::Playfair.new.encrypt(@pt, @k), cli_out
  end

  def test_cli_playfair2
    args =  %Q(-d "FDSDDSSS" -c playfair -k "EFF")
    cli_out = %x[#{@cli} #{args}].chomp.strip
    assert_equal true, !!cli_out.match(/could not decrypt/i)
    args = "-p -d '#{@pf_ciphertext}' -c playfair -k '#{@k}'"
    cli_out = %x[#{@cli} #{args}].chomp
    args = "-p -d '#{@pf_ciphertext}' -c playfair -k '#{@k}' -p"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal "HIDETHEGOLDINTHETREESTUMP", cli_out
  end

  def test_cli_out_file
    args = "-e '#{@pt}' -c playfair -k '#{@k}' -o #{TF[:out_f]}"
    #puts "Running '#{@clie} #{args}'"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal '', cli_out
    assert_equal true, File.exists?(TF[:out_f])
    #assert_equal @pf_ciphertext, IO.readlines(@outfile).first.chomp
  end

  def test_pretty_output
  end

  def test_multi_keys
    args = "-e '#{@pt}' -c playfair -k '#{@k},#{@k2}' "
    #puts "Running '#{@clie} #{args}'"
    cli_out = %x[#{@cli} #{args}].chomp
    #puts cli_out
    assert_equal [@pf_ciphertext, @pf_ciphertext2].join("\n"), cli_out
  end

  def test_shmoocon2010_part1
    shmooct = File.open(TF[:shmoocon2010_1], 'w') { |f| f << SHMOO_CT }
    args = "-e -i #{TF[:shmoocon2010_1]} -c caesar -k 'G'"
    cli_out = %x[#{@cli} #{args}].chomp
  end

end

