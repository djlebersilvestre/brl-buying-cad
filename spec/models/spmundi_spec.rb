describe Spmundi do
  subject(:spmundi) { Spmundi.new }

  describe '#buy_cad_cost', :vcr, cassette: 'cad_rate_spmundi' do
    subject(:buy) { spmundi.buy_cad_cost 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.65)
    end
  end
end
