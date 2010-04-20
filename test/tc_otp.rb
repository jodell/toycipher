require 'toycipher'
require 'test/unit'

class TestOtp < Test::Unit::TestCase
  def setup
   @cipher = ToyCipher::Otp.new
   @plaintext = 'abcabc'
   @key = 'abc'
   @ciphertext = 'ACEACE'
  end
  
  def test_key_size_check
    assert_raise ToyCipher::ToyCipherException do 
      @cipher.encrypt(@plaintext, @key)
    end
  end

  def test_encrypt
    @cipher.plaintext = @plaintext
    @cipher.key = @key + @key 
    assert_equal @cipher.key, @cipher.plaintext
    assert_equal @cipher.encrypt, @ciphertext
  end

  def test_decrypt
    assert_equal @plaintext.upcase, @cipher.decrypt(@ciphertext, @key)
  end
end

