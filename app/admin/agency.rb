ActiveAdmin.register Agency do
  actions :all, :except => [:new, :edit]



  filter :organisation_name
  filter :website


end