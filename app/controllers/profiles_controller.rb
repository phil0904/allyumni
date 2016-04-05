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
    @profiles=Profile.search(params[:search_school],params[:search_company])
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