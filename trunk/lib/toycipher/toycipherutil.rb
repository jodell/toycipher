
module ToyCipher

  # Utility Class, provides pretty print, distribution graph, etc.
  #
  module ToyCipherUtil
    
    def frequency(str, alph = @@ALPH)
      dist_pp distribution(normalize(str), alph) 
    end

    EN_US_FREQ_RANK = %w(E R S T L N) unless defined?(EN_US_FREQ_RANK)

    def show_en_us_freq_rank
      puts EN_US_FREQ_RANK.join * ', '
    end

    # Generate alphabet
    #
    def generate_alphabet
      alph = []
      ('A'..'Z').each { |l| alph << l }
      alph
    end


     # Find the frequency of each character in alph
     #
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
       keys.each { |l| 
         print "#{l}: "; dist[l].times do print "#" end
         (30 - dist[l]).times { print " " }
         print "(#{dist[l]})\n"
       }
     end
  
     # Normalize a string.  Remove non-alphanumeric characters and upcase it.
     # 
     def normalize(str) str.gsub(/\W/, '').upcase end

     def file2array(file)
       IO.readlines(file)
     end
  
  end # ToyCipherUtil

end # ToyCipher
