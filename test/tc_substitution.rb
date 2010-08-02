

require 'test_helper'

class TestSubstitutionCipher < Test::Unit::TestCase

  def setup
    @cipher = ToyCipher::Substitution.new
  end

  def teardown
  end

  def test_substitution
    key = 'FNVBQDZEXOPUHTLSJKACWIMYRG'
    ciphertext = <<-EoC
MQA
FRFZF
XTBQUX
NQKFCQU
RCEFCEW
HFTXTZQ
TWXCDVF
TTLCVLTV
LVCFVRSE
QKMEXVE
EWHFTXT
ZQTWXC
RVFTTL
CKQAL
UIQ
EoC
    @cipher.key = key
    puts @cipher.key.sort.inspect
    puts @cipher.decrypt(ciphertext)
    
    # 'WE SAY AGAIN DELIBERATELY THAT HUMAN INGENUITF CANNOT
    # CONCOCT A CYPHER WHICH HUMAN INGENUITY CANNOT RESOLVE'
    # - Edgar Allen Poe (via LosT)
    #
    plaintext = 'WESAYAGAINDELIBERATELYTHATHUMANINGENUITF' + 
      'CANNOTCONCOCTACYPHERWHICHHUMANINGENUITYCANNOTRESOLVE'
    assert_equal plaintext, @cipher.decrypt(ciphertext)
  end

end
