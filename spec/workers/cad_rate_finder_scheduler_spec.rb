describe CadRateFinderScheduler do
  subject { described_class.new }
  let(:finders) { [Class, Object] }

  describe '#perform' do
    it 'executes CadRateFinderWorker for each registered finder' do
      expect(subject).to receive(:list_cad_rate_finders).and_return(finders)
      finders.each do |klass|
        expect(CadRateFinderWorker).to receive(:perform_async).with(klass.to_s)
      end

      subject.perform
    end
  end
end
