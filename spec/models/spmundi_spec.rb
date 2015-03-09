describe Spmundi do
  subject(:spmundi) { Spmundi.new }

  describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_spmundi' do
    subject(:buy) { spmundi.rate_cad_in_brl 1 }

    it 'calculates a buy of CAD with the current BRL rate' do
      is_expected.to eq(2.65)
    end
  end
end
