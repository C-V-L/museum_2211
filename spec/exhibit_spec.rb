require 'rspec'
require './lib/exhibit'

RSpec.describe Exhibit do
  let(:exhibit) { Exhibit.new({name: "Gems and Minerals", cost: 0})}
  describe '#initialize' do
    it 'exists' do
      expect(exhibit).to be_a(Exhibit)
    end
  end
end
