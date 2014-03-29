pwd=`pwd`.split("/")
filename="/"+pwd[1]+"/"+pwd[2]+"/.dict/wordlist.txt"
puts "rm "+filename
`rm #{filename}`
