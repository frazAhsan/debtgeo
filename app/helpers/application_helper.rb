module ApplicationHelper

 def set_website_title
 	return title_format_1
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
   meta_tag_format1
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

  def set_header_name
  	return set_h1_name
  end

  def set_sub_header_name
  	return set_h2_name
  end

  def set_h1_name
 	if !@provider.nil?
 		return "#{@provider.name}"
 	elsif !@state.nil?
 		place_info = "#{@state.name}"
 		place_info += ", #{params[:attribute]}" unless params[:attribute].blank?
 		return "#{place_info} Debt Consolidation Providers"
 	end
 	return "Debt Consolidation Providers"
  end

  def set_h2_name
 	if !@provider.nil?
 		return "#{pluralize(BbbOverview.where(agency_id: @provider.agency_id).count, 'result')}"
 	elsif !@state.nil?
 		return "#{pluralize(@total_entries, "result")}"
 	end
 	return "#{pluralize(Agency.count, "result")}"
  end
end
