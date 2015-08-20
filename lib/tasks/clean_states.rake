namespace :cca do

  desc 'ETL '
  task :clean_states => :environment do
    State.find_each do |state|
        puts state.id
        state.update_attributes(name: state.name.to_s.gsub("\t", ""), state_code: state.state_code.to_s.gsub("\t", ""))
    end
  end


  task :clean_jds => :environment do
    JudicialDistrict.find_each do |jd|
        puts jd.id
        jd.update_attributes(name: jd.name.to_s.gsub("\t", ""))
    end    
  end

end
