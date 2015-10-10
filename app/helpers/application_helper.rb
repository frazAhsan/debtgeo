module ApplicationHelper

 def set_website_title
 	if @site.seo_template == "2"
 		return title_format_2
 	else
 		return title_format_1
 	end
 end

 def title_format_2
 	if !@provider.nil?
 		return "#{@provider.name} Debt Settlement in #{@provider.locality}, #{@provider.region}"
 	elsif !@state.nil? 		
 		unless params[:attribute].blank?
 		  place_info = "#{params[:attribute]}, #{@state.name}" 
 		  return "#{place_info} Debt Settlement Firm Accreditation & Reviews "
 		else
 		  place_info = "#{@state.name}"
 		  return "#{place_info} Debt Settlement Clinic Reviews "
 		end
 	end
 	return "Debt Settlement Clinic Reviews "
 end

 def title_format_1
 	if !@provider.nil?
 		return "#{@provider.name} on #{@provider.street_address} in #{@provider.locality}, #{@provider.region}"
 	elsif !@state.nil?
 		place_info = "#{@state.name}"
 		place_info += ", #{params[:attribute]}" unless params[:attribute].blank?
 		return "#{place_info} Debt Consolidation Providers - Reviews & Accreditations"
 	end
 	return "Debt Consolidation Provider Reviews & Accreditations"
 end

 def set_meta_tag
 	if @site.seo_template == "2"
 		return meta_tag_format2
 	else
 		return meta_tag_format1
 	end   
 end

  def meta_tag_format1
 	if !@provider.nil?
 		return "Read reviews of #{@provider.name}, an approved credit counseling agency with the Department of Justice (Last updated: #{@provider.updated_at.strftime("%m/%d/%Y")}) headquartered in #{@provider.region}, #{@provider.locality}. See payment accepted, service offering details and real reviews for #{@provider.name}"
 	elsif !@state.nil?
 		place_info = "#{@state.name}"
 		place_info += ", #{params[:attribute]}" unless params[:attribute].blank?
 		return "Finding the right debt help in the #{place_info}. Whether a debt consolidation provider charges up front fees, is accredited and their average debt payoff percentages are just a few of the questions you should ask."
 	end
 	return "With #{BbbOverview.count} certified debt consolidation providers offering services, choosing the right company for your specific financial situtation can be confusing. Make an informed choice by reviewing our database of accredidations for debt consolidation providers."
  end

  def meta_tag_format2
 	if !@provider.nil?
 		return "#{@provider.name}, a debt settlement firm in #{@provider.locality}, #{@provider.region}. Research payment methods, treatment offerings, and reviews from past clients for #{@provider.name}"
 	elsif !@state.nil?
  		unless params[:attribute].blank?
 		  place_info = "#{params[:attribute]}, #{@state.name}" 
 		  return "Research debt settlement options near #{place_info}. Filter by dependency, payment terms, services offered and real user reviews"
 		else
 		  place_info = "#{@state.name}"
 		  return "Finding the right debt settlement help in #{@state.name} begins with reviewing facilities for certification, fee structure and past performance. Start getting help with debt in #{@state.state_code}."
 		end 		
 	end
 	return "Finding the right debt settlement company begins with reviewing facilities for certification, cost and historical performance. Live a debt-free life. Getting help with your debt today."
  end

  def set_header_name
 	if @site.seo_template == "2"
 		return set_h1_name2
 	else
 		return set_h1_name1
 	end    	
  end

  def set_sub_header_name
 	if @site.seo_template == "2"
 		return set_h2_name2
 	else
 		return set_h2_name1
 	end  	
  end

  def set_h1_name1
 	if !@provider.nil?
 		return "#{@provider.name}"
 	elsif !@state.nil?
 		place_info = "#{@state.name}"
 		place_info += ", #{params[:attribute]}" unless params[:attribute].blank?
 		return "#{place_info} Debt Consolidation Providers"
 	end
 	return "Debt Consolidation Providers"
  end

  def set_h1_name2
 	if !@provider.nil?
 		return "#{@provider.name}"
 	elsif !@state.nil?
 		place_info = "#{@state.name}"
 		place_info += ", #{params[:attribute]}" unless params[:attribute].blank?
 		return "#{place_info} Debt Settlement"
 	end
 	return "Debt Settlement"
  end

  def set_h2_name1
 	if !@provider.nil?
 		return "#{pluralize(BbbOverview.where(agency_id: @provider.agency_id).count, 'result')}"
 	elsif !@state.nil?
 		return "#{pluralize(@total_entries, "result")}"
 	end
 	return "#{pluralize(Agency.count, "result")}"
  end

  def set_h2_name2
 	  if !@provider.nil?
 		  return "Addiction Center in #{@provider.locality}, #{@provider.region}"
 	  elsif !@state.nil?
 		  return "#{pluralize(@total_entries, "result")}"
 	  end
 	  return "#{pluralize(Agency.count, "result")}"
  end

  def near_by_cities
    if @site.seo_template == "2"
      return "Debt Settlement in #{@provider.locality}"
    else
      return "Debt Consolidation Providers in #{@provider.locality}"
    end
  end

  def near_by_zip_codes
    if @site.seo_template == "2"
      return "#{@provider.postal_code} Debt Settlement"
    else
      return "#{@provider.postal_code} Debt Consolidation Providers"
    end
  end

  def provider_widget_class(zip_count, city_count)
    return "col-md-12" if zip_count == 0 && city_count == 0
    return "col-md-8"
  end

  def zip_code_class_name(zip_count)
    return "col-md-6" if zip_count == 2
    return "col-md-12" if zip_count < 2
    return "col-md-4"
  end
end
