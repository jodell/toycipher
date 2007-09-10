
require 'toycipher'

module ToyCipher
 class PlayFair < ToyCipherBase
    include ToyCipherUtil

    attr_reader :keyblock, :ommit_letter
    VALID_OMMIT_LETTERS = ['Q', 'I', 'J']
    OMMIT_DEFAULT = VALID_OMMIT_LETTERS.first
    INSERT_LETTER = 'X'

    def initialize
      super
      set_ommit_letter
    end

    def set_ommit_letter(l = OMMIT_DEFAULT)
      if VALID_OMMIT_LETTERS.member? l.upcase
        @ommit_letter = l.upcase 
      else
        false
      end
    end
    
    def encrypt(plaintext = @plaintext, key = @key)
      generate_keyblock key
      plaintext = prepare_digraph plaintext 
    end

    def decrypt(ciphertext = @ciphertext, key = @key)
      generate_keyblock key 
    end
    
    def prepare_digraph(str)
      # pair letters & handle repeats
      str = normalize str
      i = 0
      while i < str.size - 1 
        if str[i] == str[i + 1]
          str.insert(i + 1, INSERT_LETTER)
        end
        i += 1
        str.insert(i, ' ') if (i+1) % 3 == 0
      end
      str += INSERT_LETTER if !! str.match(/\ \w$/) or str.size == 1
      str
    end

    def key_block_lookup(str)
      # returns the matching pair
    end

    def generate_keyblock(key = @key)
      flat = ( normalize(key).split '' ).uniq | @alph
      flat.delete @ommit_letter 
      @keyblock = []
      # I'm annoyed the following doesn't work.
      # flat.each { |e|  @keyblock[flat.index(e) / 5] << e }
      dimension = Math.sqrt(@alph.size).to_i
      for i in 0..(dimension - 1)
        @keyblock << flat.slice!( 0..(dimension - 1) )
      end
      @keyblock
    end

    def pp
      @keyblock.each do |l|
        l.each { |e| print e + "\t" }
        print "\n" 
      end
    end

    def to_s
    end

  end # PlayFair

end # ToyCipher

c = ToyCipher::PlayFair.new
c.generate_keyblock 'testerson'
c.plaintext = 'this is an aribtrarily long plaintext for the sake of demonstrating the playfair cipher'
temp = c.prepare_digraph c.normalize(c.plaintext)
puts c.plaintext
puts temp
c.pp
