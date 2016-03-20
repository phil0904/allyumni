class ProfilesController < Admin::BaseController
  autocomplete :country, :state, :city
end
class ProfilesController < ApplicationController
	def index
    @profiles = Profile.all
  end

  def new
	end
	def create
    @profile = Profile.new(profile_params)
    @profile.save
    redirect_to profiles_path
	end
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :email, :phone, :country, :city)
    end
end