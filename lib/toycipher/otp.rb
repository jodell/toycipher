
require 'toycipher'

module ToyCipher
  
  # One-time pad 
  #
  class Otp < ToyCipherBase
    include ToyCipherUtil
  
    # One-time pad encryptio
    # TODO - Change warning?
    #
    def encrypt(plaintext = @plaintext, key = @key)
      if plaintext.size != key.size
        raise ToyCipherException, "#{self.class}: Key length should be equal to the length of message!"
      end
      results = pad_key normalize(plaintext), normalize(key)
      @ciphertext = xor results.first, results.last
    end

    # One-time pad decryption
    #
    def decrypt(ciphertext, key)
      results = pad_key normalize(ciphertext), normalize(key)
      @plaintext = inv_xor results.first, results.last
    end 
  end # Otp 

end # ToyCipher
