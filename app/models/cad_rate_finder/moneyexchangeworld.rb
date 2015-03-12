module CadRateFinder
  class Moneyexchangeworld < Base
    private

    def css_find_cad_rate(doc)
      doc.css('CATALOG')
        .css('RATE')
        .css('COUNTRY:has(contains("Brazil")) + WEBUY + WESELL + INVBUY')
        .text
    end

    def url_find_cad_rate
      'http://www.moneyexchangeworld.com/rates/rateswithcss.xml'
    end

    # TODO: refactor the abstraction approach because it does not work for XML
    def current_cad_rate
      doc = Nokogiri::XML(open(url_find_cad_rate))
      css_find_cad_rate doc
    end
  end
end
