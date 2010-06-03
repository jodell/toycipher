
require 'toycipher'

class TestVigenereCipher < Test::Unit::TestCase

  def setup
   @cipher = ToyCipher::Vigenere.new
   @plaintext = 'abcabc'
   @key = 'abc'
   @ciphertext = 'ACEACE'
  end
  
  def teardown
  end

  def test_encrypt
    assert_equal @cipher.encrypt(@plaintext, @key), @ciphertext
    @cipher.plaintext = @plaintext
    @cipher.key = @key
    assert_equal @cipher.encrypt, @ciphertext
  end

  def test_decrypt
    assert_equal @plaintext.upcase, @cipher.decrypt(@ciphertext, @key)
  end

end

