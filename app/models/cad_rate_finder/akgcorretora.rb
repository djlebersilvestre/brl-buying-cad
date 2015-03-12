module CadRateFinder
  class Akgcorretora < CurrencyExchange
    private

    def css_find_cad_rate(doc)
      doc.css('div.blocoMoeda[id=bloco_CAD]')
        .at_css('input[id=especie_venda_CAD]')
        .attributes['value']
        .value
    end

    def url_find_cad_rate
      'http://www.agkcorretora.com.br/pagina/cotacoes-e-simulador'
    end
  end
end
