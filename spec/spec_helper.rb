require 'rack/test'
require 'rspec'
require 'sequel'

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../app.rb', __FILE__

db_config = {
  adapter: 'postgres',
  default_schema: 'public',
  user: ENV['DATABASE_USER'],
  password: ENV['DATABASE_PASSWORD'],
  host: ENV['DATABASE_HOST'],
  database: "wedding_#{ENV['RACK_ENV']}",
  max_connections: 5
}

Sequel.connect(db_config.merge(database: 'root')) do |db|
  db.execute "DROP DATABASE IF EXISTS #{db_config[:database]}"
  db.execute "CREATE DATABASE #{db_config[:database]}"
end

DB = Sequel.connect(db_config)

Sequel.extension :migration, :core_extensions, :pg_json
Sequel::Model.plugin :json_serializer
Sequel::Migrator.run(DB, './db/migrations')

require File.expand_path '../../models/rsvp.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure { |c| c.include RSpecMixin }
