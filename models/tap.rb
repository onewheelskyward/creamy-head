class Tap
	include DataMapper::Resource

	property :id, Serial
	property :tap_moniker, String
	property :created_at, DateTime

	belongs_to :beer
end
