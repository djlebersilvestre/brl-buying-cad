module CadRateFinder
  class Spmundi < Base
    private

    def css_find_cad_rate(doc)
      doc.at_css('span.calc_price').content
    end

    def url_find_cad_rate
      'https://www.spmundi.com.br/DolarCanadense'
    end
  end
end
