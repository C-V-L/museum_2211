require './lib/patron'
require './lib/exhibit'
require './lib/museum'

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
end