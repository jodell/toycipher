
require 'test_helper'
require 'toycipher'
require 'fileutils'

def debug?
  ENV['DEBUG'] || ENV['debug']
end

class TestMorse < Test::Unit::TestCase

  def setup
    @cipher = ToyCipher::Morse.new
    @mc2010_ciphetext = '.... .- ...- . ..-. ..- -. .--. .- ... ... .-- --- .-. -.. --... ..... ..... --... .... . .-.. .-.. --- .... .- ...- . ..-. ..- -.'
    @mc2010_plaintext = 'HAVEFUNPASSWORD7557HELLOHAVEFUN'
  end

  def teardown
  end

  def test_morse
    assert @cipher.is_a?(ToyCipher::Morse)
  end

  def test_cli
    assert_equal @mc2010_plaintext, @cipher.decrypt(@mc2010_ciphetext)
  end




end
