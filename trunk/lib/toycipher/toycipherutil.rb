
module ToyCipher

  # Utility Class, provides pretty print, distribution graph, etc.
  #
  module ToyCipherUtil
    
    def frequency(str, alph = @@ALPH)
      dist_pp distribution(normalize(str), alph) 
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
   
     # Pretty Print of a character frequency hash
     #
     def dist_pp(dist)
       keys = dist.keys.sort
       keys.each { |l| 
         print "#{l}: "; dist[l].times do print "#" end; print "\t (#{dist[l]})\n"
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
