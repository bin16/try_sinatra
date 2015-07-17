# $LOAD_PATH.unshift(File.dirname(__FILE__))
require 'sinatra'
require 'erb'


get '/' do
  erb:login
end

set :public, File.dirname(__FILE__) + '/static'