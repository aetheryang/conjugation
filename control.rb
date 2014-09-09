class Control 

  def continue?
    puts "continue?"
    gets
  end

  def clear
    30.times{ puts "\n" }
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
    puts "5. Look back words"
  end

  def make_chose
    case gets.chomp
    when "0"
      exit!
    when "1"
      word_new
    when "2"
      puts 'Please input the num of the word to delete!'
      num = gets.chomp.to_i
      word_delete(num)
    when "3"
      show_all
    when "4"
      puts 'Please input the num of the word'
      show_by_num(gets.chomp.to_i)
    when "5"
      look_back
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

  def word_delete(num)
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
  end

  def look_back
    1.upto(@@all_word.size) do |num|
      clear
      show_by_num(num)
      answer = gets.chomp
      case answer
      when "delete" then 
        word_delete(num)
      when "q", "Q", "exit", "quit" then break
      end
    end
    continue?
  end

end

