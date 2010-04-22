
require 'toycipher'

module ToyCipher
 
  # One-time pad 
  # NOTE:  A one-time pad is calculated identically to the Vigenere
  # cipher with the exception of the constraint that the key size 
  # should match the plain/cipher text.  Need to confirm official
  # sources and potentially refactor.
  #
  class Otp < ToyCipherBase
    def encrypt(plaintext = @plaintext, key = @key)
      if plaintext.size != key.size
        raise ToyCipherException, "#{self.class}: Key length should be equal to the length of message!"
      end
      results = pad_key normalize(plaintext), normalize(key)
      @ciphertext = xor results.first, results.last
    end

    def decrypt(ciphertext, key)
#      if ciphertext.size != key.size
#        raise ToyCipherException, "#{self.class}: Key length should be equal to the length of message!"
#      end
      results = pad_key normalize(ciphertext), normalize(key)
      @plaintext = inv_xor results.first, results.last
    end 
  end # Otp 

end # ToyCipher
