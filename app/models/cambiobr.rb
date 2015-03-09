require "open-uri"

class Cambiobr
  def buy_cad_cost(cad)
    cad * cad_to_brl_rate
  end

  private

  def cad_to_brl_rate
    rate = current_cad_rate
    parse_rate(rate)
  end

  def parse_rate(rate_text)
    Monetize.assume_from_symbol = true
    rate = Monetize.parse rate_text
    rate.to_f
  end

  def current_cad_rate
    doc = Nokogiri::HTML(open(url_cad_rate))
    doc.at_css("span.price").content
  end

  def url_cad_rate
    "http://www.cambiobr.com.br/dolarcanadense.html"
  end
end

