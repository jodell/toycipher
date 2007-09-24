# ToyCipher
# by jodell
#
# License: GPL
#
# ToyCipher module.
# This module implements various traditional ciphers that I have used
# or wished implemented while taking part of various crptographic
# challenges.  Hopefully you will find it useful or interesting.

# FIXME: Paths

$:.unshift File.join(File.dirname(__FILE__), "/toycipher")

module ToyCipher
  
  require 'toycipherutil'
  require 'toycipherbase'
  require 'caesar'
  require 'vigenere'
  require 'otp'
  require 'playfair'

  CIPHERS = %w[caesar otp playfair vigenere shift rot13]

end 



