class Kantor < CurrencyExchange
  private

  def css_find_cad_rate(doc)
    doc.css('div.bottomboxes')
      .css("td:has(b[text()='1 BRL']) + td + td")
      .text
  end

  def url_find_cad_rate
    'http://www.kantor.ca/foreign_exchange_toronto_en_244cms.htm'
  end

  def cad_to_brl_rate
    brl_rate = super
    1 / brl_rate
  end
end
