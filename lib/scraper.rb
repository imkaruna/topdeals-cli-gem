#Scraper class fetches and parses data using Nokogiri gem
require 'open-uri'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(deals_url)
    html = Nokogiri::HTML(open(deals_url).read)

    html.css(".col-xs-8").collect do |offer|
      {
        :offername => offer.css("header a").text,
        :seller => offer.css("span a").text,
        :details => offer.css(".deal-desc p").text,
        :value => offer.css(".cpriceb").text
      }
    end
  end

end
