# This file afford the lib of the way to handle a word
# e.g. change \a to ä

class Verben  # verbs

  def init_data!
    @right = 0
    @wrong = 1
    @time = Time.now
    puts "Please input the Chinese meaning"
    @chinese = gets.chomp
  end

  def change_time!
    @time = Time.now
  end

  def counter
    day = 3_600 * 24
    @right * 50 * day * day + @wrong * (-60) * day * day + (Time.now.to_i - @time.to_i) ** 2 * (-1)
  end

  def to_s
    @infintiv.long_tab + @indikativ_praesens_du.long_tab + @indikativ_praeteritum.long_tab\
      + @zweites_partizip.long_tab + @chinese
  end

  def out
    cut = "&"
    @infintiv + cut + @indikativ_praesens_du + cut + @indikativ_praeteritum + cut + @zweites_partizip \
      + cut + @right.to_s + cut + @wrong.to_s + cut + @time.to_s + cut + @chinese
  end

  def get_from_s!(str)
    verben_s = str.chomp.split("&")
    puts verben_s
    @infintiv = verben_s[0]
    @indikativ_praesens_du = verben_s[1]
    @indikativ_praeteritum = verben_s[2]
    @zweites_partizip = verben_s[3]
    @right = verben_s[4].to_i
    @wrong = verben_s[5].to_i
    @time = verben_s[6]
    @chinese = verben_s[7]
    self
  end

  def word_change!
    puts 'Please input the Indikativ Präsens_du of the word'
    @indikativ_praesens_du = gets.chomp.convert_german!
    puts 'Please input the Indikativ Präteritum of the word'
    @indikativ_praeteritum = gets.chomp.convert_german!
    puts 'Please input the Zweites Partizip of the word'
    @zweites_partizip = gets.chomp.convert_german!
    @time = Time.now
    self
  end

  def infintiv
    @infintiv
  end

  def infintiv=(verben)
    @infintiv = verben
  end

  def indikativ_praesens_du
    @indikativ_praesens_du
  end

  def indikativ_praeteritum
    @indikativ_praeteritum
  end

  def zweites_partizip
    @zweites_partizip
  end

  def chinese
    @chinese
  end

  def right
    @right += 1
  end

  def wrong
    @wrong += 1
  end
end


class String

  def convert_german!
  # Change the german world like '\a' into 'ä'.
      while change_mark = self.index("\\")
        case self[change_mark + 1]
        when "a" then self[change_mark, 2] = "ä"
        when "A" then self[change_mark, 2] = "Ä"
        when "o" then self[change_mark, 2] = "ö"
        when "O" then self[change_mark, 2] = "Ö"
        when "u" then self[change_mark, 2] = "ü"
        when "U" then self[change_mark, 2] = "Ü"
        when "s"||"S" then self[change_mark, 2] = "ß"
        else puts "wrongword!"
          return self
        end
      end
      return self
  end

  def long_tab
    (self.length < 8) ? self + "\t\t" : self + "\t" 
  end

  def black
    "\e[30m" + self
  end

  def red
    "\e[31m" + self
  end

  def green
    "\e[32m" + self
  end

  def yellow
    "\e[33m" + self
  end

  def blue
    "\e[34m" + self
  end

  def purple
    "\e[35m" + self
  end

  def light_blue
    "\e[36" + self
  end

  def grey
    "\e[37m" + self
  end
end

