describe Wallstreetfinance do
  subject(:wallstreetfinance) { Wallstreetfinance.new }

  describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_wallstreet' do
    subject(:buy) { wallstreetfinance.rate_cad_in_brl 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.6481)
    end
  end
end
