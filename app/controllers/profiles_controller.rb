class ProfilesController < ApplicationController
  before_action :required_logged_in
  
  def show
   #@user = User.find_by(id: params[:user_id])  
   #@profile = @user.profile
   @profile = Profile.find(params[:id])
   @user = @profile.user
   @topics = @profile.user.topics
  end
  
  def new
    if !profile_nil?(current_user)
      redirect_to profile_path(current_user.profile)
    end
    @profile = Profile.new
  end
  
  def create
    if !profile_nil?(current_user)
      redirect_to profile_path(current_user.profile)
    end
    
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id
    
    if @profile.save
     redirect_to profile_path(@profile.id), success: '投稿に成功しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  private 
  def profile_params
    params.require(:profile).permit(:profile_image, :place, :introduce)
  end
end
