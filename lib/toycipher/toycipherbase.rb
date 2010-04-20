

module ToyCipher

  class ToyCipherException < Exception; end

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
      nil # Subclass responsibilty
    end

    def decrypt
      nil # Subclass responsibility'
    end

    # Implementation of ROT13
    #
    def rot13(str)
      normalize(str).split(//).inject('') { |acc, b| acc += mod_shift(b, @alph.size/2) }
    end

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

    def to_s
      "<%s: id=%d, plaintext='%s', key='%s', ciphertext='%s', alph='%s'>" %
        [self.class, self.object_id, @plaintext, @key, @ciphertext, @alph]
    end

    ################
    # Alphabet
    #####
    def generate_alphabet
      ('A'..'Z').inject([]) { |acc, l| acc << l }
    end

    ##
    # Rotate the alphabet, default A = 0.  Other common cases are A = 1.
    #
    def rotate_alphabet(offset)
      alph = generate_alphabet
      (offset % alph.size).times { alph.unshift(alph.pop) }
      alph
    end

    def rotate_alphabet!(offset)
      @alph = rotate_alphabet(offset)
    end

    ##
    # Reset the alphabet to A = 0
    #
    def reset_alphabet!
      @alph = generate_alphabet
    end
    ################
    
  end # ToyCipherBase
      
end # ToyCipher


