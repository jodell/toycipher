# ToyCipher module.
# This module implements various traditional ciphers that I have used
# or wished implemented while taking part of various crptographic
# challenges.  Hopefully you will find it useful or interesting.

$:.unshift File.join(File.dirname(__FILE__), "/toycipher")

module ToyCipher
  CIPHERS = %w[caesar otp playfair vigenere shift rot13]
  VERSION = "ToyCipher v0.3 by Jeffrey O'Dell <jeffrey.odell@gmail.com>, http://github.com/jodell/toycipher"

  require 'toycipherutil'
  require 'toycipherbase'
  require 'caesar'
  require 'vigenere'
  require 'otp'
  require 'playfair'
end 



