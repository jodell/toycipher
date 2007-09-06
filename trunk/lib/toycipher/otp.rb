
require 'toycipher'

module ToyCipher
  
  # One-time pad 
  #
  class Otp < ToyCipherBase
    include ToyCipherUtil
  
    def initialize
      super
    end

    # One-time pad encryptio
    # TODO - Change warning?
    #
    def encrypt(plaintext = @plaintext, key = @key)
      if plaintext.size != key.size
        'Warning:  Key length should be equal to the length of message!'
        return
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

    # Perform modular subtraction per character as: lhs - rhs
    # TODO - Determine if this should actually go in ToyCipherUtil
    #
    def inv_xor(str1, str2)
      result = ''
      for i in 0..(str1.size - 1) do
        result += mod_sub(str1[i].chr, str2[i].chr)
      end
      result
    end
  
  end # Otp 

end # ToyCipher

