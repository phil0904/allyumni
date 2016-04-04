class Education < ActiveRecord::Base
  belongs_to :profile

  scope :unique_name, -> { group(:name) }
  scope :unique_major, -> { group(:major) }
end
