module FormHelper
  def setup_profile(profile)
    3.times { profile.educations.build }
    profile
  end
end