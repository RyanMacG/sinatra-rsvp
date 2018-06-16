require 'sequel'
require './app'

RACK_ENV = ENV['RACK_ENV'] ||= 'development'

db_config = {
  adapter: 'postgres',
  default_schema: 'public',
  user: ENV['DATABASE_USER'],
  password: ENV['DATABASE_PASSWORD'],
  host: ENV['DATABASE_HOST'],
  database: "wedding_#{RACK_ENV}",
  max_connections: 5
}

if %w[development test].include?(ENV['RACK_ENV'])
  Sequel.connect(db_config.merge(database: 'root')) do |db|
    db.execute "DROP DATABASE IF EXISTS #{db_config[:database]}"
    db.execute "CREATE DATABASE #{db_config[:database]}"
  end
end

DB = Sequel.connect(db_config)

Sequel.extension :migration, :core_extensions, :pg_json
Sequel::Model.plugin :json_serializer
Sequel::Migrator.run(DB, './db/migrations')

run App
