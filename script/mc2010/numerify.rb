#!/usr/bin/env ruby

$: << File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'toycipher'

stream = IO.readlines(ARGV[0]).inject([]) do |acc, l|
#  puts "l: #{l}"
#  puts "l split: #{l.split(' ').inspect}"
  acc << l.split(' ').map { |c| c.gsub(/\W/, '') }
  acc
end.flatten

include ToyCipher::ToyCipherUtil

puts "stream: #{stream.inspect}"
alph = generate_alphabet
puts "alph: #{alph.inspect}"
puts stream.inject('') { |acc, s| acc += alph[s.to_i] }




