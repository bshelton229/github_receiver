require 'json'
require 'dm-core'
require 'dm-migrations'
require 'dm-types'

#Load DataMapper
DataMapper.setup(:default, YAML::load_file(File.expand_path('../config.yml',__FILE__))['database']['uri'])

#Load our DataMapper models
Dir[File.expand_path('../models/*.rb',__FILE__)].each {|f| require f }

#This will automatically add the table
DataMapper.auto_upgrade!

#Receive the POST from github and process
post '/' do
  #Save the post to the Log model
  @data = Log.create :payload => params[:payload]
  
  #Perform ACTION using @data
  
  "payload received"
end
