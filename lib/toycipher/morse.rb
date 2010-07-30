
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
    result = ''
    plaintext.split(' ').each do |c|
      next unless c =~ /\.|-/
      result += LETTER[c]
    end
    result
  end
  
  def decrypt(ciphertext = @ciphertext)
    result = ''
    ciphertext.split(' ').each do |c|
      next unless c =~ /\.|-/
      result += LETTER.invert[c]
    end
    result
  end

  def normalize(string)
  end

end  
