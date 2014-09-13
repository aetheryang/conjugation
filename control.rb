class Control 

  def continue?
    puts "continue?".red + "".grey
    gets
  end

  def clear
    30.times { puts "\n" }
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
        file.each_line { |line| @@all_word << Verben.new.get_from_s!(line) }
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
    when "0"  # exit
      exit!
    when "1"  # new
      verben = Verben.new
      puts 'Please input the Infintiv of the word'
      verben.infintiv = gets.chomp.convert_german!
      verben.word_change!
      verben.init_data!
      @@all_word << verben
    when "2"  # delete
      puts 'Please input the num of the word to delete!'
      num = gets.chomp.to_i
      word_delete(num)
    when "3"  # show all
      show_all
    when "4"  # show by num
      puts 'Please input the num of the word'
      verben = search_by_num(gets.chomp.to_i)
      puts num.to_s + "\t" + verben.to_s if verben
      continue?
    when "5"  # look back
      look_back
    end
  end

  def exit!
    File.open(@filename,"wt+") do |file|
      @@all_word.each { |verben| file.puts verben.out }
    end
    puts "okey~bye!".red
    `rm #@filename~`
    exit
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
      out_put=counter.to_s + "\t" + verben.to_s
      if counter % 2 == 1
        puts out_put.green
      else
        puts  out_put.yellow
      end
        counter += 1
    end
    puts "".grey
    continue?
  end

  def search_by_num(num)
    @@all_word[num] or puts "There is no word by num" + "#{num}".yellow + "".grey
  end

  def look_back
    0.upto(@@all_word.size) do |num|
      clear
      verben = search_by_num(num)
      break if verben == nil
      puts verben.infintiv.purple + "".grey
      answer = verben.clone
      answer.word_change!
      puts verben.to_s.blue
      out_put = verben.infintiv.blue
      right_answer = verben.infintiv.blue
      resault = 
        if answer.indikativ_praesens_du == verben.indikativ_praesens_du
          out_put += "\t" + answer.indikativ_praesens_du.green
          right_answer += "\t" + verben.indikativ_praesens_du.green
          verben.right
          1
        else
          out_put += "\t" + answer.indikativ_praesens_du.red
          right_answer += "\t" + verben.indikativ_praesens_du.purple
          verben.wrong
          0
        end
      resault +=
        if answer.indikativ_praeteritum == verben.indikativ_praeteritum
          out_put += "\t" + answer.indikativ_praeteritum.green
          right_answer += "\t" + verben.indikativ_praeteritum.green
          verben.right
          1
        else
          out_put += "\t" + answer.indikativ_praeteritum.red
          right_answer += "\t" + verben.indikativ_praeteritum.purple
          verben.wrong
          0
        end
      resault +=
        if answer.zweites_partizip == verben.zweites_partizip
          out_put += "\t" + answer.zweites_partizip.green
          right_answer += "\t" + verben.zweites_partizip.green
          verben.right
          1
        else
          out_put += "\t" + answer.zweites_partizip.red
          right_answer += "\t" + verben.zweites_partizip.purple
          verben.wrong
          0
        end
      puts out_put + "".grey
      puts right_answer + "".grey
      verben.change_time! if resault == 3
      next_chose = continue?.chomp    # FIXME dont know weather ok
      case next_chose
      when "delete" then 
        word_delete(num)
      when "q", "Q", "exit", "quit" then break
      end
    end
    @@all_word.sort_by { |verben| verben.counter }
  end
end

