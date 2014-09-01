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
    if File.exist?(@filename)
      `cp #@filename #@filename~`
      File.open(@filename) do |file|
        file.each_line do |line|
          str=line.chomp
          # HACK need to change ! ## REVIEW OPTIMIZE
          str=str.split("&")
          @word=Phrase.new(str)
          @@all_word<<@word
        end
      end
    else
        puts @filename+"doesn't exist!"
    end
  end

  def chose_list
    clear
    puts "0. Quit"
    puts "1. Write in a new world"
    puts "2. Delete a world"
    puts "3. Show all"
    puts "4. Show by num"
    puts "8. Look back a word"
    @countral_num = gets
  end

  def make_chose
    case @countral_num.chomp
    when "0"
      File.open(@filename,"wt+") do |file|
        @@all_word.each do |word|
          word.fwrite(file)
        end
      end
      puts "okey~bye!"
      `rm #@filename~`
      exit
    when "1"
      word_new
    when "2"
    when "3"
    when "4"
    when "5"
    end
  end

  def word_new
  end

  def show_all
    clear
    continue?
  end

  def word_search_num(num)
    puts "There is no word by num #{num}"
  end

  def get_time
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

