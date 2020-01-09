require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require('pry')
also_reload('lib/**/*.rb')
require('./lib/song')
require("pg")

DB = PG.connect({:dbname => "train_station"})
