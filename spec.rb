require 'rspec'
require 'data_mapper'
require_relative 'helpers'
require_relative 'models/tap'
require_relative 'models/beer'
require_relative 'models/fill'
require_relative 'models/price'
require_relative 'models/glass'

DataMapper::Logger.new($stdout, :debug)
#DataMapper.setup(:default, "sqlite::memory:")
DataMapper.setup(:default, "postgres://localhost/beers_test")
DataMapper.finalize
DataMapper.auto_migrate!

fixture = '{"status":"ok","cache":"2013-04-22T21:49:50.003Z","data":{"2":{"brewery":"Great Divide","beer":"Nomad Pilsner","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.46689516129032266,"added":"2013-04-20T01:47:26.249Z","style":"Pilsner"},"3":{"brewery":"Widmer Brothers","beer":"Kill Devil Uncut","glass":"Snifter","prices":["$7.00","$3.50"],"fill":0.5466268656716419,"added":"2013-04-21T02:32:58.092Z","style":"Strong Ale"},"4":{"brewery":"Double Mountain","beer":"Pale Death","glass":"Snifter","prices":["$5.50","$2.50"],"fill":0.6026025236593062,"added":"2013-04-21T00:25:04.691Z","style":"Belgian Imperial IPA"},"5":{"brewery":"Widmer Brothers","beer":"KGB Russian Imperial Stout","glass":"Snifter","prices":["$4.00","$2.00"],"fill":0.49665322580645055,"added":"2013-04-16T20:09:54.565Z","style":"Imperial Stout"},"6":{"brewery":"Silver Moon","beer":"Bone Crusher Red","glass":"Nonic","prices":["$5.00","$3.00"],"fill":0.4265322580645162,"added":"2013-04-20T19:27:26.493Z","style":"Imperial Red Ale"},"7":{"brewery":"Three Creeks","beer":"Ponderosa Pale","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.41941207783758233,"added":"2013-04-19T23:05:45.429Z","style":"Pale Ale"},"8":{"brewery":"Russian River","beer":"Blind Pig","glass":"Nonic","prices":["$5.50","$3.00"],"fill":0.8083870967741936,"added":"2013-04-22T01:52:06.763Z","style":"IPA"},"9":{"brewery":"Amnesia","beer":"London Calling","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.6900201612903228,"added":"2013-04-20T23:22:58.068Z","style":"Mild"},"10":{"brewery":"Claim 52","beer":"Southtown Session","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.6494469746258947,"added":"2013-04-20T04:34:35.105Z","style":"India Session Ale"},"11":{"brewery":"Gigantic","beer":"The End of Reason","glass":"Nonic","prices":["$5.50","$3.00"],"fill":0.5043473117643582,"added":"2013-04-19T20:32:57.12Z","style":"Belgian Strong Dark Ale"},"12":{"brewery":"Wasatch","beer":"White Label","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.3762298387096776,"added":"2013-04-19T23:54:26.288Z","style":"Witbier"},"13":{"brewery":"New Belgium","beer":"Clutch","glass":"Snifter","prices":["$4.50","$2.00"],"fill":0.1793548387096782,"added":"2013-04-15T02:29:14.007Z","style":"Dark Sour"},"14":{"brewery":"Lucky Lab","beer":"Stumptown Porter","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.649959677419355,"added":"2013-04-20T04:24:31.03Z","style":"Porter"},"15":{"brewery":"GoodLife","beer":"Scottish Heart","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.25971774193548397,"added":"2013-04-17T03:34:56.703Z","style":"Wee Heavy"},"16":{"brewery":"Lagunitas","beer":"Waldo\'s Special Ale","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.9600806451612903,"added":"2013-04-22T20:37:00.131Z","style":"Imperial IPA"},"17":{"brewery":"Lagunitas","beer":"Hop Stoopid","glass":"Nonic","prices":["$4.50","$2.50"],"fill":1,"added":"2013-04-22T20:38:09.387Z","style":"Imperial IPA"},"18":{"brewery":"Lagunitas","beer":"Undercover Investigation Shut-Down Ale","glass":"Nonic","prices":["$4.50","$2.50"],"fill":1,"added":"2013-04-22T20:38:19.05Z","style":"Strong Ale"},"19":{"brewery":"Lagunitas","beer":"Little Sumpin\' Sumpin\'","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.9956451612903225,"added":"2013-04-22T20:39:14.081Z","style":"American Pale Wheat Ale"},"20":{"brewery":"Lagunitas","beer":"IPA","glass":"Nonic","prices":["$4.50","$2.50"],"fill":1,"added":"2013-04-22T20:36:43.631Z","style":"IPA"},"Cask":{"brewery":"Double Mountain","beer":"Vaporizer","glass":"Nonic","prices":["$5.00","$3.00"],"fill":0.9824921135646688,"added":"2013-04-22T20:40:32.958Z","style":"Dry Hopped Pale Ale"},"Nitro":{"brewery":"Migration","beer":"Life O\'Rye-ly IPA","glass":"Nonic","prices":["$4.50","$2.50"],"fill":0.27745967741935496,"added":"2013-04-18T19:14:57.191Z","style":"Rye IPA"}}}'

describe "stuff" do
	fixxie = JSON.parse fixture
	it "should be ok" do
		fixxie['status'].should == "ok"
	end

	#it "get and throw away" do
	#	x = get_baileys
	#	x['status'].should == "ok"
	#end

	#it "should populate the list" do
	#	update get_baileys
	#	taps = Tap.all
	#	taps.count.should > 0
	#end

	# Todo: Sim fill: 1, it seems to fail

	it "should give me a dollar-less price" do
		["$4.50", "$2.50"].each do |price|
			price.match /(\d+\.\d+)/
			puts $1
		end
	end
end
