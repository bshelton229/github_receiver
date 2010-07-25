require 'rubygems'
require 'json'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, YAML::load_file(File.expand_path('../config.yml',__FILE__))['database']['uri'])

class Log
  include DataMapper::Resource
  property :id, Serial
  property :message, Text
  property :branch, String
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

  Log.create :message => data, :branch => data['ref'].split('/')[2]
  @data = data
  erb :response
end
