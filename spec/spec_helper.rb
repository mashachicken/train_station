require 'rspec'
require 'pg'
require 'train'
require 'citty'
require 'pry'

DB = PG.connect({:dbname => 'train_station_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM citties *;")
  end
end
