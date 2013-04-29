require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require_relative 'helpers'

register Sinatra::Reloader
also_reload './helpers.rb'

["models/*.rb", "controllers/*.rb"].each do |dir_glob|
	require_and_reload(dir_glob)
end

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "postgres://localhost/beers")
DataMapper.finalize
DataMapper.auto_upgrade!

class App < Sinatra::Base
	get "/" do
		Beer.all.to_json
	end

	get "/update" do
		update(get_baileys).to_json
	end

	#get '/' do
	#	erb :basic, :locals => {local_erb_var: "xyz"}
	#end
end
