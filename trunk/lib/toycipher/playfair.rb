
require 'toycipher'

module ToyCipher
 class Playfair < ToyCipherBase
    include ToyCipherUtil

    attr_reader :keyblock, :ommit_letter, :fill_letter, :transforms
    VALID_OMMIT_LETTERS = ['Q', 'I', 'J']
    OMMIT_DEFAULT = VALID_OMMIT_LETTERS.first
    VALID_FILL_LETTERS = ['X']
    FILL_DEFAULT = 'X'

    def initialize() 
      super
      set_ommit_letter; set_fill_letter; set_tranformations
    end

    def set_ommit_letter(l = OMMIT_DEFAULT)
      @ommit_letter = l.upcase if VALID_OMMIT_LETTERS.member? l.upcase
    end
 
    def set_fill_letter(l = FILL_DEFAULT)
      @fill_letter = l.upcase if VALID_FILL_LETTERS.member? l.upcase
    end
   
    def encrypt(plaintext = @plaintext, key = @key)
      @key = normalize key
      @plaintext = normalize plaintext
      generate_keyblock key
      stream = prepare_digraphs @plaintext 
      @ciphertext  = transform_stream stream, @ciphertext, :encrypt
    end
    
    def decrypt(ciphertext = @ciphertext, key = @key)
      @key = normalize key
      @ciphertext = normalize ciphertext
      generate_keyblock key
      stream = pair_digraphs @ciphertext
      @plaintext = transform_stream stream, @plaintext, :decrypt
    end

    def transform_stream(instream, outstream, mode)
       instream = instream.split(' ') if instream.class == String
       instream.each { |p| outstream += (transform_digraph p, mode) + ' ' }
       outstream
    end

    def set_tranformations
      @transforms = {}
      @transforms[:encrypt] = {
          :rectangle => Proc.new { |x0, y0, x1, y1| [[x1, y0], [x0, y1]] },
          :same_row => Proc.new { |x0, y0, x1, y1| [[x0 + 1, y0], [x1 + 1, y0]] },
          :same_col => Proc.new { |x0, y0, x1, y1| [[x0, y0 + 1], [x0, y1 + 1]] }
      }
      @transforms[:decrypt] = {
          :rectangle => Proc.new { |x0, y0, x1, y1| [[x1, y0], [x0, y1]] },
          :same_row => Proc.new { |x0, y0, x1, y1| [[x0 - 1, y0], [x1 - 1, y0]] },
          :same_col => Proc.new { |x0, y0, x1, y1| [[x0, y0 - 1], [x0, y1 - 1]] }
      }
    end
 
    # p0 = (x0, y0), p1 = (x1, y1)
    # returns p2 & p3 where p2 & p3 are the the points that make a rectangle
    # with p0 & p1.  p2 & p3 should be: 
    # x1 - x0 != 0 && y1 - y0 != 0
    #    p2 = (x1, y0), p3 = (x0, y1)
    # x1 - x0 = 0 && y1 - y0 != 0
    #    p2 = (x0, y0 + 1), p3 = (x0, y1 + 1)
    # x1 - x0 != 0 && y1 - y0 = 0
    #    p2 = (x0 + 1, y0), p3 = (x1 + 1, y0)
    #
   def transform_digraph(str, mode)
      l0 = xy_pos str[0].chr; l1 = xy_pos str[1].chr
      x0, y0 = l0.first, l0.last
      x1, y1 = l1.first, l1.last
      delta_x = x1 - x0; delta_y = y1 - y0
      case 
      when delta_x != 0 && delta_y != 0:
        digraph =  @transforms[mode][:rectangle].call(x0, y0, x1, y1)
        return letter_at(digraph.first) + letter_at(digraph.last)
      when delta_x != 0 && delta_y == 0:
        digraph =  @transforms[mode][:same_row].call(x0, y0, x1, y1)
        return letter_at(digraph.first) + letter_at(digraph.last)
      when delta_x == 0 && delta_y != 0: 
        digraph =  @transforms[mode][:same_col].call(x0, y0, x1, y1)
        return letter_at(digraph.first) + letter_at(digraph.last)
      when delta_x == 0 && delta_y == 0:
        return 'insanity'
      end
    end

    # Returns [row, col] position of a letter in the keyblock
    #
    def xy_pos(letter)
      [@keyblock.index(letter) % 5, @keyblock.index(letter) / 5]
    end

    # Return the letter in the keyblock given a coordinate position
    #
    def letter_at(pos)
      @keyblock[ (pos.first) % 5 + ( (pos.last % 5) * 5) ]
    end

  
    # Normalize a string and return it in pairs, splitting pairs with the
    # @fill_letter and padding if it is of odd length.  Should work for both
    # plaintext and ciphetext.
    #
    def prepare_digraphs(str)
      # pair letters & handle repeats
      str = normalize str
      i = 0
      while i < str.size - 1 
        if str[i] == str[i + 1]
          str.insert(i + 1, @fill_letter)
        end
        i += 1
        str.insert(i, ' ') if (i + 1) % 3 == 0
      end
      str += @fill_letter if !! str.match(/\ \w$/) or str.size == 1
      str
    end

    # TODO Refactor this with prepare_digraphs
    def pair_digraphs(str)
      str = normalize str
      i = 0
      while i < str.size - 1
        str.insert(i, ' ') if (i + 1) % 3 == 0
        i += 1
      end
      #str.each_byte { |b| str.insert(str.index(b.chr), ' ') if str.index(b.chr) % 3 == 0 }
      str
    end

    def generate_keyblock(key = @key)
      @keyblock = ( normalize(key).split '' ).uniq | @alph
      @keyblock.delete @ommit_letter 
    end

    def pp
      @keyblock.each do |l|
        print l + "\t" 
        print "\n" if ( (@keyblock.index(l) + 1) % 5 ) == 0
      end
    end

    # TODO
    def to_s() super end 

  end # Playfair

end # ToyCipher

