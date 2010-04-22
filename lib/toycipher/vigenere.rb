
require 'toycipher'

module ToyCipher
  
  # Vigenere cipher
  # TODO: MORE DOC
  #
  class Vigenere < ToyCipherBase
    def encrypt(plaintext = @plaintext, key = @key)
      results = pad_key normalize(plaintext), normalize(key)
      @ciphertext = xor results.first, results.last
    end

    def decrypt(ciphertext, key)
      results = pad_key normalize(ciphertext), normalize(key)
      @plaintext = inv_xor results.first, results.last
    end 
  end # Vigenere

end # ToyCipher

