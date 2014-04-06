class Control 
    @@all_word=[]
    def continue?
        puts "continue?"
        gets
    end
    def clear
        puts "\n"*30
    end
    def initialize()
        getfilename
        readfile
    end
    def getfilename
        pwd=`pwd`.split("/")
        @filename="/"+pwd[1]+"/"+pwd[2]+"/.dict/wordlist.txt"
        @filename="wordlist.txt"
    end
    def readfile
        if 0
        if File.exist?(@filename)
            File.open(@filename) do |file|
                file.each_line do |line|
                    str=line.chomp
                    str=str.split("&")
                    @word=Phrase.new(str)
                    @@all_word<<@word
                end
            end
        else
            puts @filename+"doesn't exist"
        end
    end
    end
    def word_first
        clear
        puts "0. Quit"
        puts "1. Write in a new phrase"
        puts "5. Delete a phrase"
        puts "6. Show by num"
        puts "7. Show all"
        puts "8. Look back a word"
        @ct = gets
    end
    def next
        case @ct.chomp
        when "0"
            File.open(@filename,"wt+") do |file|
                @@all_word.each do |word|
                    word.fwrite(file)
                end
            end
            puts "okey~bye!"
            exit
        when "1"
            word_new
        when "2"
            puts "Please input the num"
            num=gets.to_i
            word_change(num)
        when "5"
            puts "Please input the num"
            num=gets.to_i
            word=word_search_num(num)
            if word!=nil
                @@all_word.delete(word)
                puts "Delete succese!"
        continue?
            end
        when "6"
            puts "Please input the num"
            num=gets.to_i
            word=word_search_num(num)
        continue?
        when "7"
            show_all
        when "8"
            lookback
        end
    end

    def word_new
        puts "what phrase is?"
        str=[]
        str<<Phrase.num
        phrase = gets.chomp.click
        str<<phrase
        puts "Please input the part of speech"
        speech=gets.chomp
        str<<speech
        puts 'Please input the appendix1'
        app1=gets.chomp
        str<<app1
        puts 'Please input the appendix2'
        app2=gets.chomp.click
        str<<app2
        puts 'Please input the appendix3'
        app3=gets.chomp.click
        str<<app3
        puts 'Please input the meaning'
        means=gets.chomp
        str<<means
        puts "Please input the remark"
        remark=gets.chomp
        str<<remark
        str<<0
        str<<1
        str<<Time.now
        word=Phrase.new(str)
        @@all_word<<word
        if word!=nil
            clear
            puts "DONE!"
            word.show
        end
        continue?
    end
    def show_all
        clear
        puts "phrase\t\tspeech\t\tappendix1\t\tappendix2\t\tappendix3\t\tmeans"
        @@all_word.each do |x|
            puts x.show_all
        end
        continue?
    end
    def word_search_num(num)
        ct=0
        @@all_word.each do |word|
            if word.wnum==num
                clear
                word.show
                return word
            end
        end
        puts "There is no word by num #{num}"
    end
    def get
        time=Time.now
        @@all_word.find do |word|
            word.value(time)<50
        end
    end
    def lookback
        loop do
            word=get()
            puts word.phrase
            puts "Know?"
            c=gets.chomp
            if c=="y" ||c==""
                re=1
            else
                re=0
            end
            word.look(re)
            c.show_all
            c=continue?.chomp
            if c=="q"||c=="n"
                break
            end
        end
    end
end
