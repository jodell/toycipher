
require 'toycipher'
require 'string'

class TestToyCipherExt < Test::Unit::TestCase

  def setup
  end

  def test_phone
    assert_equal '2', 'a'.phone
    assert_equal '2', 'a'.phone(:foo)
    assert_equal '1', 'a'.phone(:legacy)
    assert_equal '3', 'd'.phone
  end

  def test_basic
    assert_equal '22233344455566677778889999', "abcdefghijklmnopqrstuvwxyz".phone
    assert_equal '11122233344455566677788899', "ABCDEFGHIJKLMNOPQRSTUVWXYZ".phone(:legacy)
    assert_equal '8447 47 2 8378', "THIS IS A TEST".phone
  end

  def test_non_alpha
    assert_equal '123', '123'.phone
    assert_equal '*&2-==[][][', '*&2-==[][]['.phone
  end

  def test_mixed_alpha_non_alpha
    assert_equal '843 78425 27696 369 586733 6837 843 5299 364!!!', 'The quick brown fox jumped over the lazy dog!!!'.phone
  end

end
 
