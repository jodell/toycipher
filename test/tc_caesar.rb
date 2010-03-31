$: << File.expand_path(File.dirname(__FILE__)) + '/../lib/'
require 'toycipher'
require 'test/unit'
require 'fileutils'

class TestCaesarCipher < Test::Unit::TestCase

  def setup
   @cipher = ToyCipher::Caesar.new
   @plaintext = 'abcabc'.upcase
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

  def test_encrypt_with_alphanumeric_key
    assert_equal @ciphertext, @cipher.encrypt(@plaintext, 'C')
    assert_equal @plaintext, @cipher.decrypt(@ciphertext, 'C')
  end

  def test_decrypt
    assert_equal @plaintext, @cipher.decrypt(@ciphertext, @offset)
  end

end

