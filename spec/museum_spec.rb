require './lib/patron'
require './lib/exhibit'
require './lib/museum'
require 'pry'

RSpec.describe Museum do
  let(:dmns) { Museum.new('Denver Museum of Nature and Science') }
  let(:dead_sea_scrolls) { Exhibit.new({name: "Dead Sea Scrolls", cost: 10}) }
  let(:gems_and_minerals) { Exhibit.new({name: "Gems and Minerals", cost: 0}) }
  let(:imax) { Exhibit.new({name: "IMAX", cost: 15}) }
  let(:patron_1) { Patron.new("Bob", 20) }
  let(:patron_2) { Patron.new("Sally", 20) }

  before do
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("IMAX")
  end

  describe '#intialize' do
    it 'exists' do
      expect(dmns).to be_a(Museum)
    end

    it 'has attributes' do
      expect(dmns.name).to eq("Denver Museum of Nature and Science")
      expect(dmns.exhibits).to eq([])
    end
  end

  describe '#add_exhibit' do
    before do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
    end
  
    it 'can add an exhibit' do
      expect(dmns.exhibits).to eq([gems_and_minerals, dead_sea_scrolls, imax])
    end
  end

  describe '#recommended_exhibits' do
    before do
      dmns.add_exhibit(gems_and_minerals)
      dmns.add_exhibit(dead_sea_scrolls)
      dmns.add_exhibit(imax)
    end

    it 'can recommend exhibits to patrons with matching interests' do
      expect(dmns.recommended_exhibits(patron_1)).to eq([gems_and_minerals, dead_sea_scrolls])
      binding.pry
      expect(dmns.recommended_exhibits(patron_2)).to eq([imax])
    end
  end

end