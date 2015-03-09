require 'open-uri'

class Spmundi < CurrencyExchange
  private

  def css_find_cad_rate
    'span.calc_price'
  end

  def url_find_cad_rate
    'https://www.spmundi.com.br/DolarCanadense'
  end
end
