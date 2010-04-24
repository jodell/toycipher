
require 'toycipher'

module ToyCipher
  
  # Monoalphabetic cipher that shifts the alphabet by N characters
  #
  class Caesar < ToyCipherBase
    #include ToyCipherUtil
    attr_writer :offset
    attr_accessor :guess
 
    def initialize
      super
      @offset = 0
    end

    def brute(ciphertext = @ciphertext)
      @alph.inject([]) { |acc, ch| acc << decrypt(ciphertext, ch) }
    end

    def encrypt(plaintext = @plaintext, offset = @offset)
      offset = normalize_key(offset)
      #puts "Trying to decrypt #{ciphertext} with offset #{offset}:#{offset.class}"
      @ciphertext = ''
      normalize(plaintext).each_byte { |b| @ciphertext += mod_shift(b.chr, offset) }
      @ciphertext
    end

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
  end # Caesar 

end # ToyCipher

