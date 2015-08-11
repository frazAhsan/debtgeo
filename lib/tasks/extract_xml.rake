namespace :cca do

  desc 'ETL '
  task :extract_xml => :environment do
    require 'open-uri'
    require 'nokogiri'
    #doc = Nokogiri::XML(open("http://www.justice.gov/ust/eo/bapcpa/ccde/docs/credit_card_act/cc_approved_agencies.xml"))
    doc = Nokogiri::XML(File.open("cc_approved_agencies.xml"))
    
    cc_agencies = doc.css("cc_agencies")
    puts cc_agencies.size
    cc_agencies.each do |cc_agency|
        states = cc_agency.css("state")
        states.each do |state_css|
            state_code = state_css.css("state_code").text   
            unless state_code == "MP" && state_code == "GU"         
            state_name = state_css.css("state_name").text
            puts "State ==== state code #{state_code} ===== state name #{state_name}"
            state = State.find_by(state_code: state_code)
            state = State.create(state_code: state_code, name: state_name) if state.nil?
            
            judicial_districts = state_css.css("judicial_district")
            judicial_districts.each do |jd|
                judicial_district_short_name = jd.css("judicial_district_short_name").text
                judicial_district_formal_name = jd.css("judicial_district_formal_name").text
                puts "JudicialDistrict #{judicial_district_formal_name}"
                judicial_district = JudicialDistrict.find_by(state_id: state.id, short_name:judicial_district_short_name)
                judicial_district = JudicialDistrict.create(state_id: state.id, short_name:judicial_district_short_name, name: judicial_district_formal_name) if judicial_district.nil?
            
                agencies_css = jd.css("agency")
                agencies_css.each do |ag|
                    organisation_id = ag.css("org_id").text
                    puts "organisation_id #{organisation_id}"
                    agency = Agency.find_by(organisation_id: organisation_id)
                    if agency.nil?
                        organization_name = ag.css("organization_name").text
                        address = ag.css("agency_name_address").text
                        website = ag.css("agency_web_site_url").text
                        agency = Agency.create(organisation_id: organisation_id, organisation_name: organization_name,
                        address: address, website: website)
                        
                        service_method_css = ag.css("service_method")
                        service_method_css.each do |smc|
                            puts "creating agencies"
                            service_method_name = smc.css("service_method_name").text
                            phone_number = smc.css("phone_number").text
                            phone_extension = smc.css("phone_extension").text
                            web_site_url = smc.css("web_site_url").text
                            location_address_street_address1 = smc.css("location_address_street_address1").text
                            location_address_street_address2 = smc.css("location_address_street_address2").text
                            location_address_city = smc.css("location_address_city").text
                            location_address_state_code = smc.css("location_address_state_code").text
                            location_address_postal_code = smc.css("location_address_postal_code").text
                            location_address_phone_number = smc.css("location_address_phone_number").text
                            doing_business_as = smc.css("doing_business_as").text
                            location_language_name = smc.css("location_language_name").text
                            translator_only_flag = smc.css("translator_only_flag").text
                            written_material_only_flag = smc.css("written_material_only_flag").text
                            full_service_flag = smc.css("full_service_flag").text
                            ServiceMethod.create(agency_id: agency.id, service_method_name: service_method_name, phone_number: phone_number,
                            phone_extension: phone_extension, web_site_url: web_site_url, location_address_street_address1: location_address_street_address1, 
                            location_address_street_address2: location_address_street_address2, location_address_city: location_address_city, location_address_state_code: location_address_state_code,
                            location_address_postal_code: location_address_postal_code, location_address_phone_number: location_address_phone_number, doing_business_as: doing_business_as,
                            location_language_name: location_language_name, translator_only_flag: translator_only_flag, full_service_flag: full_service_flag)
                        end
                    end
                    jda = JudicialDistrictAgency.find_by(agency_id: agency.id, judicial_district_id: judicial_district.id)
                    JudicialDistrictAgency.create(agency_id: agency.id, judicial_district_id: judicial_district.id) if jda.nil?
                end
            end
            end
        end
    end
    
  end

end
