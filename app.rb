require('sinatra')
require('sinatra/reloader')
require('./lib/train')
require('./lib/citty')
require('pry')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "train_station"})

get('/') do
  redirect to('/trains')
end
get('/trains') do
  @trains = Train.all
  # @trains_sold = Train.all_sold
  erb(:trains)
end
get ('/trains/new') do
  erb(:new_train)
end
post ('/trains') do
  name = params[:train_name]
  train = Train.new({:name => name, :id => nil})
  train.save()
  redirect to('/trains')
end
get ('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
end
get ('/trains/:id/edit') do
  @train = Train.find(params[:id].to_i())
  erb(:edit_train)
end
patch ('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  @train.update(params[:name])
  redirect to('/trains')
end
post ('/trains/:id/citties') do
  @train = Train.find(params[:id].to_i())
  citty = Citty.new({:name => params[:citty_name], :train_id => @train.id, :id => nil})
  citty.save()
  erb(:train)
end
get ('/trains/:id/citties/:citty_id') do
  @citty = Citty.find(params[:citty_id].to_i())
  erb(:citty)
end
patch ('/trains/:id/citties/:citty_id') do
  @train = Train.find(params[:id].to_i())
  citty = Citty.find(params[:citty_id].to_i())
  citty.update(params[:name], @train.id)
  erb(:train)
end
delete ('/trains/:id/citties/:citty_id') do
  citty = Citty.find(params[:citty_id].to_i())
  citty.delete
  @train = Train.find(params[:id].to_i())
  erb(:train)
end
