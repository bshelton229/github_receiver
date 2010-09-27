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
  @logs = Log.all
  erb :index
end

#Receive the POST from github and process
post '/' do
  #Save the post to the Log model
  @data = Log.create :payload => params[:payload]
  begin
    #Load the config file
    @config = YAML::load_file(File.expand_path('/etc/github_trigger.conf'))
    #Get the repo we're conerned with from the hook
    @config_repo = @config[@data.repo]
    if @config_repo

      #Find the system git command
      @git = `which git`.chomp!

      #Run the git pull in the directory specified from the config file
      @data.git_response = `cd #{@config_repo['dir']}; #{@git} pull`
      #@data.update(:git_response => git_response)
      
      #Try commands
      # if @repo['post_command']
      #   post_command = `#{@repo['post_command']}`
      #   @data.update(:post_command => post_command)
      # end
      
      @data.save
    end
  rescue
    @config = false
  end   
  #Output
  "payload received"
end
