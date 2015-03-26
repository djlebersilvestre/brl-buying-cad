class RatesController < ApplicationController
  def index
    # TODO: cleanup the controller and the view
    @rates_for_graph = ExchangeHouse.all.map do |house|
      { name: house.name.gsub(/CadRateFinder::/, ''),
        data: get_rates_for_data_graph(house.rates.last(30)) }
    end
  end

  private

  def get_rates_for_data_graph(rates)
    data_rates = {}
    rates.each do |rate|
      read_at = rate.read_at.change(sec: 0)
      data_rates[read_at] = rate.value
    end

    data_rates
  end
end
