#!/usr/bin/env ruby

$: << File.expand_path(File.dirname(__FILE__) + '/../../lib')
require 'toycipher'


morse = ToyCipher::Morse.new


puts morse.inspect

puts ToyCipher::Morse::LETTER.inspect


puts morse.decrypt '.... .- ...- . ..-. ..- -. .--. .- ... ... .-- --- .-. -.. --... ..... ..... --... .... . .-.. .-.. --- .... .- ...- . ..-. ..- -.'




