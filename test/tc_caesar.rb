
require 'toycipher'
require 'test/unit'

class TestCaesarCipher < Test::Unit::TestCase

  def setup
   @cipher = ToyCipher::Caesar.new
   @plaintext = 'abcabc'
   @offset = 3
   @ciphertext = 'DEFDEF'
  end
  
  def teardown
  end

  def test_encrypt
    assert_equal @cipher.encrypt(@plaintext, @offset), @ciphertext
    @cipher.plaintext = @plaintext
    @cipher.offset = @offset
    assert_equal @cipher.encrypt, @ciphertext
  end

  def test_decrypt
    assert_equal @plaintext.upcase, @cipher.decrypt(@ciphertext, @offset)
  end

end

