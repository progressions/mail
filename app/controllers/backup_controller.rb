require 'vendor/secure_pop'
require 'digest/sha1'

class BackupController < ApplicationController
  def index
  end
  
  def fetch
#    if (params[:server] && params[:port] && params[:username] && params[:password] && params[:ssl])
    begin
      @server = params[:server]
      @port = params[:port].to_i
      @username = params[:username]
      @password = params[:password]
      @ssl = (params[:ssl] == "1")
          
      @connection = Net::POP3.new(@server, @port)
      @connection.enable_ssl(OpenSSL::SSL::VERIFY_NONE) if @ssl
      @connection.start(@username, @password)
      
      @count = 0
      # @error = false
      
      @filename = Digest::SHA1.hexdigest("--#{@username}--") + ".mbox"
      
      unless @connection.mails.empty?
        File.open("public/#{@filename}", File::CREAT|File::TRUNC|File::WRONLY) do |file|
          @connection.each_mail do |msg|
            begin       
              mail = TMail::Mail.parse(msg.pop)
              mail.base64_decode         
              file.write mail
              @count += 1
            end
            # Delete message from server
            msg.delete
          end
        end
      end
    
      @connection.finish
  
    #rescue 
      
    end
  end    
end
