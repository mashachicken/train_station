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
  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train = Train.new({:name => "Blue Train", :id => nil})
      train2 = Train.new({:name => "Blue Train", :id => nil})
      expect(train).to(eq(train2))
    end
  end
  describe('#save') do
    it("saves a train") do
      train = Train.new({:name => "Green Train", :id => nil})
      train.save()
      train2 = Train.new({:name => "Blue Train", :id => nil})
      train2.save()
      expect(Train.all).to(eq([train, train2]))
    end
  end
  describe('.clear') do
    it("clears all trains") do
      train = Train.new({:name => "Green Train", :id => nil})
      train.save()
      train2 = Train.new({:name => "Blue Train", :id => nil})
      train2.save()
      Train.clear
      expect(Train.all).to(eq([]))
    end
  end
  describe('.find') do
    it("finds a train by id") do
      train = Train.new({:name => "Green Train", :id => nil})
      train.save()
      train2 = Train.new({:name => "Blue Train", :id => nil})
      train2.save()
      expect(Train.find(train.id)).to(eq(train))
    end
  end
  describe('#update') do
    it("updates an train by id") do
      train = Train.new({:name => "Green Train", :id => nil})
      train.save()
      train.update("Blue Train")
      expect(train.name).to(eq("Blue Train"))
    end
  end
  describe('#delete') do
  it("deletes a train by id") do
    train = Train.new({:name => "Green Train", :id => nil})
    train.save()
    train2 = Train.new({:name => "Blue Train", :id => nil})
    train2.save()
    train.delete()
    expect(Train.all).to(eq([train2]))
  end
end

end
