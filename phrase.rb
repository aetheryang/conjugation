# This file afford the lib of the way to handle a word
# e.g. change \a to ä

class Verben  # verbs

  def init_data
    @right = 0
    @wrong = 1
    @time = Time.now
  end

  def to_s
    tab = "\t"
    @infintiv + tab + @indikativ_praesens_du + tab + @indikativ_praeteritum + tab + @zweites_partizip
  end

  def out
    cut = "&"
    @infintiv + cut + @indikativ_praesens_du + cut + @indikativ_praeteritum + cut + @zweites_partizip \
      + cut + @right.to_s + cut + @wrong.to_s + cut + @time.to_s
  end

  def get_from_s(str)
    verben_s = str.chomp.split("&")
    puts verben_s
    @infintiv = verben_s[0]
    @indikativ_praesens_du = verben_s[1]
    @indikativ_praeteritum = verben_s[2]
    @zweites_partizip = verben_s[3]
    @right = verben_s[4].to_i
    @wrong = verben_s[5].to_i
    @time = verben_s[6]
    self
  end

  def word_change!
    puts 'Please input the Indikativ Präsens_du of the word'
    @indikativ_praesens_du = gets.chomp.convert_german!
    puts 'Please input the Indikativ Präteritum of the word'
    @indikativ_praeteritum = gets.chomp.convert_german!
    puts 'Please input the Zweites Partizip of the word'
    @zweites_partizip = gets.chomp.convert_german!
    self
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

end

