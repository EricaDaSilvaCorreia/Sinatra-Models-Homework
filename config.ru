require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/contrib'
require 'pg'
require_relative './Models/Books.rb'
require_relative './controllers/page_controller.rb'

use Rack::Reloader
use Rack::MethodOverride

run App
