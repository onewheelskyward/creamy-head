class Price
	include DataMapper::Resource

	property :id, Serial
	property :amount, Decimal
	property :created_at, DateTime

	belongs_to :beer
end
