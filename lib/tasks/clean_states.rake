namespace :cca do

  desc 'ETL '
  task :clean_states => :environment do
    State.find_each do |state|
        puts state.id
        state.update_attributes(name: state.name.to_s.gsub("\t", ""), state_code: state.state_code.to_s.gsub("\t", ""))
    end
    
  end

end
