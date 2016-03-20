class Location < ActiveRecord::Base
end
create_table :location do |t|
	t.column :country, :state, :city
end