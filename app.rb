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
      rsvps = DB[:rsvps].select(:name, :dietary)
      json rsvps.all
    end

    get '/rsvps/:access_key' do
      rsvp = get_rsvp(access_key: params[:access_key])

      if rsvp
        json rsvp
      else
        status 404
        json message: 'the rsvp was not found'
      end
    end
  end

private
  def get_rsvp(access_key:)
    rsvps = DB[:rsvps].select(:name, :dietary, :access_key)
    rsvps.first(access_key: access_key)
  end
end
