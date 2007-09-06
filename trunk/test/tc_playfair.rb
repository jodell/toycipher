
require 'toycipher'
require 'test/unit'

class TestPlayFairCipher < Test::Unit::TestCase

  def setup
    @plaintext = 'The quick brown fox jumps over the lazy dog'
    @ciphertext = ''
    @key = ''
    @cipher = ToyCipher::PlayFair.new
  end
  
  def teardown
  end

  def test_encrypt
    assert_equal @ciphertext, tc.encrypt(@plaintext, @key)
  end

  def test_decrypt
    assert_equal @plaintext, tc.decrypt(@ciphertext, @key)
  end

end

