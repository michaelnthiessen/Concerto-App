require 'sequel'

database = Sequel.connect('postgres://Michael@127.0.0.1:5432/concerts')

concerts = database.from(:concerts)

concerts.each do |c|
	puts "Artists:"
	c[:artists].split(',').each do |artist|
		puts artist.strip
	end
	puts "Date: #{c[:date]}"
	puts
end