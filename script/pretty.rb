#!/usr/bin/env ruby

# This will evolve into word recognition

#puts "initializing dict file"
#puts "dict file has #{DICT.size} words"

class String
  DICT_FILE = '/usr/share/dict/words'
  def dict
    @@dict ||= IO.readlines(DICT_FILE)
  end

  def word?
    !dict.grep(/^#{self}\n/i).empty? && self.size != 1
  end
end

#test = 'thisisatest'
test = 'thisisamuchlargerfuckingtest'

puts "Testing: #{test}"
puts "basic: #{test.word?}"

@start = test.split(//).first
@end = @start.dup
@words = []
test.split(//).each do |char|
  @current = char
end

def gross_check(str)
  for i in 0..str.size - 1 do
    @current = str[i].chr
    puts "Inspecting current letter: #{@current}"
    j = i
    while j < str.size - 1
      puts "checking word status of #{str[i..j]}: #{str[i..j].word?}" if str[i..j].word?
      j += 1
    end
  end
end

def simple_check(str)
  i = 0
  found = false
  while i < str.size - 1 # for the whole string
    j = i 
    while j < str.size - 1
      if str[i..j].word?
        found = true
        puts "word found: #{str[i..j]}"
      else
        j += 1
      end
      while found && j < str.size - 1
        j += 1
        found = false unless str[i..j].word?
      end
      #puts "current word: #{str[i..j]}"
    end
  end
end


puts "t: #{'t'.word?}"
puts "th: #{'th'.word?}"
puts "thi: #{'thi'.word?}"
puts "this: #{'this'.word?}"


#gross_check test
simple_check test
