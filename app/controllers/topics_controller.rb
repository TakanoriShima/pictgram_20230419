class TopicsController < ApplicationController
  def index
    @topics = Topic.all.includes(:favorite_users)
  end
  
  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_params)

    if @topic.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
  
  def destroy
   favorite = Favorite.find_by(topic_id: params[:topic_id], user_id: params[:user_id])
   favorite.destroy
   flash[:success] = "お気に入りを解除しました"
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
  def favorite_padams
    params.require(:favorite).permit(:topic_id, :user_id)
  end
end
