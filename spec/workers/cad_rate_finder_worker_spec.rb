describe CadRateFinderWorker do
  subject { described_class.new }
  # TODO: can we solve with factory girl?
  let(:time) { Time.parse('2015-03-13 18:06:55') }
  let(:finder) { CadRateFinder::Cambiobr.to_s }
  let(:house) { ExchangeHouse.find_by(name: finder) }

  describe '#perform', :vcr, cassette: 'rate_cad_in_brl_cambiobr' do
    before(:each) { allow(Time).to receive(:now).once.and_return(time) }

    # TODO: refactor - only one expectation per test
    it 'persists a new Rate' do
      expect { subject.perform(finder) }.to change(Rate, :count).by(1)

      rate = Rate.first
      expect(rate.value).to eq(2.62)
      expect(rate.read_at).to eq(time)
      expect(rate.exchange_house).to eq(house)
    end
  end
end
