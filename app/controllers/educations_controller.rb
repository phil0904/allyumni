class EducationsController < ApplicationController
  def edit
    @education = Education.find(params[:id])
  end

  def create
  	@profile = Profile.find(params[:profile_id])
  	@education = @profile.educations.create(education_params)
    redirect_to profile_path(@profile)
  end

  def update
  	@profile = Profile.find(params[:profile_id])
    @education = @profile.educations.update(education_params)
    redirect_to profile_path(@profile)
  end

  private
  	def education_params
  		params.require(:education).permit(:school_type, :name, :end_year, :major)
  	end
end
