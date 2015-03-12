describe ExchangeHouse do
  subject { described_class.new }

  it 'validates the presence of name' do
    expect(subject.save).to be false
  end
end
