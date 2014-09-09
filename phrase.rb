# This file afford the lib of the way to handle a word
# e.g. change \a to ä

class Verben  # verbs

  attr_writer:
    infintiv,
    indikativ_praesens_du,
    indikativ_praeteritum,
    zweites_partizip,
    time,
    right,
    wrong

  def to_s
    tab = "\t"
    @infintiv + tab + @indikativ_praesens_du + tab + @indikativ_praeteritum
  end

  def equal?(verben)  # maby just use eql?
    if verben.class == Verben
      if
        verben.@infintiv == self.@infintiv ||
        verben.@indikativ_praesens_du == self.@indikativ_praesens_du ||
        verben.@indikativ_praeteritum == self.@indikativ_praeteritum
      then
        true
      else
        nil
      end
    else
      nil
    end
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

