require 'open-uri'

class Cambiobr < CurrencyExchange
  private

  def css_find_cad_rate
    'span.price'
  end

  def url_find_cad_rate
    'http://www.cambiobr.com.br/dolarcanadense.html'
  end
end
