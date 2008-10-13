class BackupController < ApplicationController
  def index    
  end
  
  def fetch
    @fetcher = Fetcher::Pop.new(:ssl => (params[:ssl]=="1"), :server => params[:server], :username => params[:username], :password => params[:password], :receiver => Backup)
    @fetcher.fetch
  end
end
