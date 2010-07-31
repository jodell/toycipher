
require 'test_helper'
require 'toycipher'
require 'fileutils'

def debug?
  ENV['DEBUG'] || ENV['debug']
end

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
    #TF.each { |k, f| FileUtils.rm f if File.exists?(f) }
  end

  def verbose?
    ENV['verbose']
  end

  def test_cli_help
    assert_equal true, !!%x[#{@cli} -h].grep(/usage/i)
    
  end
  
  def test_cli_no_args
    # spills to stderr
    #assert_equal true, !!%x[#{@cli}].grep(/expected one of/i)
  end

  def test_cli_caesar
    args = "-e caesar foobar -k2"
    #assert_equal "HQQDCT", %x[#{@cli} #{args}].chomp
  end

  def test_cli_playfair
    args = "-e playfair '#{@pt}' -k '#{@k}'"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal @pf_ciphertext, cli_out 
    assert_equal ToyCipher::Playfair.new.encrypt(@pt, @k), cli_out
  end

  def test_cli_playfair2
    args =  %Q(-d playfair "FDSDDSSS" -k "EFF")
    cli_out = %x[#{@cli} #{args}].chomp.strip
    puts cli_out if debug?
    assert_equal true, !!cli_out.match(/could not decrypt/i)
    args = "-p -d playfair '#{@pf_ciphertext}' -k '#{@k}'"
    cli_out = %x[#{@cli} #{args}].chomp
    args = "-p -d playfair '#{@pf_ciphertext}' -k '#{@k}' -p"
    cli_out = %x[#{@cli} #{args}].chomp
    assert_equal "HIDETHEGOLDINTHETREESTUMP", cli_out
  end

  def test_cli_out_file
    args = "-e playfair '#{@pt}' -k '#{@k}' -o #{TF[:out_f]}"
    #puts "Running '#{@cli} #{args}'"
    cli_out = %x[#{@cli} #{args}].chomp
    puts cli_out if verbose?
    assert_equal '', cli_out
    assert_equal true, File.exists?(TF[:out_f])
    #assert_equal @pf_ciphertext, IO.readlines(@outfile).first.chomp
  end

  def test_pretty_output
  end

  def test_multi_keys
    args = "-e playfair '#{@pt}' -k '#{@k},#{@k2}' "
    puts "Running '#{@cli} #{args}'" if verbose?
    cli_out = %x[#{@cli} #{args}].chomp
    puts cli_out if verbose?
    assert_equal [@pf_ciphertext, @pf_ciphertext2].join("\n"), cli_out
  end

  def test_examples
    ct = "The moose is loose"
    k = "G,M,A,R,K"
    ct_ans = <<-ANS
AOLTVVZLPZSVVZL
GURZBBFRVFYBBFR
UIFNPPTFJTMPPTF
LZWEGGKWAKDGGKW
ESPXZZDPTDWZZDP
ANS

    args = "-e caesar '#{ct}' -k '#{k}' "
    puts "Running '#{@cli} #{args}'" if verbose?
    cli_out = %x[#{@cli} #{args}]
    puts cli_out if verbose?
    assert_equal ct_ans, cli_out
  end

  def test_shmoocon2010_part1
    shmooct = File.open(TF[:shmoocon2010_1], 'w') { |f| f << SHMOO_CT }
    args = "-i #{TF[:shmoocon2010_1]} -d caesar -kG"
    puts "Running: #{@cli} #{args}" if debug?
    puts "File \n#{TF[:shmoocon2010_1]}" if debug?
    puts `cat #{TF[:shmoocon2010_1]}` if debug?
    cli_out = %x[#{@cli} #{args}].chomp
    puts "Output: \n#{cli_out}" if debug?
  end

  def test_analysis
    shmooct = File.open(TF[:shmoocon2010_1], 'w') { |f| f << SHMOO_CT }
    args = "-a < #{TF[:shmoocon2010_1]}"
    cli_out = %x[#{@cli} #{args}]
    puts cli_out if verbose?
    ans = <<-ANS
A: ############################        (28)
B: ##############                      (14)
C: #####                               (5)
D: #################                   (17)
E: ####################                (20)
F: ####################                (20)
G: ##################################  (34)
H: ##########                          (10)
I: #######                             (7)
J: ###########                         (11)
K: ####################                (20)
L: #################                   (17)
M: #####################               (21)
N: #####                               (5)
O: ############                        (12)
P: #####################               (21)
Q: #########                           (9)
R: #########################           (25)
S: ####################                (20)
T: #########                           (9)
U: ###############                     (15)
V: #########                           (9)
W: ############                        (12)
X: #######                             (7)
Y: ###########                         (11)
Z: #####################               (21)
28,14,5,17,20,20,34,10,7,11,20,17,21,5,12,21,9,25,20,9,15,9,12,7,11,21
ANS
    assert_equal ans, cli_out
  end

  def test_brute_caesar 
    args = "-d caesar -b 'FOOBAR'"
    cli_out = %x[#{@cli} #{args}]
    puts cli_out if verbose?
    ans = <<-ANS
ENNAZQ
DMMZYP
CLLYXO
BKKXWN
AJJWVM
ZIIVUL
YHHUTK
XGGTSJ
WFFSRI
VEERQH
UDDQPG
TCCPOF
SBBONE
RAANMD
QZZMLC
PYYLKB
OXXKJA
NWWJIZ
MVVIHY
LUUHGX
KTTGFW
JSSFEV
IRREDU
HQQDCT
GPPCBS
FOOBAR
ANS
    assert_equal ans, cli_out
  end

  def test_morse
    args = "-d morse '.... .- ...- . ..-. ..- -. .--. .- ... ... .-- --- .-. -.. --... ..... ..... --... .... . .-.. .-.. --- .... .- ...- . ..-. ..- -.'"
    cli_out = %x[]

  end

end

