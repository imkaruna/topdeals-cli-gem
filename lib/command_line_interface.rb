require_relative "../lib/scraper.rb"
require_relative "../lib/topdeals.rb"
require 'nokogiri'

class CommandLineInterface
  BASE_URL = "http://www.dealsofamerica.com/hot-deals.php"

  def run
    system 'clear'
    make_deals
    display_all_deals

  end

  def make_deals
    #deals_array=Nokogiri::HTML(open(BASE_URL))
    deals_array = Scraper.scrape_index_page(BASE_URL)
    Deal.create_from_collection(deals_array)
  end

  def display_all_deals
    index = 0
    exit_display=false
    puts "===============             TODAY's DEALS         ================="
    Deal.all.each do |deal|
      index+=1
      if index < 21

        print "#{index}.   "
        puts "#{deal.offername} - by #{deal.seller}"
      end
    end
    while !exit_display do
      puts "    _________________________________________________________________"
      puts "                        COMMANDS                                "
      puts "    - Type deal index number for details      "
      puts "    - Type 'deals' to list deals"
      puts "    - Type 'exit' to end"
      puts "    _________________________________________________________________"
      deal_input=gets.strip
      if deal_input == 'deals'
        display_all_deals
      elsif deal_input != nil && deal_input != "" && deal_input.to_i.between?(1,20)
        display_deal_details(deal_input)
      elsif deal_input != 'exit'
        puts "ERROR: Invalid Input"
      else
        puts "Exiting..."
        exit_display = true
      end
    end

  end

  def display_deal_details(input)
    Deal.deal_details(input)
  end

end
