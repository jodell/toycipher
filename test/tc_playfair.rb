
require 'toycipher'
require 'test/unit'

class TestPlayfairCipher < Test::Unit::TestCase

  def setup
    # Example courtesy of http://en.wikipedia.org/wiki/Playfair_cipher.html
    @cipher = ToyCipher::Playfair.new
    @plaintext = 'Hide the gold in the tree stump'
    @ciphertext = 'BM ND ZB XD KY BE JV DM UI XM MN UV IF '
    @key = 'playfair example'
  end
  
  def teardown
  end

  def test_encrypt
    assert_equal @cipher.ommit_letter, 'Q'
    assert_equal @ciphertext, @cipher.encrypt(@plaintext, @key)
  end

  def test_decrypt
    assert_equal @cipher.normalize(@plaintext), @cipher.normalize(@cipher.decrypt(@ciphertext, @key)).delete(@cipher.fill_letter)
  end

  def test_fill_letter
    %w(Q Z W).each do |fl|
      @cipher.set_fill_letter fl
      assert_equal @cipher.prepare_digraphs('BOO'), "BO #{fl}O"
    end
  end

  def test_set_ommit_letter
    assert_equal @cipher.ommit_letter, 'Q'
    assert_equal @cipher.set_ommit_letter('a'), nil 
    assert_equal @cipher.set_ommit_letter('A'), nil
    assert_equal @cipher.set_ommit_letter('q'), 'Q'
    assert_equal @cipher.set_ommit_letter('Q'), 'Q'
    assert_equal @cipher.set_ommit_letter('i'), 'I'
    assert_equal @cipher.set_ommit_letter('j'), 'J'
  end

  def test_prepare_digraphs
    assert_equal @cipher.prepare_digraphs('boo'), 'BO XO'
    assert_equal @cipher.prepare_digraphs('boon'), 'BO XO NX'
    assert_equal @cipher.prepare_digraphs('boone'), 'BO XO NE'
    assert_equal @cipher.prepare_digraphs('aaa'), 'AX AX AX'
    assert_equal @cipher.prepare_digraphs('a'), 'AX'
    given = 'This is a long test with little repeated digraphs'
    expected = 'TH IS IS AL ON GT ES TW IT HL IT XT LE RE PE AT ED XD IG RA PH SX'
    assert_equal @cipher.prepare_digraphs(given), expected

    # This check is really only for ciphertext
    assert_equal false,  @cipher.possible?(given.gsub(/\s/, ''))
  end

  def test_keyblock_lookup
    @cipher.generate_keyblock 'testerson'
    b = ToyCipher::ToyCipherBase.new
    assert_equal ( @cipher.keyblock - b.alph.reject!{|l| l == @cipher.ommit_letter} ), []
    @cipher.keyblock do |l|
      assert_equal l, @cipher.keyblock_letter(@cipher.xy_pos(l))
    end
  end

  def test_keyblock_generation
    @cipher.generate_keyblock 'testerson'
    assert_equal @cipher.keyblock, ["T", "E", "S", "R", "O", "N", "A", "B", "C", "D", "F", "G", "H", "I", "J", "K", "L", "M", "P", "U", "V", "W", "X", "Y", "Z"]
  end

  def test_possible
    assert_equal true, @cipher.possible?(@ciphertext)
    assert_equal true, @cipher.impossible?('AAXX')
    assert_equal false, @cipher.possible?('AAXX')
    assert_equal true, @cipher.possible?('ABDCEFGH')
    assert_equal true, @cipher.possible?('ABDEEFFH')
  end

end

