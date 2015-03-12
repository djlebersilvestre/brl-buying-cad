describe Wallstreetfinance do
  describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_wallstreet' do
    subject(:buy) { described_class.new.rate_cad_in_brl(1)  }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.6481)
    end
  end
end
