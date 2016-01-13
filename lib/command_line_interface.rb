require_relative "../lib/scraper.rb"
require_relative "../lib/topdeals.rb"
require 'nokogiri'

class CommandLineInterface
  BASE_URL = "http://www.dealsofamerica.com/hot-deals.php"

  def run
    system 'clear'
    make_deals
    display_all_deals
    input_loop
  end

  def make_deals
    #deals_array=Nokogiri::HTML(open(BASE_URL))
    deals_array = Scraper.scrape_index_page(BASE_URL)
    Deal.create_from_collection(deals_array)
  end

  def display_all_deals
    puts "===============             TODAY's DEALS         ================="

    Deal.all[0..19].each.with_index(1) do |deal, i|
      print "#{i}.   "
      puts "#{deal.offername} - by #{deal.seller}"
    end

    puts "    _________________________________________________________________"
    puts "                        COMMANDS                                "
    puts "    - Type deal index number for details      "
    puts "    - Type 'all' to list all deals"
    puts "    - Type 'exit' to end"
    puts "    _________________________________________________________________"
  end

    def input_loop
      exit_display=false
      while !exit_display do
      deal_input=gets.chomp
      if deal_input == "all"
        display_all_deals
      elsif deal_input != nil && deal_input != "" && deal_input.to_i.between?(1,20)
        display_deal_details(deal_input)
      elsif deal_input != 'exit'|| deal_input == nil || deal_input == ""
        puts "ERROR: Invalid Input"
        puts "    _________________________________________________________________"
        puts "                        COMMANDS                                "
        puts "    - Type deal index number for details      "
        puts "    - Type 'all' to list all deals"
        puts "    - Type 'exit' to end"
        puts "    _________________________________________________________________"

      elsif deal_input == 'exit'
        puts "Thank you! "
        puts "Exiting..."
        exit_display = true
      end
    end

  end

  def display_deal_details(input)
    Deal.find(input).print_details
  end

end
