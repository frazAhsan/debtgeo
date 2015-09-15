class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :name
      t.string :domain
      t.string :city
      t.integer :state_id

      t.timestamps null: false
    end
  end
  #Website.create(name: "Dummy Site", domain: "dummysite.com", city: "Test", state_id: 1)
end
