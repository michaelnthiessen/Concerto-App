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

# Configure our server and do any initialization
configure do

	# Make sure to flush the output
	$stdout.sync = true

	@@DAYS_PER_PAGE = 5

	$stdout.sync = true;

	# Set up our database
	@@database = Sequel.connect( ENV['DATABASE_URL'] || 'postgres://Michael@127.0.0.1:5432/concerts')

	# Print out which database we connected to
	puts "Connected to database at #{@@database.uri}"

end

get '/' do
	puts 'You are at the root!'
	redirect to '/page/1'
end

get '/page/:pageNum' do

	# We need to create an array of days, each day holding an array of concerts
	@days = []
	@pageNum = params[:pageNum].to_i

	puts "Serving up page #{@pageNum}"

	# Redirect if not in range
	if @pageNum < 1 || @pageNum > 3
		redirect to '/error'
	end

	# We want to get 2..10 days from now
	beginVal = (@pageNum - 1) * @@DAYS_PER_PAGE
	for i in beginVal...(beginVal + @@DAYS_PER_PAGE) do

		# Get the concerts for that day
		beginDate = (Date.today + i)

		# concerts = @database.from(:concerts).where(:date => beginDate..(beginDate + 1)).order(:date)
		concerts = @@database.from(:concerts).where(:date => /#{beginDate.to_s}.*/).order(:date)

		# Add to the list if there are some concerts
		if concerts.count > 0
			@days << concerts
		else
			puts "No concerts found to display on page #{@pageNum}"
			puts "A list of concerts:"
			puts concerts.all.to_s
			redirect to '/error'
		end

	end

	# Display the page
	erb :index

end

get '/next/:pageNum' do
	redirect to ('/page/' + (params[:pageNum].to_i + 1).to_s)
end

get '/prev/:pageNum' do
	redirect to ('/page/' + (params[:pageNum].to_i - 1).to_s)
end

get '/addconcert' do

	erb :addconcert

end

get '/buytickets' do

	erb :buytickets

end

# Get data when people add a concert
put '/addconcert' do
	erb :previewAdd
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

not_found do
	redirect to '/error'
end

get '/error' do
	puts 'There was an error'
	erb :error
end




















