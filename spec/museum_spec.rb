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
  let(:patron_3) { Patron.new("Johnny", 5) }

  before do
    patron_1.add_interest("Dead Sea Scrolls")
    patron_1.add_interest("Gems and Minerals")
    patron_2.add_interest("IMAX")
    patron_3.add_interest("Dead Sea Scrolls")
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
      expect(dmns.recommended_exhibits(patron_2)).to eq([imax])
    end
  end

  describe '#patrons' do
    it 'starts with no #patrons' do
      expect(dmns.patrons).to eq([])
    end

    it 'can #admin patrons' do
    dmns.admit(patron_1)
    dmns.admit(patron_2)
    dmns.admit(patron_3)
    expect(dmns.patrons).to eq([patron_1, patron_2, patron_3])
    end
  end

  describe '#patrons_by_exhibit_interest' do
    before do
      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)
    end

    xit 'can return a hash with exhibit keys and values of patrons interested' do
      expected_hash = {
        gems_and_minerals => [patron_1],
        dead_sea_scrolls => [patron_1, patron_3],
        imax => [patron_2]
      }
      expect(dmns.patrons_by_exhibit_interest).to eq(expected_hash)
    end
  end

  describe '#ticket_lottery_contestants' do
    before do
      dmns.admit(patron_1)
      dmns.admit(patron_2)
      dmns.admit(patron_3)
    end

    it 'returns an array of customers with interest but not enough money' do
      expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq([patron_1, patron_3])
    end
  end
end