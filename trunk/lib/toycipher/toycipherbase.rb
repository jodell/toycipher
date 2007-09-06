

module ToyCipher

  # Main implementation class, Provides encrypt, decrypt to be overridden. 
  #
  class ToyCipherBase
    include ToyCipherUtil
    
    attr_accessor :plaintext, :ciphertext, :key, :alph

    def initialize
      @alph = generate_alphabet unless defined?(@alph)
      @plaintext, @key, @ciphertext = '', '', ''
    end

    def encrypt
      'Subclass responsibilty'
    end

    def decrypt
      'Subclass responsibility'
    end

    # Simple xor
    #
    def xor(str1, str2)
      result = ''
      for i in 0..(str1.size - 1) do
        result += mod_add(str1[i].chr, str2[i].chr)
      end
      result
    end

    # Modular addition
    #
    def mod_add(chr1, chr2)
      mod_shift chr1, @alph.index(chr2) 
    end

    # Shift a character by adding an offset.
    #
    def mod_shift(chr, offset)
      @alph[(@alph.index(chr) + offset) % @alph.length]
    end

    # Modular subtraction
    # result = lhs - rhs
    #
    def mod_sub(chr1, chr2)
      mod_shift chr1, -@alph.index(chr2) 
    end

    # Implementation of ROT13
    #
    def rot13(str)
      str2 = ''
      normalize(str).each_byte { |b| str2 += mod_shift(b.chr, @alph.size/2) }
      str2
    end

    # Rotate the alphabet, default A = 0.  Other common cases are A = 1.
    #
    def rotate_alphabet(offset)
      @alph = generate_alphabet
      (offset % @alph.size).times do @alph.unshift(@alph.pop) end
      @alph
    end

    # Rest the alphabet to A = 0
    #
    def reset_alphabet() @alph = generate_alphabet end

    # Pad key if needed
    #
    def pad_key(plaintext, key)
      key += key while key.size < plaintext.size
      key = key.slice(0, plaintext.size) if key.size > plaintext.size
      [plaintext, key]
    end

    # One time pad encryption
    #
    def otp(plaintext, key)
      results = pad_key normalize(plaintext), normalize(key)
      xor results.first, results.last
    end

  end
      
end


