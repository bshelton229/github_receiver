require 'rubygems'

#Bundler
require 'bundler'
Bundler.setup


require 'json'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-types'

#Load DataMapper
DataMapper.setup(:default, YAML::load_file(File.expand_path('../config.yml',__FILE__))['database']['uri'])

class Log
  include DataMapper::Resource
  property :id, Serial
  property :payload, Json
  property :branch, String
  
  before :save, :fix_branch
  
  #Set the branch
  def fix_branch
    self.branch = self.payload['ref'].split('/')[2]
  rescue
    self.branch = nil
  end
  
end

#This will automatically add the table
DataMapper.auto_upgrade!

post '/' do

  @data = Log.create :payload => params[:payload]
  
  #erb :response
  "payload received"
end
