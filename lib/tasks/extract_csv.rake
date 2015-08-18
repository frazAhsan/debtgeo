namespace :cca do

  desc 'ETL '
  task :extract_csv => :environment do
    require 'csv'     

    doc = Nokogiri::XML(File.open("cc_approved_agencies.xml"))
    CSV.foreach(File.open("free-zipcode-database.csv"), :headers => true) do |values|
    #"RecordNumber","Zipcode","ZipCodeType","City","State","LocationType","Lat","Long","Xaxis","Yaxis","Zaxis","WorldRegion","Country","LocationText","Location","Decommisioned","TaxReturnsFiled","EstimatedPopulation","TotalWages","Notes"
    #puts row[0]
    puts values[1]


    city = City.find_by(city: values[1].downcase)
    state = State.find_by(state_code: values[4])
    state_id = state.try(:id)
    City.create(zip_code: values[1].downcase, city: values[3].downcase, state_id: state_id, state_code: values[4],
    	latitude: values[6], longitude:  values[7],xaxis: values[8],yaxis: values[9], zaxis: values[10],
    	country: values[12], location: values[13], location_code: values[14]) if city.nil?

	end
end
end