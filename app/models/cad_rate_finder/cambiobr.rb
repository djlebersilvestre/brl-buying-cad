module CadRateFinder
  class Cambiobr < Base
    private

    def css_find_cad_rate(doc)
      doc.at_css('span.price').content
    end

    def url_find_cad_rate
      'http://www.cambiobr.com.br/dolarcanadense.html'
    end
  end
end
