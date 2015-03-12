# TODO: test it
class CadRateFinderScheduler
  include Sidekiq::Worker

  def perform
    finders = list_cad_rate_finders

    finders.each do |klass|
      class_name = klass.to_s
      CadRateFinderWorker.perform_async(class_name)
    end
  end

  private

  def list_cad_rate_finders
    CurrencyExchange.subclasses
  end
end
