require 'json'
require 'yaml'
require 'dm-core'
require 'dm-migrations'
require 'dm-types'
require 'dm-timestamps'

#Set up the datamapper database connection
DataMapper.setup(:default, YAML::load_file(File.expand_path('../config.yml',__FILE__))['database']['uri'])

#Load our DataMapper models
Dir[File.expand_path('../models/*.rb',__FILE__)].each {|f| require f }

#This will automatically add the table and run any schema changes
DataMapper.auto_upgrade!

#Root path
get '/' do
  "Github Trigger"
end

#Receive the POST from github and process
post '/' do
  #Save the post to the Log model
  @data = Log.create :payload => params[:payload]
  
  begin
    @config = YAML::load_file(File.expand_path('/etc/github_trigger.conf'))
    @config_repo = @config[@data.repo]
    if @config_repo
      @git = `which git`.chomp!
      system "cd #{@config_repo['dir']}; #{@git} pull origin master"
    end
  rescue
    @config = false
  end
   
  #Output
  "payload received"
end
