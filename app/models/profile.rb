class Profile < ActiveRecord::Base
	has_many :educations
	accepts_nested_attributes_for :educations, :allow_destroy => true

	has_many :experiences
	accepts_nested_attributes_for :experiences, :allow_destroy => true

	belongs_to :user

end