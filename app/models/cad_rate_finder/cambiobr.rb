module CadRateFinder
  class Cambiobr < CurrencyExchange
    private

    def css_find_cad_rate(doc)
      doc.at_css('span.price').content
    end

    def url_find_cad_rate
      'http://www.cambiobr.com.br/dolarcanadense.html'
    end
  end
end
