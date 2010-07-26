require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'


root_dir = File.dirname(__FILE__)

set :environment, ENV['RACK_ENV'].to_sym
disable :run

require File.join(root_dir,'app')

run Sinatra::Application
