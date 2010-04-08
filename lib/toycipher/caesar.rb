
require 'toycipher'

module ToyCipher
  class Caesar < ToyCipherBase
    include ToyCipherUtil
    attr_writer :offset
    attr_accessor :guess
 
    def initialize
      super
      @offset = 0
    end

    # TODO
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
      offset = normalize_key(offset)
      #puts "Trying to decrypt #{ciphertext} with offset #{offset}:#{offset.class}"
      @ciphertext = ''
      normalize(plaintext).each_byte { |b| @ciphertext += mod_shift(b.chr, offset) }
      @ciphertext
    end

    # Caesar decryption
    #
    def decrypt(ciphertext = @ciphertext, offset = @offset)
      offset = normalize_key(offset)
      #puts "Trying to decrypt #{ciphertext} with offset #{offset}:#{offset.class}"
      @plaintext = '' 
      normalize(ciphertext).each_byte { |b| @plaintext += mod_shift(b.chr, -offset) }
      @plaintext
    end 

    # UGLY
    def normalize_key(key)
      case key 
      when String
        if key =~ /[0-9]/ 
          key = key.to_i + 1
        elsif key =~ /[A-Z]/
          key = @alph.index(key.upcase) + 1
        else
          key
        end
      else
        key
      end
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

