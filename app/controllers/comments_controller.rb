class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = current_user.comments.new(comment_params)
    
    if @comment.save
      redirect_to topics_path, success: "投稿に成功しました"
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

 private
 def topic_params
  params.require(:comment).permit(:topim_id, :user_id, sentence)
 end
end