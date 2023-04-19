class CommentsController < ApplicationController
  before_action :required_logged_in
  
  def new
    @topic_id = params[:id]
    @comment = Comment.new
  end
  
  def create
    
    @topic = Topic.find(params[:id])
    @comment = @topic.comments.new(comment_params)
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to topics_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

 private
 def comment_params
  params.require(:comment).permit(:sentence)
 end
end