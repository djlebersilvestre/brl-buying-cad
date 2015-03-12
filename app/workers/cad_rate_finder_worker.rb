# TODO: test it
class CadRateFinderWorker
  include Sidekiq::Worker

  sidekiq_options queue: :medium

  def perform(class_name)
    finder = class_name.constantize.new

    data = {
      company: class_name,
      cad_rate: finder.rate_cad_in_brl(1),
      timestamp: Time.now
    }

    # TODO: persist into DB
    File.open('log/cad_rates.json', 'a+') do |f|
      f.write(data.to_json)
    end
  end
end
