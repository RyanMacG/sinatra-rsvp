require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

class App < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api' do
    get '/health' do
      json message: 'The Application is running'
    end
  end
end
