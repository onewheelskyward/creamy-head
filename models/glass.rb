class Glass
	include DataMapper::Resource

	property :id, Serial
	property :name, String
	property :size, Integer
	property :units, Enum[:oz], default: :oz

	belongs_to :beer
end
