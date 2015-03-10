describe Kantor do
  subject(:kantor) { Kantor.new }

  describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_kantor' do
    subject(:buy) { kantor.rate_cad_in_brl 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.5982124298482643)
    end
  end
end
