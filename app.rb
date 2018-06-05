require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'

class App < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api' do
    get '/health' do
      json message: 'The Application is running'
    end

    get '/rsvps' do
      json [
        {
          name: 'Foo Bar',
          dietary: '',
          access_key: 'abc123'
        },
        {
          name: 'Baz Qux and Bar Qux',
          dietary: 'Gluten free',
          access_key: 'xyz456'
        }
      ]
    end

    get '/rsvps/:access_key' do
      json_response =
        if params[:access_key] == 'abc123'
          {
            name: 'Foo Bar',
            dietary: '',
            access_key: 'abc123'
          }
        else
          {
            name: 'Baz Qux and Bar Qux',
            dietary: 'Gluten free',
            access_key: 'xyz456'
          }
        end

      json(json_response)
    end
  end
end
