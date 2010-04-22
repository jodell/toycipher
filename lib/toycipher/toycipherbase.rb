
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

    def to_s
      "<%s: id=%d, plaintext='%s', key='%s', ciphertext='%s', alph='%s'>" %
        [self.class, self.object_id, @plaintext, @key, @ciphertext, @alph]
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
  end # ToyCipherBase
      
end # ToyCipher
