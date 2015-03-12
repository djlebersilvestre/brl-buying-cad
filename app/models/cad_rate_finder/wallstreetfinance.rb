module CadRateFinder
  class Wallstreetfinance < Base
    private

    def css_find_cad_rate(doc)
      doc.at_css('td:contains("Real") + td + td + td').text
    end

    def url_find_cad_rate
      'http://wallstreetfinance.ca/rates/axParseXmlWebRates.php'
    end
  end
end
