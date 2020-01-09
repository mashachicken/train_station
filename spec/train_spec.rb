require 'rspec'
require 'train'
require 'citty'
require 'pry'
require 'spec_helper'

describe '#Train' do
  before(:each) do
    Train.clear
  end
  describe('.all') do
    it("returns an empty array when there are no trains") do
      expect(Train.all).to(eq([]))
    end
  end
end
