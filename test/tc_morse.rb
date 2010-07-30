
require 'test_helper'
require 'toycipher'
require 'fileutils'

def debug?
  ENV['DEBUG'] || ENV['debug']
end

class TestMorse < Test::Unit::TestCase

  def setup
    @cipher = ToyCipher::Morse.new
  end

  def teardown
  end

  def test_morse
    assert @cipher.is_a?(ToyCipher::Morse)
  end



end
