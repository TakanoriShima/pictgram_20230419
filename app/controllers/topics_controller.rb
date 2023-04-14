class TopicsController < ApplicationController
  before_action :required_logged_in
  
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
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
     @topic = Topic.find(topic_params)
     if @topic.update
       redirect_to topics_path, success: "投稿を更新しました"
     else
       flash.now[:danger] = "投稿の更新に失敗しました"
       render :edit
     end
  end
  
  def destroy
    topic = Topic.find(params[:id])
    
    if topic.destroy
     redirect_to topics_path
    end
    
  end
  
  private
  def topic_params
    params.require(:topic).permit(:image, :description)
  end
end
