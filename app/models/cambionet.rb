class Cambionet < CurrencyExchange
  private

  def css_find_cad_rate(doc)
    doc.css('table.exchange-rates-table > tbody > tr > td.venda')[8].content
  end

  def url_find_cad_rate
    'http://www.cambionet.com/site/cotacoes.php'
  end
end
