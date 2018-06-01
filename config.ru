require './app'

RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
set :protection, except: :json_csrf

run App
