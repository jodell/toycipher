
class String
  LETTER_A_VALUE = 97 unless defined?(LETTER_A_VALUE) # ASCII value of 'a'
 
  # Quick way to support ascii [A-Z]
  # Only tested in 1.8.7
  # 1.8 syntax
  #
  # Touchtone phone:
  #  1   2   3
  # abc def ghi
  #  4   5   6
  # jkl mno pqr
  #  7   8   9
  # stu vwx yz
  #
  #  1   2   3
  #     abc def
  #  4   5   6
  # ghi jlk mno
  #  7   8   9
  # pqrs tuv wxyz
  #
  # really?
  #
  #
  def phone 
    raise "Ruby version #{RUBY_VERSION} not supported!" unless RUBY_VERSION =~ /^1.8/
    self.downcase.split(//).inject('') do |acc, b| # better syntax in 1.9
      if b =~ /[a-z]/
        index = b[0] % LETTER_A_VALUE
        acc += ((index / 3) + 1).to_s
      else
        acc += b
      end
    end
  end
end

puts "abcdefghijklmnopqrstuvwxyz".phone
puts "ABCDEFGHIJKLMNOPQRSTUVWXYZ".phone
puts "THIS IS A TEST".phone
