require 'pry'
class Deal

  attr_accessor :offername, :seller, :details, :link, :value
  @@all = []

  def initialize(deal_hash)
    #binding.pry
    deal_hash.each { |key, value| send("#{key}=", value) }
    @@all << self
  end

  def self.create_from_collection(deals_array)
    deals_array.each { |deal| Deal.new(deal) }
  end

  def self.deal_details(deal_index)
    deal_index = deal_index.to_i - 1
    deal_info = @@all[deal_index].details
    puts "DEAL    : #{@@all[deal_index].offername}"
    puts "SELLER  : #{@@all[deal_index].seller}"
    puts "DETAILS : #{deal_info}"
    puts "VALUE   : #{@@all[deal_index].value.strip}"
    puts "--------------------------------------------------------"

  end

  def self.all
    @@all
  end

end
