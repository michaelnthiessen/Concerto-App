require 'sinatra'
require 'json'
require 'sequel'
require 'date'

# Define our constants
LIMIT = 10
OFFSET = 0

# Parses out the parameters into an easily accessible hash
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

# Displays concert information for a single day
def displaySingleDay displayMode

	# Set up our database
	@database = Sequel.connect('postgres://Michael@127.0.0.1:5432/concerts')

	# Set variables differently depending on if we're looking at today's or tomorrow's concerts
	if displayMode == 'Today'

		# Get the concerts and the string containing the date
		@concertList = @database.from(:concerts).where(:date => (Date.today)..(Date.today + 1)).order(:date)
		@currentDay = Date.today.strftime("%b %-d")

	else
		@concertList = @database.from(:concerts).where(:date => (Date.today + 1)..(Date.today + 2)).order(:date)
		@currentDay = (Date.today + 1).strftime("%b %-d")
	end

	# Set our current display mode
	@displayMode = displayMode

	# Render our page
	erb :index
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

	displaySingleDay 'Today'

end

get '/tomorrow' do

	displaySingleDay 'Tomorrow'

end

get '/nextWeek' do

	# Set up our database
	@database = Sequel.connect('postgres://Michael@127.0.0.1:5432/concerts')

	# We need to create an array of days, each day holding an array of concerts
	@days = []

	# We want to get 2..10 days from now
	for i in 2...10 do

		# Get the concerts for that day
		beginDate = (Date.today + i)

		# concerts = @database.from(:concerts).where(:date => beginDate..(beginDate + 1)).order(:date)
		concerts = @database.from(:concerts).where(:date => /#{beginDate.to_s}.*/)

		# Add to the list if there are some concerts
		if concerts.count > 0
			@days << concerts
		else
			puts "Not enough concerts on #{beginDate.to_s}"
		end

	end

	erb :nextWeek

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
	@concertList = database.from(:concerts).all

	# Now we can get the list of concerts and stuff
	JSON.pretty_generate(@concertList)

end




















