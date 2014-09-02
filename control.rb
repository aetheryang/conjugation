class Control 

  def continue?
    puts "continue?"
    gets
  end

  def clear
    puts "\n" * 30
  end

  def initialize()
    # TODO so ,change the counter from 0 to 1
    # title = 'num' + "\t" + 'word'
    # @@all_word << title
    @@all_word = []
    get_filename
    readfile
  end

  def get_filename
    pwd = `pwd`.split("/")
    # two way of file 
    # FIXME need to mkdir .reciteword first
    @filename = "/" + pwd[1] + "/" + pwd[2] + "/.reciteword/wordlist.txt"
    # FIXME if a packed program del the next line
    @filename = "wordlist.txt"
  end

  def readfile
    if File.exist?(@filename)
      `cp #@filename #@filename~`
      File.open(@filename) do |file|
        file.each_line { |line| @@all_word << line.chomp }
      end
    else
        puts @filename + "doesn't exist!"
    end
  end

  def run
    chose_list
    make_chose
  end

  def chose_list
    clear
    puts "0. Quit"
    puts "1. Write in a new world"
    puts "2. Delete a world"
    puts "3. Show all"
    puts "4. Show by num"
    puts "5. Look back a word"
  end

  def make_chose
    case gets.chomp
    when "0"
      exit!
    when "1"
      word_new
    when "2"
    when "3"
      show_all
    when "4"
      show_by_num
    when "5"
    end
  end

  def exit!
    File.open(@filename,"wt+") do |file|
      @@all_word.each { |word| file.puts word }
    end
    puts "okey~bye!"
    `rm #@filename~`
    exit
  end

  def word_new
    puts 'Please input the new word'
    new_word = gets.chomp.convert_german!
    @@all_word << new_word
  end
# TODO delete
  def show_all
    clear
    counter=0
    @@all_word.each do |word|
      puts counter.to_s + "\t" + word
      counter += 1
    end
    continue?
  end
# TODO
  def show_by_num
    puts 'Please input the num of the word'
    num = gets.chomp.to_i
    if @@all_word[num]
      puts num.to_s + "\t" + @@all_word[num]
    else
      puts "There is no word by num #{num}"
    end
    continue?
  end
# TODO
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

