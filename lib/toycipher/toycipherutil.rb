
module ToyCipher
  # Utility Class, provides pretty print, distribution graph, etc.
  module ToyCipherUtil
    EN_US_FREQ_RANK = %w(E R S T L N) unless defined?(EN_US_FREQ_RANK)
    
    def frequency(str, alph = @alph)
      dist_pp distribution(normalize(str), alph) 
    end

    def show_en_us_freq_rank
      puts EN_US_FREQ_RANK.join * ', '
    end

    def generate_alphabet
      alph = []
      ('A'..'Z').each { |l| alph << l }
      alph
    end

    def distribution(str, alph)
      dist = {}
      alph.each { |l| dist[l] = 0 }
      str.each_byte { |b| dist[b.chr] = dist[b.chr] + 1 }
      dist
    end

    def map_dist_to_rank(dist, alph = EN_US_FREQ_RANK)
      dist_to_rank = {}
      dist.invert.keys.sort.map.each { |count|
      }
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
  
    # Normalize a string.  Remove non-alphanumeric characters and upcase it.
    # 
    def normalize(str) str.gsub(/\W/, '').upcase end

    # This does a matrix transposition on an m x n array of strings,
    # returning n x m
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

    def self.transpose(arr)
      cols = arr.first.size
      raise Exception, "#{self.class}: Inconsistent string lengths in matrix! " if arr.any? { |l| l.size != cols } 
      arr.inject([]) { |acc, l| 
        acc << l.split(//) 
      }.transpose.inject([]) { |acc, l| acc << l.join }
    end

  end # ToyCipherUtil
end # ToyCipher
