
require 'toycipher'

class ToyCipher::Morse < ToyCipher::ToyCipherBase

  LETTER = Hash[*%w/
  A .- N -.
  B -... O ---
  C -.-. P .--.
  D -.. Q --.-
  E . R .-.
  F ..-. S ...
  G --. T -
  H .... U ..-
  I .. V ...-
  J .--- W .--
  K -.- X -..-
  L .-.. Y -.--
  M -- Z --..
  1 .---- 2 ..---
  3 ...-- 4 ....-
  5 ..... 6 -....
  7 --... 8 ---..
  9 ----. 0 -----
  /]

  def initialize
  end
  
  def encrypt(plaintext = @plaintext)
    plaintext.upcase.split(//).inject([]) do |acc, c|
      next unless LETTER.keys.include?(c)
      acc << LETTER[c]
    end * ' '
  end
  
  def decrypt(ciphertext = @ciphertext)
    ciphertext.split(' ').inject('') do |acc, c|
      next unless LETTER.values.include?(c)
      acc += LETTER.invert[c]
    end
  end

  def normalize(string)
  end

end  
