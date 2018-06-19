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
      json Rsvp.select(:name, :dietary)
    end

    get '/rsvps/:access_key' do
      rsvp = get_rsvp(access_key: params[:access_key])

      if rsvp
        rsvp.to_json(except: %i[id])
      else
        status 404
        json message: 'the rsvp was not found'
      end
    end

    put '/rsvps/:access_key' do
      rsvp = get_rsvp(access_key: params[:access_key])

      if rsvp
        rsvp.update(dietary: params[:dietary], attending: params[:attending])
        rsvp.update(guest_details: Sequel.pg_json(params[:guest_details])) if rsvp.extra_guests?

        rsvp.to_json(except: %i[id guests])
      else
        status 404
        json message: 'the rsvp was not found'
      end
    end
  end

  private

  def get_rsvp(access_key:)
    Rsvp.where(access_key: access_key).first
  end
end
