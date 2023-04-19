class FavoritesController < ApplicationController
  before_action :required_logged_in
  
  def index
    @favorite_topics = current_user.favorite_topics
    @flag = true
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
  
  def favorite_users
    @topic = Topic.find(params[:id])
    @users = @topic.favorite_users
  end  
  
  def ranking
    # @topics = Topic.includes(:favorite_users).sort {|a,b| b.favorite_users.size <=> a.favorite_users.size}
    
    @topics = Topic.find(Favorite.group(:topic_id).order('count(topic_id) desc').pluck(:topic_id))
    # SELECT COUNT(favorites.topic_id) AS ranking, topics.* FROM topics INNER JOIN favorites ON favorites.topic_id=topics.id GROUP BY favorites.topic_id ORDER BY ranking DESC;
    # SELECT topics.* FROM topics INNER JOIN favorites ON favorites.topic_id=topics.id GROUP BY favorites.topic_id ORDER BY COUNT(favorites.topic_id) DESC;   
    @flag = true;
  end  
  
  private
  def favorite_params
    params.require(:favorite).permit(:topic_id, :user_id)
  end
  
end