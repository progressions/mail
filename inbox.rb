require 'secure_pop'

puts "About to fetch mail."

Net::POP3.start('pop.gmail.com', 995,
                'worldracketeeringsquad@gmail.com', 'sylvia69') do |pop|
  puts "Fetching mail..."
  
  if pop.mails.empty?
    puts 'No mail.'
  else
    i = 0
    
    puts "Mailbox has mail in it..."
    pop.each_mail do |m|   # or "pop.mails.each ..."
      puts "Getting one mail"
      File.open("inbox/#{i}", 'w') do |f|
        f.write m.pop
      end
      # m.delete
      i += 1
    end
    puts "#{pop.mails.size} mails popped."
  end
end