describe Akgcorretora do
  subject(:akgcorretora) { Akgcorretora.new }

  describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_akgcorretora' do
    subject(:buy) { akgcorretora.rate_cad_in_brl 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.68)
    end
  end
end
