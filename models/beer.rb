class Beer
	include DataMapper::Resource

	property :id, Serial
	property :brewery, String
	property :name, String
	property :tapped_at, DateTime
	property :style, String
	property :status, Enum[:tapped, :untapped], default: :tapped
	property :type, Enum[:nitro, :cask, :co2], default: :co2
	property :created_at, DateTime

	has 1, :tap
	has n, :prices
	has n, :fills
	has 1, :glass
end
