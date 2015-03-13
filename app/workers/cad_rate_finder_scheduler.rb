# TODO: test it
class CadRateFinderScheduler
  include Sidekiq::Worker

  sidekiq_options queue: :high

  def perform
    finders = list_cad_rate_finders

    finders.each do |finder|
      class_name = finder.to_s
      CadRateFinderWorker.perform_async(class_name)
    end
  end

  private

  def list_cad_rate_finders
    CadRateFinder::Base.subclasses
  end
end
