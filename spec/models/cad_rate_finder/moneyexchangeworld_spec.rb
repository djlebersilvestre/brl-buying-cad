module CadRateFinder
  describe Moneyexchangeworld do
    describe '#rate_cad_in_brl', :vcr, cassette: 'rate_cad_in_brl_moneyxchg' do
      subject(:buy) { described_class.new.rate_cad_in_brl(1)  }

      it 'calculates a buy of CAD with the current BRL rate' do
        is_expected.to eq(2.6603)
      end
    end
  end
end
