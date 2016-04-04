class ExperiencesController < ApplicationController
  def edit
    @experience = Experience.find(params[:id])
  end

  def create
  	@profile = Profile.find(params[:profile_id])
  	@experience = @profile.experiences.create(experience_params)
    redirect_to profile_path(@profile)
  end

  def update
  	@profile = Profile.find(params[:profile_id])
    @experience = @profile.experiences.update(experience_params)
    redirect_to profile_path(@profile)
  end

  private
  	def experience_params
  		params.require(:experience).permit(:job_type, :company_name, :title, :country, :city, :start_month, :start_year, :end_month, :end_year, :is_present, :industry)
  	end
end