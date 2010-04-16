
require 'toycipher'

module ToyCipher
  
  # Vigenere cipher
  #
  class Vigenere < ToyCipherBase
    include ToyCipherUtil
  
    def initialize
      super
    end

    # Vigenere encryption
    #
    def encrypt(plaintext = @plaintext, key = @key)
      results = pad_key normalize(plaintext), normalize(key)
      @ciphertext = xor results.first, results.last
    end

    # Vigenere decryption
    #
    def decrypt(ciphertext, key)
      results = pad_key normalize(ciphertext), normalize(key)
      @plaintext = inv_xor results.first, results.last
    end 

    # Perform modular subtraction per character as: lhs - rhs
    # TODO - Determine if this should actually go in ToyCipherUtil
    # TODO - Performance comparison of implementations
    #
    def inv_xor(str1, str2)
      #result = ''
      #for i in 0..(str1.size - 1) do
      #  result += mod_sub(str1[i].chr, str2[i].chr)
      #end
      #result

      # Probably slower than above:
      str1.split(//).zip(str2.split(//)).inject('') do |acc, ch| 
        acc += mod_sub(ch.first, ch.last) 
      end
    end
  end # Vigenere

end # ToyCipher

