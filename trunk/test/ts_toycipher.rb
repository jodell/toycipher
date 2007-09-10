# file ts_toycipher.rb 
$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift File.join(File.dirname(__FILE__))
require 'test/unit'
require 'tc_toycipher'
require 'tc_vigenere'
require 'tc_otp'
require 'tc_caesar'
require 'tc_playfair'
