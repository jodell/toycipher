
# FIXME
require '/home/jodell/toycipher/toycipher.rb'

class Otp < ToyCipher::ToyCipherBase

  def initialize
    @key = ''
    @ciphertext = ''
    @plaintext = ''
  end

  def encrypt(plaintext = @plaintext, key = @key)
    puts "plaintext = #{plaintext}, key = #{key}"
    results = pad_key plaintext, key
    puts "#{results.first.to_s}, #{results.last.to_s}"
    @ciphertext = xor results.first, results.last
  end

  def decrypt(ciphertext = @ciphertext, key = @key)
    results = pad_key ciphertext, key
    @plaintext = ''
  end

end
