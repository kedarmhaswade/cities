# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# seed the database from zips.csv in config.root
require 'csv'

def seed_from(file_path)
  if File.readable? file_path
    CSV.foreach(file_path, :headers => true) do |row|
      state = State.find_or_create_by_short(row[1])
      state.name = row[5]
      state.save!
      city = City.find_or_create_by_name(row[4])
      city.longitude = row[3].to_f
      city.latitude = row[2].to_f
      city.state = state
      city.save!
      code = Code.find_or_create_by_zip_code(row[0])
      code.city = city
      code.save!
    end
  else
    Rails.logger.info("no data to load from file #{file_path}")
  end

end
require 'activerecord-import'
require 'set'
def import_from(file_path)
  if File.readable? file_path
    states, cities, codes = [], [], []
    state_id = 0
    city_id = 0
    code_id = 0
    new_state = false; new_city = false
    CSV.foreach(file_path, :headers => true) do |row|
      state = State.new(:name => row[5], :short => row[1])
      if states.none? { |s| s.short == state.short }
        state_id += 1
        state.id = state_id
        states << state
      end
      city = City.new(:name => row[4], :latitude => row[2].to_f, :longitude => row[3].to_f, :state_id => state_id)
      if cities.none? { |c| c.name == city.name }
        city_id += 1
        city.id = city_id
        cities << city
      end
      code = Code.new(:zip_code => row[0], :city_id => city_id)
      code_id += 1
      code.id = code_id
      codes << code
    end
    Rails.logger.info("***** states: #{states.size}")
    Rails.logger.info("***** cities: #{cities.size}")
    Rails.logger.info("***** codes: #{codes.size}")
    State.import states
    City.import cities
    Code.import codes
  else
    Rails.logger.info("no data to load from file #{file_path}")
  end
end
#seed_from(Rails.root.to_path+"/zips.csv")
import_from(Rails.root.to_path+"/zips.csv")
