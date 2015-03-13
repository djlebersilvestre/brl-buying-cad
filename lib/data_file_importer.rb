class DataFileImporter
  def import_into_db
    rates = generate_json_from_file
    rates.each do |rate|
      Rate.create(
        exchange_house: finders[get_key(rate)],
        value: rate['cad_rate'],
        created_at: Time.parse(rate['timestamp'])
      )
    end

    nil
  end

  private

  def finders
    @finders ||= Hash[ExchangeHouse.all.map { |e| [e.name, e] }]
  end

  def generate_json_from_file
    file_txt = File.read('log/cad_rates.json')
    file_txt.gsub!(/}{/, '},{')

    JSON.parse('[' + file_txt + ']')
  end

  def get_key(rate)
    key = 'CadRateFinder::' + rate['company']
    key = rate['company'] if rate['company'] =~ /CadRateFinder::/

    key
  end
end
