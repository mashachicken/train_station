
require 'rspec'
require 'pg'
require 'citty'
require 'train'
require 'pry'
require 'spec_helper.rb'

describe '#Citty' do

  before(:each) do
    Train.clear
    Citty.clear
    @train = Train.new({:name => "Blue Train", :id => nil})
    @train.save()
  end
  describe('#==') do
    it("is the same citty if it has the same attributes as another citty") do
      citty = Citty.new({:name => "Portland", :train_id => @train.id, :id => nil})
      citty2 = Citty.new({:name => "Portland", :train_id => @train.id, :id => nil})
      expect(citty).to(eq(citty2))
    end
  end
  describe('.all') do
    it("returns a list of all citties") do
      citty = Citty.new({:name => "Clackamas", :train_id => @train.id, :id => nil})
      citty.save()
      citty2 = Citty.new({:name => "Portland", :train_id => @train.id, :id => nil})
      citty2.save()
      expect(Citty.all).to(eq([citty, citty2]))
    end
  end
  describe('.clear') do
    it("clears all citties") do
      citty = Citty.new({:name => "Hillsboro", :train_id => @train.id, :id => nil})
      citty.save()
      citty2 = Citty.new({:name => "Gresham", :train_id => @train.id, :id => nil})
      citty2.save()
      Citty.clear()
      expect(Citty.all).to(eq([]))
    end
  end
  describe('#save') do
    it("saves a citty") do
      citty = Citty.new({:name => "Portland", :train_id => @train.id, :id => nil})
      citty.save()
      expect(Citty.all).to(eq([citty]))
    end
  end
  describe('.find') do
    it("finds a citty by id") do
      citty = Citty.new({:name => "Giant Steps", :train_id => @train.id, :id => nil})
      citty.save()
      citty2 = Citty.new({:name => "Naima", :train_id => @train.id, :id => nil})
      citty2.save()
      expect(Citty.find(citty.id)).to(eq(citty))
    end
  end
  describe('#update') do
    it("updates citty by id") do
      citty = Citty.new({:name => "Portland", :train_id => @train.id, :id => nil})
      citty.save()
      citty.update("Beaverton", @train.id)
      expect(citty.name).to(eq("Beaverton"))
    end
  end
  describe('#delete') do
    it("deletes a citty by id") do
      citty = Citty.new({:name => "Giant Steps", :train_id => @train.id, :id => nil})
      citty.save()
      citty2 = Citty.new({:name => "Naima", :train_id => @train.id, :id => nil})
      citty2.save()
      citty.delete()
      expect(Citty.all).to(eq([citty2]))
    end
  end
  describe('.find_by_train') do
    it("finds citties for a train") do
      train2 = Train.new({:name => "Green Train", :id => nil})
      train2.save
      citty = Citty.new({:name => "Pdx", :train_id => @train.id, :id => nil})
      citty.save()
      citty2 = Citty.new({:name => "Gresham", :train_id => train2.id , :id => nil})
      citty2.save()
      expect(Citty.find_by_train(train2.id)).to(eq([citty2]))
    end
  end
  describe('#train') do
    it("finds the train a citty belongs to") do
      citty = Citty.new({:name => "Clackamas", :train_id => @train.id, :id => nil})
      citty.save()
      expect(citty.train()).to(eq(@train))
    end
  end
end
