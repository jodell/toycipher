
module ToyCipher
  
  # Utility module, provides pretty print, distribution graph, etc.
  #
  module ToyCipherUtil
    EN_US_FREQ_RANK = %w(E R S T L N) unless defined?(EN_US_FREQ_RANK)
    
    def frequency(str, alph = @alph)
      dist_pp distribution(normalize(str), alph) 
    end

    def show_en_us_freq_rank
      puts EN_US_FREQ_RANK.join * ', '
    end

    def distribution(str, alph)
      dist = {}
      alph.each { |l| dist[l] = 0 }
      str.each_byte { |b| dist[b.chr] = dist[b.chr] + 1 }
      dist
    end
  
    # Pretty Print of a character frequency hash
    #
    def dist_pp(dist)
      keys = dist.keys.sort
      max = dist.values.max + 2
      keys.each { |l| 
        print "#{l}: "; dist[l].times do print "#" end
        (max - dist[l]).times { print " " }
        print "(#{dist[l]})\n"
      }
      puts dist_csv(dist)
    end

    def dist_csv(dist)
      dist.sort.inject([]) { |acc, pair| acc << pair.last }.join(',')
    end
 
    # TODO
    def map_dist_to_rank(dist, alph = EN_US_FREQ_RANK)
      dist_to_rank = {}
      dist.invert.keys.sort.map.each do |count|
        #
      end 
    end
  
    # Normalize a string.  Remove non-alphanumeric characters and upcase it.
    # 
    def normalize(str) 
      str.gsub(/\W/, '').upcase 
    end
 
    # DEPREACTED unless there are proven performance gains over transpose
    def self.transpose2(arr)
      cols = arr.first.size
      raise Exception, "#{self.class}: Inconsistent string lengths in matrix! " if arr.any? { |l| l.size != cols } 
      rows = arr.size
      ans  = [] 
      (0..cols-1).each do |col|
        #puts "Working on col: #{col} in str #{arr[col]}"
        ans << ''
        (0..rows-1).each do |row|
          #puts arr[row][col].chr
          ans[col] += arr[row][col].chr
        end
      end
      ans 
    end

    # This does a matrix transposition on an m x n array of strings,
    # returning n x m
    def self.transpose(arr)
      cols = arr.first.size
      raise Exception, "#{self.class}: Inconsistent string lengths in matrix! " if arr.any? { |l| l.size != cols } 
      arr.inject([]) { |acc, l| acc << l.split(//) }.transpose.inject([]) do |acc, l| 
        acc << l.join
      end
    end


    #######
    # Modular arithmetic
    #####
    # addition
    #
    def mod_add(chr1, chr2)
      mod_shift chr1, @alph.index(chr2) 
    end

    ##
    # subtraction
    # result = lhs - rhs
    #
    def mod_sub(chr1, chr2)
      mod_shift chr1, -@alph.index(chr2) 
    end

    ##
    # Shift a character by adding an offset.
    #
    def mod_shift(chr, offset)
      @alph[(@alph.index(chr) + offset) % @alph.length]
    end

    ########

    # Pad key if needed
    #
    def pad_key(plaintext, key)
      key += key while key.size < plaintext.size
      key = key.slice(0, plaintext.size) if key.size > plaintext.size
      [plaintext, key]
    end

    ########
    # CHEAP CIPHERS
    #####
    
    # One time pad encryption
    #
    def otp(plaintext, key)
      results = pad_key normalize(plaintext), normalize(key)
      xor results.first, results.last
    end

    # Implementation of ROT13
    #
    def rot13(str)
      normalize(str).split(//).inject('') { |acc, b| acc += mod_shift(b, @alph.size / 2) }
    end

    ########

    ##
    # Perform modular subtraction per character as: lhs - rhs
    # TODO - Performance comparison of implementations
    # TODO - DRY
    #
    def inv_xor(str1, str2)
      #result = ''
      #for i in 0..(str1.size - 1) do
      #  result += mod_sub(str1[i].chr, str2[i].chr)
      #end
      #result

      # Probably slower than above:
      str1.split(//).zip(str2.split(//)).inject('') do |acc, ch| 
        acc += mod_sub(ch.first, ch.last) 
      end
    end

    ##
    # Simple xor
    #
    def xor(str1, str2)
      #result = ''
      #for i in 0..(str1.size - 1) do
      #  result += mod_add(str1[i].chr, str2[i].chr)
      #end
      #result

      # Probably slower than above:
      str1.split(//).zip(str2.split(//)).inject('') do |acc, ch| 
        acc += mod_add(ch.first, ch.last) 
      end
    end

    ########
    # Alphabet
    #####
    def generate_alphabet
      ('A'..'Z').inject([]) { |acc, l| acc << l }
    end

    ##
    # Rotate the alphabet, default A = 0.  
    # Other common cases are A = 1.
    #
    def rotate_alphabet(offset)
      alph = generate_alphabet
      (offset % alph.size).times { alph.unshift(alph.pop) }
      alph
    end
    ########
  end # ToyCipherUtil

end # ToyCipher
