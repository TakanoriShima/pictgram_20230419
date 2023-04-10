class ProfilesController < ApplicationController
  before_action :required_logged_in
  
  def index
   @user = User.find_by(id: params[:user_id])  
   @profile = @user.profile
  end
  
  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(profile_params)
    
    
    if @profile.save
     redirect_to profiles_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end
  
  private 
  def profile_params
    params.require(:profile).permit(:profile_image, :place, :introduce, :user_id)
  end
end
