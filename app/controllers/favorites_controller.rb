class FavoritesController < ApplicationController
  before_action :required_logged_in
  
  def index
    @favorite_topics = current_user.favorite_topics
  end

  def create
    favorite = Favorite.new
    favorite.user_id = current_user.id
    favorite.topic_id = params[:topic_id]

    if favorite.save
      redirect_to topics_path, success: 'お気に入りに登録しました'
    else
      redirect_to topics_path, danger: 'お気に入りに登録に失敗しました'
    end
  end  
  
  def destroy
   Favorite.find_by(user_id: current_user.id, topic_id: params[:topic_id]).destroy
   flash[:success] = "お気に入りを解除しました"
   redirect_to topics_path
  end
  
  private
  def favorite_params
    params.require(:favorite).permit(:topic_id, :user_id)
  end
  
end