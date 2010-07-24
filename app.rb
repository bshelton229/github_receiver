require 'rubygems'
require 'json'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, YAML::load_file(File.expand_path('../database.yml',__FILE__))['uri'])

class Log
  include DataMapper::Resource
  property :id, Serial
  property :message, Text
end

#This will automatically add the table
DataMapper.auto_upgrade!

get '/' do
  erb :index
end

post '/' do
  begin
    data = JSON.parse(params[:payload])
  rescue
    data = params[:payload]
  end
  Log.create(:message => data)
  @data = data
  erb :response
end
