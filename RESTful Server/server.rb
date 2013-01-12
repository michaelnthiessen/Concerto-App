require 'sinatra'
require 'json'
require 'sequel'
require 'date'

# Define our constants
LIMIT = 10
OFFSET = 0

def hashParameters params

	# Create a temp array
	parameters = []

	# Load each element into a one dimensional array
	params.each do |p|
		p.each do |x|
			parameters << x
		end
	end

	# Convert to a hash and return
	parameters = Hash[*parameters]
end

# Configure our server and do any initialization
configure do

	# Set our server to bind to port 127.0.0.1 for testing
	set :bind, '127.0.0.1'

end

# Gets the last time that the database was updated
get '/last_updated' do

end

get '/' do

	# Get our concert data
	database = Sequel.connect('postgres://Michael@127.0.0.1:5432/concerts')
	@todayList = database.from(:concerts).where(:date => (Date.today)..(Date.today + 1)).order(:date)
	# @tomorrowList = database.from(:concerts).where(:date => (Date.today + 1)..(Date.today + 2)).order(:date)

	# Render our page
	erb :index
end

# Return a list of the concerts in JSON
get '/concerts' do

	# Get a nice hash of the parameters
	parameters = hashParameters params

	# Get the values out of the hash
	limit = parameters["limit"] || LIMIT
	offset = parameters["offset"] || OFFSET

	# Set some default values if those haven't been set yet
	limit ||= LIMIT
	offset ||= OFFSET

	# Get our concert data
	database = Sequel.connect('postgres://Michael@127.0.0.1:5432/concerts')
	@concertList = database.from(:concerts).first(20)

	# Now we can get the list of concerts and stuff
	JSON.pretty_generate(@concertList)

end




















