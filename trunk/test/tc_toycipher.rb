
require 'test/unit'
require 'toycipher'

class TestToyCipher < Test::Unit::TestCase

  def setup
    @tc = ToyCipher::ToyCipherBase.new
  end

  def teardown
  end

  def test_alph
    alph = []
    ('A'..'Z').each { |l| alph << l }
    assert_equal @tc.alph, alph 
  end
  
  def test_rot13
    assert_equal 'GRFG', @tc.rot13('test')
    assert_equal 'NOPQRSTUVWXYZ', @tc.rot13('ABCDEFGHIJKLM')
    assert_not_equal 'MOPQRSTUVWXYY', @tc.rot13('ABCDEFGHIJKLM')
    assert_not_equal 'BOPQRSTUVWXYZ', @tc.rot13('ABCDEFGHIJKLM')
    assert_not_equal 'ABCDEFGHIJKLM', @tc.rot13('ABCDEFGHIJKLM')
    assert_equal @tc.rot13('the quick brown fox jumps over the lazy dog'), 
      "GURDHVPXOEBJASBKWHZCFBIREGURYNMLQBT"
  end

  def test_rotate_alphabet
    alph = @tc.alph
    assert_equal alph, @tc.alph
    @tc.rotate_alphabet 1
    assert_equal 'Z', @tc.alph.first
    assert_equal 'A', @tc.alph[1]
    assert_equal 'Y', @tc.alph.last
    @tc.rotate_alphabet 2
    assert_equal 'Y', @tc.alph.first
    @tc.reset_alphabet
    assert_equal alph, @tc.alph
  end

  def test_modular_arithmetic
    assert_equal @tc.mod_add('A', 'B'), 'B'
    assert_equal @tc.mod_add('B', 'C'), 'D'
    assert_equal @tc.mod_add('X', 'Z'), 'W'
    assert_equal @tc.mod_sub('M', 'A'), 'M'
    assert_equal @tc.mod_sub('M', 'B'), 'L'
    assert_equal @tc.mod_sub('Y', 'W'), 'C'
  end

  def test_one_time_pad
    plaintext = 'abcabc'
    key = 'abc'
    ciphertext = 'ACEACE'
    assert_equal @tc.otp(plaintext, key), ciphertext
  end

end
