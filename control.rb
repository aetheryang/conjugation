class Control 

  def continue?
    puts "continue?"
    gets
  end

  def clear
    puts "\n" * 30
  end

  def initialize()
    @@all_word = []
    get_filename
    readfile
  end

  def get_filename
    pwd = `pwd`.split("/")
    # two way of file 
    # OPTIMIZE need to mkdir .reciteword first
    @filename = "/" + pwd[1] + "/" + pwd[2] + "/.reciteword/wordlist.txt"
    # OPTIMIZE if a packed program del the next line
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
    puts "1. Write in a new word"
    puts "2. Delete a word"
    puts "3. Show all"
    puts "4. Show by num"
    puts "5. Show word by word"
    puts "6. Look back a word"
  end

  def make_chose
    case gets.chomp
    when "0"
      exit!
    when "1"
      word_new
    when "2"
      word_del
    when "3"
      show_all
    when "4"
      puts 'Please input the num of the word'
      show_by_num(gets.chomp.to_i)
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

  def word_del
    puts 'Please input the num of the word to delete!'
    num = gets.chomp.to_i
    if @@all_word[num]
      puts "going to delete the blew word, are you sure? (y/n)"
      puts num.to_s + "\t" + @@all_word[num]
      if ['y', 'Y'].include?(gets.chomp)
        @@all_word.delete_at(num)
        puts 'Done!'
      else
        puts 'never mind'
      end
    else
      puts "There is no word by num #{num}"
    end
    continue?
  end

  def show_all
    clear
    counter=0
    @@all_word.each do |word|
      puts counter.to_s + "\t" + word
      counter += 1
    end
    continue?
  end

  def show_by_num(num)
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

