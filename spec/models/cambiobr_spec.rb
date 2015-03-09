describe Cambiobr do
  subject(:cambiobr) { Cambiobr.new }

  describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_cambiobr' do
    subject(:buy) { cambiobr.rate_cad_in_brl 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.62)
    end
  end
end
