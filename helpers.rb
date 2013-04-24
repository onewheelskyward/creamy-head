require 'mechanize'
require 'open-uri'
require 'JSON'
require 'data_mapper'

#register Sinatra::Reloader
#also_reload './helpers/helpers.rb'
#Dir.glob("controllers/*.rb").each { |controller| also_reload controller }

def get_baileys
  url = 'http://api.legitimatesounding.com/api/baileys'
  intermediate = open(url).read
  puts intermediate
  JSON.parse intermediate
  #agent = Mechanize.new
  #page = agent.get()
  #noko = Nokogiri.HTML(page.body)
end

def determine_beer_type(tap_moniker)
	case tap_moniker
		when "Nitro"
			type = :nitro
		when "Cask"
			type = :cask
		else
			type = :co2
	end
end

def update(stuffs)
	stuffs['data'].each do |tap|
		tap_moniker = tap[0]
		beerdata = tap[1]

		beer = Beer.first_or_create(
			brewery: beerdata['brewery'],
			name: beerdata['beer'],
			glass: Glass.first_or_create(name: beerdata['glass']),
			style: beerdata['style']
			)
		beer.status = :tapped
		beer.type = determine_beer_type(tap_moniker)
		beer.tapped_at = beerdata['added']
		beer.save

		tap = Tap.first_or_create(tap_moniker: tap_moniker, beer: beer)
		puts "--------------------------------FILL #{tap_moniker} #{beerdata['fill']}"
		fill = Fill.first_or_create(beer: beer, amount: beerdata['fill'])

		beerdata['prices'].each do |price|
			#price.gsub /\$/, ""
			#Price.first_or_create(
		end

		puts tap.valid?
	end
end
