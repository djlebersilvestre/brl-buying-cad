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

  def css_find_cad_rate(_)
    raise_not_implemented __method__
  end

  def url_find_cad_rate
    raise_not_implemented __method__
  end

  def cad_to_brl_rate
    rate = current_cad_rate
    parse_brl(rate)
  end

  def parse_brl(brl_text)
    brl_regex = /(\$)?(\s){0,3}(?<float_str>(\d)+\.(\d)+)/

    text = brl_text.gsub(/,/, '.')
    match = text.match(brl_regex)

    if match
      match[:float_str].to_f
    else
      fail "Could not parse #{brl_text} in BRL"
    end
  end

  def current_cad_rate
    doc = Nokogiri::HTML(open(url_find_cad_rate))
    css_find_cad_rate doc
  end
end
