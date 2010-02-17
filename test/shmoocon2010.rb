$:.unshift File.join(File.dirname(__FILE__), "..", "lib")
$:.unshift File.join(File.dirname(__FILE__))
require 'toycipher'
require 'test/unit'

class TestCaesarCipher < Test::Unit::TestCase
  SHMOO_CIPHER = {
   '1' => 'VFLASGGGGIUGAAGYBDAWHOEVHUUVLLHGJYOLGFGPGHALGGGOAAGGJPLLHZKAGZSLRXHSRYHKFPVKISTF',
   '2' => 'XBMGRMBULEMPBMSRGMEBYRGMGRGHFMAGNMRLRZOMGXMJRMLNBMEMUAZEGNQEQBGPSZRYZLDPYQDUGEPL',
   '3' => 'BVQZWOOBPPUSAZJEAUBTMATDFAJTTAUIFDSAQPVIPFTIBOPWAUFOFHFAAJPASZSXMSBMFFMERIUSDZFU',
   '4' => 'QRJRWGDNMCZQTGYRZGFWRLRJRUFRSYWWKARAGMLSRRGSKGMWYZKGSREOAVDKAQRZDTRKSDWWUYIVUSAQ',
   '5' => 'KCPNCEJPKPPAFFFZZKDKEPEPZZFXRCOKLAVDYDKOXTXEJHKKPPEKECMSKKWEDBLEEDBZDEDZKSGJAZOW'
  }

  SHMOO2 = {
    '1' => 'DTZSLEKQALKRADYIODBLMY',
    '2' => 'DRDOTCFMELMYQCLDQHTRCY',
    '3' => 'OZRYRWLRALEELDQHTRCYET',
    '4' => 'LSIYZHLBZSALEECGQDCAIY',
    '5' => 'LTSQATTSQOSTSOZHVYPODL'
  }

  def transpose(arr)
    # assert equal size str!
    cols = arr.first.size
    rows = arr.size
    ans  = [] 
    (0..cols-1).each do |col|
      #puts "Working on col: #{col} in str #{arr[col]}"
      ans << ''
      (0..rows-1).each do |row|
        #puts arr[row][col].chr
        ans[col] += arr[row][col].chr
      end
    end
    ans 
  end

  def setup
    $shmoo = SHMOO_CIPHER.values.inject('') { |acc, l| acc += l[l.size-22..l.size]; acc }
    $shmoo2_reg = SHMOO2.values.join
    $shmoo2_tra = transpose(SHMOO2.values).join
  end
  
  def teardown
  end

  def test_caesar
    @cipher = ToyCipher::Caesar.new
    key = ['G', 'M', 'A', 'R', 'K']
    #puts @cipher.alph.inspect
    i = 0
    puts "Applying GMARK caesar cipher:"
    SHMOO_CIPHER.sort.each do |k, v|
    #transpose(SHMOO_CIPHER.values).sort.each do |k, v|
      #puts "on key #{k}, using #{@cipher.alph.index(key[i]) + 1}"
      (@second ||= []) << first = @cipher.decrypt(v, @cipher.alph.index(key[i]) + 1)
      puts first
      i += 1
    end

    (0..@second.first.size - 1).each do |j|
      (0..4).each do |i|
        print @second[i][j].chr.sub('Z', ' ')
      end
    end
    print "\n"
  end

  def _test_caesar2
    ct = SHMOO2.values.join
    puts "Shmoo2: #{ct}"
    (1..26).each do |i|
      #puts "Trying #{i}"
      puts @cipher.decrypt ct, i
    end

    @caesar_brute = {}
    #SHMOO2.each do |k, v|
    transpose(SHMOO2.values).each do |v|
      (1..26).each do |i|
        #puts "Trying #{i}"
        try = @cipher.decrypt v, i
        puts try
        (@caesar_brute["#{i}"] ||= []) << try
      end
    end

    #puts @caesar_brute.inspect
    @caesar_brute.sort.each do |k, v|
      if k.to_i < 10 
        puts "0#{k}: #{v * ' + '}"
      else
        puts "#{k}: #{v * ' + '}"
      end
    end
  end

  # Prints a string into lines of size, size.
  #
  def grid_print(str, size)
    unless $grid_off
      (1..str.size).each do |i|
        if i % size == 0
          print "#{str[i - 1].chr}\n"
        else
          print "#{str[i - 1].chr}"
        end
      end
    else
      puts str
    end
  end

  def test_zotp
    puts "Trying various one-time pads"
    guess = %w(SHMOOCON MOOSE GMARK PLAYFAIR)
    guess.each do |g| 
      @otp = ToyCipher::Otp.new
      @otp.rotate_alphabet 1
      [$shmoo2_tra, $shmoo2_reg].each do |str|
        puts "Trying #{g} with a one-time pad against #{str}:"
        #SHMOO2.values.each do |v|
        ans = @otp.decrypt str, g
        grid_print(ans, 22)
      end
    end

    puts 'Trying crazy otp'
    @otp = ToyCipher::Otp.new
    @otp.rotate_alphabet 1
    puts @otp.decrypt SHMOO2.values.join, transpose(SHMOO2.values).join
  end

  def test_freq
    [$shmoo2_reg, $shmoo2_tra].each do |str|
      header
      puts "Showing freq of #{str}"
      ToyCipher::Playfair.new.frequency(str, ToyCipher::ToyCipherBase.new.generate_alphabet)
      header
    end
  end

  def test_play
    #ct = SHMOO2.values.join
    ct = transpose(SHMOO2.values).join
    guess = %w(GMARK SHMOOCON MOOSE PLAYFAIR)
    #@play.set_ommit_letter 'I'
    puts "play inspect: #{@play.inspect}"
    guess.each do |g|
      puts "Applying #{g} to #{ct}"
      #SHMOO2.values.each do |v|
      transpose(SHMOO2.values).join.each do |v|
        @play = ToyCipher::Playfair.new
        @play.set_ommit_letter 'J'
        #puts @play.prepare_digraphs ct
        #puts "#{g}: #{@play.decrypt ct, g}"
        puts "#{@play.decrypt(v, g).gsub(' ','')}"
      end
    end
  end

  def test_vig
    @vig = ToyCipher::Vigenere.new
    puts "Trying Vig on "
    SHMOO2.values.each { |v| puts v }
    puts "answer:"
    SHMOO2.values.each do |v|
      puts @vig.decrypt v, 'GMARK'
    end
  end

  def header(title = '')
    40.times { print "=" }
    print title
    40.times { print "=" }
    print "\n"
  end

  def test_vz 
    header
    puts "Trying playfair 2"
    header
    @total = ''
    %w(GMARK).each do |guess|
      transpose(SHMOO2.values).each do |l|
      #SHMOO2.values.each do |l|
        @p2 = ToyCipher::Playfair.new
        @p2.set_ommit_letter 'J'
        line = @p2.decrypt l, guess
        @total += line
      end
    end
    puts "total: #{@total.gsub(' ', '').gsub('insanity', '')}"
  end

  def test_vza
    puts "Transposed matrix:"
    @pf = ToyCipher::Playfair.new
    transpose(SHMOO2.values).each do |l|
      puts l
    end
    orig = SHMOO2.values.inject('') { |acc, l| acc += l }

    #trans = SHMOO2.values.inject('') { |acc, l| acc += l }
    trans = transpose(SHMOO2.values).inject('') { |acc, l| acc += l }
   
    puts "Letter Codes:"
    trans.each_byte { |chr| print "#{@pf.generate_alphabet.index(chr.chr) + 1} " }; print "\n"
    puts "transposed single line: \n#{trans}"
    puts "transposed as block:"
    grid_print(trans, 22)

    %w(NOCHEATING PLAYFAIR MOOSE SHMOOCON GMARK DEFCON VISION PASSION PLAN PASSIONATE).each do |guess|
      otp = ToyCipher::Otp.new.rotate_alphabet!(1).decrypt(trans, guess)
      puts "Trying #{guess} as otp"
      grid_print(otp, 22)
      #puts ToyCipher::Vigenere.new.decrypt trans, guess
      pf = ToyCipher::Playfair.new
      pf.rotate_alphabet 1
      pf.set_ommit_letter 'J'
      puts "Trying #{guess} via playfair"
      puts pf.decrypt(trans, guess)
    end
    pf = ToyCipher::Playfair.new
    pf.set_ommit_letter 'J'
    puts "Trying test:"
    puts "Seeing if playfair is possible: #{pf.possible? trans}, #{pf.possible? orig}"
    print "\n"
  end

  def test_zz
    header
    puts "Trying to OTP old & new ciphertext"
    header
    otp = ToyCipher::Otp.new
    puts "shmoo     : #{$shmoo}"
    puts "shmoo2    : #{$shmoo2_reg}"
    puts "shmoo2_tra: #{$shmoo2_tra}"
    puts "Trying to decrypt orig with an otp of the new"
    otp.rotate_alphabet 1
    ans = otp.decrypt $shmoo, $shmoo2_reg
    grid_print ans, 22
    otp_try($shmoo2_tra, $shmoo)
    puts "Trying to decrypt new with an otp of the orig"
    ans = otp.decrypt $shmoo2_reg, $shmoo
    grid_print ans, 22

    %w(VISION PASSION PASSIONATE PLAN).each do |g|
      otp_try($shmoo2_reg, g)
      otp_try($shmoo2_reg, g, 0)
      otp_try($shmoo2_tra, g)
      otp_try($shmoo2_tra, g, 0)
    end
  end

  def otp_try(ciphertext, key, alph = 1)
    otp = ToyCipher::Otp.new
    otp.rotate_alphabet alph
    header "Trying #{key}"
    ans = otp.decrypt ciphertext, key
    grid_print ans, 22
    #header
  end

  def _test_zzz
    puts "Original: #{SHMOO2.inspect}"
    SHMOO2.values.each { |l| puts l }
    puts transpose(SHMOO2.values).join.inspect
  end

end

