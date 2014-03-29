class Phrase
    # A word should like this :num  phrase,speech;appendix1;appendix2;appendix3;means;remark
	def self.num
        @@num
	end
	def self.num=(num)
        @@num = num
	end
	def wnum
        @wnum
	end
	def phrase
        @phrase
	end
    def speech
        @speech
    end
    def initialize(str)
        @wnum=str[0].to_i
        @phrase=str[1]
        @speech=str[2]
        @appendix1=str[3]
        @appendix2=str[4]
        @appendix3=str[5]
        @means=str[6]
        @remark=str[7]
        @right=str[8].to_i
        @wrong=str[9].to_i
        @@num += 1
	end
    def read (ans)
        if ans	== 1
            @right += 1
        else
	        @wrong += 1
		end
		all += 1
	end
	def fwrite (file)
		cut = "&"
        appendix=@speech+cut+@appendix1+cut+@appendix2+cut+@appendix3+cut+@means+cut+@remark
        str =@wnum.to_s+cut+@phrase+cut+appendix+cut+@right.to_s+cut+@wrong.to_s+"\n"
        file.write(str)
    end
    def show_all
        str="#{@wnum}\t\t#@phrase\t\t#@means\n"
    end
    def show
        cut="\t"
        str="num\tphrase\t\tspeech\tapp1\tapp2\tapp3\tmeans\t\tremark\tright\twrong"
        puts str
        appendix=@speech+cut+@appendix1+cut+@appendix2+cut+@appendix3+cut+@means+cut+cut+@remark
        str =@wnum.to_s+cut+@phrase+cut++cut+appendix+cut+@right.to_s+"\t"+@wrong.to_s+"\n"
        puts str
    end
end

class String
    def click
        while letter=self.index("\\")
            if self[letter + 1] == "a"
                self[letter,2]= "ä"
			elsif self[letter + 1] == "A"
                self[letter,2] = "Ä"
			elsif self[letter + 1] == "o"
                self[letter,2] = "ö"
			elsif self[letter + 1] == "O" 
                self[letter,2] = "Ö"
			elsif self[letter + 1] == "u" 
                self[letter,2] = "ü"
			elsif self[letter + 1] == "U" 
                self[letter,2] = "Ü"
			elsif self[letter + 1] == "s" || self[letter + 1] == "S"
                self[letter,2] = "ß"
			else
			puts "wrongword!"
            return self
            end
        end
        return self
    end 
end
