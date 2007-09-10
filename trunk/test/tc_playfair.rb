
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
    assert_equal @cipher.ommit_letter, 'Q'
    #assert_equal @ciphertext, @cipher.encrypt(@plaintext, @key)
  end

  def test_decrypt
    #assert_equal @plaintext, @cipher.decrypt(@ciphertext, @key)
  end

  def test_set_ommit_letter
    assert_equal @cipher.ommit_letter, 'Q'
    assert_equal @cipher.set_ommit_letter('a'), false
    assert_equal @cipher.set_ommit_letter('A'), false
    assert_equal @cipher.set_ommit_letter('q'), 'Q'
    assert_equal @cipher.set_ommit_letter('Q'), 'Q'
    assert_equal @cipher.set_ommit_letter('i'), 'I'
    assert_equal @cipher.set_ommit_letter('j'), 'J'
  end

  def test_prepare_digraph
    assert_equal @cipher.prepare_digraph('boo'), 'BO XO'
    assert_equal @cipher.prepare_digraph('boon'), 'BO XO NX'
    assert_equal @cipher.prepare_digraph('boone'), 'BO XO NE'
    assert_equal @cipher.prepare_digraph('aaa'), 'AX AX AX'
    assert_equal @cipher.prepare_digraph('a'), 'AX'
    given = 'This is a long test with little repeated digraphs'
    expected = 'TH IS IS AL ON GT ES TW IT HL IT XT LE RE PE AT ED XD IG RA PH SX'
    assert_equal @cipher.prepare_digraph(given), expected
  end

  def test_keyblock_generation
    @cipher.generate_keyblock 'testerson'
    assert_equal @cipher.keyblock, [["T", "E", "S", "R", "O"], ["N", "A", "B", "C", "D"], ["F", "G", "H", "I", "J"], ["K", "L", "M", "P", "U"], ["V", "W", "X", "Y", "Z"]]
  end

end

