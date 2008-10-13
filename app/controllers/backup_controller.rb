require 'net/pop'

class BackupController < ApplicationController
  def index
    Net::POP3.start('pop.gmail.com', 995,
                'worldracketeeringsquad@gmail.com', 'sylvia69') do |email|
    end
  end
end
