require 'rubygems'
require 'sinatra'

root_dir = File.dirname(__FILE__)

set :environment, ENV['RACK_ENV'].to_sym
disable :run

require File.join(root_dir,'app.rb')

run Sinatra::Application
