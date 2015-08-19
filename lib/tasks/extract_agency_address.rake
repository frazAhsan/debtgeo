namespace :cca do

  desc 'ETL '
  task :extract_address => :environment do
    require 'open-uri'
    require 'nokogiri'
    Agency.find_each do |agency|

    address = agency.address.split(" ").tap(&:pop).join(" ")
    url = "http://maps.googleapis.com/maps/api/geocode/xml?address="
    url += address.gsub(" ", "+")
    doc = Nokogiri::XML(open(url))

    
    response = doc.css("GeocodeResponse")
    result = response.css("result")
    result.each do |result_css|
        formatted_address = result_css.css("formatted_address").text  
        address_components = result_css.css("address_component") 
        address_components.each do |address_component|

            type = address_component.css("type").text
            long_name =  address_component.css("long_name").text
            short_name =  address_component.css("short_name").text
            puts "#{type} ---- #{long_name} === #{short_name}"
            if type == "street_number"
                agency.street_number = long_name
            elsif type == "route"
                agency.route = long_name
            elsif type == "localitypolitical"
                agency.city = long_name
            elsif type == "administrative_area_level_2political"
                agency.county = long_name
            elsif type == "administrative_area_level_1political"
                state = State.where("lower(state_code) = ?", short_name.downcase).first
                agency.state_code = short_name
                agency.state_id = state.try(:id)
            elsif type == "countrypolitical"
                agency.country = long_name 
            elsif type == "postal_code"  
                agency.zip_code = long_name 
            end              
        end

        geometry = result_css.css("geometry") 
        location = geometry.css("location")
        agency.latitude = location.css("lat").text
        agency.longitude = location.css("lng").text
        agency.save
    end
    end

    
  end

end
