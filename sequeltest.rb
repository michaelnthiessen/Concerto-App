# Sequel test

require 'sequel'

database = Sequel.connect('postgres://Michael@127.0.0.1:5432/concerts')

concerts = database.from(:concerts)
concerts.insert(:headliner => 'Muse', :date => '02/28/13')
concerts.insert(:headliner => 'deadmau5', :date => '02/28/13')
concerts.insert(:headliner => 'Savant', :date => '03/01/13')