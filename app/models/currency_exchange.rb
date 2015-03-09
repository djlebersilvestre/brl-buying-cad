require 'open-uri'

class CurrencyExchange
  def rate_cad_in_brl(cad)
    cad * cad_to_brl_rate
  end

  private

  def raise_not_implemented(method)
    error_msg = "#{self.class} must implement abstract method #{method}"
    fail NoMethodError, error_msg
  end

  def css_find_cad_rate
    raise_not_implemented __method__
  end

  def url_find_cad_rate
    raise_not_implemented __method__
  end

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
    doc = Nokogiri::HTML(open(url_find_cad_rate))
    doc.at_css(css_find_cad_rate).content
  end
end
