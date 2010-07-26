require 'json'
require 'dm-core'
require 'dm-migrations'
require 'dm-types'

#Load DataMapper
DataMapper.setup(:default, YAML::load_file(File.expand_path('../config.yml',__FILE__))['database']['uri'])

class Log
  include DataMapper::Resource
  property :id, Serial
  property :payload, Json
  property :repo, String
  property :branch, String

  
  before :save, :load_data
  
  #Set the branch
  def load_data
    self.branch = self.payload['ref'].split('/')[2]
    self.repo = self.payload['repository']['name']
  rescue
    self.branch = nil
    self.repo = nil
  end
  
end

#This will automatically add the table
DataMapper.auto_upgrade!

post '/' do
  @data = Log.create :payload => params[:payload]
  "payload received"
end
