describe Cambionet do
  subject(:cambionet) { Cambionet.new }

  describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_cambionet' do
    subject(:buy) { cambionet.rate_cad_in_brl 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.694)
    end
  end
end
