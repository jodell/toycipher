
require 'test_helper'
require 'toycipher'
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

  def test_0
    assert_not_nil ToyCipher
    assert_not_nil ToyCipher::Caesar
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

  def test_brute
    ans = <<-ANS
CDECDE
BCDBCD
ABCABC
ZABZAB
YZAYZA
XYZXYZ
WXYWXY
VWXVWX
UVWUVW
TUVTUV
STUSTU
RSTRST
QRSQRS
PQRPQR
OPQOPQ
NOPNOP
MNOMNO
LMNLMN
KLMKLM
JKLJKL
IJKIJK
HIJHIJ
GHIGHI
FGHFGH
EFGEFG
DEFDEF
ANS
    try = @cipher.brute(@ciphertext)
    assert_equal ans.gsub(/\n/, ''), @cipher.brute(@ciphertext).to_s
  end

end

