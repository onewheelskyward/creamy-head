require 'mechanize'
require 'open-uri'
require 'JSON'
require 'sinatra/base'
require 'json'

module Sinatra
	module Helpers
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

				tap = Tap.first_or_create(tap_moniker: tap_moniker)

				existing_beer = Beer.first(tap: tap)
				if existing_beer.brewery == beerdata['brewery'] and existing_beer.name == beerdata['beer'] and existing_beer.style == beerdata['style']
					# Same beer!  Just update the fillage & prices.
					beer = existing_beer
				else
					beer = Beer.first_or_create(
						brewery: beerdata['brewery'],
						name: beerdata['beer'],
						style: beerdata['style']
					)
					beer.glass = Glass.first_or_create(name: beerdata['glass'])
					beer.status = :tapped
					beer.type = determine_beer_type(tap_moniker)
					beer.tapped_at = beerdata['added']
					beer.save
				end

				Fill.first_or_create(beer: beer, amount: beerdata['fill'])

				beerdata['prices'].each do |price|
					price.match /(\d+\.\d+)/
					# There's probably a better way to map these.  Figure it out.
					Price.first_or_create(beer: beer, amount: $1.to_f)
				end

				puts tap.valid?
			end
		end
	end
	helpers Helpers
end

