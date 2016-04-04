class ProfilesController < ApplicationController
  autocomplete :profile, :country, :scopes => [:unique_country]
  autocomplete :profile, :city, :scopes => [:unique_city]
  autocomplete :education, :name, :scopes => [:unique_name]
  autocomplete :education, :major, :scopes => [:unique_major]
  autocomplete :experience, :company_name, :scopes => [:unique_company_name]
  autocomplete :experience, :title, :scopes => [:unique_title]
  autocomplete :experience, :country, :scopes => [:unique_country]
  autocomplete :experience, :city, :scopes => [:unique_city]
  before_action :authenticate_user!

	def index
    if (params[:search_school].present? && params[:search_company].present?)
      @profiles = Profile.joins('LEFT OUTER JOIN educations ON educations.profile_id = profiles.id LEFT OUTER JOIN experiences ON experiences.profile_id = profiles.id').where('educations.name LIKE ? AND experiences.company_name LIKE ?', "%#{params[:search_school]}%", "%#{params[:search_company]}%").group("profiles.id")
    elsif (params[:search_school].present? && params[:search_company].blank?)
      @profiles = Profile.joins('LEFT OUTER JOIN educations ON educations.profile_id = profiles.id').where('educations.name LIKE ?', "%#{params[:search_school]}%").group("profiles.id")
    elsif (params[:search_company].present? && params[:search_school].blank?)
      @profiles = Profile.joins('LEFT OUTER JOIN experiences ON experiences.profile_id = profiles.id').where('experiences.company_name LIKE ?', "%#{params[:search_company]}%").group("profiles.id")
    else
      @profiles=Profile.all
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def new
    @profile = Profile.new
    @profile.educations.build
    @profile.experiences.build
	end

	def create
    @profile = Profile.new(profile_params)
    if @profile.save
      flash[:notice] = "Successfully created profile."
    else
      redirect_to @profile and return
    end
    render :action => 'new'
	end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update_attributes(profile_params)

    render :action => 'edit'
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    flash[:notice] = "Successfully destroyed profile."
    redirect_to profiles_path
  end

  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :email, :phone, :country, :city, educations_attributes: [:id, :school_type, :name, :end_year, :major, :_destroy], experiences_attributes: [:id, :job_type, :company_name, :title, :country, :city, :start_month, :start_year, :end_month, :end_year, :is_present, :industry, :_destroy])
    end
end