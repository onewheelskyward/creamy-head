class Fill
	include DataMapper::Resource

	property :id, Serial
	property :amount, Float
	property :created_at, DateTime

	belongs_to :beer
end
