
require 'toycipher'

module ToyCipher
  
  # Caesar cipher
  #
  class Caesar < ToyCipherBase
    include ToyCipherUtil

    attr_writer :offset
    attr_accessor :guess
 
    def initialize
      super
      @offset = 0
    end

    def brute
      (0..25).each do |i|
        (@guess ||= []) << decrypt(ciphertext, i)
      end
      @guess
    end

    # Caesar encryption
    # Monoalphabetic cipher that shifts the alphabet by N characters
    #
    def encrypt(plaintext = @plaintext, offset = @offset)
      #if offset.class != Fixnum
      #  # Explode
      #  return
      #end

      @ciphertext = ''
      normalize(plaintext).each_byte { |b| @ciphertext += mod_shift b.chr, offset.to_i }
      @ciphertext
    end

    # Caesar decryption
    #
    def decrypt(ciphertext = @ciphertext, offset = @offset)
      @plaintext = '' 
      ciphertext.each_byte { |b| @plaintext += mod_shift b.chr, -offset }
      @plaintext
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
  
  end # Caesar 

end # ToyCipher

