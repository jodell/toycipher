
$: << File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'toycipher'
class String
  LETTER_A_VALUE = 97 unless defined?(LETTER_A_VALUE) # ASCII value of 'a'
 
  # Quick way to support ascii [A-Z]
  # Only tested in 1.8.7
  # 1.8 syntax
  #
  # Support two Touchtone phone keypads:
  #
  # legacy:
  #  1   2   3
  # abc def ghi
  #  4   5   6
  # jkl mno pqr
  #  7   8   9
  # stu vwx yz
  # 
  # default:
  #  1   2   3
  #     abc def
  #  4   5   6
  # ghi jlk mno
  #  7   8   9
  # pqrs tuv wxyz
  #
  # 
  #
  #
  def phone(type = :default)
    raise "Ruby version #{RUBY_VERSION} not supported!" unless RUBY_VERSION =~ /^1.8/
    self.downcase.split(//).inject('') do |acc, b| # better syntax in 1.9
      if b =~ /[a-z]/
        unless type == :legacy
          val = ((b[0] % LETTER_A_VALUE / 3) + 2)
          val -= 1 if %w(s v y z).include?(b)
          acc += val.to_s
        else # not real
          acc += ((b[0] % LETTER_A_VALUE / 3) + 1).to_s
        end
      else
        acc += b
      end
    end
  end

  # NOTE: Might want to switch to class method to avoid all of these allocations
  def to_morse
    ToyCipher::Morse.new.encrypt(self)
  end

  def from_morse
    ToyCipher::Morse.new.decrypt(self)
  end
end

#puts "abcdefghijklmnopqrstuvwxyz".phone
#puts "ABCDEFGHIJKLMNOPQRSTUVWXYZ".phone(:legacy)
#puts "THIS IS A TEST".phone
#puts '.... .- ...- . ..-. ..- -. .--. .- ... ... .-- --- .-. -.. --... ..... ..... --... .... . .-.. .-.. --- .... .- ...- . ..-. ..- -.'.from_morse
#puts 'HAVEFUNPASSWORD7557HELLOHAVEFUN'.to_morse
