require 'toycipher'

class ToyCipher::Substitution < ToyCipher::ToyCipherBase
  def initialize
    super
  end

  def key=(key)
    new_key = case key
              when String 
                key.split(//)
              when Array
                key
              end
    @key = @alph.zip(new_key).inject({}) do |acc, pair|
      acc[pair.first] = pair.last
      acc
    end
  end

  def encrypt(plaintext = @plaintext)
    normalize(ciphertext).split(//).inject('') do |acc, c|
      acc += @key[c]
    end
  end

  def decrypt(ciphertext = @ciphertext, key = @key)
    normalize(ciphertext).split(//).inject('') do |acc, c|
      acc += @key.invert[c]
    end
  end

  def brute
    @alph.each do |c|
    end
  end

end
