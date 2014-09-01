# This file afford the lib of the way to handle a word
# e.g. change \a to ä

class String
  # Change the german world like '\a' into 'ä'.
  def convert_german!
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

