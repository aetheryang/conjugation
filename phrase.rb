# This file afford the lib of the way to handle a word
# e.g. change \a to ä

class Verben  # verbs

  attr_accessor :infintiv, :indikativ_praesens_du, :indikativ_praeteritum, :zweites_partizip, :right, :wrong, :time

  def to_s
    tab = "\t"
    @infintiv + tab + @indikativ_praesens_du + tab + @indikativ_praeteritum
  end

  def out
    cut = "&"
    @infintiv + cut + @indikativ_praesens_du + cut + @indikativ_praeteritum \
      + cut + @right.to_s + cut + @wrong.to_s + cut + time
  end

  def get_from_s(str)
    verben_s = str.chomp.split("&")
    verben = Verben.new
    @infintiv = verben_s[0]
    @indikativ_praesens_du = verben_s[1]
    @indikativ_praeteritum = verben_s[2]
    @zweites_partizip = verben_s[3]
    @right = verben_s[4]
    @wrong = verben_s[5]
    @time = verben_s[6]
    verben
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

