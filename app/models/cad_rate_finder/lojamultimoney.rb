module CadRateFinder
  class Lojamultimoney < CurrencyExchange
    private

    def css_find_cad_rate(doc)
      doc.css('span.precoProduto')
        .at_css('input[id=ctl00_MainContent_rptProdutos_ctl05_hidValorTaxa]')
        .attributes['value']
        .value
    end

    def url_find_cad_rate
      'http://www.lojamultimoney.com.br/MoedasEspecie.aspx'
    end
  end
end
