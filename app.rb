require 'rubygems'
require 'json'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-types'

DataMapper.setup(:default, YAML::load_file(File.expand_path('../config.yml',__FILE__))['database']['uri'])

class Log
  include DataMapper::Resource
  property :id, Serial
  property :payload, Json
  property :branch, String
end

#This will automatically add the table
DataMapper.auto_upgrade!

post '/' do

  @data = Log.create :payload => params[:payload]
  
  erb :response
end
