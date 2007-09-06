
require 'toycipher'
require 'test/unit'

class TestOtp < Test::Unit::TestCase

  def setup
   @cipher = ToyCipher::Otp.new
   @plaintext = 'abcabc'
   @key = 'abc'
   @ciphertext = 'ACEACE'
  end
  
  def teardown
  end

  def test_encrypt
    # TODO Need either a warning or exceptions: exceptions appropriate here?
    assert_nil @cipher.encrypt(@plaintext, @key), @ciphertext
    @cipher.plaintext = @plaintext
    @cipher.key = @key + @key 
    assert_equal @cipher.key, @cipher.plaintext
    assert_equal @cipher.encrypt, @ciphertext
  end

  def test_decrypt
    assert_equal @plaintext.upcase, @cipher.decrypt(@ciphertext, @key)
  end

end

