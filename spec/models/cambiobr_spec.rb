describe Cambiobr do
  subject(:cambiobr) { Cambiobr.new }

  describe '#buy_cad_cost', :vcr, cassette: 'cad_rate_cambiobr' do
    subject(:buy) { cambiobr.buy_cad_cost 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.61)
    end
  end
end
