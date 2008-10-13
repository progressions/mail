class Backup < ActionMailer::Base
  def receive(mail)
    File.open("public/mail.mbox", File::CREAT|File::APPEND|File::WRONLY) do |file|
      file.puts mail
    end
  end
end
