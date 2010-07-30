# ToyCipher module.
# This module implements various traditional ciphers that I have used
# or wished implemented while taking part of various crptographic
# challenges.  Hopefully you will find it useful or interesting.

$:.unshift File.join(File.dirname(__FILE__), "/toycipher")

module ToyCipher
  CIPHERS     = %w[caesar otp playfair vigenere shift rot13 morse]
  VERSION     = 0.3
  AUTHOR      = "Jeffrey O'Dell"
  EMAIL       = "jeffrey.odell@gmail.com"
  URL         = 'http://github.com/jodell/toycipher'
  VERSION_STR = "ToyCipher v#{VERSION} by #{AUTHOR} <#{EMAIL}>, #{URL}"

  require 'toycipherutil'
  require 'toycipherbase'
  require 'caesar'
  require 'vigenere'
  require 'otp'
  require 'playfair'
  require 'morse'
end 
