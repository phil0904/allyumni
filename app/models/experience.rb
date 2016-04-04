class Experience < ActiveRecord::Base
	belongs_to :profile

	scope :unique_company_name, -> { group(:company_name) }
	scope :unique_title, -> { group(:title) }
	scope :unique_country, -> { group(:country) }
	scope :unique_city, -> { group(:city) }
end
