

require 'toycipher'

module ToyCipher

  # PlayFair Cipher
  #
  class PlayFair < ToyCipherBase
    include ToyCipherUtil

    attr_reader :keyblock

    def initialize
      super
    end
    
    def encrypt(plaintext = @plaintext, key = @key)
      generate_keyblock(key)
    end

    def decrypt(ciphertext = @ciphertext, key = @key)
    end

    def generate_keyblock(key = @key)
      @keyblock = str2arry( normalize(key) ).uniq | @alph
    end

    # Probably an easier way of doing this.
    #
    def str2arry(str)
      a = []
      str.each_byte { |b| a << b.chr }
      a
    end

    def pp
      @keyblock.each do |e|
        print e 
        print "\n" if (keyblock.index(e)+1) % 5 == 0
      end
    end

  end # PlayFair

end


