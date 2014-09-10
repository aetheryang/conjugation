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
    pwd = `pwd`.split("/")
    # two way of file 
    # OPTIMIZE need to mkdir .reciteword first
    @filename = "/" + pwd[1] + "/" + pwd[2] + "/.reciteword/wordlist.txt"
    # OPTIMIZE if a packed program del the next line
    @filename = "wordlist.txt"
    readfile
  end

  def readfile
    if File.exist?(@filename)
      `cp #@filename #@filename~`
      File.open(@filename) do |file|
        file.each_line { |line| @@all_word << Verben.new.get_from_s(line) }
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
    puts "5. Test"
  end

  def make_chose
    case gets.chomp
    when "0"
      exit!
    when "1"
      verben = Verben.new
      puts 'Please input the Infintiv of the word'
      verben.infintiv = gets.chomp.convert_german!
      word_change!(verben)
      verben.init_data
      @@all_word << verben
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
      @@all_word.each { |verben| file.puts verben.out }
    end
    puts "okey~bye!"
    `rm #@filename~`
    exit
  end

  def word_change!(verben)
    puts 'Please input the Indikativ Präsens_du of the word'
    verben.indikativ_praesens_du = gets.chomp.convert_german!
    puts 'Please input the Indikativ Präteritum of the word'
    verben.indikativ_praeteritum = gets.chomp.convert_german!
    puts 'Please input the Zweites Partizip of the word'
    verben.zweites_partizip = gets.chomp.convert_german!
    verben
  end

  def word_delete(num)
    if @@all_word[num]
      puts "going to delete the blow word, are you sure? (y/n)"
      puts num.to_s + "\t" + @@all_word[num].to_s   # OPTIMIZE maybe .to_s is not need
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
    @@all_word.each do |verben|
      puts counter.to_s + "\t" + verben.to_s
      counter += 1
    end
    continue?
  end

  def show_by_num(num)
    if @@all_word[num]
      puts num.to_s + "\t" + @@all_word[num].to_s
      @@all_word
    else
      puts "There is no word by num #{num}"
      nil
    end
  end

  def look_back
    0.upto(@@all_word.size) do |num|
      clear
      verben = show_by_num(num)
      answer = verben.clone
      word_change(answer)
      if answer eql? verben
        puts "right"
        verben.right += 1
      else
        puts "wrong"
        verben.wrong += 1
      end
      next_chose = continue?.chomp    # FIXME dont know weather ok
      case next_chose
      when "delete" then 
        word_delete(num)
      when "q", "Q", "exit", "quit" then break
      end
    end
    continue?
  end
end

