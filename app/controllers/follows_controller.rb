class FollowsController < ApplicationController
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings
    @title = 'フォロー中のユーザー一覧'
    
  end  
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
    @title = 'フォローされているユーザー一覧'
    
  end 
  
  def create
    @follow_id = params[:id]
    follow = Follow.new
    follow.user_id = current_user.id
    follow.follow_id = @follow_id
    if follow.save
      redirect_to profile_path(User.find(@follow_id).profile)
    else
    end  
    
  end
  
  def destroy
    @follow = Follow.find(params[:id])
    @follow_id = @follow.follow_id
    @follow.destroy
    redirect_to profile_path(User.find(@follow_id).profile)
  end  
    
end
