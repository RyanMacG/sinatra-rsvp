require 'sinatra/base'
require 'sinatra/json'

class App < Sinatra::Base
  get '/' do
    json message: 'Hello the app is running'
  end
end
