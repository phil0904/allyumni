class Profile < ActiveRecord::Base
	has_many :educations
	accepts_nested_attributes_for :educations, :allow_destroy => true

	has_many :experiences
	accepts_nested_attributes_for :experiences, :allow_destroy => true

	belongs_to :user

  scope :unique_country, -> { group(:country) }
  scope :unique_city, -> { group(:city) }

	def self.search(search_school,search_company)
    if (search_school.present? && search_company.present?)
      Profile.joins('LEFT OUTER JOIN educations ON educations.profile_id = profiles.id LEFT OUTER JOIN experiences ON experiences.profile_id = profiles.id').where('educations.name LIKE ? AND experiences.company_name LIKE ?', "%#{search_school}%", "%#{search_company}%").group("profiles.id")
    elsif (search_school.present? && search_company.blank?)
    	Profile.joins('LEFT OUTER JOIN educations ON educations.profile_id = profiles.id').where('educations.name LIKE ?', "%#{search_school}%").group("profiles.id")
    elsif (search_school.blank? && search_company.present?)
    	Profile.joins('LEFT OUTER JOIN experiences ON experiences.profile_id = profiles.id').where('experiences.company_name LIKE ?', "%#{search_company}%").group("profiles.id")
    else
      Profile.all
    end
  end
end