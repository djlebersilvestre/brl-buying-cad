require 'open-uri'

module CadRateFinder
  class Base
    def rate_cad_in_brl(cad)
      cad * cad_to_brl_rate
    end

    private

    # TODO: improve selectors from some sites
    abstract_method :css_find_cad_rate, :url_find_cad_rate

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
end
