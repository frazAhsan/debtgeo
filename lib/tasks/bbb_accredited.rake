namespace :cca do

  desc 'ETL '
  task :bbb_accredited => :environment do
    require 'open-uri'
    require 'nokogiri'
    Agency.where("website is not null").find_each do |agency|
        puts agency.website
        puts agency.id
    url = "https://www.bbb.org/search/?type=name&input=#{agency.website}&location=&tobid=&filter=business&radius=&country=USA%2CCAN&language=en&codeType=YPPA"
    puts url
    doc = Nokogiri::HTML(open(url))
    nodes =doc.css('div.search-results-container > table > tbody > tr > td > h4 > a')
    if nodes.size > 0
        agency.update(bbb_accredited: true)
        nodes.each do |node|
            overview_url = node.to_s.gsub('<a href="', "")
            overview_url = overview_url.split('">').first
            overview_url = overview_url.split("<em>").first
            puts overview_url
            overview_doc = Nokogiri::HTML(open(overview_url))
            #unless overview_url.include?("phoenix")
                accredited_since =overview_doc.css('h3.accredited-since').text.squish rescue nil
        
                if accredited_since.upcase == "This business is not BBB accredited.".upcase || accredited_since.blank?
                        agency.update(bbb_accredited: false)
                else
                    accredited_since =accredited_since.split("BBB Accredited Business since ").last.split("document.write('").last.split("');").first
                    #if accredited_since.include?("BBB")
                    agency.update(bbb_accredited: true)
                end
                puts accredited_since
                title =overview_doc.css('h1.business-title').text.squish
                
                phone =overview_doc.css('div.business-detail-text > p > span.business-phone').text
                phone = phone.split("Phone:").last.squish rescue nil
                fax =overview_doc.css('div.business-detail-text > p > span.business-fax').text
                fax = fax.split("Fax:").last.squish rescue nil

                business_link =overview_doc.css('div.business-detail-text > p > span.business-link a').text.squish
                address = overview_doc.css('div.business-detail-text > p > span.business-address span')
                streetAddress =nil
                addressLocality =nil
                addressRegion =nil
                postalCode =nil
                address.each_with_index do |add, index|
                  if index == 0
                    streetAddress= add.text.squish
                  elsif index == 1
                    addressLocality= add.text.squish
                  elsif index == 2
                    addressRegion= add.text.squish
                  elsif index == 3
                    postalCode= add.text.squish
                  end
                        
                        
                end

                email =overview_doc.css('span.business-email a').text
                additional_phones =overview_doc.css('div#additional-phone-pop > ul > li')
                add_phones = Array.new
                additional_phones.each do |additional_phone|
                    add_phones << additional_phone.text.squish rescue nil
                end
                add_phones = add_phones.join(", ")
                rating =overview_doc.css('div#business-rating > div#business-rating-text > span.business-rating-scale strong').text.squish
                rating = rating.gsub("On a scale of", "").gsub("to F", "").squish
                puts "title #{title} phone #{phone} fax #{fax} business_link #{business_link} streetAddress #{streetAddress} addressLocality #{addressLocality} addressRegion #{addressRegion} postalCode #{postalCode} email #{email}"
                puts "rating #{rating} add_phones #{add_phones}"
                bbb_overview = BbbOverview.find_by(agency_id: agency.id, name: title)
                bbb_overview = BbbOverview.new(agency_id: agency.id, name: title) if bbb_overview.nil?
                bbb_overview.accredited_since = accredited_since
                bbb_overview.phone = phone
                bbb_overview.fax = fax
                bbb_overview.profile_url = overview_url
                bbb_overview.business_link = business_link
                bbb_overview.street_address = streetAddress
                bbb_overview.locality = addressLocality
                bbb_overview.region = addressRegion
                bbb_overview.postal_code = postalCode
                bbb_overview.rating = rating
                bbb_overview.additional_phone = add_phones
                bbb_overview.email = email
                bbb_overview.save


                complaint_table =overview_doc.css('div#customer-complaint-summary-container table.complaint-table').first
                unless complaint_table.nil?
                    complaints = complaint_table.css("tr")
                    complaints.each_with_index do |complaint, index|
                        unless (index == 0 || index == 6)
                            complaint_type = complaint.css("td").first.text.squish
                            total_closed_complaints = complaint.css("td").last.text.squish
                            bbb_complaint = BbbComplaint.find_by(bbb_overview_id: bbb_overview.id, complaint_type: complaint_type)
                            bbb_complaint = BbbComplaint.new(bbb_overview_id: bbb_overview.id, complaint_type: complaint_type)
                            bbb_complaint.total_closed_complaints = total_closed_complaints
                            bbb_complaint.save
                        end
                    end
                end


            #else
            #    puts "0000000000000000000000000"
            #end
        end

    else
        puts "there are no nodes"
        agency.update(bbb_accredited: false)
    end
    end

    
  end

end
