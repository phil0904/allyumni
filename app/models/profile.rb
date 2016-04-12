class Profile < ActiveRecord::Base
	has_many :educations, :dependent => :destroy
	accepts_nested_attributes_for :educations, :allow_destroy => true

	has_many :experiences, :dependent => :destroy
	accepts_nested_attributes_for :experiences, :allow_destroy => true

	belongs_to :user

	def self.search(search_school,search_company)
    if (search_school.present? && search_company.present?)
      Profile.joins('LEFT OUTER JOIN educations ON educations.profile_id = profiles.id LEFT OUTER JOIN experiences ON experiences.profile_id = profiles.id').where('lower(educations.name) LIKE ? AND lower(experiences.company_name) LIKE ?', "%#{search_school}%".downcase, "%#{search_company}%".downcase).group("profiles.id")
    elsif (search_school.present? && search_company.blank?)
    	Profile.joins('LEFT OUTER JOIN educations ON educations.profile_id = profiles.id').where('lower(educations.name) LIKE ?', "%#{search_school}%".downcase).group("profiles.id")
    elsif (search_school.blank? && search_company.present?)
    	Profile.joins('LEFT OUTER JOIN experiences ON experiences.profile_id = profiles.id').where('lower(experiences.company_name) LIKE ?', "%#{search_company}%".downcase).group("profiles.id")
    else
      Profile.all
    end
  end
end