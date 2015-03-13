class CadRateFinderWorker
  include Sidekiq::Worker

  sidekiq_options queue: :default

  def perform(class_name)
    finder = class_name.constantize.new

    Rate.create!(
      exchange_house: exchange_house(class_name),
      value: finder.rate_cad_in_brl(1),
      read_at: Time.now
    )
  end

  private

  def exchange_house(name)
    # TODO: create a new ExchageHouse if does not exist
    ExchangeHouse.find_by(name: name)
  end
end
