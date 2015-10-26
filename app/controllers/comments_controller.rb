class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      if @comment.commentable_type == "Goal"
        redirect_to goal_url(@comment.commentable_id)
      else
        redirect_to user_url(@comment.commentable_id)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(current_user)
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:comment, :commentable_id, :commentable_type)
  end
end
